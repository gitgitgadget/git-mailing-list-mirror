Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B0C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD3B20733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QG4271/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfLQSoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:44:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59092 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfLQSoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:44:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6958A9ABDA;
        Tue, 17 Dec 2019 13:44:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DKi6fDVMmPsZvonQapnpBGd/ieI=; b=QG4271
        /zamdnYWER9thjnCCpdUBMGFzEIxkyTMGGB1594cJPPAKvS+lsuBEB8iSAs4FK9D
        Tb9r9MKkNs6mTh+UkS3xiSYrnXqwEHIz5hU3CIrgQ1w15lUelNHaT5CfwO5Y3t0v
        CFsdN38t0nE2FyWzbfruOlHMs0Cvig899pW+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vqYLUtOrCxsUARCYaXXJCDJGJNOe6ofM
        D6wewup/wEL/6xDKzfBzJTaGAiwNNQ78wOZ015uez4NIV+6deiMDhNphmM38SGLf
        kQHEukE6XuqVD8xr74pRTinfZACA9vaQgCYf76ZOrpX8LmNX/KIETLAEvJx5RpuK
        rGwNxZOjipk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 616BF9ABD9;
        Tue, 17 Dec 2019 13:44:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EB629ABD7;
        Tue, 17 Dec 2019 13:44:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 06/15] t0003: don't use `test_must_fail attr_check`
References: <cover.1576583819.git.liu.denton@gmail.com>
        <3afa3a16ca2fc2fecba19ff9741925d513f68562.1576583819.git.liu.denton@gmail.com>
Date:   Tue, 17 Dec 2019 10:44:09 -0800
In-Reply-To: <3afa3a16ca2fc2fecba19ff9741925d513f68562.1576583819.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 17 Dec 2019 04:01:31 -0800")
Message-ID: <xmqqo8w6hjwm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3768DFA8-20FD-11EA-9323-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  test_expect_success 'open-quoted pathname' '
>  	echo "\"a test=a" >.gitattributes &&
> -	test_must_fail attr_check a a
> +	attr_check a unspecified
>  '

I offhand do not think of a reason why "git check-attr" must be
given freedom to choose from more than one answers (which is what
the original test that said "as long as it does not report 'a', we
are happy" allowed the command to), so it probably is OK to make the
tests more strict like this patch does.

Thanks.
