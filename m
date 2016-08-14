Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583171F859
	for <e@80x24.org>; Sun, 14 Aug 2016 08:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbcHNIjw (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 04:39:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751229AbcHNIjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 04:39:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B841366DF;
	Sat, 13 Aug 2016 23:21:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e0wdPi9SWdCkcptUKlK6yoi9Xi8=; b=rcJ6aj
	RZncI7oNSX0NjtveaGReqQdki1z0UOPVRJD+pfyQrjuPL7YvB0X+MfnPQO5jNttX
	d/JBniZZ2CI4d9LDk3bd4+Uwl6cX7rryfy4rtcoj8CQKNYOvI3SA49Fs/CFq3vF5
	Mmis9QfH3umYfVgoTQBxlipAO7bWLV3PTW4mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vKD/MLlEgfREUzLSPCli7YvDxR7wSQyb
	y5/3EiOkBtdlfIZ23o0QTMOQkv64Mv4PFLSRZQvN9n6EIKkpimrpFoEhocX8wIS7
	nTLhIRuPhJhtmOUGdSfr/YZ/Irl5aLNaXg4CriUGajEOWNRJGHnmRNlBEfG8anuX
	+BT5MDa33ew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33124366DD;
	Sat, 13 Aug 2016 23:21:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C169366DC;
	Sat, 13 Aug 2016 23:21:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	"Tom Tanner \(BLOOMBERG\/ LONDON\)" <ttanner2@bloomberg.net>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] difftool: always honor "command not found" exit code
References: <57AD772501C207A400390148_0_15304@p057>
	<20160813103639.mxscvfyztee4hbvh@john.keeping.me.uk>
	<20160813113028.uwedje6fzuc3cuzr@john.keeping.me.uk>
Date:	Sat, 13 Aug 2016 20:21:14 -0700
In-Reply-To: <20160813113028.uwedje6fzuc3cuzr@john.keeping.me.uk> (John
	Keeping's message of "Sat, 13 Aug 2016 12:30:28 +0100")
Message-ID: <xmqqtweokpcl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29535FF2-61CE-11E6-A5BD-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> At the moment difftool's "trust exit code" logic always suppresses the
> exit status of the diff utility we invoke.  This is useful because we
> don't want to exit just because diff returned "1" because the files
> differ, but it's confusing if the shell returns an error because the
> selected diff utility is not found.
>
> POSIX specifies 127 as the exit status for "command not found" and 126
> for "command found but is not executable" [1] and at least bash and dash
> follow this specification, while diff utilities generally use "1" for
> the exit status we want to ignore.
>
> Handle 126 and 127 as special values, assuming that they always mean
> that the command could not be executed.

Sounds like a reasonable thing to do.  Will queue; thanks.
