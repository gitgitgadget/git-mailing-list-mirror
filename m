Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB8BC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 20:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349615AbiFNUUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352216AbiFNUUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 16:20:08 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1353E17A89
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:20:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id s1so7447796ilj.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=G6+tKdTAOMif7hqTKEp56v0v4gVxQUS7XdqxcI3rkWc=;
        b=QS7+ZEii5STy1rXup4SStriHfMxxFDbQmlNEDGXRpA5/OdNpZq7iVkAIMTSslBRA2u
         QptxIv0uM7dgfcZCysIqRd1KCOfy+GKY/6XENbIaffomdWNi5/WlJEqzlkHGR/O2CAUq
         f6QYzh+D3PjCHPCBADewa+3zfVJCjN4yvHitKCUVQFkiy6LtH69hHK+KoQWVSti6y4Ag
         Lbl59kDQbHzShuekH+TDJgYsWiCWYhqM+jtUeY2J8lpcAFL7C0qY0RIX40bW8bEtIyrE
         sJmzBvYhNUlANyGkT7cxSJ7R/J2dzIH3jDYD7sXUotN4RcKPtTvsSX8waa+D7ZnWuEqd
         d+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=G6+tKdTAOMif7hqTKEp56v0v4gVxQUS7XdqxcI3rkWc=;
        b=KvbZNnWgEi8bvMv/Olp4OQoCVwtHW9PJseXUP09uDPwAJ5TWDzwoMLkNIQf9goQylx
         rNKRp76hjJvU7urgWAqG5g1+QeXRnpDS58nXX7U7L8MgJNV/9bWlfrynOs17OD/0zNi3
         fEQJcSfexPPxfvIutKxRSX1sj234x+KuJxIzmLfzIN9H7JY7Cdq4Cg3K9eqam/s68umW
         jWigiEFb5oTL4bhayiiwzRLfYyAqU/VsdnIn++gqbbYUcyTz7LPMeAlAszrE6n0ea86e
         kBNjMoxIZU9de9o4UrCAsaDS0pf6f38JnoTnT6QcfHrhmoDbso6O45QOmHjv7qXmMzGq
         CqzA==
X-Gm-Message-State: AJIora8m4uTHFlzliv4Ru8emfhQuAYkM1nT38pW1Ndhy9XzTjx3RBS3Y
        gPLKPc6gACZl1h4K9v4w9n9raTTEOmLy35M1KDd2vfhauosx+7hOG43e8N+eCUygN28BSxLkLP0
        VMCfUA8nKwb1q6o4mxgjWWXPPakiYZmGwyra9c60pF+h+kY5QlOEqYO2rEM+aDkNNmSAByg==
X-Google-Smtp-Source: AGRyM1tZxTI5/Vf4QzUmSZLG7potbyZLyhAauu8pQ+fq3BraHcBxaBYSHVMNKO0N6a2hmlsiPgyaSw==
X-Received: by 2002:a05:6e02:164b:b0:2d3:ccea:ff38 with SMTP id v11-20020a056e02164b00b002d3cceaff38mr4006467ilu.37.1655238007029;
        Tue, 14 Jun 2022 13:20:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id z3-20020a027a43000000b0032b5e4281d3sm5235773jad.62.2022.06.14.13.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:20:06 -0700 (PDT)
Message-ID: <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
Date:   Tue, 14 Jun 2022 16:20:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Git Test Coverage Report for v2.37.0-rc0
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Neeraj Singh <nksingh85@gmail.com>
References: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
In-Reply-To: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 4:18 PM, Derrick Stolee wrote:
> Ævar Arnfjörð Bjarmason	338959da remote.c: remove braces from one-statement "for"-loops
> remote.c
> 338959da 149) for (i = 0; i < remote->url_nr; i++)
> 338959da 153) for (i = 0; i < remote->pushurl_nr; i++)
> Ævar Arnfjörð Bjarmason	323822c7 remote.c: don't dereference NULL in freeing loop
> remote.c
> 323822c7 151) FREE_AND_NULL(remote->url);

