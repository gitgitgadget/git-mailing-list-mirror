Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FABA1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbcHOWTz (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 18:19:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932173AbcHOWTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 18:19:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 603C636661;
	Mon, 15 Aug 2016 18:19:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G7pKctHVWIYMXxeDoJFUZBl9e5U=; b=wJS1JQ
	EEd9fLJyZpfzyhEs8/B8AL2UC3AWz4V/MOZH5GEmht062vPmW35sQmIhWTb7n642
	Fd/poJ2jD+5j87qZeFc+utupirVmf/gmp3cpTpBizX+1u3xnziB9C1B1Sm78oonE
	mJ4baXys/44lMZEwlgj766InPq7Q+k4WQ5G/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEKnEwt6Yg62+Ihdw6Vvb6eO274KY0Fl
	b1UId573HTAxsXb/mpFqLkuducer3HHZwBYjieaeefTvRiQtjkXjlVGNhvoO91OE
	sVfVynLzYaoioeZEt/xBQBcwMYBV7dlWLIeOwc3HcfDB/RsKWnCuRUIHkmyRHey0
	P6kUbUMHGOk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5616536660;
	Mon, 15 Aug 2016 18:19:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC0603665F;
	Mon, 15 Aug 2016 18:19:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>,
	<larsxschneider@gmail.com>, <me@jnm2.com>
Subject: Re: [PATCH v2] help: make option --help open man pages only for Git commands
References: <20160812201011.20233-1-ralf.thielow@gmail.com>
	<20160815053628.3793-1-ralf.thielow@gmail.com>
	<D954CB3E6C3445AF9358C6941362B69D@PhilipOakley>
	<xmqqr39phq3c.fsf@gitster.mtv.corp.google.com>
	<C8DDA334A45E4B558FD1EFB191E047C9@PhilipOakley>
Date:	Mon, 15 Aug 2016 15:19:50 -0700
In-Reply-To: <C8DDA334A45E4B558FD1EFB191E047C9@PhilipOakley> (Philip Oakley's
	message of "Mon, 15 Aug 2016 21:40:54 +0100")
Message-ID: <xmqq8tvxfzeh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63673236-6336-11E6-9FCE-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> The other option is to simply build a guide-list in exactly the same
> format as the command list (which if it works can be merged
> later). Re-use the existing code, etc.

Yeah, that sounds like a good way to go forward.  To implement typo
correction for "git help <guidename>", having guide-list would be
very useful.

A related tangent is that I think "git <guide> --help" shouldn't
fall back to "git help <guide>", regardless of typo correction.  It
happens to "work" only because we blindly turned "<w> --help" to
"help <w>" without even checking what <w> is.  Making it stop
"working" would be a bugfix.

And having both command and guide list would be helpful to prevent
"git <guide> --help" from falling back to "git help <guide>".
