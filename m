Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5D41F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbcG1QWh (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:22:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758928AbcG1QWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:22:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 716A02E232;
	Thu, 28 Jul 2016 12:22:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Ho9jedo+2ZftQ+MMuzMedOhCzc=; b=cXMIYW
	PgEbPs03doi2RSpodCOMMI8Nuf2MaZpgtAlWlovsBJkryU1DkB4QQaEid6N6pMcq
	mRlW6zOFA1T4gGoI4gXq/mjln/I8jkSdn8nhDALYXAY392d/h0so3Kzq1Y8kNrlk
	EY69nUEjM6jm4W0wSrfAbJWLo3T1azurZUDRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJ+N48bVvRLGGaL8/ZDqxWjIN6Wv7MsJ
	jvBYbKFhjAoc0LvCudeGg7mUcrfvmjF+kmdgcXbaV7EmA+HVrQfBRnFK5/Xt6B8F
	QhUoQM1JZNnea7cUWijPTx2PcF5fkixgp6Ekn6V/itYm8nWfXvLo+l5XHJ+MCzw5
	K2vylx9OjXM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 673932E231;
	Thu, 28 Jul 2016 12:22:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD4312E230;
	Thu, 28 Jul 2016 12:22:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Chris Packham <judge.packham@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv1] completion: add option '--recurse-submodules' to 'git clone'
References: <20160727083406.10241-1-judge.packham@gmail.com>
	<xmqqshuvvvxb.fsf@gitster.mtv.corp.google.com>
	<xmqqoa5jvven.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka0kvr9RAkGHbgrZ7fery8436dH8Nu4bwG0t3K5FprgKA@mail.gmail.com>
Date:	Thu, 28 Jul 2016 09:22:31 -0700
In-Reply-To: <CAGZ79ka0kvr9RAkGHbgrZ7fery8436dH8Nu4bwG0t3K5FprgKA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 27 Jul 2016 10:41:08 -0700")
Message-ID: <xmqqshutspfc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D5E8226-54DF-11E6-BC19-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Anyway, I'll apply the "addition to the completion" patch.
>>
>> Thanks.
>
> Thanks for this patch!
>
> Note: if we ever decide to resurrect sb/submodule-default-path,
> we run into a merge conflict. The reasoning for using
> "--recurse-submodules" instead of a plain "--recurse" makes sense
> as well, so that merge conflict will be resolved in favor of this patch.

Thanks for an advance warning.  My rerere database has already been
taught about this conflict ;-)

As to sb/submodule-default-path topic, which has been blocked on
still-in-flux attribute work, I am tempted to declare that the
attribute work is not yet thread-ready but it is in a good enough
shape to base other works on, and have them advance to 'next'.

The traditional pattern of allowing the callers to randomly allocate
an array of "struct git_attr_check" and passing the pointer to its
first element to git_check_attr() function was impossible to extend
without having to update the callers, but we have migrated away from
the pattern and the attribute subsystem can be enhanced without
impacting the callers too much.

