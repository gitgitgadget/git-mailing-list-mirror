Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C0E1F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbcHCQPr (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:15:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751501AbcHCQPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:15:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 897E42F5C9;
	Wed,  3 Aug 2016 12:08:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G/z74WYZIhrZjo9/xY8I2Oy31G8=; b=Zysbut
	4dJaQ4kDbGuE4ujCCBDF4iffHwFf8q/ztYf5ZcVEGFVg+bETUXp7CVR4TDcNptI5
	S6CMieugi7lqufHNlfBTz+xyZVbXHoU5B8PmzlNqLsMMbWKU9eTPvGjAFqMvomK9
	UgjSx+w7qIk5ykeFdjJvgT3BugCa8xXfJB4Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wk9VADnwHt1sHuDf6thWff9F/BdK8u9Q
	QR2rn1SYo1xBCZBAiJyE3UjNQbo2oqkU7INS66RC46LDfNjvVrblO4QE5Uth34dq
	tm4IcdMUpPNBzVFdQ5KXsdEUq+09KurZHYgCrpkulf+z9lCIoUPDyS4jzQvde1+a
	R4zK8vBpY5k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E83D2F5C7;
	Wed,  3 Aug 2016 12:08:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E91812F5C5;
	Wed,  3 Aug 2016 12:08:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
References: <20160803084743.3299-1-judge.packham@gmail.com>
	<alpine.DEB.2.20.1608031621590.107993@virtualbox>
Date:	Wed, 03 Aug 2016 09:08:48 -0700
In-Reply-To: <alpine.DEB.2.20.1608031621590.107993@virtualbox> (Johannes
	Schindelin's message of "Wed, 3 Aug 2016 16:31:41 +0200 (CEST)")
Message-ID: <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9154AF08-5994-11E6-AD36-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... my Git garden shears [*1*] (essentially, what
> git rebase --interactive --preserve-merges *should* have been).

Any plan to fold it into "git rebase -i" as a new (improved) mode of
operation, by the way?

> However, I could imagine that we actually want this to be more extensible.
> After all, all you are doing is to introduce a new rebase -i command that
> does nothing else than shelling out to a command.

Yup, I tend to agree.

Adding "sign" feature (i.e. make it pass -S to "commit [--amend]")
may be a good thing, but adding "sign" command to do so is not a
great design.

There is no inherent reason why "sign" feature implies "--no-edit",
and adding a "sign" command like this patch means that the next
command somebody else proposes will be "sign-and-reword".

We should be able to treat Signing and Rewording as two orthogonal
features, one that passes -S, and the other that refrains from
passing --no-edit.  Otherwise as the number of features grow, the
number of commands will see combinatorial growth.

Thanks.


