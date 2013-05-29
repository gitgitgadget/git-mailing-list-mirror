From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/5] rebase: fix 'cherry' mode storage
Date: Tue, 28 May 2013 22:03:48 -0500
Message-ID: <51a57014a1184_807b33e18100353@nysa.mail>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
 <1369747757-10192-3-git-send-email-felipe.contreras@gmail.com>
 <7v8v2yyc04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 05:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWmH-0005tY-EI
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759163Ab3E2DKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:10:11 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48140 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241Ab3E2DKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:10:10 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so10759297oag.39
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/CBgbjmvSqrlEjd0mM592RnyXdlevSIeq7V5Z7dcvBQ=;
        b=Y6V47ZRh2AtGGagSR8LnoAks7zgM1PsEBoCGNoLPLG0cqD09oYd20QwqeGO3Fk3vFF
         VxnqIEOSqZr0M8JWBIpkn3mThBI0kiE23PmYTf5WXAhWQIgfJAKUtRbUegBton6H4aIF
         IrGX8taMqCVSbHAwH2hV10nCmEUl2r8wMxQLFbtJUT5KUaSKQxjpYO9W5BZq72QPJJ84
         wiOR9F/zLSE+lc8jJ467v00xXaV9u8+9kJB59Y99+mO6B9t7+PsMSxq6oiNlyd86dgND
         8ZBf/ZJk3iPuHFl/nISUwS+nnhnreh08c26ivjt3UyBSTeiOjhVmUe2nKmgf6A8tkkQj
         CLqA==
X-Received: by 10.60.57.101 with SMTP id h5mr496295oeq.0.1369797009494;
        Tue, 28 May 2013 20:10:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm39101347oel.2.2013.05.28.20.10.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:10:08 -0700 (PDT)
In-Reply-To: <7v8v2yyc04.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225709>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > We don't use the 'rebase-apply'.
> 
> s/.$/; we will use rebase-merge instead./ I think.

We could use 'rebase-apply' or any directory, but currently we don't use any,
and 'rebase-apply' is for 'git am'.

> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  git-rebase--cherry.sh | 4 ++++
> >  git-rebase.sh         | 5 ++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> > index cbf80f9..ab1f8b7 100644
> > --- a/git-rebase--cherry.sh
> > +++ b/git-rebase--cherry.sh
> > @@ -18,6 +18,9 @@ esac
> >  
> >  test -n "$rebase_root" && root_flag=--root
> >  
> > +mkdir "$state_dir" || die "Could not create temporary $state_dir"
> > +: > "$state_dir"/cherry || die "Could not mark as cherry"
> 
> Style:
> 
> 	>"$state_dir/cherry-pick"

Fix that in git-rebase--interactive.sh then, where this code came from.

> I am not sure if the user _cares_ that internally we use cherry-pick
> when s/he asks us to do a keep-empty, and I suspect "mark as cherry"
> incomprehensible.  I do not even know what is going on at this point
> (yet).

It's the same we do in git-rebase--interactive.sh.

> I _suspect_ that you are using cherry-pick when --keep-empty is given,
> so it might even make sense to talk in the end-users' terms,
> i.e. call this "$state_dir/keep-empty" (I am not sure if calling
> this split half "git-rebase--keep-empty.sh" makes sense, yet).

If git-rebase--cherry(-pick)?.sh does the same as 'git-rebase--am.sh', we can
replace it, and make yet another step of replacing scripts (git am) with C code
(git cherry-pick). I thought I explained that somewhow, maybe I didn't.

It still makes sense to fix the broken --keep-empty behavior.

-- 
Felipe Contreras
