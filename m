Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E681F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbcG2SUz (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:20:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752988AbcG2SUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:20:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 562A032A2A;
	Fri, 29 Jul 2016 14:20:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KDzTMl7xH3vYCNIbm/YEppKzz4=; b=vTOXmf
	qxTplE7pCCOIIjQryNOlYsFkUuPWx1u3UPbu7yaPt+12lSmNUcAz/codVknDIJQ0
	Eltci9Ayo4hF9Zv87fSCBK8rfXR9cJpR3PavdSB1xzw9z4kcHoSzMpt1zx4PEauz
	G4cSECXsivT2JM/qgRh/EGz1mHmVCPr/sRoiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIUBQlBw6RRwA1D8eLS/hhuufvdWT1L1
	gCdTcjeGbgWK1wfZJ073Fv9nzmxecUpKTOqNHKPoF4iQbxvLK0OZf5IcUDHkmuU7
	m8Q4M2+CB+6tTcx4yd/VFMxG6v3sf0kp81MwxMfoW1q5iw7EVews3lmWGaSqI8df
	/1HA3h/Icfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E71A32A29;
	Fri, 29 Jul 2016 14:20:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C06AB32A28;
	Fri, 29 Jul 2016 14:20:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Dakota Hawkins <dakotahawkins@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
	<xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 29 Jul 2016 11:20:49 -0700
In-Reply-To: <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Jul 2016 10:47:27 -0700")
Message-ID: <xmqqa8h0nw5a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E72E85C-55B9-11E6-877F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Dakota Hawkins <dakotahawkins@gmail.com> writes:
>
>> In those cases specifically, I never have local commits that differ
>> from the remote, so a "pull --ff-only" should leave me in the same
>> state as a "pull --rebase".
>>
>> Is this a case of rebase trying to make sure it has enough information
>> for me to be a committer before knowing whether I even need to rewrite
>> any commits, and could/should that be avoided?  Alternatively (or also)
>> could/should rebase detect that a fast-forward is possible and prefer
>> to do that instead?
>
> I think that is a reasonable argument,...

There is one that still wants to know who you are, I think.  The
reflog entries record who moved the tip of the ref and when, and
obviously a fast-forward is also recorded.

I _think_ our intention was to allow a bogus ident in reflog entries
(even though we want to avoid a bogus ident in commits and tags), so
perhaps additional code/logic for user.useConfigOnly may need to know
about that (I didn't dig)?

