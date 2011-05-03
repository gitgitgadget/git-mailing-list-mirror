From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] userdiff.c: Avoid old glibc regex bug causing
 t4034-*.sh test failures
Date: Tue, 3 May 2011 16:07:16 -0500
Message-ID: <20110503210716.GL1019@elie>
References: <4DC04021.1040606@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, trast@student.ethz.ch,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 03 23:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHMoa-0001hn-5e
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 23:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab1ECVHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 17:07:23 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60479 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1ECVHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 17:07:22 -0400
Received: by yia27 with SMTP id 27so192545yia.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xc6HHYRhEWxfw/N9qzpm6KkSxNKA4v9EQiIufcViHBo=;
        b=ZEVjXthPOf0oTOb7FZS7QC6PRtRJ2dZ7f4ourrog5y2lnxnX7oZL1UiJzB/NNKvbB2
         6G2wU8w+SaUn9E/6eBsamV78eltcPtxNOkkK838H7zDVNJlplAzFAbby2R/NKHXnAO0g
         mRyGhxO/+xyhLfft5Xp02H9ULTN6iil/Bl7HY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aDUsORXRSaHRBl0d0bsj56oBFSZ+ZHuh/qduRKesaZskTZl49JEY5qU6bfULbOKIQd
         9PF3TiziP4hR6yuUaXXQQPibvZcgjbl+8lWvhIHURhuFNulVkoVubOJN3p6w6doMeucK
         cPwB7EQr9HOlG8KvGLOYR+rz7Zbj4dsRrEVqU=
Received: by 10.236.67.41 with SMTP id i29mr414806yhd.279.1304456841411;
        Tue, 03 May 2011 14:07:21 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.sbcglobal.net [69.209.62.211])
        by mx.google.com with ESMTPS id u7sm222174yhn.92.2011.05.03.14.07.19
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 14:07:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC04021.1040606@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172694>

Hi,

Ramsay Jones wrote:

> This is an RFC because:
>     - A simple fix would be for me to put NO_REGEX=1 in my config.mak,
>       since the compat/regex routines don't suffer this problem.
>     - I suspect this bug is old enough that it will not affect many users.
>     - I have not audited the other non-matching list expressions in
>       userdiff.c
>     - blame, grep and pickaxe all call regcomp() with the REG_NEWLINE
>       flag, but get the regex from the user (eg from command line).

I think excluding \n along with ' ' and \t in similar places makes
sense, but that meanwhile we should add tests to the testsuite for
blame/grep/pickaxe to catch such implementations failing when
NO_REGEX=1 is not set.

Does that make sense?  Thanks for tracking this down.

Jonathan
