Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16CF207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 05:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbcI0Ffr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 01:35:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54906 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751495AbcI0Ffq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 01:35:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F80E42E20;
        Tue, 27 Sep 2016 01:35:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dDXn30Kie4iU+DvY4rwtIe6xbws=; b=mTRYEX
        mzGrGMTbMvVr9sWCuvPQZzqDTiTuJEPkTqeJccNANxXffkJrPohBrRhPiyAQyWos
        ZxTpGszwJbWBeNYigWwgubhIRBvZ7YivFWV+O+yvXd3dZBfzuHQHlFMmvxOPhm2c
        JaMgiHaBUQ8cYMZLUAd11c3urU86ZaUindFLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t1YlhUu4rBU+uw0iSw+BF4/0diUbcIwK
        Ea0CjQvuRiykbaJppj1b6C16s1iKAJ5I5q8Qdm3edVyzsvMXar3vsVg3ePiEvf99
        UAZDDBiYFOabNLtSGMlPoaDgmfSbVrmawJTsb+0V6hR0txfJhPEx+HN1kePkld7O
        D5wzSFsR35Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8843742E1F;
        Tue, 27 Sep 2016 01:35:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CDA242E1E;
        Tue, 27 Sep 2016 01:35:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org,
        mhagger@alum.mit.edu, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 1/2] tree-walk: be more specific about corrupt tree errors
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
        <1474918365-10937-2-git-send-email-novalis@novalis.org>
        <20160927051453.yuvrnao5ldjpzhcj@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 22:35:41 -0700
In-Reply-To: <20160927051453.yuvrnao5ldjpzhcj@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 27 Sep 2016 01:14:54 -0400")
Message-ID: <xmqqbmz9sy4y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C184A26-8474-11E6-8FF4-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +test_expect_success 'malformed mode in tree' '
>> +	test_must_fail git hash-object -t tree ../t1007/tree-with-malformed-mode 2>err &&
>> +	grep "malformed mode in tree entry for tree" err
>> +'
>
> This ".." will break when the test is run with "--root". You should use
>
>   "$TEST_DIRECTORY"/t1007/...
>
> instead. And ditto in the second test, of course.

Ahh, that explains the breakage I saw.

Thanks.
