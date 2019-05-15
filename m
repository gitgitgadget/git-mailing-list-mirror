Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CAA1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEOBMk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:12:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54750 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfEOBMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:12:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2A9C69025;
        Tue, 14 May 2019 21:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=H/O4qObq39fL
        25xVtxpjMvzmtU4=; b=jMtLRCAzSr4whDw49JYQmJ+X+FXGa7D/VfFxRgO193d3
        LzATH0dnp+9ifN5V9LrzbGV11xS4RG2dVNMkfJ01T1CBdD+1QL5XdqwwQHUUTMyA
        zxncWIdvEAjf+fYMKGcmZ4L08uSzpK5KD6WRPTX7uHMB0FGUXX0uAgxXrjFhZrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nQdCTR
        zqO0nN625p/ChDalQAQxVsaxjLvqRiA5+McibbVEIFdamLG6g2y2E+5ogYxFoMPz
        TNCSo+PofKGprzSFbpKWYZsScXXxxGddqek+ZgB1QCegXuex50OgyAYfPTxCqHX3
        /JlB3Rwimxz+qQ3Zuaoa0HCU7igct1xngH6ag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAB3F69024;
        Tue, 14 May 2019 21:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDF6D69023;
        Tue, 14 May 2019 21:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: How to exchange rerere/redo resolutions?
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
        <871s17xk79.fsf@evledraar.gmail.com>
        <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
        <d139d79a-f35a-e00c-3790-104146b066c7@iee.org>
        <87mujpwiod.fsf@evledraar.gmail.com>
Date:   Wed, 15 May 2019 10:12:34 +0900
In-Reply-To: <87mujpwiod.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 14 May 2019 10:21:06 +0200")
Message-ID: <xmqqr2908qrh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 86C91E18-76AE-11E9-BCF6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>     if test -s "$GIT_DIR/MERGE_RR"
>>
>> It's not clear if that is an internal implementation detail, or a
>> mistaken use of a historic path name. Can anyone enlighten me?
>
> Historic? No, this is path.c now on master:
>
>     path.c:1454:REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
>
> Internal, sure. We don't document it so it could change in theory, but
> then we'd probably change rerere-train.sh along with it...

Doesn't the function defined by REPO_GIT_PATH_FUNC() do far more
than a simple concatenation?  I suspect that he questions why
"$GIT_DIR/MERGE_RR" is an OK substitute for that.

The $GIT_DIR variable in the script is set by inclusion of
git-sh-setup, that runs "git rev-parse --git-dir"; in post "git
worktree" world, where ".git" may be a "gitdir: $real_location" text
file, this will give the actual directory, not the path to a regular
file at the top of the working tree whose name is ".git", so the
answer to the question is that the concatenation we see should be
OK, even in the "git worktree" world.

