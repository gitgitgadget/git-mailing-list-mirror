Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B6EC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CF3613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhGNT2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGNT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:28:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D15C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:25:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k25-20020a635a590000b02902288bbae35bso2496481pgm.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DUtsKCJZ4ZYpQZpzlLKnlkVDM/1r0XOD5imFcN/BMlg=;
        b=iLX+mAVcZjUo/zjdexNPOVJjZBLx6/GvYeoItSMRCPNwTF7kE74GEe6LK82SVMwlMq
         uo+Txjvh8wX/sqqQgdMyjhSV43h2yo9y+BYlx++qAXRelcywKVehmSHo9nv2GtRBqu/Y
         qOUhtWQK3G4FKjbS/jVRV/l+v0E9077389W91vipCNQToXvGI/yr6laCL7gJV13kT8KX
         ZRQxuOKMpiwpQaiPJiiqevWmcEv5M+LIWaQksT2QpBGiZOgb37p3WxDwp6JQ3Il+HicT
         z0/to/hDvQrQi/o/CKwlpySl4NEade+W2IwdF4t0igrhsBKPa8yqkyZJiiIIr1ABjrgb
         jkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DUtsKCJZ4ZYpQZpzlLKnlkVDM/1r0XOD5imFcN/BMlg=;
        b=baZgqHT8C8fWVZGAeOt9sESuY4zlKLpQ3jqgu5O9VxT+aDiFj36Z1TmxMMbVe9bRKQ
         pI0TH3U6bE5X6Yu7oxpwPjiBg6Lib3Rb2oZ05OUerDLqtLtP7L5mtylytLglzZ8StA8j
         8/9r62rMV/ADicw74DLAq1DoNfe9PHeZ2Q2h4m+QdwFH01hnlHFmQKvJC7+Fa6CRpERo
         Vt0lFtKK1AcEx2UOCZE7lWK8u98ISj5IHP4N9qOwaWaEELewmGfoZMW39jdWJmBu1kgt
         IIyZpzB17zMikuX923W4NIxkpStYEwUZgyAOnu5PoK25t5S24Rc0yL3snFyTtUMFS1IT
         TMJg==
X-Gm-Message-State: AOAM531Vyym3dBQ0pInSe+4Bzc3tvbyNBuXD+bPOXLt0eiBq5iuV/OF6
        uethC/PHuIwBerW1k6rCI3DOwHdIeXQBepjt2t+G
X-Google-Smtp-Source: ABdhPJwVFfPftJvIbdIUaEztn1vWPUygap6OQFMO0bfFss4RhbCFogj8rEZE/5dmq+sTPQqGFOFw9RFRPIY+ANr12rMp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1a4b:0:b029:328:da0b:d83b with
 SMTP id a72-20020a621a4b0000b0290328da0bd83bmr11591474pfa.59.1626290713994;
 Wed, 14 Jul 2021 12:25:13 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:25:09 -0700
