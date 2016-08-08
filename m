Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404462018E
	for <e@80x24.org>; Mon,  8 Aug 2016 20:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbcHHUMB (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 16:12:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752300AbcHHUMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 16:12:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4055334E9B;
	Mon,  8 Aug 2016 16:11:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qjjtY7PIoHMHUUZzrf1lPh9jc48=; b=tgKM5f
	+ZMqZZWkegat6PmhjwyJfXWCeoh4Z4y2lncMfEZMDi4sXcDsZ1yIA/ifs5opO1el
	N2oGuyWAv1faeqNxlCy5Te4iR+xbMTOUFQbr7MnZGcyeahzt4COiBiz8Lfl50Ozi
	Bf6m9kffVfCb3a/qMglagENwzG3wi/RvOPCkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eFn/+9z7yDK6y89RvhYfwC6yuu30ZVSY
	/u635sQXbnfTneb04H8FmsZbWNRjtUxKGfED2qZUbNAo2hSpobuEUlql0MnoZWUE
	pDPR+VWeNvc3aYHXhz5WHJNKek+I1kHoZnKmy+cxmvVe82ynYTGggimuC2wBOJXn
	ovU+iHVRww8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3683134E9A;
	Mon,  8 Aug 2016 16:11:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5F4F34E99;
	Mon,  8 Aug 2016 16:11:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge: use string_list_split() in add_strategies()
References: <57A4FEAF.3040208@web.de>
	<alpine.DEB.2.20.1608081034250.5786@virtualbox>
	<xmqqeg5zf8mh.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 08 Aug 2016 13:11:56 -0700
In-Reply-To: <xmqqeg5zf8mh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 08 Aug 2016 10:55:34 -0700")
Message-ID: <xmqqfuqfdnqr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C5BE906-5DA4-11E6-BE3B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If the input comes from the end user, we certainly would want to
> allow "word1 word2\tword3 " as input (i.e. squishing repeated

Any intelligent reader may have guessed already, but before I
stupidly told Emacs to refill the paragraph, the above example had
two SPs between word1 and word2.  Sorry for being sloppy.

> delimiters into one without introducing an "empty" element, allowing
> more than one delimiter characters like SP and HT, and ignoring
> leading or trailing runs of delimiter characters).
>
> If the input is generated internally, perhaps we should rethink the
> interface between the function that wants to do the for-each-word
> and its caller; if the caller wants to pass multiple things to the
> callee, it should be able to do so without first having to stuff
> these multiple things into a single string, only to force the callee
> to use this helper to split them out into individual pieces.
