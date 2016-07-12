Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C751FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbcGLTwx (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:52:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751193AbcGLTww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 15:52:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 83BDB2B551;
	Tue, 12 Jul 2016 15:52:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oc683NfatkReYzButHyHsX/Q+ts=; b=w5/bRd
	LGbfcDtU6hICE3CGm7xY26F73DX89HlHEzyxIHY4VGeodtG6kQORqk+aZ7BzsO4/
	OQRUtZD0jwvZxSqIeOYyGLRcUJ3Iddz5QJ3SNgjtlrmfq9CBmnOGOMWMId/aD3C8
	WMTt6AZCOcYUXdb/iC8MQV+HNN+v/osABdTOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GaNHThXJvP1nCK1G/HB/t0RgX05ShpI+
	uKUu/7WMIVclhN6joRaBnAyBnHcuSyH1yAdhrF7Fbb4jBDWYdUFnhw81u41VQGx1
	YnZLR/8DOrBdzJ1Zu3MAMJ0c/FO6kneH61uwOI5lqElh7l8zFHwiuRhVz8xSL3H4
	FfNqeV5MoBg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C9442B550;
	Tue, 12 Jul 2016 15:52:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E6642B54D;
	Tue, 12 Jul 2016 15:52:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v5 0/8] extend smudge/clean filters with direct file access (for pu)
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
Date:	Tue, 12 Jul 2016 12:52:44 -0700
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name> (Joey Hess's
	message of "Mon, 11 Jul 2016 18:45:04 -0400")
Message-ID: <xmqqeg6y4os3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34302E0A-486A-11E6-B565-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <joeyh@joeyh.name> writes:

> Since tb/convert-peek-in-index is not currently in pu, this reroll isn't
> based on it, and will conflict if that topic gets added back into pu.
> Not sure what the status of tb/convert-peek-in-index is at this point?

It appears that we are converging on _not_ using that topic after
all (cf. $gmane/299320).

I'll try to apply these on top of a merge between the 'cc/am-apply'
topic and the current 'master' branch and requeue.

> Improvements from Junio's review:
>
> 	fix build with DEVELOPER=1
> 	style fixes
> 	use test_cmp in test cases
> 	improve robustness of a test case
> 	clean up some confusing code
> 	small performance tweak
>
> Joey Hess (8):
>   clarify %f documentation
>   add smudgeToFile and cleanFromFile filter configs
>   use cleanFromFile in git add
>   use smudgeToFile in git checkout etc
>   warn on unusable smudgeToFile/cleanFromFile config
>   better recovery from failure of smudgeToFile filter
>   use smudgeToFile filter in git am
>   use smudgeToFile filter in recursive merge
>
>  Documentation/config.txt        |  18 ++++-
>  Documentation/gitattributes.txt |  42 ++++++++++++
>  apply.c                         |  16 +++++
>  convert.c                       | 148 ++++++++++++++++++++++++++++++++++++----
>  convert.h                       |  10 +++
>  entry.c                         |  59 ++++++++++++----
>  merge-recursive.c               |  53 +++++++++++---
>  sha1_file.c                     |  42 ++++++++++--
>  t/t0021-conversion.sh           | 117 +++++++++++++++++++++++++++++++
>  9 files changed, 459 insertions(+), 46 deletions(-)