Just noting that these lines are inside remote_clear() which is called by
remote_state_clear(), which is called by repo_clear(). Apparently we have
no tests that clear a 'struct repository' that loaded remotes? This sounds
likely since we don't close these unless they are not the_repository.

> Ævar Arnfjörð Bjarmason	fd3aaf53 run-command: add an "ungroup" option to run_process_parallel()
> run-command.c
> fd3aaf53 1645) code = pp->start_failure(pp->ungroup ? NULL :
> fd3aaf53 1646)  &pp->children[i].err,
> fd3aaf53 1649) if (!pp->ungroup) {
> fd3aaf53 1650) strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
> fd3aaf53 1651) strbuf_reset(&pp->children[i].err);

This change seems sufficiently complicated that it would be good to look
into the test coverage here. It's possible that it is covered by the
GIT_TEST_* variables that I didn't use when generating my test coverage.

> Christian Couder	511cfd3b http: add custom hostname to IP address resolutions
> http.c

(These untested lines are my fault for not having Apache installed. I'll
be sure to include that in my coverage next time.)

> Derrick Stolee	b56166ca multi-pack-index: use --object-dir real path
> builtin/multi-pack-index.c
> b56166ca 61) opts.object_dir = xstrdup(get_object_directory());

This is demonstrating that opts.object_dir is never populated before
we parse the options. We must be handling a NULL object_dir properly
somewhere else. I'll work on a patch to fix this.

> Derrick Stolee	080ab56a cache-tree: implement cache_tree_find_path()
> cache-tree.c
> 080ab56a 104) struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)

Hm. This commit claims that this method will be used later, but it never is.

I even checked our code in microsoft/git and it's dead code there, too. We
should probably revert this commit. (Or: will it be useful for Shaoxuan's
GSoC work? Perhaps we hold onto it for a little longer?)

> Jeff Hostetler	9915e08f t/helper/hexdump: add helper to print hexdump of stdin

I did my testing on Linux, so all of the FS Monitor stuff will be untested.
Even if we did the testing on macOS, I doubt that the daemon code would be
tracked properly.

> Neeraj Singh	23a3a303 update-index: use the bulk-checkin infrastructure
> builtin/update-index.c
> 23a3a303 68) flush_odb_transaction();

This is signalling that we never use 'git update-index --verbose' in our
test suite. Might be worth fixing that.

> Taylor Blau	5b92477f builtin/gc.c: conditionally avoid pruning objects via loose
> builtin/gc.c
> 5b92477f 337) strvec_push(&repack, "--cruft");
> 5b92477f 338) if (prune_expire)
> 5b92477f 339) strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);

The context here is this:

static void add_repack_all_option(struct string_list *keep_pack)
{
	if (prune_expire && !strcmp(prune_expire, "now"))
		strvec_push(&repack, "-a");
	else if (cruft_packs) {
		strvec_push(&repack, "--cruft");
		if (prune_expire)
			strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);
	} else {

The only test that checks this behavior runs "git gc --cruft --prune=now",
so the "-a" option is being added and we never add the "--cruft" option.

We should probably add a test for "git gc --cruft" with a different prune
time.

> Taylor Blau	f9825d1c builtin/repack.c: support generating a cruft pack
> builtin/repack.c
> f9825d1c 680) strvec_pushf(&cmd.args, "--cruft-expiration=%s",

The --cruft-expiration option is not tested.

> f9825d1c 708) fprintf(in, "%s.pack\n", item->string);

This is related to the existence of .keep packs. A corner case, but maybe
worth exploring.

> pack-write.c
> 5dfaf49a 330) unlink(mtimes_name);
> 5dfaf49a 331) fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);

This appears to be an interesting case for the write_mtimes_file() method,
since its first parameter is 'mtimes_name' and all tested cases are
passing NULL, it seems.

Thanks,
-Stolee

