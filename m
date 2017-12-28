Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4197F1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbdL1TBc (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:01:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751229AbdL1TBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:01:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B29CC4AA8;
        Thu, 28 Dec 2017 14:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iuCyN1HI9moe
        1pmWYUMETYk19ao=; b=XSkLsA5RezK0rWSI0XwnmXpJTto1G0HePLizkU/VAav6
        bLX0b1SqNQ+GL0zuQRGek6pkK8EFltI9UGxT6/VHkyxI7jWlD729uzOOo+kBYID4
        6XtCaFbfm/CvX2K4+gaefFh+yFjU5Rbn6YtQH5MCPF7w+N0HBx7Z6Zb6O1UZs6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iA5v3k
        7MB9urC4uAdMTZbXcm2nV23Pv7gpxCvCNEgGsYOWmYzNBeerxSMez2vy+dtKNvvA
        e4abvZQcBpucZuTnHGOOtKyhkPb+sVMquWj3HiMqbI9jAmGWD0AY9VSFRrMtjXeG
        k90hquZ/ELcVpohBE35yKk776yM/ATv4RmJrw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 118A9C4AA7;
        Thu, 28 Dec 2017 14:01:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 713A7C4AA6;
        Thu, 28 Dec 2017 14:01:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
References: <20171227164905.13872-1-szeder.dev@gmail.com>
        <20171227164905.13872-3-szeder.dev@gmail.com>
        <332E6163-C09C-426F-80BE-084D6D6D5AD0@gmail.com>
        <CAM0VKjmCodQgmTa8bjEc02N99cPjrFdp4rFGF3yQOA-VMer4hw@mail.gmail.com>
Date:   Thu, 28 Dec 2017 11:01:29 -0800
In-Reply-To: <CAM0VKjmCodQgmTa8bjEc02N99cPjrFdp4rFGF3yQOA-VMer4hw@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 28 Dec 2017 11:31:42
 +0100")
Message-ID: <xmqqlghmllrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8395AAD8-EC01-11E7-81FD-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> I was aware that things like 'cmd file >file' don't work, because the
> shell opens and truncates 'file' before executing the command, so 'cmd'
> will open the already empty file, but I didn't know that 'echo "$(cmd
> file)" >file' works.  Thanks for letting me know.
>
> However, this is subject to the portability issues of the shell's
> 'echo', i.e. try
>
>   echo "$(cat git.c)" >git.c
>
> with Bash and Dash.  Bash produces the exact same contents, but Dash
> turns all '\n' in help and error strings to real newline characters.

Besides, that is a bad practice in general if you do not have a
guarantee that 'git.c' (or whatever file in question) is small
enough not to bust any platform's argv[] length limit.

> ...  Still, I think it'd be better
> to stick to using a good old temporary file:

Yes.

