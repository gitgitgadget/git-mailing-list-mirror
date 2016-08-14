Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB0B1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbcHNUmo (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 16:42:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932628AbcHNUml (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 16:42:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55E8234DBB;
	Sun, 14 Aug 2016 16:42:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zZ4cXHGnX/ObJ0yOYcM8TP9uBRM=; b=SvT9im
	DEy/nIMjumLeVbTGMy88nMPun/uLsdovtiv2X8h5o6T+CBLUDK2zUrNdSS4Qc1Cq
	JYOfjRTMtRlJNC+8QcvMsp83hphWAbbhOv/AMpVL6YXKJNzn/qe/2/KVwt6IvG2P
	HdnzQJOEJ4sm7oIHuZRdVS/I/TwHk/BA8Dxlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cga3cM89xGSBAco81162z15lcHu9YfGk
	14yUu/9j+36u3pP+ocZXdrGQmjXuy4FX+4BcFAk1e2eRolxp32FH+AOuqgaanjq8
	Ao3ZtraOAXjfvxCWV8KtE+Y1soXL9xpzR4MLuhbs6R9huRxiVLibqbdSDtXHeZr4
	hAjZGif1SWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F08934DBA;
	Sun, 14 Aug 2016 16:42:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7FAF34DB9;
	Sun, 14 Aug 2016 16:42:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] squash! diff: add --diff-line-prefix option for passing in a prefix
References: <5ca415f99718b1792cd0a9c31606b45d27befc48.1471164824.git.johannes.schindelin@gmx.de>
Date:	Sun, 14 Aug 2016 13:42:37 -0700
In-Reply-To: <5ca415f99718b1792cd0a9c31606b45d27befc48.1471164824.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 14 Aug 2016 10:56:25 +0200
	(CEST)")
Message-ID: <xmqqinv3krpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A43DA06A-625F-11E6-BE44-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
> +	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g' -e 'y/>/_/')

The existing sed scriptlet says "we cannot have slash and do not
want to have space in filename, so we squash runs of them to a
single underscore".  If you have more characters that you do not
want, you should add that to the existing set instead.

While you are at it, it may be sensible to add a colon to that set,
too, no?

Something like this, perhaps?

> -	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
> +	test=$(echo "$cmd" | sed -e 's|[/ <:>][/ <:>]*|_|g')
