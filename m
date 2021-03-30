Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D31FC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066CE61953
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhC3ULv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:11:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63107 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhC3ULf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 16:11:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6799912D8BF;
        Tue, 30 Mar 2021 16:11:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z6l80NzPJt70AjRE48JGKhevTgE=; b=H+99/U
        ALcEL3G/WKgojnHV6pcUiItNIvmuyG054MY8xNtEuuhMIBC3t2VcHse3stLicy2t
        HR+hfzWSVxrG/bLgdH7n4s9lXwlOnFb/MC1zDO8NWbFfX+FlmzbXkNrmCTGz4BA+
        19Ui8XvgJfLPRIrBPA6uSCoQ+IVgvkYF+JzPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l4Hn+TQYSLDS1mx3tWDbwM29k0EZq0mi
        vU+dYJrN6mQ0+WGHMJZn5wPL0eQXGtiBnyj/jrUjn56aj2Db0eVM2u2R2LOU5eRy
        iexcrWGkvXJ4oDDeizx3mj7IHAcDNhQvKL2xW/xfDmQAkotQJ073p5NyOp6ml84q
        UBZOClt7Ku4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E0E712D8BE;
        Tue, 30 Mar 2021 16:11:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8E26E12D8BD;
        Tue, 30 Mar 2021 16:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 00/21] Sparse Index: Design, Format, Tests
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:11:30 -0700
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 30 Mar 2021 13:10:43
        +0000")
Message-ID: <xmqqsg4ccsgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EFCD042-9194-11EB-B174-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
>       +	 * Initialize this as off.
>       +	 */
>       +	r->settings.sparse_index = 0;
>      -+	if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
>      ++	if (!repo_config_get_bool(r, "index.sparse", &value) && value)
>       +		r->settings.sparse_index = 1;
>        }

It would be helpful to have a way for the repository owner to say
"Even if the version of Git may be capable of handling 'sdir'
extension, and my checkout uses sparse-cone settings, I do not want
to use it", and the other way around, i.e. "Even if my checkout
currently does not use sparse-cone settings, do use 'sdir'
extension".  But for that, .sparse_index member may need to be
tristate (i.e. forbidden, enable-if-needed, use-even-unneeded)?

We have a similar setting in index.version; I believe we always
auto-demote 3 down to 2 when extended flags are not used, and
I think "always auto-demote" would be sufficient (iow,
"use-even-unneeded" may not be necessary, even though that might
help debugging).

Thanks.
