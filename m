Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A6320189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbcFVPtQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:49:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752151AbcFVPtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D52232EA;
	Wed, 22 Jun 2016 11:49:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90rMh7Ib4aGzHOj64+j2erBeqUc=; b=h7189O
	Gg9XEpCJ/9jYT3lR1IMFIoBe1EoW4E0KDOYE1pKM2+VN6GTmjXFi1DEddacWfQUy
	f9ZU8KI9F81yESwfXqIteFzw21a/YIuajj4RusacbT/4bqtbmzoyuYxB9FB8MtNJ
	CMFJfS7KCp/bb65k/qQe1XMYhg+7YAyvuSg3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vltBRdoFezvXn46gB1aTBsWaOAHJ0gFM
	NU7XYyJa0C9DcXyAXxoA7FOK0gdxxmeJsYxN9ev6rb6C5VwZofmklhWVGIPf21BD
	Eo3MQif1aFl4v3EBM74JXj/UEjik8a6k4EH1qQtS1N8CESTmwzcMVbAc4eGYhV1B
	wuaeXTbUkv8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AD49232E9;
	Wed, 22 Jun 2016 11:49:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3B3C232E7;
	Wed, 22 Jun 2016 11:49:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
	<de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
	<CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
	<alpine.DEB.2.20.1606200814510.22630@virtualbox>
	<xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606210906190.22630@virtualbox>
	<xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606220849480.10382@virtualbox>
Date:	Wed, 22 Jun 2016 08:49:09 -0700
In-Reply-To: <alpine.DEB.2.20.1606220849480.10382@virtualbox> (Johannes
	Schindelin's message of "Wed, 22 Jun 2016 09:24:07 +0200 (CEST)")
Message-ID: <xmqqeg7pns0a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD30948E-3890-11E6-AB1E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But there's a rub... If you specify --color *explicitly*, use_color is set
> to GIT_COLOR_ALWAYS and the file indeed contains ANSI sequences (i.e. my
> analysis above left out the command-line part).

Heh, the command-line is the _ONLY_ thing I raised, as we knew
ui.color is not an issue in this codepath, in $gmane/297757.

Going back to that and reading again, I suggested to check with
GIT_COLOR_AUTO (i.e. if it is left to "auto", disable it) because I
think the former is a much more future-proof way (imagine that we
may add --color=<some new setting> in the future) than checking with
GIT_COLOR_ALWAYS (i.e. if it is not explicitly set to "always",
disable it).

> In short, I think you're right, I have to guard the assignment, with the
> minor adjustment to test use_color != GIT_COLOR_ALWAYS.

So I am not sure if you said "use_color != GIT_COLOR_ALWAYS" only to
be different from what I suggested (you seem to have a tendency to
do so whenever you can), or there was some other reason.
