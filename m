Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1051C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiHDQQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiHDQQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:16:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E011583E
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:16:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83E951ADA21;
        Thu,  4 Aug 2022 12:16:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rWIU4rb/2omEqyqE5umPmC0/dVI0GCavB89rJT
        4c2Ds=; b=kIsezvcNBjcuFMZeYRPbfY5kWfnk+s1hza834yuxcys7pDRsbkXyw5
        Ac+aCJLPQDZ+6t4R1z9lKiXWHz5bJqQSWQDox1GWWmYE2vN2KZY4YIzr+VK3Nl41
        I5e8pDwfd/Kwan4PfF53nXQ9xce3w/Fjp6FnMlLDbiHa+hdiz02Gg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C02E1ADA20;
        Thu,  4 Aug 2022 12:16:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BB431ADA1F;
        Thu,  4 Aug 2022 12:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/10] refs: add array of ref namespaces
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
        <xmqqzggldf7y.fsf@gitster.g>
        <9d60ae93-5acf-cf26-f0ab-cc2aa0808f7e@github.com>
Date:   Thu, 04 Aug 2022 09:16:16 -0700
In-Reply-To: <9d60ae93-5acf-cf26-f0ab-cc2aa0808f7e@github.com> (Derrick
        Stolee's message of "Thu, 4 Aug 2022 09:29:06 -0400")
Message-ID: <xmqqles46l2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4CA1AF2-1410-11ED-9D48-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> +		 * by the core.notesRef config variable or the
>>> +		 * GIT_NOTES_REFS environment variable.
>>> +		 */
>>> +		.ref = "refs/notes/commit",
>>> +		.exact = 1,
>> 
>> Allowing just "the default" to be replaced by another "custom
>> default" is a good start, but we probably want to support more than
>> one notes refs, to parallel how "struct display_notes_opt" has
>> extra_notes_refs to allow multiple notes refs to decorate objects.
>
> I imagine that if we allowed multiple notes refs, then we would need
> to use a ref prefix to define a namespace. If we relaxed that, then
> we could modify this as follows:
>
> 	.ref = "refs/notes/",
> 	/* .exact = 0, */
>
> (The comment is included just to illustrate the change.)

As I do not think it is so bad to decorate a commit with, say,
refs/notes/amlog in "git log --notes" (not "git log --notes=amlog")
output if such a commit happens to appear, so limiting to the single
notes ref that is given by notes.displayRef and ignoring others like
the posted patch felt like an over-engineering that may result in
even a negative gain.  Treating it just like "tags" and "remotes"
hierarchy would match intuition better for people, I suspect.

Thanks.


