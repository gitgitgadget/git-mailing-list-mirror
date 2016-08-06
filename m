Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE531F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcHFUEw (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:04:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752054AbcHFUEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 234E530295;
	Sat,  6 Aug 2016 13:05:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EKjdx2Y2SUDFhKiM/JdpLnRCwRU=; b=UYojpZ
	r42K5+AhHz/N2X7DDpYMFGL0Myvtw837LaC7juxlznxrbuDdUZ6V6k2xq3dkgCak
	RiF62hRxWBlPms/vVjs/RfXeoZh9wzvAhUHbArEy1QfHkA6C0QR0dFPBN2jZj4f9
	+AyrzFwP2EjHAJfALJQOZWx63KLwgnah8TURc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t4TxnbXruUeTPPmFhHVZxR/9OBRuF51V
	KvBSYfO0mlYsEUlfk8pdLrETRs6zeHVuzt2mWIjJZLmnMHdx9zP8TM8K0C6V4c9Z
	wZ+H9/ORiS+EwosOpMBVvMBfVSrs9X9/EIqGFj4wJwVbksr17LdeKiW5YECQtjIJ
	qf008i6dFTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BC9A30294;
	Sat,  6 Aug 2016 13:05:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A94430293;
	Sat,  6 Aug 2016 13:05:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jens.Lehmann@web.de, git@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCHv2 4/6] submodule--helper update-clone: allow multiple references
References: <20160806012318.17968-1-sbeller@google.com>
	<20160806012318.17968-5-sbeller@google.com>
Date:	Sat, 06 Aug 2016 10:05:05 -0700
In-Reply-To: <20160806012318.17968-5-sbeller@google.com> (Stefan Beller's
	message of "Fri, 5 Aug 2016 18:23:16 -0700")
Message-ID: <xmqqoa55j0am.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED39F58E-5BF7-11E6-99C2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Allow the user to pass in multiple references to update_clone.
> Currently this is only internal API, but once the shell script is
> replaced by a C version, this is needed.
>
> This fixes an API bug between the shell script and the helper.
> Currently the helper accepts "--reference" "--reference=foo"
> as a OPT_STRING whose value happens to be "--reference=foo", and
> then uses
>
>         if (suc->reference)
>                 argv_array_push(&child->args, suc->reference)
>
> where suc->reference _is_ "--reference=foo" when invoking the
> underlying "git clone", it cancels out.
>
> with this change we omit one of the "--reference" arguments when passing

s/with this change/With this change/;

After the "We won't look at what is queued on 'pu'", I am debating
myself if I should amend this locally.
