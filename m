Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3641FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbcGSSyA (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:54:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751218AbcGSSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:53:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B21062DFD2;
	Tue, 19 Jul 2016 14:53:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UNke6SNbnyAOGb3AXn/xySa3bz8=; b=gPvN3M
	gsW2aOOhz6GtYWLivjHRKSUmPismu+LNaRnaV17siPMgng/xFfr9XqQQsH3X51Nb
	WBQfgfevsL34wg1Fqw0k6pkZV7OYE38aJQYANtaSktKSDshC3UEGb3gB7wq3cHQe
	sk6CGo2W8S2ZUfXY0eyJXizz+MUw2bBV6Qrt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A+4rbyRW9MOzLMSGA9JwTykgvJnwAZVn
	dnIoPUckCGyFPeBy8SD0Bt12xVRz2mofteQQNYL2QXTgjq7DDrL4+SQaX9X8hjYG
	4JqyXn371rTkVpw0SSbgEWrZ9AX9NxFlcFoBTRx23C6RxMf3l5zM8WtWY5zZGCuw
	ppS1l7Bk2uk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9D452DFD0;
	Tue, 19 Jul 2016 14:53:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D16C2DFCD;
	Tue, 19 Jul 2016 14:53:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: Looking for help to understand external filter driver code
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
	<xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 19 Jul 2016 11:53:55 -0700
In-Reply-To: <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jul 2016 10:56:00 -0700")
Message-ID: <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25B53780-4DE2-11E6-986D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The key benefit of this arrangement is the above can be done without
> having to do poll() to flip between reading and writing that is
> needed to avoid deadlocking, which kept the code simpler.  A later
> conversion of the write side into async does not fundamentally
> change anything from the original arrangement.

Translation: I was too lazy to worry about doing poll()/select()
when I did it originally.  As long as you can do so correctly, be my
guest to reduce one process by having the main process do both
reading and writing.

;-)
