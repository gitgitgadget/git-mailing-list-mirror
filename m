Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF1D1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbcFUQuY (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:50:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751661AbcFUQuW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:50:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B891249D4;
	Tue, 21 Jun 2016 12:50:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=De2KQIhO6PaNwfpsvJcCdQ1r2u0=; b=U4ztnc
	Z1bHxv8hUo/vJFBjr+w997nx+5hjqNWZ/tBHwGww2T6kZeRLDvkCmsUrwDpatXJj
	F2pKGtK6TfANstHmHbKJPdYHkQnlj+jsuyArIMc4fo2mDozfXUhXvjkx+5l3qtnx
	xqFzbT/Em3YCoxPmoM36bSyycOJs0rwAFE6oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DVAX8mGGsX22dLXTJ5VWKqww8nf0JXrD
	G3KeftlXJAmcSXmF5vzjZNI0aH4mAPu3Zb6h4EI4IIqwDJOQyNZIym65Gz/vzkGS
	zbTA39RwwDs1QpAYJ8UxOz/omjDn6bjzbqRkzR359TF8SMwHyY7k8v85hZqfm9au
	aqQM4Yv6BkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43913249D3;
	Tue, 21 Jun 2016 12:50:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3743249D2;
	Tue, 21 Jun 2016 12:50:19 -0400 (EDT)
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
Date:	Tue, 21 Jun 2016 09:50:17 -0700
In-Reply-To: <alpine.DEB.2.20.1606210906190.22630@virtualbox> (Johannes
	Schindelin's message of "Tue, 21 Jun 2016 09:15:05 +0200 (CEST)")
Message-ID: <xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D0901FA-37D0-11E6-9C43-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is a very convincing argument. So convincing that I wanted to change
> the patch to guard behind `diff_use_color_default == GIT_COLOR_AUTO`.

I actually was expecting, instead of your:

 	if (output_directory) {
+		rev.diffopt.use_color = 0;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));

an update would say

 	if (output_directory) {
		if (rev.diffopt.use_color == GIT_COLOR_AUTO)
                	rev.diffopt.use_color = 0;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));

I didn't expect you to check diff_use_color_default exactly for the
reason why you say "But that is the wrong variable".
