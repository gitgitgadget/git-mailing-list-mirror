Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FEE1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934391AbcHJUiU (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:38:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753131AbcHJSPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:15:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AFB8E3005D;
	Wed, 10 Aug 2016 11:59:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3OpZ3Uyekq7JCbCyYeMixfXpNEU=; b=bajk1c
	I53x/VHN0O1Nyo6e27+JdR7KBK7QOH6MYompumVjxFT8/AzbnrAYmn9foV+dVpJg
	2pH/stloDfCGlBu1CQxeImPK4myHab8gWGvUzV/8YfgKnRuM8Owbj2cHbod2E5vo
	c+3YeWt8XBSjpVPd0Ugoofz1J+D92v/HcMCiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rCK1jtC8o4oJu+Z0lLtNIka96gDQ7alF
	jDaFjLam9t5QB74c6PQKFNR5I3JRJ5e75HhJAOm9MKNxd4KmpgPT01fuqPRgyGv2
	nwtBDmJElIRM+vcSCQwGC1eJEQKttMHh6iMHzRq3dA3VmGk5dX5PsVntEHneWPCP
	qkJnoRf0Azc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A88183005C;
	Wed, 10 Aug 2016 11:59:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CF373005B;
	Wed, 10 Aug 2016 11:59:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160809040811.21408-1-sbeller@google.com>
	<xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
	<xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
	<xmqq8tw5aijv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbPvj6dU1DMaCh7ieJbs0qWimdHSD8xFfUyV98md2pywQ@mail.gmail.com>
	<xmqqeg5x8vl4.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYkn6eVUBd_hXd4FSxr+y-iNTSsOfqdcKWBWp-aaVpAkQ@mail.gmail.com>
Date:	Wed, 10 Aug 2016 08:59:40 -0700
In-Reply-To: <CAGZ79kYkn6eVUBd_hXd4FSxr+y-iNTSsOfqdcKWBWp-aaVpAkQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Aug 2016 15:05:07 -0700")
Message-ID: <xmqqpopg7gyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73214BAC-5F13-11E6-937F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Aug 9, 2016 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> becomes easily doable (i.e. subsequent "submodule update" can realize
>> that the submodule does not have alternates but it could borrow from
>> the submodule in the other-super-project-location).
>
> I would suggest to postpone this to a later time once the need arises.

Oh, no question about that (did I even sound to be suggesting to do
it now?).  It is just one of the yardsticks I use when gauging if a
proposed solution is sound to see how it will naturally scale and/or
extend to other possible scenarios, and I was pointing out that this
seems to pass the test.

