Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C207C1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934123AbcJQSra (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 14:47:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932403AbcJQSr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 14:47:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B590D475F7;
        Mon, 17 Oct 2016 14:47:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oDWvbhYhUzeTC6Tm3yVOYNkGhvY=; b=uRW02j
        +1LVEdr3wa/AxWHGslOTurFlIWb2UQEoC7I7n+pB3mcTGVRO1PkoJAPLur+WOdTa
        c6t7m7by8Hz1u+RloOzDQpp7DAx4O6csGyOYJrAgyKTtbI94qm2eZmWpT0HR/liZ
        Glq2lGq3yU8yr4JBzUAaf8I/PbOJLyF3/KBkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZsJhNSyI6Tq2ZkaU37nYK0AE0o+8oZJm
        Y1q3bdZayvyr/1seEgyw+jmmtYN+UxI4u/KVVyFRNMDfgw0Szos5VmK2xgHHvjC0
        ttu9u+EFomomavRq4rQ9C/hB35U85f9f3nQ4Irfq7szHwkvuZLYWq3c/MrVe+dqn
        fFQkf9akhB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD394475F6;
        Mon, 17 Oct 2016 14:47:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A36C475F5;
        Mon, 17 Oct 2016 14:47:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de
Subject: Re: [PATCH v11 00/14] Git filter protocol
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Date:   Mon, 17 Oct 2016 11:47:22 -0700
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sun, 16 Oct 2016 16:20:24
        -0700")
Message-ID: <xmqqd1iyvmmd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24AC49C4-949A-11E6-B036-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> The goal of this series is to avoid launching a new clean/smudge filter
> process for each file that is filtered.
>
> A short summary about v1 to v5 can be found here:
> https://git.github.io/rev_news/2016/08/17/edition-18/
>
> This series is also published on web:
> https://github.com/larsxschneider/git/pull/15
>
> Patches 1 and 2 are cleanups and not strictly necessary for the series.
> Patches 3 to 12 are required preparation. Patch 13 is the main patch.
> Patch 14 adds an example how to use the Git filter protocol in contrib.

Will replace.  If you ever need tor reroll 13, please squash the
following in (which I already did locally so there is no need to
resend only to correct it).

Thanks.

 convert.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 9d2aa68df9..bc242276ff 100644
--- a/convert.c
+++ b/convert.c
@@ -535,7 +535,8 @@ static int packet_write_list(int fd, const char *line, ...)
 	return packet_flush_gently(fd);
 }
 
-static void read_multi_file_filter_status(int fd, struct strbuf *status) {
+static void read_multi_file_filter_status(int fd, struct strbuf *status)
+{
 	struct strbuf **pair;
 	char *line;
 	for (;;) {
-- 
2.10.1-613-g6ad57fc60c


