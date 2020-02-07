Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD893C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D3620726
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4HpF+8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGSvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:51:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64704 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 13:51:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 687EC54EC9;
        Fri,  7 Feb 2020 13:51:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5Qyoy4tcDG8P
        8qbdLSA/Mq4GtSA=; b=j4HpF+8Nmdfv4iH7aEF1od2x9n/VCoPaXpxdmqnmE9oB
        Y6a8BMd27JfuTKszGlZwH16LMGCkYHKWsh7FJKkjzOXdOverA/hOSAmr95o1lbNV
        1PZ1g4QwAxFzbZxuI4fRidQRdlCb/bYZEViCI6VCgWGcNvOu8k+bqMUXzR6KlWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KUHm/X
        zPc5zI0l0NN4bWVJJ4tLy55BBzRgpGfZC4dIM4TuCCWEiy2IKCdvtPHPGPOSsFe2
        j7Cjim5YJ+4JrH3/FQrEY94zM+SVrOJibYdPkgfJixVq7+JF/p8fC8wlXm4plzGN
        PG7fpXoBygNsB91i2psnlnKtvdhyMKEcv8oXU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60E7654EC8;
        Fri,  7 Feb 2020 13:51:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C501A54EC7;
        Fri,  7 Feb 2020 13:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 03/15] bugreport: add tool to generate debugging info
References: <20200206004108.261317-1-emilyshaffer@google.com>
        <20200206004108.261317-4-emilyshaffer@google.com>
        <20200207141802.GE2868@szeder.dev>
Date:   Fri, 07 Feb 2020 10:51:29 -0800
In-Reply-To: <20200207141802.GE2868@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 7 Feb 2020 15:18:02 +0100")
Message-ID: <xmqq5zgi44em.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DAA5EF48-49DA-11EA-8F9F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Feb 05, 2020 at 04:40:56PM -0800, Emily Shaffer wrote:
>> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
>> new file mode 100755
>> index 0000000000..451badff0c
>> --- /dev/null
>> +++ b/t/t0091-bugreport.sh
>> @@ -0,0 +1,49 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git bugreport'
>> +
>> +. ./test-lib.sh
>> +
>> +# Headers "[System Info]" will be followed by a non-empty line if we =
put some
>> +# information there; we can make sure all our headers were followed b=
y some
>> +# information to check if the command was successful.
>> +HEADER_PATTERN=3D"^\[.*\]$"
>> +check_all_headers_populated() {
>> +	while read -r line; do
>> +		if test "$(grep "$HEADER_PATTERN" "$line")"; then
>> +			echo "$line"
>> +			read -r nextline
>> +			if test -z "$nextline"; then
>> +				return 1;
>> +			fi
>> +		fi
>> +	done
>> +}
>> +
>> +test_expect_success 'creates a report with content in the right place=
s' '
>> +	git bugreport &&
>> +	REPORT=3D"$(ls git-bugreport-*)" &&
>
> What if the globbing were to match more than one file?

An often-useful pattern is to make the command report the output
filename, i.e.

	REPORT=3D$(git butreport) &&

if the design insists that "git bugreport" should allocate a
filename in order to make it easy to guarantee uniqueness.

Of course, we can make the invoker supply filename, e.g.

	REPORT=3D$(generate-output-filename) &&
	git bugreport -o "$REPORT" ;# or git bugreport >"$REPORT"

