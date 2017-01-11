Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734CD205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 18:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031171AbdAKSPj (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 13:15:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S967807AbdAKSPa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 13:15:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C77145F22F;
        Wed, 11 Jan 2017 13:15:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dReQabCRfIb3UmuX2eX2iyuWMnU=; b=cAS34Z
        L0z1yfnGNJ/PMeLbVoDZZrt9VVCdW9Zxpwwwo4oqDDA6R+gsxymaBXKGP6ZFcFAH
        B3b4ry4UEHAzCjsyI014yEZIvDIhB0S2QVtLd+6YAOBZdcriM9lLVQU0EWHwqMP9
        f+nr4f8cCDIyaV2ik2NbU/wv09cTwpV5Vm1x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K2mzw/Fta5eL1zvE3/nhcO05cyFmZWLD
        hhe674iZ5zvONHGbNGMz/vXYq0bR2Ynw6DQltK2sof76IwlNwtvnxozNpgmi6RtY
        IUFW+iVnyyCuq7CnPuu7IeT8yd1Hi4kymkZTv0jo2TefC8M5IHdtIWur50tjJiqg
        wIaANa1vXA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C07555F22E;
        Wed, 11 Jan 2017 13:15:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30C425F22D;
        Wed, 11 Jan 2017 13:15:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-3-hansenr@google.com>
        <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
        <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com>
        <xmqq60lmpb4j.fsf@gitster.mtv.corp.google.com>
        <21b416ae-8bf6-4f82-25d3-e51a574e7746@google.com>
Date:   Wed, 11 Jan 2017 10:15:27 -0800
In-Reply-To: <21b416ae-8bf6-4f82-25d3-e51a574e7746@google.com> (Richard
        Hansen's message of "Wed, 11 Jan 2017 12:24:57 -0500")
Message-ID: <xmqqwpe1o43k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE26FBE6-D829-11E6-A9DE-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

> On 2017-01-10 21:46, Junio C Hamano wrote:
>> Richard Hansen <hansenr@google.com> writes:
>>
>>> I was looking at the code to see how the two file formats differed and
>>> noticed that match_order() doesn't set the WM_PATHNAME flag when it
>>> calls wildmatch().  That's unintentional (a bug), right?
>>
>> It has been that way from day one IIRC even before we introduced
>> wildmatch()---IOW it may be intentional that the current code that
>> uses wildmatch() does not use WM_PATHNAME.
>
> You are the original author (af5323e027 2005-05-30).  Do you remember
> what your intention was?

Yes.  

Back then we didn't even have wildmatch(), and used fnmatch()
instead, so forcing FNM_PATHNAME would have meant that people
wouldn't be able to say "foo*bar" to match "foo/other/bar"; with
wildmatch, "foo**bar" lets you defeat WM_PATHNAME so having
WM_PATHNAME always in effect is less of an issue, but with
fnmatch(), having FNM_PATHNAME always in effect has a lot of
downside.

I'd expect that orderfile people have today will be broken and
require tweaking if you switched WM_PATHNAME on.
