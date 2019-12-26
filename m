Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505AFC2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BF320740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWg67ogR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLZRzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:55:45 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38409 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZRzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:55:45 -0500
Received: by mail-qv1-f65.google.com with SMTP id t6so9290132qvs.5
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1x1LLrdCjqVLVr9usD9RtG0mEE/OmrglTEhae+yyXcE=;
        b=eWg67ogRtu2mm/a78GbI5gAPvAFaVKJvnLVKLWeSrbUXyOAnZ/fr6gQ6hTh9St9qcx
         +SVA7Je9kZEIepbRQY2qxrJgEVP8zl34gEnP+cK9xUsm1LZTlReqrOi6glGi+h2Ed9iX
         snm9xv4AZ6cUqCpeIu2RLLQ5S7nrnLlN8gMk6jh0k+W+khQYqrYP0ihkqukboXHqIi/+
         JK51Xf6WQAqK6Y5Pyqy1A/MZ+PWLKNJXdVO3U81HyPm+cKP8w3hxNxIBR9QwZKbDS4Ho
         xWbTfK2Ld3ZB3Fs1zcaqa4M8wLsuI2Lg1MHCmL1E283GFmI0AjWpAaHEv2tOSWxh9CC1
         bmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1x1LLrdCjqVLVr9usD9RtG0mEE/OmrglTEhae+yyXcE=;
        b=QTZashDRB/6Xy/CEKs+cAEO/qfRjIyPbBXTL5Okdcvb3WOAPo0KzhSHkvBhgfIjJ5i
         bI4B9UakWATN5tYqodt06sKHiiL3Oaf5UiXFIrNpGGM4HRHToFlUyzOJSUDJdZzdYfQY
         V8+Jhelnj7ELBZuhJyp5G6mK+sw1Fx0HXIzbPo/6EU8z8ptJwBK00NFYVWp8sLIBq97n
         Qbpd8TKazxXKQSTvnGg+Duwd2jDS3k7tQRHYPdb2eMqy4fDCYy0W/5O06b/cD1dEahWY
         pXg2Td3gfvDC9b8HQ8V/e7QDa/87DWpxILImAB4mjxiKPS35bERs7WlxpnKo6N1dQYof
         p55Q==
X-Gm-Message-State: APjAAAV2WZPtlY2xo6enCnOsAPO6lPpd71Oln5TXC1oExDPr/zRnbwWL
        7jLCJHPoAA7tg1juXjCLyosMkodx
X-Google-Smtp-Source: APXvYqxr894zBup8ptrNHVMt+lpc08Iv2QOPvFFsJREkpjOiFWgapqqRkaLhgVXfUled/wIYDWh1OA==
X-Received: by 2002:a05:6214:1189:: with SMTP id t9mr36284856qvv.153.1577382943654;
        Thu, 26 Dec 2019 09:55:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1010:86cc:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id z28sm9837301qtz.69.2019.12.26.09.55.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:55:43 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.25.0-rc0)
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <02febb94-9749-c219-8fae-d109720f4c71@gmail.com>
Message-ID: <a86d6247-22cb-a240-6d9e-08a9e5ffec3f@gmail.com>
Date:   Thu, 26 Dec 2019 12:55:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <02febb94-9749-c219-8fae-d109720f4c71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/26/2019 12:19 PM, Derrick Stolee wrote:
> Here is the test-coverage report for v2.25.0-rc0 against v2.24.1.

> add-interactive.c
> add-patch.c

These two files had a lot of changes, but they are related to
the "builtin add -p" feature, which is still not complete. Hence,
tests do not cover this logic.

> builtin/bundle.c
> 73c3253d 143) static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
> 73c3253d 145) int bundle_fd = -1;
> 73c3253d 147) struct option options[] = {
> 73c3253d 152) argc = parse_options_cmd_bundle(argc, argv, prefix,
> 73c3253d 156) memset(&header, 0, sizeof(header));
> 73c3253d 157) if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
> 73c3253d 158) return 1;
> 73c3253d 159) if (!startup_info->have_repository)
> 73c3253d 161) return !!unbundle(the_repository, &header, bundle_fd, 0) ||
> 73c3253d 162) list_bundle_refs(&header, argc, argv);
> 73c3253d 187) else if (!strcmp(argv[0], "unbundle"))
> 73c3253d 188) result = cmd_bundle_unbundle(argc, argv, prefix);

It is unfortunate that we never had tests for "git bundle unbundle",
but this code is just a refactor of the previously-untested code.

> dir.c
> 96cc8ab5 663) pl->use_cone_patterns = 0;
> 96cc8ab5 665) goto clear_hashmaps;
> 190a65f9 676)    strihash(translated->pattern) :
> 96cc8ab5 689) hashmap_add(&pl->parent_hashmap, &translated->ent);
> 96cc8ab5 690) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
> 96cc8ab5 691) free(data);
> 96cc8ab5 692) return;
> 96cc8ab5 698) goto clear_hashmaps;
> 190a65f9 707)    strihash(translated->pattern) :
> 96cc8ab5 716) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
> 96cc8ab5 717) free(data);
> 96cc8ab5 718) free(translated);
> 96cc8ab5 1280) return MATCHED;

Many of these lines are related to verifying cone-mode patterns
in the sparse-checkout file. I plan to send a series that makes
these checks more robust, and that will include more tests that
should improve coverage here. I'll try to get that out before
the release candidate period to ensure these uncovered lines
do not contain a bug that needs fixing.
> progress.c
> 44a4693b 308) return start_progress_delay(title, total, get_default_delay(), 1);

This is the one line in start_delayed_sparse_progress(), which
has no callers. Shall we delete?

> revision.c
> 0aa0c2b2 3202) static void reset_topo_walk(struct rev_info *revs)
> 0aa0c2b2 3204) struct topo_walk_info *info = revs->topo_walk_info;
> 0aa0c2b2 3206) clear_prio_queue(&info->explore_queue);
> 0aa0c2b2 3207) clear_prio_queue(&info->indegree_queue);
> 0aa0c2b2 3208) clear_prio_queue(&info->topo_queue);
> 0aa0c2b2 3209) clear_indegree_slab(&info->indegree);
> 0aa0c2b2 3210) clear_author_date_slab(&info->author_date);
> 0aa0c2b2 3212) FREE_AND_NULL(revs->topo_walk_info);
> 0aa0c2b2 3213) }
> 0aa0c2b2 3220) reset_topo_walk(revs);

We call reset_topo_walk(revs) on line 3220 only if we run
init_topo_walk() a second time on the same revs (and revs->topo_walk_info
is non-null). 0aa0c2b2 allowed this, but it appears nothing needs it right
now. Looks safe, anyway.

> strbuf.c
> b38dd9e7 1129) int strbuf_edit_interactively(struct strbuf *buffer, const char *path,

(more add-interactive stuff here)

> t/helper/test-run-command.c

(these changes are Windows-specific)

Those are the things that caught my eye. All new behavior
is looking pretty well tested. Thanks, everyone!

Thanks,
-Stolee
