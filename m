From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix for normalization of foreign idents
Date: Mon, 23 Aug 2010 16:35:31 -0500
Message-ID: <20100823213531.GD2120@burratino>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Mon Aug 23 23:37:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onehq-0000x5-63
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 23:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab0HWVhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 17:37:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50693 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130Ab0HWVhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 17:37:19 -0400
Received: by fxm13 with SMTP id 13so3378382fxm.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YYUPtWk3n/aY7Pxm9IAkuwlSJtOpY3B7f4kVJ7ENBfY=;
        b=cdrPqprtx8+WcDqo5cpyrYWWWHK35aHE5GhNEyzpwrcwGY8+wSj6YyMQ74iRC8WcyY
         R+smIO7/v6kgD7R7f9xHtwTh6tM1X5oaqC50rUf36bqGWcIfYxcuoLyz3LZXwr2OB0Jn
         YlSVDe28fMO0aCannD1XDI/8zd0Y6FRGCeRkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UOrZFAOXkrm+x5Gswu09m5pcbGJnwuVbkQGTdjeyr8DcRl/Fm5UsS8+WAUlxvjhKO0
         dWZzPaeWL1CGBlP3cJGfliTytn4wnzEzU3CMXKfURHktJmCAXDdwJTcxrx3e6FSs5edR
         VyFGD9syHLDybdVDWJm8JKV4WSjqeIpP3w5Gc=
Received: by 10.213.20.77 with SMTP id e13mr3335731ebb.59.1282599438083;
        Mon, 23 Aug 2010 14:37:18 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v59sm11516854eeh.16.2010.08.23.14.37.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 14:37:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154261>

Hi,

Marcus Comstedt wrote:

>   $Id: blah$ --(c_t_w_t)--> $Id: blah$ --(c_t_g)--> $Id: blah$
> 
> This restores correct and deterministic operation of status and
> diff, meaning that if the file hasn't actually been modified, no
> modifications are shown.
> 
> As you might suggest, always keeping the foreign ident would mean it
> is never updated when you commit new versions of the file, which isn't
> really what we want.  Keeping the foreign ident as long as the last
> modification to the file was made in the previous version control
> system makes perfect sense, but once we make a commit to the file
> within git, it should be replaced with a git ident.

I was with you up to here.  Is commit time really the right moment
to clobber a foreign ident?  I suspect it would be confusing.

It might be simpler to just never clobber a foreign ident and instead
rely on local policy (scripts, pre-commit hooks, and so on) to remove
them at the appropriate time.
