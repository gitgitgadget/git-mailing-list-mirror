From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 13:52:31 -0700
Message-ID: <20090526205230.GA66544@gmail.com>
References: <1243316165-99065-1-git-send-email-davvid@gmail.com> <200905262231.50892.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	nick@incise.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue May 26 22:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M93dv-0004NM-3a
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 22:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959AbZEZUwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbZEZUwh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 16:52:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:54290 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbZEZUwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 16:52:36 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1047629rvb.5
        for <git@vger.kernel.org>; Tue, 26 May 2009 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zly7ofKTIonFb82rdgzfBFCbEMNZPSS22Yf4MX19gAU=;
        b=hPaT5j8u22bSoXZdRLfNw6ZwRBsiCoUVaHxcqDHo8n8JuW/ods0tLbRBBhL3wNzqLt
         6tBXyc2F2xDlJGaVWdVX3nCrdfOUbltNibxnoLHCKuXO5i9BYJGAmvSfaqterC7iKboS
         IFw2lOJSwjJQuyKhtBNeDAaqLg88bqhxhsbIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a54+zhFF7JE7uXVFKMOaYIH2goNy3JIoFoXuxNdE1YJoQ6ngC2GTyqBlgqTncOaWGh
         LQlo3B7HxwqS4bz8viGXhh3PRNWmGSue318GPwJdVbnpgTXydWG345dSfUF2bgmZw0O6
         rHEOmjaNr5z38ETLyqQg80dj+Zwm19KPRKdXc=
Received: by 10.141.113.3 with SMTP id q3mr3411019rvm.12.1243371157755;
        Tue, 26 May 2009 13:52:37 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id g22sm14250345rvb.36.2009.05.26.13.52.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 13:52:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905262231.50892.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120010>

On Tue, May 26, 2009 at 10:31:50PM +0200, Markus Heidelberg wrote:
> David Aguilar, 26.05.2009:
> > Diffing "name.ext" now generates "name.XXXX.ext".
> > Diffing files with no extension now generates "name_XXXX".
> 
> Would it simplify the patch when using "name_XXXX.ext" and "name_XXXX"?
> Or what about "XXXX_name.ext" and "XXXX_name"? Then you don't even have
> to search for the dot and it has the advantage to show the original
> filename without some random letters in the middle of it.
> 
> Markus
> 

In that case suffix_len is always len(basename) + 1
and there's less strbuf juggling to do.
That is simpler.  Let's do that.

My next patch series will be two parts:
part 1: add compat/mkstemps.c
part 2: use it in prep_temp_blob() via git_mkstemps()

Part 1 has me a little nervous because I'm not sure which
platforms in the Makefile need the
	NO_MKSTEMPS = YesPlease
setting.  I only have access to mac + linux, so I can do the
right thing there, but I'll have to make a best guess for the
rest of the platforms.

Perhaps the best answer is to set them all to YesPlease except
for mac and openbsd, which I know have native implementations.

-- 
		David
