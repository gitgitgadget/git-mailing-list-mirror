Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DDC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C7C60F4B
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhHBVHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhHBVHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:07:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7BC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:06:51 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s8-20020a17090a0748b0290177ecd83711so1084345pje.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UICWBgYaJ+vbZtMlo04wSVlND1O3At4ZNoXC5ZOoRbc=;
        b=cD/3Ch7wKo+J1mN3lAKQAqVAuCSQHGVkQrSs+zEblJrlQzrfQ2i9Z8DmLMWVoSmmGQ
         j3P1WqRV9JU1/VHUu4IvAKPdpVhHIjV/mNypRupsBJJhpoj0gXq8cnANOiTjHBHub+5e
         mfxILxWy+lsF1nCiJCEEVh3pfMMwaTqIZzhqf5kGUlZ2+jEXHsEt3M/hXYC/HX7AgaB5
         xDwDNeV2uNJMSQxkljHCv5tdDZzb1kIJYaSypaJI3DzN/AGpSqoXdXBCIuvmee2GvpZ3
         XWnQLFlkPdPVMwNAm9xIqqL1Ksh3Ji33Ezs1RZ6ze2Gfl/wSuZXEEvTL7SCJOfBJf3bV
         EZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UICWBgYaJ+vbZtMlo04wSVlND1O3At4ZNoXC5ZOoRbc=;
        b=R+QkHaVcCBhM3KYnBfQGruq9QbA+JpzoAlqPR7CL0dD2h464MAwwmPnwu5UQKQvdjC
         ivIYb0OqKFk8VdBhMGKwDtUwEXSC+IL7m+hhEZxEHkmwha+RPhRY/TYoLEKVBbZ2tCsP
         CPEtfK8eT4IX5U7Uonbd1YrATHI9jLiVVSIqpBK2+6pAZlTAXlXmBq1k6aAQf/OlQkbg
         voHggpqh177KpYplgte44MppdkCrPfz7ayzdGPPXcYUQmcX5GubqertN6pm1xps1c857
         uI7Txi9njC2i6f/YIeBUxqJXYn62DOQW7Ba9Pc1zYUjT1FXXgsKZqkA6+x/+xJfDusrJ
         5H9Q==
X-Gm-Message-State: AOAM530gpHIhVD35mBoTqrZimRj1pQYw4DmEVIzjynDPEVH6G3PhVo2F
        /94jZeD23Z/YXRg+pwQXORj0Ykb88t9QPMG3rwtx
X-Google-Smtp-Source: ABdhPJxkIptkmeuWvMymVZbiT67ksXXxWwdxGdnAKgSYkGcJtHAEllRSo9UUJGTKVFgqIv3cOFMw13EinoV+UHmN9V3l
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:ce44:0:b029:3aa:37f6:6fd6 with
 SMTP id y65-20020a62ce440000b02903aa37f66fd6mr18409802pfg.59.1627938410430;
 Mon, 02 Aug 2021 14:06:50 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:06:44 -0700
In-Reply-To: <20210731203415.618641-1-kim@eagain.st>
Message-Id: <20210802210644.3432544-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210731203415.618641-1-kim@eagain.st>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: Re: [PATCH v2] upload-pack.c: treat want-ref relative to namespace
From:   Jonathan Tan <jonathantanmy@google.com>
To:     kim@eagain.st
Cc:     git@vger.kernel.org, bwilliams.eng@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index e9e471621d..96df3073d1 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -298,6 +298,78 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
>  	grep "want-ref refs/heads/o/bar" log
>  '
> 
> +REPO="$(pwd)/repo-ns"
> +
> +test_expect_success 'setup namespaced repo' '
> +	git init -b main "$REPO" &&
> +	cd "$REPO" &&
> +	test_commit a &&
> +	test_commit b &&
> +	git checkout a &&
> +	test_commit c &&
> +	git checkout a &&
> +	test_commit d &&
> +	git update-ref refs/heads/ns-no b &&
> +	git update-ref refs/namespaces/ns/refs/heads/ns-yes c &&
> +	git update-ref refs/namespaces/ns/refs/heads/hidden d &&
> +	git -C "$REPO" config uploadpack.allowRefInWant true &&
> +	git -C "$REPO" config transfer.hideRefs refs/heads/hidden
> +'

If you're not using a subshell to set up the repo, you should add '-C
"$REPO"' to all the "git" commands (like you do in the last 2 lines)
instead of "cd"-ing halfway through the test. The helper function
test_commit also has that facility ('test_commit -C "$REPO" a', for
example).

> +test_expect_success 'want-ref with namespaces' '
> +	oid=$(git -C "$REPO" rev-parse c) &&
> +	cat >expected_refs <<-EOF &&
> +	$oid refs/heads/ns-yes
> +	EOF
> +	>expected_commits &&
> +
> +	oid=$(git -C "$REPO" rev-parse c) &&
> +	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_command fetch)
> +	0001
> +	no-progress
> +	want-ref refs/heads/ns-yes
> +	have $oid

