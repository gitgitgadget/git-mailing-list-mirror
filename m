Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AA71F855
	for <e@80x24.org>; Fri, 29 Jul 2016 21:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbcG2VDl (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:03:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751973AbcG2VDk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 17:03:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F38EC30963;
	Fri, 29 Jul 2016 17:03:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mpl1yJ0v2Q9dw1fOcDPah1ChHkY=; b=Qj+VEA
	ORddwn6dUdlmThqHD7x5mZD89SlYRoWLWyHfPfchy1vvWe9xrfS9O+UXTYII7FX2
	SMLhkQ6HpFDEE2JRCGzRO6HhNn6FvusBlAu8tOv2lJAtA8QTS5IQpDFXoY1nK+Vv
	5taUCmBiQnMnfFD4JqhYgPoRg8j/00HkaPjhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CpQ7mqwXNIchg5zuk9iD5XVFREmV9Lt7
	Xxad0XaKAni5Q5N+WKrBHab9iSxAwb9s1OrMcRWyEhA32O4cy6CtDKBocxgOGwv9
	DE8gwplyGkUkKduQCweUp+dcNCsdUPM3RGPNExphiYKWfrQEvxUj9tmeUW/fH+W/
	jSR3v308SSs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD6E30962;
	Fri, 29 Jul 2016 17:03:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 741E230961;
	Fri, 29 Jul 2016 17:03:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kevin Willford <kcwillford@gmail.com>
Cc:	git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 2/4] patch-ids: replace the seen indicator with a commit pointer
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-3-kcwillford@gmail.com>
Date:	Fri, 29 Jul 2016 14:03:31 -0700
In-Reply-To: <20160729161920.3792-3-kcwillford@gmail.com> (Kevin Willford's
	message of "Fri, 29 Jul 2016 12:19:18 -0400")
Message-ID: <xmqqk2g4ma1o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8DE551C-55CF-11E6-B957-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> From: Kevin Willford <kewillf@microsoft.com>
>
> The cherry_pick_list was looping through the original side checking the
> seen indicator and setting the cherry_flag on the commit.  If we save
> off the commit in the patch_id we can set the cherry_flag on the correct
> commit when running through the other side when a patch_id match is found.
>
> Signed-off-by: Kevin Willford <kcwillford@gmail.com>
> ---
>  patch-ids.c |  1 +
>  patch-ids.h |  2 +-
>  revision.c  | 18 +++---------------
>  3 files changed, 5 insertions(+), 16 deletions(-)

We lose the final loop to fix up the shorter side, because the
second loop now marks both sides.

And as a side effect, we do not use commit->util which is a scarce
shared resource (aka historical API wart).

Makes sense.  Thanks.
