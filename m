Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A50C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB43208A3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hhmyhW4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfKUAQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:16:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53406 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKUAQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:16:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88108AB2D1;
        Wed, 20 Nov 2019 19:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=lgxwIX8rbkrkQYgsEv60SanRIUk=; b=hhmyhW4ND2yTBW1SKhNC
        02pPRQFkxOjVP8ODlbQTsWvtVK/VowbhmPm6XzRW4bdgDYqgaV8KErVOSUwJNtSW
        kdWpGCpgHa0+K60RDL7YCkg5YHxyQGQ2cM5/0AYugiJZC6IrAAFqJrxYF+7ta4ei
        ZAzh0T+hYptVgvUy1+emB70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=t7OP17s/hoKJvR89XWmHw55ZG+e4Kg2u2Zqr3e5bZQTfab
        LkT/UpQicXLsrQ76Z6ACe4W/40pcVRM46DKiW4N/u6V7VUKfIYTQd6VIm3mzwHWE
        0Bt2qQOr+LxVYS9yAXsXj6wms4RIURR+V819ItmVL2+lifE5HQVh+x1Oa3CPQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 800C7AB2D0;
        Wed, 20 Nov 2019 19:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACEF6AB2CE;
        Wed, 20 Nov 2019 19:16:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] sequencer: handle rebase-merge for "onto" message
References: <pull.327.git.gitgitgadget@gmail.com>
        <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
        <xmqq8sod3l5a.fsf@gitster-ct.c.googlers.com>
        <20191118112357.GA29922@danh.dev>
Date:   Thu, 21 Nov 2019 09:16:03 +0900
Message-ID: <xmqqa78qaxto.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BF536C2-0BF4-11EA-9243-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> Anyway, when reading their patch, I discovered a problem with
> git rebase --rebase-merges when its message is onto.
>
> Here is a patch to fix it.
>
> I applied Dscho's patches over my dd/sequencer-utf8 then writing this
> patch, in case you have problem applying it.
>
> The context for the diff is coming from Dscho's patches.

Thanks.  While technically this is independent from the "safer
rebase-merges labels" topic (specifically its preparation step),
in the larger picture, this too is to ensure we do not use a wrong
string as a label ;-), so I'll queue it on top of those two patches,
just like how you developed.

Thanks.

> -------8<--------------------
> From 48205889b404b82baa4b30c2eedd52243c349e3e Mon Sep 17 00:00:00 2001
> From: Doan Tran Cong Danh <congdanhqx@gmail.com>
> Date: Mon, 18 Nov 2019 18:02:05 +0700
> Subject: [PATCH] sequencer: handle rebase-merge for "onto" message
>
> In order to work correctly, git-rebase --rebase-merges needs to make
> initial todo list with unique labels.
>
> Those unique labels is being handled by employing a hashmap and
> suffixing an unique number if any duplicate is found.
>
> But we forgat that beside of those labels for side branches,
> we also make a special label `onto' for our so-called new-base.
>
> In a special case that any of those labels for side branches named
> `onto', git will run into trouble.
>
> Correct it.
>
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---
>  sequencer.c              |  5 +++++
>  t/t3430-rebase-merges.sh | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 350045b1b4..fc81e43f0f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4569,10 +4569,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  	strbuf_init(&state.buf, 32);
>  
>  	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
> +		struct labels_entry *onto_label_entry;
>  		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
>  		FLEX_ALLOC_STR(entry, string, "onto");
>  		oidcpy(&entry->entry.oid, oid);
>  		oidmap_put(&state.commit2label, entry);
> +
> +		FLEX_ALLOC_STR(onto_label_entry, label, "onto");
> +		hashmap_entry_init(&onto_label_entry->entry, strihash("onto"));
> +		hashmap_add(&state.labels, &onto_label_entry->entry);
>  	}
>  
>  	/*
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f728aba995..4e2c0ede51 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -474,4 +474,25 @@ test_expect_success '--rebase-merges with commit that can generate bad character
>  	git rebase --rebase-merges --force-rebase E
>  '
>  
> +test_expect_success '--rebase-merges with message matched with onto label' '
> +	git checkout -b onto-label E &&
> +	git merge -m onto G &&
> +	git rebase --rebase-merges --force-rebase E &&
> +	test_cmp_graph <<-\EOF
> +	*   onto
> +	|\
> +	| * G
> +	| * F
> +	* |   E
> +	|\ \
> +	| * | B
> +	* | | D
> +	| |/
> +	|/|
> +	* | C
> +	|/
> +	* A
> +	EOF
> +'
> +
>  test_done
