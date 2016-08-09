Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A8B1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbcHISfq (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:35:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752600AbcHISfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:35:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC60E3284B;
	Tue,  9 Aug 2016 14:35:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x6qxTCEqXF8xinAByDh0HmVA6nQ=; b=gBymPP
	Q2kPEuY6Uowb3TAq7Q/0z/0Aq8wyxa7e/PcX96mFO1YS04/1zjAmBYw/VL1mjM1n
	r9EwVANUbEs2mVJ/VZWfRSwWiRnYyaV8YL+wEg0RC9a2QTsqEU5g+jJrsYzleugF
	r91q99wuAJwceIk1la8jdgN+h30xs15KGZn8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVCWwulU5PHhZ79zwgwiPpJ9+UAP2Ujq
	S/WI6+sKoVHEwM4qsEpud/MloIzlqGkGZByA18JrMbno5Mu8IAqvz8yI20PyP7EF
	Tyk6KNDJGHkXbW7MYPD24oArwjCzWTdlnlV4d6iXAtEMzTARnDKb3yADmHiF/1P9
	RZJxA+8lf6o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5BE032849;
	Tue,  9 Aug 2016 14:35:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4081932848;
	Tue,  9 Aug 2016 14:35:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 6/9] clone: implement optional references
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-8-sbeller@google.com>
	<xmqq7fbpdhkw.fsf@gitster.mtv.corp.google.com>
	<xmqq4m6tbzfd.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbS1_DULjf8gPram+zNLe-xRShETotq+at+r7bmWrUyxA@mail.gmail.com>
Date:	Tue, 09 Aug 2016 11:35:39 -0700
In-Reply-To: <CAGZ79kbS1_DULjf8gPram+zNLe-xRShETotq+at+r7bmWrUyxA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Aug 2016 11:20:04 -0700")
Message-ID: <xmqqd1lhaiys.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1329EC6C-5E60-11E6-BD5A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Thinking about that we may want to not rely on such a hack,
> but make it clearer.

But that is far from sufficient, isn't it?

You'd need to bypass "not a local repository", "shallow" and "is
grafted" anyway, so in that sense, that hack is not doing much.
If modules/X (or modules/X/) does not exist, it won't pass these
checks, so burdening the readers with slash trickery is not really
worth their time.



