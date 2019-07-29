Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6DE1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 21:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfG2VqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 17:46:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64710 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfG2VqU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 17:46:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAF576BE4E;
        Mon, 29 Jul 2019 17:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y+VagkdprIgYFKpejacfKvhxlHE=; b=RZgauT
        VKxAdg8TzPCcaD+YGMlNrYOlWI9B38O+7TCkBgApNmlxKemNa/TAarzsJrMBnRfZ
        1KsXvNKzDA0OgjNv3yzy6ArPQdG2fysQy9ZJ87bvWVRvSG14vD6yWQEtP9SQe08g
        h6wy+/ijK7DNJoUhW/O09AMp7lVn4S06B7XXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rZPDND4p+fB4VSZXBxQuJsGla352jZxL
        oydtL4i0XSD9dw6A/ZSjlvHs9/RffxUf0+3WjBWtlUegt3h8FIgfxUSoH7MVgpdr
        Ko4MccUSmQP72c24sDLMJILJSgUm4E93czC5MUOpvYP3mK4jTjZfs37+tmLclghM
        T94tLtzX188=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3DC36BE4D;
        Mon, 29 Jul 2019 17:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DB9F6BE4C;
        Mon, 29 Jul 2019 17:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralph Maalouf <ralph.maalouf@caretrx.com>
Cc:     "'git\@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: 'git show -c' omits hunk even though file was modified from all parents
References: <MN2PR13MB2607878CB0C1E351B83F006BEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
        <xmqqd0hsvfb9.fsf@gitster-ct.c.googlers.com>
        <MN2PR13MB2607F47AC76601FC709A67A8EADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
Date:   Mon, 29 Jul 2019 14:46:13 -0700
In-Reply-To: <MN2PR13MB2607F47AC76601FC709A67A8EADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
        (Ralph Maalouf's message of "Mon, 29 Jul 2019 19:52:55 +0000")
Message-ID: <xmqqsgqotsyi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A9E5EB2-B24A-11E9-934D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralph Maalouf <ralph.maalouf@caretrx.com> writes:

> "We do not show hunks that match one of the parents ". But in case
> 1 the second hunk matches one of the parents yet `git show -c`
> still outputs it.
>
> diff --combined test1
> index 02ef2b0,ffc05f2..59d575d
> --- a/test1
> +++ b/test1
> @@@ -1,8 -1,8 +1,9 @@@
>   One
>  +Two
> + Four
>   Three
>
>
>   Seven
>  -Ten
>  +Eight
>   Nine

The above is a single hunk (whose definition is the group of lines
delimited by @@@...@@@ lines).