In-Reply-To: <YO4SZs40xzHEb6W7@google.com>
Message-Id: <20210714192509.4082107-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YO4SZs40xzHEb6W7@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: Re: [PATCH 1/3] send-pack: fix push.negotiate with remote helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >  
> >  	if (from_stdin) {
> >  		if (args.stateless_rpc) {
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index 0916f76302..5ce32e531a 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -1768,4 +1768,53 @@ test_expect_success 'denyCurrentBranch and worktrees' '
> >  	test_must_fail git -C cloned push --delete origin new-wt
> >  '
> >  
> > +. "$TEST_DIRECTORY"/lib-httpd.sh
> > +start_httpd
> 
> Ah, so fetch-push test wasn't doing any HTTP testing whatsoever. Does
> that mean there is a better place for these to go? Or does it mean that
> fetch-push test was under-testing?

These are closely related to the non-HTTP push negotiation tests that I
previously added to this file, so I don't think there is a better place.
As for whether this test is under-testing, I also don't think so - most
fetch/push processes would be the same regardless of protocol (but not
push negotiation, apparently).

> 
> > +
> > +test_expect_success 'http push with negotiation' '
> > +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> > +	URI="$HTTPD_URL/smart/server" &&
> > +
> > +	rm -rf client &&
> > +	git init client &&
> > +	test_commit -C client first_commit &&
> > +	test_commit -C client second_commit &&
> > +
> > +	# Without negotiation
> > +	test_create_repo "$SERVER" &&
> > +	test_config -C "$SERVER" http.receivepack true &&
> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> Pushing a branch with just the first commit...
> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> transfer.hideRefs (referenced by receive.hideRefs) says this ref will be
> omitted from advertisement, so we are forcing either an inefficient push
> or a negotiation to occur, by having the server initially claim not to
> know about it. 

Currently, the client attempts the negotiation before the push ref
advertisement, so the ref advertisement does not influence whether the
negotiation happens or not. 

(One might ask, should the negotiation happen after the push ref
advertisement then? This is an interesting idea, because the push ref
advertisement could have information that shows us that negotiation is
unnecessary, but I think that eventually it's best if we suppress the
push ref advertisement.)

> But it's only omitted from the *initial* advertisement,
> so it will be advertised in later rounds of negotiation, right?

There is no ref advertisement in any round of negotiation (there is no
ls-refs call). It will be acknowledged if the client queries for it,
though. (In any case, this config is not meant to affect the negotiation
part at all, because the negotiation part is using the "fetch" protocol
and the "receive" in "receive.hideRefs" means that it only affects the
"push" protocol.)

> > +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
> > +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
> And then from 'main' we push first_commit and second_commit?

Depending on the result of negotiation. Here, we push both commits (as
you can see from the next line you quoted below).

> > +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> Nice, I like the comment - this helps.

Thanks.

> > +
> > +	# Same commands, but with negotiation
> > +	rm event &&
> > +	rm -rf "$SERVER" &&
> Ok, clean up the trace and the server so we can start over, but we don't
> need to recreate the client commits because the server doesn't know
> about them anyway. Fine.
> > +	test_create_repo "$SERVER" &&
> > +	test_config -C "$SERVER" http.receivepack true &&
> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> > +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
> > +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
> And then here's the same set of commands with push negotiation, ok.
> > +	grep_wrote 3 event # 1 commit, 1 tree, 1 blob
> 
> Is there any reason the event counts would change or be
> non-deterministic outside of negotiation? Or, in other words, is this
> potentially flaky?

In general, no - the information that the server conveys to the client
in the ref advertisement (which commits it has) is quite well-defined,
so it can be precisely computed which objects the server has and hasn't.
One potential point of flakiness is if we change the client to push
extra objects (say, if the client decided to store one packfile per
commit and all its trees and blobs, and then push the entire packfile
whenever it needs to push that commit), but I don't think that we're
heading in that direction.

> 
> > +'
> > +
> > +test_expect_success 'http push with negotiation proceeds anyway even if negotiation fails' '
> > +	rm event &&
> > +	rm -rf "$SERVER" &&
> > +	test_create_repo "$SERVER" &&
> > +	test_config -C "$SERVER" http.receivepack true &&
> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> Hmm, this relies on 'client' being in the same state the above test left
> it. Probably better to recreate it or at least leave a loud warning
> about it in a comment above this test definition...

I ended up recreating it.

> 
> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> > +	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
> > +		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&
> 
> And we're pushing with protocol v0 so no negotiation can occur here,
> right?

Yes, but this is worth adding a comment for, so I added it.
> 
> > +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> > +	test_i18ngrep "push negotiation failed" err
> > +'
> > +
> > +# DO NOT add non-httpd-specific tests here, because the last part of this
> > +# test script is only executed when httpd is available and enabled.
> > +
> >  test_done
> > -- 
> > 2.32.0.288.g62a8d224e6-goog
> > 
> 
> Thanks for answering novice questions :)

Thanks for taking a look.
