Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7D81F609
	for <e@80x24.org>; Mon, 10 Jun 2019 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbfFJRYE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:24:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60143 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbfFJRYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:24:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28EF3699C3;
        Mon, 10 Jun 2019 13:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8RPJDWZBNQE5
        LGNHJIa+tQ5tYgY=; b=MDUKKabAfbUzu7wekjPCVVOXp/vyWD8HVIVGlRwuh4Ny
        msiLWv2P6oUd7QTDf8/VAutqHK9zsMgXlPY/9SsBMgbkWIOr4VYTcsG5WkL332d2
        mHEsEIBO5EhSBWjuICDBS5Aa7lxW7UCmq9Cx1dh1ie478fnt9evMlk6KrEtjMZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xQmnKH
        03rr6slgOrqPLwLsg2PyfnGBVthTNIbknKMfBIu8OBz0u51/nP6GzsvLGW/SNxA6
        3Wuawi9LYoQRKgxhvM9ZZpQy7K96Cwlg7APXQL2zBG/MuUMtncwvP7A8QAMNH2+y
        7e90e1233dFy5olZCuGoQ+iDxNdpVK1/mU5TA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21E3D699C2;
        Mon, 10 Jun 2019 13:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46DAF699BF;
        Mon, 10 Jun 2019 13:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] t7610-mergetool: do not place pipelines headed by `yes` in subshells
References: <cover.1560152205.git.j6t@kdbg.org>
        <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560152205.git.j6t@kdbg.org>
        <20190610095942.GA19035@szeder.dev>
Date:   Mon, 10 Jun 2019 10:23:57 -0700
In-Reply-To: <20190610095942.GA19035@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 10 Jun 2019 11:59:42 +0200")
Message-ID: <xmqq36khnyky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88888FBC-8BA4-11E9-86A9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> turn these
>
>   test "$(cat file1)" =3D "that"'
>
> checks into
>
>   echo that >expect &&
>   test_cmp expect file1
>
> because 'test_cmp' on Windows first compares the two files in shell
> and runs 'diff' only when there is a difference to report.

Needs measuring.  Is two extra file I/Os that inexpensive?
