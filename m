Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00DEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGUSjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 14:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSjL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:39:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE43586
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:39:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5838c631690so14139877b3.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689964747; x=1690569547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzBYZzVG2FRhlg6OVWa13Q0fuSB2cuKkRtN1O0aPiSk=;
        b=WVoQBMFEnghH4h5wf5RTf8uyufUg4uxxpoOLBPbi3XzmOMHl4SghRvZ/0StCIweTlU
         OYtMfDToyfCqK0ebzpVkDcm/1MwbDtKwUqJaiRuw+3ITbkQEvg1EbEPUz1An8CLO6njc
         mGMPA8xxodHg+cE/2BQ7fCdx5zIKpnC/zg8tJRdP/mQpv8b4qfC+9sCSz+HLPQSEe9Ot
         IBpzj5kosEVDlwz5s5fwhE/cJ/jbqVm3vKOAuvKl4CTGezWVP23I0C0PsyVspMnfQaSx
         DzYUPS8HOiGaevrtuDH7mnhhCPUyLlUo2zouwrb4lUFlf+mp4+Z/H0djNLx+vktLeEM3
         no1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964747; x=1690569547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzBYZzVG2FRhlg6OVWa13Q0fuSB2cuKkRtN1O0aPiSk=;
        b=IUrO4moUrNK3u7Q5sVSY+3fRezgBO0FCa/A1Rke2lOWmMQZnelNxETH3HgvlTJW1DG
         oHHnRxI3LGJmDEnN3IIdyCazQ3gQE7FArxEwI6zyVcWKISpcocB6Q4+/zfFBA22gMaB2
         kyxvaHuqK9R+/8UBpJuOhsLB8Cu3dmAV2yPSJn61P2KgrQD1hWZJS6gSLxN3jHe4DnGg
         u/sCmUm9vFshpLA8A7UwJHbMFsTTe9dSLQTpRoU/ki78k6OC4db5SKM5t1ZdU+hs4ab7
         xbP+QOouNVAuhxYjrP8OSbGBPpCwO4jN07orqrkDHcn/RWmESl1Obtq76awILYDB2RmY
         dJWg==
X-Gm-Message-State: ABy/qLb/8NWpBQIjXUpDZuckGPtNjRaWKgBkZKOrux55i4pmbucZeNF3
        6poreIyFl2RS6NyfuheqBKF2cA==
X-Google-Smtp-Source: APBJJlHHjgncw2sC+KaKz+enwmFVSW+PZQhnrlfVZMpRVnsM2r4a2qWEEvRN497Pc2SIyDGlHbgrsQ==
X-Received: by 2002:a81:49d8:0:b0:559:f18d:ee94 with SMTP id w207-20020a8149d8000000b00559f18dee94mr805050ywa.10.1689964746818;
        Fri, 21 Jul 2023 11:39:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x196-20020a81a0cd000000b005838c613b40sm753697ywg.44.2023.07.21.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:39:06 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:39:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t/lib-commit-graph.sh: avoid directory change in
 `graph_git_behavior()`
Message-ID: <ZLrQyZAoRIaga1mT@nand.local>
References: <cover.1689960606.git.me@ttaylorr.com>
 <715a160903be6dc8873a7215c55f90894e62f589.1689960606.git.me@ttaylorr.com>
 <CAPig+cTse-bgpApQR3jVGir0Tur22NEgAoTKpmLek+pTRovxwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTse-bgpApQR3jVGir0Tur22NEgAoTKpmLek+pTRovxwg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 02:01:58PM -0400, Eric Sunshine wrote:
> > diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
> > @@ -20,12 +20,14 @@ graph_git_behavior() {
> >         test_expect_success "check normal git operations: $MSG" '
> > -               cd "$TRASH_DIRECTORY/$DIR" &&
> > -               graph_git_two_modes "log --oneline $BRANCH" &&
> > -               graph_git_two_modes "log --topo-order $BRANCH" &&
> > -               graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
> > -               graph_git_two_modes "branch -vv" &&
> > -               graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
> > +               (
> > +                       cd "$TRASH_DIRECTORY" &&
> > +                       graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
> > +                       graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
> > +                       graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
> > +                       graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
> > +                       graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
> > +               )
> >         '
> >  }
>
> As mentioned in my review of patch [1/5], for safety, you'd probably
> want to quote the expansion of DIR in case it ever contains whitespace
> (or other weird characters). The obvious POSIX-correct way to do this
> would be:
>
>     graph_git_two_modes "${DIR:+-C \"$DIR\"} log ..." &&
>
> Unfortunately, however, some older broken shells incorrectly expand
> this to a single argument ("-C <dir>") rather than the expected two
> arguments (-C and "<dir>")[1,2,3,4]. The workaround is unsightly but
> doable:
>
>     graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} log ..." &&

Hmm. I get what you're saying, but I think in this case we're OK, since
this all goes to `graph_git_two_modes`, whose implementation looks like:

    graph_git_two_modes() {
        git -c core.commitGraph=true $1 >output
    }

So I think we really do want everything smashed together into a single
argument.

(Just to sure, here's the diff of what I applied on top of [2/5] before
replying to your message):

--- 8< ---
diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index c93969ae74..d60e64cb0b 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -22,11 +22,11 @@ graph_git_behavior() {
 	test_expect_success "check normal git operations: $MSG" '
 		(
 			cd "$TRASH_DIRECTORY" &&
-			graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
-			graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
-			graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
-			graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
-			graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
+			graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} log --oneline $BRANCH" &&
+			graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} log --topo-order $BRANCH" &&
+			graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} log --graph $COMPARE..$BRANCH" &&
+			graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} branch -vv" &&
+			graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} merge-base -a $BRANCH $COMPARE"
 		)
 	'
 }
--- >8 ---

> [1]: https://lore.kernel.org/git/20160517215214.GA16905@sigill.intra.peff.net/
> [2]: https://lore.kernel.org/git/e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c/
> [3]: https://lore.kernel.org/git/20160518010609.Horde.sM8QUFek6WMAAwho56DDob8@webmail.informatik.kit.edu/
> [4]: https://lore.kernel.org/git/1240044459-57227-1-git-send-email-ben@ben.com/

Thanks,
Taylor
