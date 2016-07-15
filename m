Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B2C20195
	for <e@80x24.org>; Fri, 15 Jul 2016 17:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbcGORHL (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 13:07:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751865AbcGORHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 13:07:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42FF92CD80;
	Fri, 15 Jul 2016 13:07:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=67QrD55AWtcSKqgbBUWNffOAqr8=; b=LmKqWY
	yadnWOYso5WkhhKnS6enJr8fRXCrtKIDUENXrCXcZB/SPf/fEgq/soi/LQG+jyyR
	TqL9GDZmHfB0A5rpmjSPyeDnGx2AhkVbgek7K3knG+trmGLLU585BSqxbxa6pPrE
	Gx5tCXx1snIbajCpwlvpD//So258vSLSKu8mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REuo7RgPMz2iKxv8Yk/f9fmwq01Q24gE
	3b1iHQRHsOspZTHcdjeWhGxTEVy1eg3X2SflbuCouUrF3jj0kVVcDrYlA0GlDGLC
	O31ZNURvhTUjfthCFbt47iZpUEqypp4E+15hI7lnWjT66p76yrUDnNCMY+j7A3j9
	QUDqMWXYd9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 370D02CD7E;
	Fri, 15 Jul 2016 13:07:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9250D2CD7C;
	Fri, 15 Jul 2016 13:07:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] Verify that --cherry-pick avoids looking at full diffs
References: <alpine.DEB.2.20.1607151749540.6426@virtualbox>
Date:	Fri, 15 Jul 2016 10:07:04 -0700
In-Reply-To: <alpine.DEB.2.20.1607151749540.6426@virtualbox> (Johannes
	Schindelin's message of "Fri, 15 Jul 2016 17:51:51 +0200 (CEST)")
Message-ID: <xmqqwpkmn83r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F0C8062-4AAE-11E6-8F44-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The entire point of the previous patch was to make sure that we look at
> abbreviated patch IDs (using the diff *headers* only, but avoiding
> to load the blobs into memory and diff them) first, and only look at
> full patch IDs when the abbreviated patch IDs were not for the
> --cherry-pick test.
>
> Let's make sure that we actually avoid looking at the full patch ID,
> simply by corrupting an object that is needed for the full patch ID, and
> then seeing that --cherry-pick still works.

I think "Avoid looking at" merely is the means to an end, and not
the goal by itself.  By not looking at them, you hopefully run
faster.

So I'd think a more useful addition under t/ would be to t/perf
somewhere, not "now you can rev-list --cherry-pick even inside a
corrupt repository, as long as corruption happens to be with blobs
and not the containing trees".

