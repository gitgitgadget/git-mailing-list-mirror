Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4172018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcGRUzM (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:55:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751632AbcGRUzK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2016 16:55:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56DF02DAAD;
	Mon, 18 Jul 2016 16:55:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p/h8i5cZLMYQ
	VVq/tjXBN7hJ7Dc=; b=bVzKQJDWnm2q6l5s7QLRestr+4a8z50s+HvsRYznhLqi
	jADQKhSiGKJzIBlBsB5vapBiomk4r+GoEDtsyTdsEZtkzylp7rMPaiZna5khgEQo
	fU/4VcXJ4vLiH+fP3Yu7Z8Y4HFPyHIH+PY/jFdO2uVijgvbuabES/zwaoh82go0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qHJuXQ
	THOpGbhlEian1EdfjR7KoccMbEUzOVjlZdxqMOkzRQP/uZUOLGdg+s9fV9jS7YWD
	W0QZqqOJLIwjNVSXeuNgGzaOB+qf6AhWHlH4cpU0xYAPt0ykRbqDDGLG76g8RnWR
	55wwLNmPq1tGDqPvhB3u+RAxBkMkqQ3BpzS98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E61D2DAAC;
	Mon, 18 Jul 2016 16:55:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBC572DAAB;
	Mon, 18 Jul 2016 16:55:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:	Herczeg Zsolt <zsolt94@gmail.com>, Git <git@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Git and SHA-1 security (again)
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
	<CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com>
	<CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
	<CACBZZX4N37Ty2yZosHA+PexscLc_Y4_QDZNktVM8bza_5cGu+g@mail.gmail.com>
Date:	Mon, 18 Jul 2016 13:55:06 -0700
In-Reply-To: <CACBZZX4N37Ty2yZosHA+PexscLc_Y4_QDZNktVM8bza_5cGu+g@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 18 Jul
 2016 22:02:21
	+0200")
Message-ID: <xmqq7fciis45.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E98915AA-4D29-11E6-87FD-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The reality of the current situation is that it's largely mitigated in
> practice because:
>
> a) it's hard to hand someone a crafted blob to begin with for reasons
> that have nothing to do with SHA-1 (they'll go "wtf is this garbage?")
>
> b) even in that case it's *very* hard to come up with two colliding
> blobs that are *useful* for some nefarious purpose, e.g. a program A
> that looks normal being replaced by an evil program B with the same
> SHA-1.

Thanks.  That's a nice rephrasing of

  http://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901%40ppc970.osdl.org/

where Linus explains SHA-1 is not the security, and the real
security is in distribution.
