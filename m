From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Mon, 3 Dec 2007 21:04:12 +0700
Message-ID: <fcaeb9bf0712030604o2efc90d0m148d3280aaa475a5@mail.gmail.com>
References: <20071128165837.GA5903@laptop>
	 <Pine.LNX.4.64.0711281703470.27959@racer.site>
	 <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com>
	 <Pine.LNX.4.64.0711281717460.27959@racer.site>
	 <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
	 <Pine.LNX.4.64.0711281810410.27959@racer.site>
	 <7v3aunb0q4.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711302250ldfb543evd6d5f70d95ae51f7@mail.gmail.com>
	 <7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 15:04:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzBuW-00047J-0M
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 15:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXLCOEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 09:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbXLCOEQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 09:04:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:22174 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbXLCOEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 09:04:15 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2707489nfb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Q+khoFCp79SOIntcZ0P4o8u76ZeYUY9pb7Tm7tGBp+Y=;
        b=ubr2dQWivFRRl0QrYGGXOCtXX1G0K4ibjZi8/WdCCmQkTSbL/EPOJ4haTiGtA8K+cWiI1nT4oIfo1Z5jbLvztAv2bftN9TlLwJucjJYt6aZnmeQPMeidByRCOwquwRakEucSJ62grwVIYXqL50LCK4drJVayTZPwwagYMewzHQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qrUgRtsu+268fLLzZjRBSxTMjZbkEd1VE5jAPWU12ClubbJFRo31FQWZ7XeT5K3FaM1+3xPei87orjrzTlULLx9PzrGFjtTvyj7Lj6N5SXCKbrcHDOI6suLO9XOnDk7T70H90ywkt25DF+lNJsNcw5VGwrYgpZMmLcnj2dzkdrM=
Received: by 10.86.60.7 with SMTP id i7mr10619657fga.1196690652837;
        Mon, 03 Dec 2007 06:04:12 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Mon, 3 Dec 2007 06:04:12 -0800 (PST)
In-Reply-To: <7v4pf25jiq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66920>

On Dec 2, 2007 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * Similarly, run a few commands in modes that do not require git
>    repository.  For example, "git apply --stat" of an existing patch
>    should be viewable no matter where you are (that is just a "better
>    diffstat" mode), so ideally it should not barf only because you
>    happen to be in a repository that is too new for you to understand.
>    I do not know offhand how your patch would handle this situation.
>
> Note that making sure the latter works is tricky to do right, for a few
> reasons.
>
>  (1) It is not absolutely clear what the right behaviour is.  It could
>      be argued that we should just barf saying we found a repository we
>      do not understand, refraining from doing any damange on it [*2*].
>
>  (2) If we choose not to barf on such a repository, it remains to be
>      decided what "gently" should do --- if it should still treat
>      t/trash/test (which has too new a version) as the found repository,
>      or ignore it and use t/trash (which we can understand) as the found
>      repository.  I think it should do the former.

You might have forgotten the third choice: ignore t/trash/test and
stop searching, instead pretend there is no repository at all (maybe
with a big warning of unsupported repository).

I agree t/trash should not be touched no matter what. I had enough
"fun" with nested gitdir already. But if _gently() treats t/trash/test
as a good repository, mysterious things may happen. Suppose gitdir v2
supports some crazy refspec that current installed git cannot
understand. Now you run git-remote on a v2 repository, it would end up
barfing "invalid refspec" or something instead of "your repository
version is not supported, upgrade git now". The latter error message
is much clearer IMHO.

If we are going "t/trash/test is good repo" route, we must make sure
_gently() callers check repository version (and barf at proper places)
before actually using it. Doing so makes repo version checking in
_gently redundant, you need to check it from callers anyway as the
callers will decide when to barf. Or return  *nongit_ok=-1 and let the
callers check return value so they do not need to run
check_repository_format_version() again.

Comments?
-- 
Duy
