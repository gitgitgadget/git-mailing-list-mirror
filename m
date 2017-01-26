Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759EE1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 23:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbdAZX05 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:26:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61692 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752226AbdAZX05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:26:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94219645E4;
        Thu, 26 Jan 2017 18:22:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r3RvqSRXVCn0
        RINS+wU9yL9UAYc=; b=uR23y4FUM5D2hsVLKi1TRJkha0D8C0SIcd+FVnbm+Vhl
        Vsfqs9JMhnXF6i5YFelP0uPHEftqgVU4RKW/oT2LmyoErp0bao9c5M9djgvKUe3j
        ejHF9FahdhJQKzlbVEiEcsGIRCYAyTSYX8fdOSp7mp5lXQtVbEE7gtWLOFRoK1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ISKr7J
        gZbRv8vnsfeXUueAqya2nUqTrfr25DsK1D0to1v//RbODPyLbtQzcjDah1hgfsli
        HAMTG92MFqUiDV2Q0uQZv41R5fno1Z8tn1BQLcNus/49aJk92zF1pk8kMi/pKvU/
        xUT3NMp+JAn/fNUq7L7qyRYTI4h74a1m4dVSU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A544645E3;
        Thu, 26 Jan 2017 18:22:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9D49645E2;
        Thu, 26 Jan 2017 18:22:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     marcandre.lureau@redhat.com, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH] git-bisect: allow running in a working tree subdirectory
References: <20170126183030.28632-1-marcandre.lureau@redhat.com>
        <96afaa1d-31d7-0b7e-d2b3-77a455158638@kdbg.org>
Date:   Thu, 26 Jan 2017 15:22:50 -0800
In-Reply-To: <96afaa1d-31d7-0b7e-d2b3-77a455158638@kdbg.org> (Johannes Sixt's
        message of "Thu, 26 Jan 2017 22:46:44 +0100")
Message-ID: <xmqqziid1k51.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5BA5819C-E41E-11E6-BC13-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.01.2017 um 19:30 schrieb marcandre.lureau@redhat.com:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> It looks like it can do it.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  git-bisect.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index ae3cb013e..b0bd604d4 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -1,5 +1,6 @@
>>  #!/bin/sh
>>
>> +SUBDIRECTORY_OK=3DYes
>>  USAGE=3D'[help|start|bad|good|new|old|terms|skip|next|reset|visualize=
|replay|log|run]'
>>  LONG_USAGE=3D'git bisect help
>>  	print this long help message.
>>
>
> Does it also work to drive git bisect from a subdirectory and pass a
> file name (or pathspec) that is relative to that subdirectory rather
> than relative to the root of the worktree? Can `git bisect good` or
> `git bisect bad` of later bisection steps be invoked from different
> subdirectories or the root?

I think the answers are no and no.  Entries in BISECT_NAMES and
BISECT_LOG are not getting any prefix.

