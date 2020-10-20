Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CE4C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29B522244
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6fhaiGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbgJTVgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733100AbgJTVgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:36:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB8C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:36:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z16so3099691qkg.15
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wfUaGgRfJoVKIAxVoLoBq1+dG6F8Xyz6tlR9Dp5PlvU=;
        b=P6fhaiGNKf41Pedb9KD1NLR4PVkddma71XpyMMInXEOuK6+B0n+LygMWgrDlNJhfrK
         w+zeTEhBWgwnxVfXwP7IPAOarhDjBjuaUYxptZQpeTu7SMJd6TUTXSkqD5zrazVbq6Gd
         saLWAloHtrzzHaWUkVT3VcfEUHztb9kLdHGprh2jTd2iWIApk0i3fGR5nXmK4Mm3e42e
         u5x3x//xejvKi3fQCjY2go1jh02dfy8+0E+D7boGWO8zUMsaHW6PwhD9gReNIooFrHqr
         /eLqcatV/EkYdPkOG1NQDdAkatngjjupeYTZ2iAVqOXHIGGSAL5a0g735qz73ueE/N8w
         55mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wfUaGgRfJoVKIAxVoLoBq1+dG6F8Xyz6tlR9Dp5PlvU=;
        b=dO0TLtGALurVVP8Xe/4DJkzDA8ha1kAAr9XCSZLdMl9be0glhutDLdSEC8ejEggYpe
         nJEO4eUfrV/PqAvzVU/rFDr9wRFR1CTAQvR/gwII2jIgPpdoU0hTrzZfg+9U8iCCwGHu
         5I6C03qK6Tt6M/L+FS9WYUlfo3e1dO10HtlD6Ctwg1Xi0oy1HJO53l8atXEjU6/pIfr5
         pyaRhIRue3CT9iga3YX2V4AWFBGQFCHcIbo0T42B2LUZrX/4x8eIe5frAOPKdfIvYaKk
         dCWlafOFEiTcPGE6GLbcK2XQ4Fqyd9s40fDRlrV/Ox+NnaER/HX8xLM887ZD+go61JXf
         81eA==
X-Gm-Message-State: AOAM530fSlcrV5Gv1fYWPdKMNkqkQkvbO4paAUGTcVkVXyTVQChTuX9M
        TRx+SeYCDjduYRCXtyJ6HNPPpySR4ESlJip8FQbo
X-Google-Smtp-Source: ABdhPJzaf6IR/o5jMRiqT4cLS0lekuP+bAsqVYFlRWSVSZKYheuIiqH2KrX0XOMHw2dPymPiltWhbztGtDO36CpkSGVr
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:174f:: with SMTP id
 dc15mr5395018qvb.25.1603229814049; Tue, 20 Oct 2020 14:36:54 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:36:51 -0700
In-Reply-To: <xmqqo8kwaagx.fsf@gitster.c.googlers.com>
Message-Id: <20201020213651.691101-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8kwaagx.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: [PATCH] apply: when -R, also reverse list of sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I wish you told that to those who added fn_table kludge to apply.c
> > back when they did so.  They apparently wanted to have a patch that
> > has more than one "diff --git a/hello.c b/hello.c" that talks about
> > the same file applied with a single invocation of "git apply".
> > Perhaps what they did is already broken with "apply -R", and blind
> > reversal of everything magically makes it work?  Or what they did
> > already works with "apply -R" and your blind reversal would break,
> > unless you undo what they did?
> 
> ;-)  It turns out that it was the former.
> 
> Without your "blindly reverse everything" patch, the attached patch
> illustrates how the "touch the same path more than once" support
> introduced in 7a07841c (git-apply: handle a patch that touches the
> same path more than once better, 2008-06-27) is broken with respect
> to "apply -R".

Ah, thanks for checking.

> So, you should be able to sell the change to fix _two_ bugs ;-)
> 
> Thanks.
> 
> diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
> index 972946c174..fa824ac09f 100755
> --- a/t/t4127-apply-same-fn.sh
> +++ b/t/t4127-apply-same-fn.sh
> @@ -30,7 +30,7 @@ test_expect_success 'apply same filename with independent changes' '
>  	test_cmp same_fn same_fn2
>  '
>  
> -test_expect_success 'apply same filename with overlapping changes' '
> +test_expect_failure 'apply same filename with overlapping changes' '
>  	git reset --hard &&
>  	modify "s/^d/z/" same_fn &&
>  	git diff > patch0 &&
> @@ -39,8 +39,13 @@ test_expect_success 'apply same filename with overlapping changes' '
>  	git diff >> patch0 &&
>  	cp same_fn same_fn2 &&
>  	git reset --hard &&
> +	cp same_fn same_fn1 &&
> +
>  	git apply patch0 &&
> -	test_cmp same_fn same_fn2
> +	test_cmp same_fn same_fn2 &&
> +
> +	git apply -R patch0 &&
> +	test_cmp same_fn same_fn1
>  '
>  
>  test_expect_success 'apply same new filename after rename' '

Indeed, with my patch, this test passes instead of fails.

Should I resend a version 2 that includes this test or will you apply
this to your local copy?
