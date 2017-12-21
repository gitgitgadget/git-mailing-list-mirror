Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2E41F424
	for <e@80x24.org>; Thu, 21 Dec 2017 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbdLUVr1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 16:47:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754637AbdLUVrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 16:47:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C37AD1C85;
        Thu, 21 Dec 2017 16:47:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7FeAy/ZFKgg/JWQ5DomRIW9l9ks=; b=sKQQZp
        Dz7/a4EO/HGopfxA0ifmM4vMkm5+JS3UC/dp7Oe6tSzsImwkx6UOjjXDMwFof8Ud
        YwZ76y4gikbvwEKc3eQR1lqgA8/vNktXH48urQuJqy16Kz9rwh+EU2tJeqF/fmBD
        v404jxS5li9ZhU/M6MeufUvePzMwDOVHAHroQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ECMeoy2sPlLxu1YEazs0TS+HZouUR0Ih
        nCQK4ASrnruHdVKaNAxhkOQyfBlRJmQSKSHTgS48eTTqjLUC4/nm/QFoiAtfeuKk
        Z8D6ub2GYxlQr9kYBXYuGvbRQer8iTmxHvCYMrzBM9gURWxj1JQD9GPDNAHGJ1Dd
        w2Nemti/w/g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8405ED1C84;
        Thu, 21 Dec 2017 16:47:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F23ECD1C83;
        Thu, 21 Dec 2017 16:47:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 2/6] fsmonitor: Add dir.h include, for untracked_cache_invalidate_path
References: <20171219002858.22214-1-alexmv@dropbox.com>
        <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
        <c8cf261d9d620d8123e8bfa5aa952fa55685a8db.1513642743.git.alexmv@dropbox.com>
        <xmqqtvwmv5fl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.10.1712201108190.10810@alexmv-linux>
Date:   Thu, 21 Dec 2017 13:47:17 -0800
In-Reply-To: <alpine.DEB.2.10.1712201108190.10810@alexmv-linux> (Alex
        Vandiver's message of "Wed, 20 Dec 2017 12:59:31 -0800 (PST)")
Message-ID: <xmqqfu83u522.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 847974C0-E698-11E7-B6A5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

>> But I am not sure if this is a right direction to go in.  If a .C
>> user of fsmonitor needs (does not need) things from dir.h, that file
>> can (does not need to) include dir.h itself.
>
> Hm; I was patterning based on existing .h files, which don't seem shy
> about pulling in other .h files.

IIUC, existing X.h do pull in Y.h when X.h uses a structure or a
typedef defined in Y.h (but using pointer to such a structure or a
type does not count) defined in Y.h; in such a case, a user of X.h
that wants to use what is defined in X.h would not be able to use
it without somehow knowing the shape of such a structure or type and
would be forced to pull in Y.h itself.  "static inline" falls into
the same category---as it stands, anybody that includes fsmonitor.h
and wants to use one of these static inline functions would need to
have definitions from dir.h, which I agree is wrong and I understand
that you want to include dir.h there.

