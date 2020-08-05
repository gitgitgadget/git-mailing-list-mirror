Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F0C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6FC206F6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DMSLJbz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHEWEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:04:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61528 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHEWEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:04:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DDE88A4C5;
        Wed,  5 Aug 2020 18:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjTozFGksikmp8ag8MN0UAofxpc=; b=DMSLJb
        z2o7gHWRNPtEh9cI7+/JmxUOvSTlixMLD9DMkzuSDM2h3JHyiA+XKW+5CIk6+z5x
        T/+otXM+GcBGAZ3QHARfUzbyJRdbDCee8ZMjzFavL30aibtUsXxy/iQ2k/V2RNv/
        9+vp0nAR01daeBECIOgROkb3GL8NWOGSoXqfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cRhAAkWUK/68m594lKvk6KXqE3GDl8Jz
        JWKAT/8HkCcRVVUVM/N3c9YALPel0nSQsx3E8FpwjHaimkUNpne7nEEN3Dp3cCRR
        SIMutVtDmwR43bb9sknmGOATy5Edd5u+vry9Rql+saO2rk7VLbtp4VUu/oss+z3X
        jMjTqUZy61k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 040998A4C4;
        Wed,  5 Aug 2020 18:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88FA98A4C3;
        Wed,  5 Aug 2020 18:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 0/9] [GSoC] Improvements to ref-filter
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 15:04:39 -0700
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Wed, 05 Aug 2020 21:51:36 +0000")
Message-ID: <xmqqtuxgn408.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9093218-D767-11EA-AFAC-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      -@@ ref-filter.c: static struct ref_to_worktree_map {
>      - 	struct worktree **worktrees;
>      - } ref_to_worktree_map;
>      +@@ ref-filter.c: static struct used_atom {
>      + 			enum { O_FULL, O_LENGTH, O_SHORT } option;
>      + 			unsigned int length;
>      + 		} objectname;
>      ++		struct email_option {
>      ++			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
>      ++		} email_option;
>      + 		struct refname_atom refname;
>      + 		char *head;
>      + 	} u;

I'll try to find enough time to read the body of the series sometime
later this week, but this interdiff alone smells that this is much
closer to being correct (no, I am not saying I spotted a bug, but it
certainly looks liek it is on the right track, relative to what I
saw the last time, to be right).

A good test for this new feature may be to try using

	"<%(authoremail:localpart)> <%(committeremail:trim)>"

as a format to make sure e-mail options are done per-atom.

Thanks.
