Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65F020705
	for <e@80x24.org>; Fri,  8 Jul 2016 04:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbcGHEeJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 00:34:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750858AbcGHEeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 00:34:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DAE1A2BB67;
	Fri,  8 Jul 2016 00:34:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0TPxbEjo+OIkW3E7rbdXDPeGmuc=; b=KDp864JnkfZlf8h73BWE
	cAtFM9olA5mlUXvVzGAfd3jqiOCvfrPm71zT+o+6tlvUnUWEb54bIpnPCFHIsq9A
	DEPKazjrfX30fVBKqlOFII7UVbRF927JS8YEitlFWOuMe7foTXrwfiCuVu8N+6ae
	Gwou+lyW/rUPfXwQovd0ivM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=B4YXoJOTo2EDm55BeS0nJ8Z5CRUdF6lkRW7v+4IcsuRDRq
	AA62o02h5SefcTrQ5ez7RqIeCWZetqx1lLDt7M8DXAUeHJlQhZ+wh5QRz5fwr7zI
	r1yZdYxWFuxB1QJoyFoRu6vUOAGkjkbyDws7Qi2FzpBe8MsYPwAwPksvxutXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D46C82BB66;
	Fri,  8 Jul 2016 00:34:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5541C2BB65;
	Fri,  8 Jul 2016 00:34:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
References: <20160708025948.GA3226@x>
Date:	Thu, 07 Jul 2016 21:34:02 -0700
Message-ID: <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3370A808-44C5-11E6-81C3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> This could result in data loss, if a user expected that having an object
> referenced from those places would protect it from pruning.

Yeah, luckily, nobody expects such.  I do not think any of our
document says nothing other than HEAD like CHERRY_PICK_HEAD is
reachability anchoring point; they are designed to be transient.

Because they are designed to be transient, I do not think there is
any downside (other than the initial start-up cost) to including
them in reachability computation.  Because they are meant to be
transient, the objects anchored by them would be reachable from
other anchoring points anyway.
