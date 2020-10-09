Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0FC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 02:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5EE2087D
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 02:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qDTdYEm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgJICrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 22:47:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57940 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgJICrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 22:47:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31F228BB78;
        Thu,  8 Oct 2020 22:47:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eKX3tOEETkS/36OiiQReZ3LqOPs=; b=qDTdYE
        m5HwQKXReBZ9j/O3cFTe8oMtb5j0k3IDUFX7pAF2O1xIhmR8jiOFdOsfUmEqxJdK
        Ej7RiF18JL+9T7YSBgRkBEnRa75rYH+zivaLm/chksWA7k67+n8bCxjvXnEJOfjd
        dx10mw9O6iAIHso6c8iwxJsa8YGFAdX5hK8Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gJLJIKiBgHFo3M+B4FZwWXNsU4Ciw8yv
        Y0FM9ImVFyQCJQcm2GJcLapmb+JdY3UeEqUEVdpKg/vGvtEY619wCkgb/8GOgGr6
        h4pRb/ObtUNMecYOdXlS5EDbIHAiU19SQN+G4Z9S0hYxM283qtidFMJw28S2e9no
        pTRjr0bzDiM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2139F8BB77;
        Thu,  8 Oct 2020 22:47:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 967BB8BB76;
        Thu,  8 Oct 2020 22:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clean up extern decl of functions
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
        <20201009015505.GB1314@generichostname>
Date:   Thu, 08 Oct 2020 19:47:36 -0700
In-Reply-To: <20201009015505.GB1314@generichostname> (Denton Liu's message of
        "Thu, 8 Oct 2020 18:55:05 -0700")
Message-ID: <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9FDA342-09D9-11EB-B7C2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Thu, Oct 08, 2020 at 08:27:55AM -0700, Junio C Hamano wrote:
>> Among external function declarations, somehow only these two
>> functions that return pointer-to-function were declared with
>> "extern" in front.
>> 
>> Ideally, we should standardise to _have_ explicit "extern" in front
>> for all function (and data) decls, but let's make things uniform
>> first.  Bulk re-addition of extern can be done without any extra
>> difficulty with or without this change.
>
> Why are we re-introducing an explicit "extern"? Since function decls are
> extern by default, what do we gain by doing this?
>
> You mentioned in the past[0]
>
> 	I think there is a push to drop the "extern " from decls of
> 	functions in *.h header files.
>
> so are we reversing that push now?

That is certainly on the table.  Re-read what you quoted and realize
that I was not expressing my opinion on the "push"; it was just
stating that other reviewers seem to be in favor.

See my other response why I think the "push"  was a bad idea.

