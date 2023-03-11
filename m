Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA31BC61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 06:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCKGAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCKGAb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 01:00:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065D122CF1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 22:00:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11985897pjg.4
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678514429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkk9/5VlA2DLtwOzg5hUv6DLP+hzPbxLn3xL0hS4rZA=;
        b=gJHTJF8d8sIHZxJfZUL2RpQk5CkrIHxkt4mDR2PfsVLAija1eF/yUnokJNa7YFM2FX
         OXil4i2f+hXrrMeMLLcUvYUU0ZxZNSVFg2nLSppjBmMcK53RMzisySii0/v+YJGkou9H
         LjyfHLyFS9qcDtYvLO6Nme4Y3/smltbGHF1+nmp9C+OlnRfh/FifphxsTIv6oVMnvqVS
         OYvnK5Yl3aMEzL4I7pif7w4/4zUjKIpvVW6FuyLGK6w5XyJMGrORsLCVlqUdkOgBdw1c
         O2SrsqNsx4+/z+OzvN9mGKebDy5aRCEXFLNJu08JPcLTb8xTJR+iLFahRXpFfdIAz8uI
         tJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678514429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkk9/5VlA2DLtwOzg5hUv6DLP+hzPbxLn3xL0hS4rZA=;
        b=o5A41u+bNT0GqzGAhGAeidv/tGpLD+w6x8Zug1he9e0Ton0JjRSnL29jRF3HCKUCfa
         J+Gh9+KolCQmIk4GLzBCKl/RgQVUWgN3AyfRpHsQuakLSfmQAWPg9nLbgPl7v8csjZiU
         uabIrPdGmxiLidYAgl9vFfIMJ8Ipg2nfbUndFUkiF+CO09Mt1xxH4eQWvtrsdOYh7ePn
         T1ZFJUiLybxIa5bmVEfJKSDWaigiy8qIiW4ok8Fphj/RjHpOdfvX3HUKWV0d4euJW1At
         dfSCX3tVMyWmPtNYT5v8XrFcXRX7RwmI+Bqa0LABwZGUNkqDJTGgobLxPTLYbnJHZ6uG
         N0tA==
X-Gm-Message-State: AO0yUKVKZuLVBSimxdu4e+IIG7r148slmFpOQT+Q1C70k+lE1d6Ex7dB
        fDUpmcVzRAykg6hZBvHb/NM5apjqZwY=
X-Google-Smtp-Source: AK7set8stL4HW4Oq1wm61B104Rkq0Rciy9WQ8PIp30H8fHA7HKxR7Paq+VRiR1EGThohfW0Fv758Hg==
X-Received: by 2002:a17:902:ea11:b0:194:cc66:66f7 with SMTP id s17-20020a170902ea1100b00194cc6666f7mr34149147plg.19.1678514429141;
        Fri, 10 Mar 2023 22:00:29 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.161])
        by smtp.gmail.com with ESMTPSA id n12-20020a63e04c000000b004f27761a9e7sm809213pgj.12.2023.03.10.22.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 22:00:28 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
Date:   Sat, 11 Mar 2023 11:30:12 +0530
Message-Id: <20230311060012.22031-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqzg8k4ad9.fsf@gitster.g>
References: <xmqqzg8k4ad9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Mar 2023 at 02:01, Junio C Hamano <gitster@pobox.com> wrote:
>
> [...]
>
> Two requests.
>
>  * Could you substantiate this claim for future readers of "git
>    log"?  A reference to an old mailing list discussion or a log
>    message of the commit that added the temporary measure that says
>    the above plan would be perfect.
>
>  * What exactly does "once the commands have been taught"?  Which
>    commands?  Could you clarify?
>

Will do the change.

> > Hence, use has_object() to check for the existence of an object, which
> > has the default behavior of not lazy-fetching in a partial clone. It is
> > worth mentioning that this is the only place where there is potential for
> > lazy-fetching and all other cases are properly handled, making it safe to
> > remove this global here.
>
> This paragraph is very well explained.
>

Thanks.

> > @@ -1728,14 +1727,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
> >       int report_end_of_input = 0;
> >       int hash_algo = 0;
> > 
> > -     /*
> > -      * index-pack never needs to fetch missing objects except when
> > -      * REF_DELTA bases are missing (which are explicitly handled). It only
> > -      * accesses the repo to do hash collision checks and to check which
> > -      * REF_DELTA bases need to be fetched.
> > -      */
>
> OK.  The comment describes the design choice we made to flip the
> fetch_if_missing flag off.  The old world-view was that we would
> notice a breakage by non-functioning index-pack when a lazy clone is
> missing objects that we need by disabling auto-fetching, and we
> instead explicitly handle any missing and necessary objects by lazy
> fetching (like "when we lack REF_DELTA bases").  It does sound like
> a conservative thing to do, compared to the opposite approach we are
> taking with this patch, i.e. we would not fail if we tried to access
> objects we do not need to, because we have lazy fetching enabled,
> and we just ended up with bloated object store nobody may notice.
>
> To protect us from future breakage that can come from the new
> approach, it is a very good thing that you added new tests to ensure
> no unnecessary lazy fetching is done (I am not offhand sure if that
> test is sufficient, though).
>
> > -     fetch_if_missing = 0;
>
> Looking good to me.  Jonathan, who reviewed the previous round, do
> you have any comments?
>
> Thanks, all.  Will queue.
>

It does seem that the tests need to be changed significantly. Will do.

> > diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> > index f519d2a87a..46af8698ce 100755
> > --- a/t/t5616-partial-clone.sh
> > +++ b/t/t5616-partial-clone.sh
> > @@ -644,6 +644,41 @@ test_expect_success 'repack does not loosen promisor objects' '
> >       grep "loosen_unused_packed_objects/loosened:0" trace
> >  '
> > 
> > +test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collsions' '
> > +     rm -rf server promisor-remote client repo trace &&
> > +
> > +     # setup
> > +     git init server &&
> > +     for i in 1 2 3 4
> > +     do
> > +             echo $i >server/file$i &&
> > +             git -C server add file$i &&
> > +             git -C server commit -am "Commit $i" || return 1
> > +     done &&
> > +     git -C server config --local uploadpack.allowFilter 1 &&
> > +     git -C server config --local uploadpack.allowAnySha1InWant 1 &&
> > +     HASH=$(git -C server hash-object file3) &&
> > +
> > +     git init promisor-remote &&
> > +     git -C promisor-remote fetch --keep "file://$(pwd)/server" &&
> > +
> > +     git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
> > +     git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
> > +     git -C client config extensions.partialClone 1 &&
> > +     git -C client config remote.origin.promisor 1 &&
> > +
> > +     git init repo &&
> > +     echo "5" >repo/file5 &&
> > +     git -C repo config --local uploadpack.allowFilter 1 &&
> > +     git -C repo config --local uploadpack.allowAnySha1InWant 1 &&
> > +
> > +     # verify that no lazy-fetching is done when fetching from another repo
> > +     GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> > +                                     fetch --keep "file://$(pwd)/repo" main &&
> > +
> > +     ! grep "want $HASH" trace
> > +'
> > +
> >  test_expect_success 'lazy-fetch in submodule succeeds' '
> >       # setup
> >       test_config_global protocol.file.allow always &&

Thanks
