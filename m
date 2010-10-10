From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Sat, 9 Oct 2010 21:41:24 -0500
Message-ID: <20101010024124.GA20305@burratino>
References: <20101009201751.GK9348@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Sun Oct 10 04:56:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4m5G-00046n-PE
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 04:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab0JJCoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 22:44:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45770 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972Ab0JJCoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 22:44:38 -0400
Received: by iwn6 with SMTP id 6so1912567iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jqLpgi7fix+ue2AP5jSxud5WjYeTlDvpFDcH0joOfqA=;
        b=eRHUsB/3rzcBsfpi4u5WaXKvTg1TBnYtygbjXjN2HicG9e9LDcMnExnEKkz+56M2ub
         8EvBfYDgJT7hCSGy1T3GvItmbHXq+bhJxUM4fpnxhP/O3I/g446CeJXtp5J+iltaSvS/
         gksyD1+gBEqMvWuCdfYFwZ82D2YcwE52Mp6HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=psZLHZYpcw97UMBl9GZ237OyvW4u3onc4V45YA8G4ViJjZ1Kr72Zd3X3yvlaGP8XSH
         c+ZUfH+Ylu9MtQQMZPud2ilzmDjCOttstL/1iw25SWCbMgz/h2n9+HJ3djiFOtXTB+0H
         nr7FkbfbjoGUgDaEQ/pjAZby5qc7MwYvp42lo=
Received: by 10.42.204.67 with SMTP id fl3mr992476icb.406.1286678677168;
        Sat, 09 Oct 2010 19:44:37 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm2857024ibi.8.2010.10.09.19.44.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 19:44:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101009201751.GK9348@bzzt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158638>

Hi,

Arnout Engelen wrote:

> When creating a temporary file, log the template.

Since mkstemp modifies its template, these hopefully would print the
actual filename on errors.  Examples:

	fatal: Unable to create temporary file '.merge_file_Sc7R5c': File exists
	fatal: Unable to create temporary file 'newrepo/.git/tOWHcxk': No space left on device

Unfortunately some mkstemp()s (such as that used to implement
git_mkstemp_mode()) clear the template on error, which would result in

	fatal: Unable to create temporary file '': Permission denied

What should git do in this situation?

> Useful for making debugging 
> problems like file permission mistakes easier.

Agreed.  Thanks.
