From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFH] - git-svn auth bug (possibly SVN 1.5.0-related)
Date: Mon, 4 Aug 2008 19:14:24 +0400
Message-ID: <20080804151424.GU7008@dpotapov.dyndns.org>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled> <488B2FC5.4080801@kitware.com> <20080803220251.GB3006@untitled> <20080804141820.GT7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1mX-0007D3-Js
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbYHDPOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbYHDPOa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:14:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:3687 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804AbYHDPO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:14:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1013088fgg.17
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yXvaTw/H7z6CbPCxKVSeQ+V2RfMSOE6yak8b4VVPAUo=;
        b=sdFyLc/0D3EHO/XLsz0mRJiEXLO6Aqga80vys1FKHUI/Yi3e6S4JzfM/r+jpEHOUsf
         BuPb6Zoa1l4L6eVVa18Ruz4Cu5LugV7/paNBMpCtE8TEZfT3pwFlyn1S49aL6BpHUgS5
         hsWglCMPuw6LifQb520VagbdUaQG63mKyAAaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kbLDhv47RxJ8JKlkDq40gd9QCqwBLygzMBcdqJTOrPTodClBvkjf7ztNpagcoKsUy3
         oW2CJOX9ky3nLb/b8kH4CImhUmte3sjfnlChLaI7OUMCF7aaWxXLBdAY6dp3tbWM6ZKv
         +G8dnlV4FxGwIoAVvHWhJdTfzT5+kNZ485v4I=
Received: by 10.86.83.2 with SMTP id g2mr10486590fgb.54.1217862867529;
        Mon, 04 Aug 2008 08:14:27 -0700 (PDT)
Received: from localhost ( [85.141.237.93])
        by mx.google.com with ESMTPS id l12sm89718fgb.6.2008.08.04.08.14.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 08:14:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080804141820.GT7008@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91370>

On Mon, Aug 04, 2008 at 06:18:20PM +0400, Dmitry Potapov wrote:
> Numbers of lines may be different for different versions of libsvn-perl,
> but the effect is exactly the same. Instead of going to the next line
> and completing AUTOLOAD, if you use FS format 3 then you end up in
> croak_on_error(), which uses some uninitialized value in string
> concatenation (which produces an additional warning) and then calls
> croak(). End of the story :(

I think I have figured out that is wrong. It is a bug in initialization
of SVN database. Before, there was only one [general] section in the
conf/svnserve.conf file and the procedure of initialization apparently
copied a template and added the following string to the end of file:

anon-access = write

but now there are two sections: [general] and [sasl]

as result "anon-access = write" is added to the wrong section,
and there is no anonymous access anymore. So, the test fails.


Dmitry
