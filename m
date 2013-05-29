From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/5] rebase: fix cherry-pick invocations
Date: Wed, 29 May 2013 00:55:23 -0500
Message-ID: <51a5984b6e642_7242869e1c714fe@nysa.mail>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
 <1369747757-10192-6-git-send-email-felipe.contreras@gmail.com>
 <7vzjvewwne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZPV-0001ot-8z
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307Ab3E2F6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:58:53 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:37989 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab3E2F6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:58:52 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so3622378obb.14
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/zGAD2LKmPont1JmeMVcntQqhRYYShBrwL9PQMnYAiE=;
        b=MxnGtXCZKuke/Lz50QEtDjW10DhZ2Ig4gpnNg8DeyfmWv45GukO5RytWNm1Ka1g7fq
         vzKn6j3LGGcxiDqBqD4WvhdNFseRHsAV1t7OksyyRuV7nUrFdPvnPEadoeAuDtCqlWSh
         9aJAFgz+KFDwGJxeOruE/t31vU2kYG99f2HLl6lD8v7g56OJtgcDKrgEvdb7QA5H4Etq
         BrdsxjxdKCC2bANEYoF5UIa+33jUsEyKA4+SMeWVn+KYZwq6RVEZyAmSDPpbwyM1ISPu
         62dAvBT7CAkKYMrdHkm4WLLfJS0gh2Y3FLYAcu5PivgBFESuzr7X7OHTbD35IGfAFx0o
         KJoQ==
X-Received: by 10.182.65.100 with SMTP id w4mr668983obs.70.1369807131697;
        Tue, 28 May 2013 22:58:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm38608977oby.12.2013.05.28.22.58.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 22:58:50 -0700 (PDT)
In-Reply-To: <7vzjvewwne.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225747>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > So that all the tests pass.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  git-rebase--cherry.sh | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> > index ca78b1b..c3a2ac9 100644
> > --- a/git-rebase--cherry.sh
> > +++ b/git-rebase--cherry.sh
> > @@ -23,11 +23,26 @@ test -n "$rebase_root" && root_flag=--root
> >  mkdir "$state_dir" || die "Could not create temporary $state_dir"
> >  : > "$state_dir"/cherry || die "Could not mark as cherry"
> >  
> > +if test -n "$rebase_root"
> > +then
> > +	revisions="$onto...$orig_head"
> > +else
> > +	revisions="$upstream...$orig_head"
> > +fi
> 
> "So that all the tests pass" needs a bit more explanation to say for
> cherry-pick codepath why and how two-dot range fails and why and how
> three-dot variant with --right-only fixes it.  What are the problematic
> cases?

There's too many failures to count. We are blindingly applying a series of
commits on top of another without checking if they are merges or if they
already exist in the destination branch.

-- 
Felipe Contreras
