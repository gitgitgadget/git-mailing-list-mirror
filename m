Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E828B1F4B7
	for <e@80x24.org>; Mon, 24 Jun 2019 20:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfFXUE0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 16:04:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55634 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFXUE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 16:04:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C593666DA;
        Mon, 24 Jun 2019 16:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c97BYt6y559j
        HLDIBaqaM+uAF3s=; b=eG6KdtUlpeVFHglhI3k6iafC1dF7bohxzwhGuz46vZ/k
        l0b4Sfr74PDQVHPy6ktrZxCw/FE0m0Jf3MM2ZUYWMCHIQcJxFM0uPghCJ1kyxkGy
        fM7+O8ulIoxANN6py6yTje1KDmZS/cJGGUMzY6l6ogvWNbGSnjri4hrPzjJHAaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QbPCuj
        WvSgHrJAENXdcvS/rtUBiQKQZm14I2l29Ntj6/OJpGka2uk+Rp1zCBPDlBsVipUu
        0rYxbTJ67sLSDEh/dI2qMi8DQXHV7l8xPB6UsIt52MLCxP1lsih0PHcNxff5l0W5
        fAhhuMSH8mZXV/ynxpjfUWdDhwxvTcmPobzLs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7403C666D9;
        Mon, 24 Jun 2019 16:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0020666D7;
        Mon, 24 Jun 2019 16:04:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
In-Reply-To: <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 24 Jun 2019 15:15:54 -0400")
References: <20190624130226.17293-1-pclouds@gmail.com>
        <20190624130226.17293-2-pclouds@gmail.com>
        <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date:   Mon, 24 Jun 2019 13:04:19 -0700
Message-ID: <xmqq5zouhhrw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41B1E01C-96BB-11E9-8CC4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 6/24/2019 9:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> ...
>> +void jw_object_stat_data(struct json_writer *jw, const char *name,
>> +			 const struct stat_data *sd)
>
> Should this be in json_writer.c or in read-cache.c ?
> Currently, json_writer.c is concerned with formatting
> JSON on basic/scalar types.

That's an interesting question.

In the longer run, is it reasonable to assume that the current
callers of these functions will stay to be the only places that
would want to say "For this path, various attributes like timestamps
and other stuff are these values"?  The answer is probably no.

Would it be reasonable to assume that the future callers are all
likely to be closely related to what functions that are currently in
read-cache.c do and would appear only in that file?  I think the
answer would also be no.  Functions in entry.c may want to report
"I've created/updated these filesystem entities and their stat info
now look like so", for example.  So (assuming that we would want to
represent "struct stat" the same way no matter who wants to write it
out), I think it is reasonable to have this function on the json
side, not on Git side.

I do not think it is a bad idea to have a layer that sits above
json-writer.c and below read-cache.c that give us standardized
mapping from in-core objects (like "struct stat") to objects in json
(they are set of key-value pairs after all).  Call it json-schema.c
or something?

What other "higher than scaler" types do we foresee that we'd need
to serialize in a standardised way?  If we do not have that many
yet, perhaps a split like that might be a bit premature and we can
start by having the function in json-writer.c side, not in the API
consumer side.

Thanks.