Do we need this "have" line? I think we can just omit it, since what the
client has is irrelevant to the test. (Same for the other tests.)

> +	done
> +	0000
> +	EOF
> +
> +	env GIT_NAMESPACE=ns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
> +	check_output
> +'
> +
> +test_expect_success 'want-ref outside namespace' '
> +	oid=$(git -C "$REPO" rev-parse c) &&
> +	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_command fetch)
> +	0001
> +	no-progress
> +	want-ref refs/heads/ns-no
> +	have $oid
> +	done
> +	0000
> +	EOF
> +
> +	test_must_fail env GIT_NAMESPACE=ns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
> +	grep "unknown ref" out
> +'

For the failure tests, it's safer to write them in pairs - one that
succeeds and one that fails. Here, a typo in "ns-no" (e.g. if I wrote
"ns-noo" instead) would cause the exact same result, but if we were to
write a pair of tests, we wouldn't have this problem.

To do this, you can bundle the same code into a function and call them
from both tests. E.g.:

  setup_want_ns_no () {
    (common code)
  }

  test_expect_success 'want-ref without namespace works...' '
    setup_want_ref_outside_namespace &&
    test-tool ... &&
    check_output
  '

  test_expect_success '...but, with namespace, does not work' '
    setup_want_ref_outside_namespace &&
    test_must_fail env GIT_NAMESPACE=ns ... &&
    grep "unknown ref" out
  '

The first test_expect_success does seem redundant, but I can't think of
a better way to ensure that the helper function (setup_want_ns_no in
this case) is written correctly.

> +test_expect_success 'hideRefs with namespaces' '
> +	oid=$(git -C "$REPO" rev-parse c) &&
> +	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_command fetch)
> +	0001
> +	no-progress
> +	want-ref refs/heads/hidden
> +	have $oid
> +	done
> +	0000
> +	EOF
> +
> +	test_must_fail env GIT_NAMESPACE=ns test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
> +	grep "unknown ref" out
> +'
> +

Same for this.

> diff --git a/upload-pack.c b/upload-pack.c
> index 297b76fcb4..c897802f1c 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1417,21 +1417,24 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
>  			  struct string_list *wanted_refs,
>  			  struct object_array *want_obj)
>  {
> -	const char *arg;
> -	if (skip_prefix(line, "want-ref ", &arg)) {
> +	const char *refname_nons;
> +	if (skip_prefix(line, "want-ref ", &refname_nons)) {
>  		struct object_id oid;
>  		struct string_list_item *item;
>  		struct object *o;
> +		struct strbuf refname = STRBUF_INIT;

"refname" needs to be released somewhere.

> 
> -		if (read_ref(arg, &oid)) {
> -			packet_writer_error(writer, "unknown ref %s", arg);
> -			die("unknown ref %s", arg);
> +		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
> +		if (ref_is_hidden(refname_nons, refname.buf) ||
> +		    read_ref(refname.buf, &oid)) {
> +			packet_writer_error(writer, "unknown ref %s", refname_nons);
> +			die("unknown ref %s", refname_nons);
>  		}
> 
> -		item = string_list_append(wanted_refs, arg);
> +		item = string_list_append(wanted_refs, refname_nons);
>  		item->util = oiddup(&oid);
> 
> -		o = parse_object_or_die(&oid, arg);
> +		o = parse_object_or_die(&oid, refname_nons);
>  		if (!(o->flags & WANTED)) {
>  			o->flags |= WANTED;
>  			add_object_array(o, NULL, want_obj);

Besides my comments about the tests, I think that this patch looks good.
Junio had a relevant question [1]:

> OK.  Assuming that it makes sense for the hideRefs mechanism to kick
> in here (which I would prefer to hear from others who've worked with
> this code, say Jonathan Tan?), the updated code makes sense.

I think it makes sense here. I checked my old code that Kim linked [2],
and in that patch I put it somewhere else (specifically, the part that
prints out the "wanted-ref" lines), but it makes sense that it is
different. In my version, "want-ref" supports globs and is allowed to
match 0 refs, but in Brandon's final version, "want-ref" does not
support globs and must match the ref, so checking it upon parse (as is
done in this commit) is the most reasonable.

Questions from Kim:

> Jonathan: I took the test code from your original patch introducing ref-in-want,
> but modified it substantially. Let me know if it is conventional to credit you
> anyway, and by which trailer.

I don't think there's a convention, but you can use the "Helped-by:"
trailer if you want.

> I have also updated the code for the v2 to use refname_nons for any die() calls,
> as I realised that this may be transmitted to the client via sideband (is that
> correct?).

I believe that only packet_writer_error() output is sent via sideband,
but it still makes sense for the server-side output to print out the ref
as read from the client verbatim.

[1] https://lore.kernel.org/git/xmqqbl6j1vgh.fsf@gitster.g/
[2] https://lore.kernel.org/git/d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com/
