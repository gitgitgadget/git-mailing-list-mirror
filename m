Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5009C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8159661353
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbhDLRkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:40:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54824 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhDLRkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:40:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF85D12EC1A;
        Mon, 12 Apr 2021 13:39:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jhy2m5LHDO2+hVV351fIfk1EwzU=; b=FS4Mjp
        dCgmQrhi1LAtkPwDtsAZyBHh5gvqE2zIsc+LF4hhii4Tv2Qj76MqS1lhBis2Bu95
        gecamZx1SP7MOZwxXYj0LtrGprjy2YL9U8uuuG0yliZXuy0pdwrli7o2t47JY9fF
        ZvS7lplseG/XStWyz9/Y3k+K9KdkjIS9ZtJ8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u0pxBoLbtq36kAQ1256iHRujHAUImsQX
        0tG8/KXkZD67HFS+du7JXKMSfh6oOvfeEaURcdU0I2TvO7DWm6W8UEsTPGktr25b
        DVm+++Ka3YdqpjxoxBqAyD5UD4pUOZGy1JECsMdxKIUhcvOP7utR4Rfft13yuzP5
        s2v+fA1QIRg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E06AF12EC19;
        Mon, 12 Apr 2021 13:39:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F43712EC15;
        Mon, 12 Apr 2021 13:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2] merge-ort: only do pointer arithmetic for non-empty
 lists
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
        <pull.930.v2.git.1618139107203.gitgitgadget@gmail.com>
        <CABPp-BE2D933Bc6w-OeaJc1r+1_tvMeK2M-HK4eEKPkQb3BdQQ@mail.gmail.com>
Date:   Mon, 12 Apr 2021 10:39:54 -0700
In-Reply-To: <CABPp-BE2D933Bc6w-OeaJc1r+1_tvMeK2M-HK4eEKPkQb3BdQQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Apr 2021 08:52:14 -0700")
Message-ID: <xmqqsg3ve711.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 187BE524-9BB6-11EB-A3B4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Otherwise, this patch looks good to me; thanks!

Queued, manually amended, and here is what I have.

$ git range-diff @{1}...
1:  ca4cc8d182 ! 1:  c1ea48a8f7 merge-ort: only do pointer arithmetic for non-empty lists
    @@ Commit message
         SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior merge-ort.c:2669:43 in
     
         Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## merge-ort.c ##
     @@ merge-ort.c: static void write_tree(struct object_id *result_oid,
    + 		       size_t hash_size)
    + {
      	size_t maxlen = 0, extra;
    - 	unsigned int nr = versions->nr - offset;
    +-	unsigned int nr = versions->nr - offset;
    ++	unsigned int nr;
      	struct strbuf buf = STRBUF_INIT;
     -	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
      	int i;
    @@ merge-ort.c: static void write_tree(struct object_id *result_oid,
     -	relevant_entries.nr = versions->nr - offset;
     -	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
     +	assert(offset <= versions->nr);
    ++	nr = versions->nr - offset;
     +	if (versions->nr)
     +		QSORT(versions->items + offset, nr, tree_entry_order);
      
