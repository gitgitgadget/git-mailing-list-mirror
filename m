Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4100EC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 07:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377583AbiDDHEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDDHEa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 03:04:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F4E37BF5
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 00:02:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f18so4786411edc.5
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EigpIo4TqseYK9d8idwKexDqlES7BRrHVgmRaZzIU8U=;
        b=W4qOQNgA7Ds5KMMXwXL9/LHeAEybvtLgCdMOjQlqaYlOVuwdpc9TCtutIbIgLvEf29
         QeHJYsKpY9JPPh/+ctu4snMzA6sslxpAqmlYEW1HMhkE/E2NRYmgaJw7B87RkjViJQca
         nbOiyMKw/ZLfuLq/X457rg0W9+MEp+cU7L59E9OHdcC4xPKUUwQ+Eyk8LauhFaz6K/ob
         rQGza6uR3jJvQmQsXijXzD9mzDN9YMRJkona1qi5EFMH0EqUmPH8Lh/LdgKBG0jj0+oy
         anO7F+XPMBRjr9nyiGoQPtFnoGqYcQaOmjhDBuWaVm+/RMqQ0d8zIsvubYEKc6jaalbt
         WI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EigpIo4TqseYK9d8idwKexDqlES7BRrHVgmRaZzIU8U=;
        b=WYsJd0ywLZJGoF+qFDYhz/fkTG3Ayah/nTyzgg/akFz1bRyjxQ8Dz/f0CIKq82ZkL8
         URga2i1XW3HoJ18XptxBoX+zDwNAl2le1YBRo+w2NLyNxpWgWRrAIw7hjhkzXyjL6yLg
         B4/czy4/OjSVi7JMRBhYZ+bNVBOuw9ILHIdq3Wih/cDfDDRWu16jS6ct0wPWo9WTJVoB
         z8JH3Sv4WMwz5AxgmLEm8fCd2B8W94QygwVs7aIJi4aSYJITRCdaYcYMao/zmZGGkP6E
         OXRIwioVKEIAQN4c7W+7GIsz4KVtsX+Le1jlA24m6Qko/pT+8OrZyNp93luSgUuNA2RB
         A8jw==
X-Gm-Message-State: AOAM531vm4BYLLte6jWBp0p7VLl5fVzaQgx03cc/VWI4AOj/KaxK6OHT
        xxxm2P0NxorZVuYUzznXMVQ=
X-Google-Smtp-Source: ABdhPJwJ5/mIDrf3DabW1AgBrgYBUJWO/FFmvMC6IGHBsCmKiMfGADMaK58QPVfBhtrVoNh2BuK4yw==
X-Received: by 2002:a05:6402:2816:b0:419:2a8e:6d3e with SMTP id h22-20020a056402281600b004192a8e6d3emr31224928ede.47.1649055753464;
        Mon, 04 Apr 2022 00:02:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709063a0200b006e05b7ce3efsm3980381eje.107.2022.04.04.00.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:02:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbGjQ-002LNI-7l;
        Mon, 04 Apr 2022 09:02:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Mon, 04 Apr 2022 08:46:44 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220403182250.904933-4-sandals@crustytoothpaste.net>
Message-ID: <220404.86pmlxjppz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, brian m. carlson wrote:

> [...snip...]

Per
https://lore.kernel.org/git/220404.86tub9jql5.gmgdl@evledraar.gmail.com/
there's a bug here, in the preceding commit you:
	
	+static int parse_revision(struct strbuf *revision, const char *commit, int quiet)
	+{
	+	strbuf_init(revision, 0);
	[...]
	 static int get_stash_info(struct stash_info *info, int argc, const char **argv)
	 {
	 	int ret;
	@@ -157,19 +175,9 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
	 	if (argc == 1)
	 		commit = argv[0];
	 
	-	strbuf_init(&info->revision, 0);
	-	if (!commit) {
	-		if (!ref_exists(ref_stash)) {
	[...]
	+	if (parse_revision(&info->revision, commit, 0)) {
	+		free_stash_info(info);
	+		return -1;
	 	}

That caller wasn't dealing with an init'd "info", so we init'd it late
and freed it (which my revisions_release() makes a lot less icky). But
unrelated to that:
	
> +	if (argc) {
> +		/*
> +		 * Find each specified stash, and load data into the array.
> +		 */
> +		for (i = 0; i < argc; i++) {
> +			ALLOC_GROW_BY(items, nitems, 1, nalloc);
> +			if (parse_revision(&revision, argv[i], 0) ||

Here...

> +			    get_oid_with_context(the_repository, revision.buf,
> +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> +						 &items[i], &unused)) {
> +				error(_("unable to find stash entry %s"), argv[i]);
> +				res = -1;
> +				goto out;
> +			}
> +		}
> +	} else {
> +		/*
> +		 * Walk the reflog, finding each stash entry, and load data into the
> +		 * array.
> +		 */
> +		for (i = 0;; i++) {
> +			char buf[32];
> +			struct object_id oid;
> +
> +			snprintf(buf, sizeof(buf), "%d", i);
> +			if (parse_revision(&revision, buf, 1) ||

...and here you are leaking memory in a loop. Per the above you need a
strbuf_reset() for both.

Then (moved from earlier):

> +static int write_commit_with_parents(struct object_id *out, const struct object_id *oid, struct commit_list *parents)
> +{
> +	size_t author_len, committer_len;
> +	struct commit *this;
> +	const char *orig_author, *orig_committer;
> +	char *author = NULL, *committer = NULL;
> +	const char *buffer;
> +	unsigned long bufsize;
> +	const char *p;
> +	struct strbuf msg = STRBUF_INIT;

This is a leak, because:

> +out:
> +	strbuf_reset(&msg);

This should be strbuf_release(), not strbuf_reset().

Anyway, even if builtin/stash.c is currently a big fail whale it's still
useful to test new code with SANITIZE=leak, e.g. (and most of this is a
lot less painful on top of my in-flight topic) on top of yours you can
try:

        printf "leak:%s\n" setup_revisions add_object_array_with_path \
        	add_rev_cmdline cmd_log_init_finish strvec_push \
                get_untracked_files pump_io_round setup_rename_conflict_info parse_pathspec \
                prep_parse_options init_reflog_walk >/tmp/supp.txt;
	LSAN_OPTIONS=print_suppressions=0:suppressions=/tmp/supp.txt ./t3903-stash.sh  -vixd

Where that printf is just something I came up with via trial & error by
re-running the test with -vixd and quieting existing leaks, until
getting to the first leak new in your topic.

