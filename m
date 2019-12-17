Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83394C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526BE206E0
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O6u/6C/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfLQUe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:34:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61528 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfLQUe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 15:34:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8EFB3C411;
        Tue, 17 Dec 2019 15:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tsEutuUjsdSD4y/WmLH9FobzFjs=; b=O6u/6C
        /8GU61xVerVyiCOa8iBS6wlb31a5aCg+/k3k2w7A9WBqeYF7HoT+135Ix4Hi4tOk
        Kz9jF+JIzn5UjmdzxmpzhVCzWJpaSIzHmj8/jfFKW9zAczDrSuAsHfnukLwc2Dbp
        wp1XLDkOaVdBZbx4FFIcMVrnleCWPWxsJh/98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SDxXty5kJxNvki+WnmyMXRPnVVHe/6X+
        xHkbvL3wjWlO2Gi/Yugtz4sEwnfIB4H4uK1MB5ys1g0Bi1xWAbzuo1fTilWe4h9A
        k5bw0qzi2dzWAhDSTxlhkVaGxJGElfSaOA/z62UxhY6ICTNuo+cuhPzDFvlzkvq/
        2jM4SqT3l1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A19C53C410;
        Tue, 17 Dec 2019 15:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1563B3C40F;
        Tue, 17 Dec 2019 15:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 03/15] bugreport: gather git version and build info
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-4-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.1912171941451.46@tvgsbejvaqbjf.bet>
Date:   Tue, 17 Dec 2019 12:34:53 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912171941451.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 17 Dec 2019 19:45:12 +0100 (CET)")
Message-ID: <xmqqfthig07m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE9CE6DC-210C-11EA-9F1F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	if (build_options) {
>> +		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
>> +		if (git_built_from_commit_string[0])
>> +			strbuf_addf(buf, "built from commit: %s\n",
>> +			       git_built_from_commit_string);
>> +		else
>> +			strbuf_addf(buf, "no commit associated with this build\n");
>
> The "StaticAnalysis" job of the Azure Pipeline is not happy with this,
> claiming that this should be an `strbuf_addstr()` call instead.

You mean the "else" clause, right?  That feels similar to say

	printf("Hello world\n");

should better be written as

	fputs("Hello world\n", stdout);

which I do not agree with at all.  IOW, I view the distinction more
like "once it is written one way or the other way, it is not worth
spending bits and braincycles to see if it is worth changing it"
kind of minor stylistic preference.


