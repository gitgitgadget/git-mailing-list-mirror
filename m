Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7249C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A32720708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eoNE72ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgA3T7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:59:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50336 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3T7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 14:59:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14822538D4;
        Thu, 30 Jan 2020 14:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y4JAn5qRjk7ovuU/G34JSd7rgNw=; b=eoNE72
        uxbTj942eFnNvh0imDSkudW4mIOACg8QDsHLMSIb3v/AC6wo+dOS+kGBrJLHmYlC
        xiSp0oJtHWiCu6X1zVXtMGN8jEVsLQqi19oIWFST2nRV9URMzkzBNKE38158g1Pt
        eejMxlPnPyff3mQk8XRUwFYJk1gN9ilHCY0eE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JHUROmQz8ogBSnbxcMrZ8/0/qEyspLCR
        8wTE60WyYe8zWclvWN7icn0Czlwa+nzk6Mhy0FpMrOhEsOjMNF1h4RTMkeISeTi+
        6Y57gM3Ai/mrZ0ftS1/HbdAvYkemss4b5NCCtYg1qfzOxaKhuruxJSYC7r/zafr6
        ZUudAk9sdaY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BEF8538D3;
        Thu, 30 Jan 2020 14:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EF2B538D2;
        Thu, 30 Jan 2020 14:59:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv1 4/6] git-p4: create helper function importRevisions()
References: <20200129111246.12196-1-luke@diamand.org>
        <20200129111246.12196-2-luke@diamand.org>
        <20200129111246.12196-3-luke@diamand.org>
        <20200129111246.12196-4-luke@diamand.org>
        <20200129111246.12196-5-luke@diamand.org>
        <CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com>
Date:   Thu, 30 Jan 2020 11:59:31 -0800
In-Reply-To: <CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 29 Jan 2020 10:00:29 -0500")
Message-ID: <xmqqzhe4btr0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0832B7B6-439B-11EA-B101-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 29, 2020 at 6:13 AM Luke Diamand <luke@diamand.org> wrote:
>> This makes it easier to try/catch around this block of code to ensure
>> cleanup following p4 failures is handled properly.
>>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>> diff --git a/git-p4.py b/git-p4.py
>> @@ -3555,6 +3555,73 @@ def importHeadRevision(self, revision):
>> +    def importRevisions(self, args, branch_arg_given):
>> +        if len(self.changesFile) > 0:
>> +            output = open(self.changesFile).readlines()
>
> Not a new problem (since this code is merely being relocated), but is
> this leaking the open file? Should there be an accompanying close()
> somewhere?
>
>     f = open(self.changesFile)
>     output = f.readlines()
>     close(f)
>
> or something.

Hmph, I was naively hoping that the (never assigned to any variable)
last reference going away at the end of the statement would make the
file object dead, and we can let eventual GC to close it.

Nevertheless it would not hurt to explicitly control the lifetime.
