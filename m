Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE8C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0521206DF
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z7cZON+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLDVZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:25:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64464 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDVZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:25:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CBFD8F96D;
        Wed,  4 Dec 2019 16:25:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EVBFv5Hw/3JjmT57rm00rlkLFk=; b=Z7cZON
        +NP3e5m0KVnIdNOfxXuEPSaKNhXNSKSQsMnaNHYUz2AW5ipeRfxzg5PdHeqzhw82
        6oclt4Rc4+cQmrzPPdLT0zzC3DzKJxRoBoHqUtaxO9PacYB2pdYzBDuFBcWISgxs
        GTN3vhWwHmuQ6yhLIAy0xAZqxph1PoCIc9iDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cf6a+x2SkFdVJjJiCg6Q0OvM5XgZ4zbZ
        f0YWZ4t2uWQyIyC9IpCoVnS08gWjfa+u8fBocr7YV24xqwuZF9MIPW5SKDzjUj3X
        kSVui1BQeMF7SDZ6iz2CGAEeLBdNgBjKjpv7aVRs98JAk+I8QlIX2nXHVushthc2
        QwnRrRuc/RU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 863428F96B;
        Wed,  4 Dec 2019 16:25:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 952BD8F969;
        Wed,  4 Dec 2019 16:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
References: <20191122011646.218346-1-emilyshaffer@google.com>
        <20191204203911.237056-1-emilyshaffer@google.com>
        <20191204210514.GA89300@generichostname>
Date:   Wed, 04 Dec 2019 13:24:55 -0800
In-Reply-To: <20191204210514.GA89300@generichostname> (Denton Liu's message of
        "Wed, 4 Dec 2019 13:05:14 -0800")
Message-ID: <xmqqy2vr3hso.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 857AC54C-16DC-11EA-865C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> +--pathspec-file-nul::
>> +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
>> +	separated with NUL character and all other characters are taken
>> +	literally (including newlines and quotes).
>
> Does it make sense to have a corresponding --patterns-file-nul option?

I do not think so.  "grep" is always record oriented and the record
separter is the LF, so patterns file can safely be delimited with
LF.

>> +test_expect_success 'setup pathspecs-file tests' '
>> +cat >excluded-file <<EOF &&
>> +bar
>> +EOF
>> ...
>> +git add excluded-file pathspec-file unrelated-file
>> +'
>
> Could you please change these here-docs to be <<-\EOF and then indent
> the test case?

Good suggestion.

	test_expect_success 'setup ...' '
		cat >excluded-file <<-\EOF &&
		bar
		EOF
		...
		git add ...
	'

If each line in these files consists of a short single token (which
seems to be the case), perhaps consider using test_write_lines?

	test_write_lines >excluded-file bar &&
	test_write_lines >pathspec-file foo bar baz &&
	test_write_lines >unrelated-file xyz &&
	test_write_lines >pathspecs pathspec-file unrelated-file &&
