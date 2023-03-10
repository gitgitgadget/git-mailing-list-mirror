Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF32C6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCJVNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:13:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794969201
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:13:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso6930721ybu.9
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678482807;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=miprtTKdWmXAo67HDNayh5B3WlyuATxil7LsXbFfscw=;
        b=RfTZkXtRHwX27VVzkYU74iidXvVaqYzcPlmHDb9IRc2V++gmwwRmDuUdt+TY+GPROZ
         rUcPQGi0TodYT5mxzYMK9gvCrntIpyb227rHRTal3CD0+jxVom4R8t8Run9kF1PgdSfv
         wblDJ0SF++ufmrZ4a2rrn8AGlCKq5PL64my172jah5yIrFZcoA69kMUT5AfSOfRIz+4S
         hiQKuoq/fA0BuZCFFSMaNslZeF0sl9i+ZCx5HpHFHDH0ZqQXP34bw06yg31l27baVWWS
         /9mvvmz3wqpeHtHKP1jLsMI22ky+amkccagtfMEzU+cDZz5YjGPTTNNaL243i4HtA40t
         TfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678482807;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miprtTKdWmXAo67HDNayh5B3WlyuATxil7LsXbFfscw=;
        b=z7e05xumMvCVcGnMGztN/VIwDBuZWKmXCKUrDHAua8lsUiNTYdnPPzSBlBRFiYLZkh
         Syh4HhnEi31FbhaePtHmRtXupQtGFhDzUgPnZxLVoe/ONTVg1p1/2B7QNPl/3L7FQFf+
         NDyYebdway4H3caNJ/7oktkYcqo7+Z6b2LgqMuxCGUvZuVjH+ar6HAJyZYPENwqo0elf
         4Dn0QwgMY9KorNpcg83KD8FvcX1hszLafk/mJOqo88jQku7lMW0FkIut8ZSnkZCpkq0r
         DQdqj8mq0kqilk/t/Fb9mpxIoK4kO9pHMOIyv4xApu3PidlMvrW6rPZDV4MoxARkc6mC
         FrEA==
X-Gm-Message-State: AO0yUKXYYxttuDqz2JVpL6xew8JoAQbwCtKahLLu3VY8DEjNUSoN8sjQ
        +RDtVFslbknHV2oST3gsH9osE7wwfWWdH+ARD1bz
X-Google-Smtp-Source: AK7set8UL74ySeAinsZ5tdIForNtmvAXQS3vaLD5FJxzW10UjxHFnjY0VUxLxrRNWjDk0vKhuZojdL+renDYt4YxsEAM
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:be5a:a4f:a8ff:f75c])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:524:b0:ab8:1ed9:cfc5 with
 SMTP id y4-20020a056902052400b00ab81ed9cfc5mr16601594ybs.6.1678482807236;
 Fri, 10 Mar 2023 13:13:27 -0800 (PST)
Date:   Fri, 10 Mar 2023 13:13:21 -0800
In-Reply-To: <xmqqzg8k4ad9.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310211321.4135748-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] index-pack: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> > Hence, use has_object() to check for the existence of an object, which
> > has the default behavior of not lazy-fetching in a partial clone. It is
> > worth mentioning that this is the only place where there is potential for
> > lazy-fetching and all other cases are properly handled, making it safe to
> > remove this global here.
> 
> This paragraph is very well explained.

It might be good if the "all other cases" were enumerated here in the
commit message (since the consequence of missing a case might be an
infinite loop of fetching).

> OK.  The comment describes the design choice we made to flip the
> fetch_if_missing flag off.  The old world-view was that we would
> notice a breakage by non-functioning index-pack when a lazy clone is
> missing objects that we need by disabling auto-fetching, and we
> instead explicitly handle any missing and necessary objects by lazy
> fetching (like "when we lack REF_DELTA bases").  It does sound like
> a conservative thing to do, compared to the opposite approach we are
> taking with this patch, i.e. we would not fail if we tried to access
> objects we do not need to, because we have lazy fetching enabled,
> and we just ended up with bloated object store nobody may notice.
> 
> To protect us from future breakage that can come from the new
> approach, it is a very good thing that you added new tests to ensure
> no unnecessary lazy fetching is done (I am not offhand sure if that
> test is sufficient, though).

I don't think the test is sufficient - I'll explain that below.

> > +test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collsions' '
> > +	rm -rf server promisor-remote client repo trace &&
> > +
> > +	# setup
> > +	git init server &&
> > +	for i in 1 2 3 4
> > +	do
> > +		echo $i >server/file$i &&
> > +		git -C server add file$i &&
> > +		git -C server commit -am "Commit $i" || return 1
> > +	done &&
> > +	git -C server config --local uploadpack.allowFilter 1 &&
> > +	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
> > +	HASH=$(git -C server hash-object file3) &&
> > +
> > +	git init promisor-remote &&
> > +	git -C promisor-remote fetch --keep "file://$(pwd)/server" &&
> > +
> > +	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
> > +	git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
> > +	git -C client config extensions.partialClone 1 &&
> > +	git -C client config remote.origin.promisor 1 &&
> > +
> > +	git init repo &&
> > +	echo "5" >repo/file5 &&
> > +	git -C repo config --local uploadpack.allowFilter 1 &&
> > +	git -C repo config --local uploadpack.allowAnySha1InWant 1 &&

The file5 isn't committed?

> > +
> > +	# verify that no lazy-fetching is done when fetching from another repo
> > +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> > +					fetch --keep "file://$(pwd)/repo" main &&
> > +
> > +	! grep "want $HASH" trace
> > +'

It seems to me that this test clones a repo and then attempts to fetch
from another repo: so far, so good. But I don't think this tests what
we want: firstly, the file5 isn't committed, so it is never fetched. And
even if it was, we only check that file3 was never fetched from "$(pwd)/
server". But file3 has nothing to do with the subsequent fetch: we are
only fetching file5. It is the hash of file5 that we are checking for
collisions, and thus it is file5 that we want to verify is not fetched.

So I think the way to do this is to have 3 repositories like the author
is doing now (server, client, and repo), and do it as follows:
 - create "server", one commit will do
 - clone "server" into "client" (partial clone)
 - clone "server" into "another-remote" (not partial clone)
 - add a file ("new-file") to "server", commit it, and pull from "another-remote"
 - fetch from "another-remote" into "client"

This way, "client" will need to verify that the hash of "new-file" has
no collisions with any object it currently has. If there is no bug,
"new-file" will never be fetched from "server", and if there is a bug,
"new-file" will be fetched.

One problem is that if there is a bug, such a test will cause an
infinite loop (we fetch "new-file", so we want to check it for
collisions, and because of the bug, we fetch "new-file" again, which we
check for collisions, and so on) which might be problematic for things
like CI. But we might be able to treat timeouts as the same as test
failures, so this should be OK.
