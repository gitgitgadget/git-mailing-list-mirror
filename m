Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AA72034E
	for <e@80x24.org>; Wed, 20 Jul 2016 21:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbcGTVuR (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:50:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751226AbcGTVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:50:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 749AA2DE3A;
	Wed, 20 Jul 2016 17:50:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cv+9bZxO6hIhS5e6NnKq2o8U7Us=; b=NQhoZG
	smGdcMNRG3BTpSrOGUj8SdtUspwGVgTuQAuGjXqxmORZ/Y5RyqJL1cg5xoim1bjf
	UtMhw39bRFov2CXf6q7bvNCkGKQbgSrS4u/DKeaa/4ngDOSH0a3MHx9mEfyAIXUY
	3X3MR7JTvUq6aS1AaPom5mPwQ4CKO8lvICMlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OsxTpW2p0AiApsUx9Od6pCGUUMgoROqX
	yJi6o+zjuA5XWT756IUx8s8mhZTimzrkJgmJ6OznlI3qKvX0af/bJ5tPFeOcV2+g
	TaPXmsZY9Bys5KO+cWkaB6Rbxu6BLcuZQN/Rhq1s8DzyEpXI0to2ESMeZwebmqRx
	U0LcAfOy3mU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D9A32DE39;
	Wed, 20 Jul 2016 17:50:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC8B92DE38;
	Wed, 20 Jul 2016 17:50:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 5/6] Add porcelain V2 documentation to status manpage
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
	<1468966258-11191-6-git-send-email-jeffhost@microsoft.com>
Date:	Wed, 20 Jul 2016 14:50:10 -0700
In-Reply-To: <1468966258-11191-6-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Tue, 19 Jul 2016 18:10:57 -0400")
Message-ID: <xmqqd1m8c73h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFC779FC-4EC3-11E6-B72E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> +A series of lines are then displayed for the tracked entries.
> +
> +    <xy> <sub> <mA> <mB> <mC> <mD> <shaA> <shaB> <shaC> R<nr> <path>[\t<pathSrc>]
> +
> +    Field       Meaning
> +    --------------------------------------------------------
> +    <xy>        The staged and unstaged values described earlier, with
> +                unchanged indicated by a "." rather than a space.

Ahh, this is where these mysterious xy came from.  You just needed
two random consecutive letters, and they could have been ab, ij, or
jk.  I don't like any of them ;-)

Also I have trouble with the "staged and unstaged" here, especially
the latter, as the word implies the user did "git rm --cached" on
the path earlier, which is not the case.  You are saying what is in
the index and what is in the working tree.

Perhaps using iw instead of xy to make them in sync with the way
"git diff --mnemonic-prefix" denotes the contents in the index and
in the working tree?  Together with s/staged/in the index/ and
s/unstaged/in the working tree/, the result would become more
consistent with the rest of the system, I suspect.

> +    <m*>        The file modes for the entry.
> +                For unmerged entries, these are the stage 1, 2, and 3,
> +                and the worktree modes.
> +                For regular entries, these are the head, index, and
> +                worktree modes; the fourth is zero.
> +    <sha*>      The SHA1 values for the entry.
> +                For unmerged entries, these are the stage 1,2, and 3 values.
> +                For regular entries, these are the head and index values;
> +                the third entry is zero.

To future-proof, we should use "object name" for what you call "SHA1
value" here, I would think.

> +    R<nr>       The rename percentage score.

s/percentage score/score/.  Do you differentiate between renames and
copies?

> +    <path>      The current pathname. It is C-Quoted if necessary.
> +    <pathSrc>   The original path. This is only present for staged renames.
> +                It is C-Quoted if necessary.

Seeing "if necessary" makes me wonder if we want to define when it
is "necessary".
