Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BD12047F
	for <e@80x24.org>; Wed, 26 Jul 2017 20:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdGZUle (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:41:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50888 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751024AbdGZUld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:41:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39F069171B;
        Wed, 26 Jul 2017 16:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p+BfIKnMkuBYEAgRISzOTSmfYGg=; b=riJfnP
        iAQRtFMwXZ1uU6nS7NF1OKBxXIxUHkyArTr7NL2vexuuX/Kr+tkNHlCES7QFIm9H
        ZkDXi/wZzz8bZEabiHCQUXafW/mzMTumdhDCzS3wv7nTW5N3LceoP+UFeYvWX5BP
        zRk+C3hDHyEEhdX7ykiZZmMvojNh/SxBXUask=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gwngq2BkxHgJJaPSuFe7FC4esbXjUyyR
        Kl5NaWg1fRJ98AD/oEQuRupylw27QeDihWLS+PS2qlmfX8SPgEoU6vkS1XcoLlGb
        uk4Dn+O49kt0NLgrO6W4/Ll6+7vrjGl5BKWL2lWKg3suEqLynyWuAmdEPJDstTyn
        lsBRE3tu85k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32FC99171A;
        Wed, 26 Jul 2017 16:41:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A226B91719;
        Wed, 26 Jul 2017 16:41:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Raman Gupta <rocketraman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] contrib/rerere-train: optionally overwrite existing resolutions
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
        <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
        <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com>
        <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
        <32b61c4b-5e58-30d9-4345-8036bc805019@gmail.com>
Date:   Wed, 26 Jul 2017 13:41:31 -0700
In-Reply-To: <32b61c4b-5e58-30d9-4345-8036bc805019@gmail.com> (Raman Gupta's
        message of "Wed, 26 Jul 2017 15:06:51 -0400")
Message-ID: <xmqq60efq6bo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF244EAC-7242-11E7-AB7B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raman Gupta <rocketraman@gmail.com> writes:

> On 26/07/17 02:05 PM, Junio C Hamano wrote:
>> I haven't tried this patch, but would this work well with options
>> meant for the 'git rev-list --parents "$@"' that grabs the list of
>> merge commits to learn from?  e.g.
>> 
>> 	$ contrib/rerere-train.sh -n 4 --merges master
>> 	$ contrib/rerere-train.sh --overwrite -n 4 --merges master
>> 	$ contrib/rerere-train.sh -n 4 --overwrite --merges master
>> 
>> I do not think it is necessary to make the last one work; as long as
>> the first two work as expected, we are good even if the last one
>> dies with a sensible message e.g. "options X, Y and Z must be given
>> before other options" (currently "X, Y and Z" consists only of
>> "--overwrite", but I think you get what I mean).
>
> You're right -- I didn't try all the cases. I wasn't able to figure
> out how to get `rev-parse --parseopt` to deal with this situation, so
> I did it manually. I'm not super-happy with the result, but it does
> work. Look for PATCH v3.

Yes, I think you could squash the two case arms in the later loop
into one i.e.

	-h|--help|-o|--overwrite)
		die "please don't." ;;

but still the repetition does look ugly.

As a contrib/ material, I do not care too deeply about it, though.

Will queue.
