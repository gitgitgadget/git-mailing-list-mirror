Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F51B1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 15:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763868AbcINP4X (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 11:56:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62715 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762054AbcINP4X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 11:56:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7481B3EFB3;
        Wed, 14 Sep 2016 11:56:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZycKoqGpsZ/HZfgdyGFw6/CrZ9Y=; b=iqIs/+
        osuff3CeSJXn9NupKWsJ+4ki33WfmV+0aMqGkLJMwYKFQWW7bj+gQLPt1ZiC7bST
        idRrl/gCB68CxmyaA1thv6HbLhA828FEOeHOweuaVYhqFYxqqcvNx5LuD6zlqtBL
        C+kZobaZRYmExlDjJPkcRZB/yQsTiwo1maq94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MmDHJZpJPuRJD0tTMpANlNE9T7w55Hmb
        Br/d/vczOKaGx4eTPxCa6FfNFunTYlX/b+eIvj/XYeyGWpel2ojTRoYB609qO1fZ
        P5zkECtjAKaF9X7ySyHYaGavTif2ut89aQrvPdMd+LTIPUwmaGTG0yTVTr7OUQz7
        MBHaJEtFd9k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6588D3EFAF;
        Wed, 14 Sep 2016 11:56:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBB223EFAE;
        Wed, 14 Sep 2016 11:56:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Ralphson <mike.ralphson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] vcs-svn/fast_export: fix timestamp fmt specifiers
References: <01020157276d4d1f-9c995462-4aea-4949-8d29-3dbdbec77dd7-000000@eu-west-1.amazonses.com>
Date:   Wed, 14 Sep 2016 08:56:18 -0700
In-Reply-To: <01020157276d4d1f-9c995462-4aea-4949-8d29-3dbdbec77dd7-000000@eu-west-1.amazonses.com>
        (Mike Ralphson's message of "Wed, 14 Sep 2016 06:40:57 +0000")
Message-ID: <xmqqeg4mscf1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C79D0CAC-7A93-11E6-9536-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Ralphson <mike.ralphson@gmail.com> writes:

> Two instances of %ld being used for unsigned longs.
>
> Signed-off-by: Mike Ralphson <mike.ralphson@gmail.com>
> ---

Good eyes.  Thanks for spotting.

>  vcs-svn/fast_export.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index bd0f2c2..97cba39 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -73,7 +73,7 @@ void fast_export_begin_note(uint32_t revision, const char *author,
>  	static int firstnote = 1;
>  	size_t loglen = strlen(log);
>  	printf("commit %s\n", note_ref);
> -	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
> +	printf("committer %s <%s@%s> %lu +0000\n", author, author, "local", timestamp);
>  	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
>  	fwrite(log, loglen, 1, stdout);
>  	if (firstnote) {
> @@ -107,7 +107,7 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
>  	}
>  	printf("commit %s\n", local_ref);
>  	printf("mark :%"PRIu32"\n", revision);
> -	printf("committer %s <%s@%s> %ld +0000\n",
> +	printf("committer %s <%s@%s> %lu +0000\n",
>  		   *author ? author : "nobody",
>  		   *author ? author : "nobody",
>  		   *uuid ? uuid : "local", timestamp);
>
> --
> https://github.com/git/git/pull/293
