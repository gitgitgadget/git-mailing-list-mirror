Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9644920189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcFVUbv (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:31:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751432AbcFVUbu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:31:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6639726C06;
	Wed, 22 Jun 2016 16:31:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jvYAw2NgvmpI3EBABMI35IudliM=; b=hYZCxi
	I11ChfPMN+UL+8M7izZMzzZftUWvu6+drUzyvBEEHiPkOci1EXjHwPK/L7t8aEMY
	IRir+mHN8OM3lraJdpA/1pF9MdD5QLmDhVTdWDCKB96bR1V+TJc4ljG4uRPawK+M
	2RIFacnxKk8TUe1PFL+07FKs2Mxk0P2vfXcqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YnsVB3dmpe+J6vYUWtM5iiEZ4pXkCFS/
	0h+BRav8KF1ZWK+KLAJ5TugIPmcxJLNflkUj/PVgVD2cgkP648EjjpPTEVfTPuIW
	SJIxgeDdlmvTmlfq1ZfTcQFBwbyI/dUdW32UjUfMOegXk65XOMYggrX1GECz3sCz
	ano+slWdTHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E3CF26C04;
	Wed, 22 Jun 2016 16:31:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D535B26C03;
	Wed, 22 Jun 2016 16:31:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Mehul Jain <mehul.jain2029@gmail.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] Introduce log.showSignature config variable
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
Date:	Wed, 22 Jun 2016 13:31:46 -0700
In-Reply-To: <20160622165126.12786-1-mehul.jain2029@gmail.com> (Mehul Jain's
	message of "Wed, 22 Jun 2016 22:21:23 +0530")
Message-ID: <xmqqr3bpklsd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 585AB35C-38B8-11E6-8BB5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mehul Jain <mehul.jain2029@gmail.com> writes:

> Add a new configuratation variable "log.showSignature" for git-log
> and related commands. "log.showSignature=true" will enable user to
> see GPG signature by default for git-log and related commands.
>
> Changes compared to v2:
> 	* A preparatory patch 1/3 has been introduced so that tests
> 	  in patches 2/3 and 3/3 can take advantage of it.

It is unclear how this change allows the remainder to "take
advanrage" to me.  Earlier, "signed" branch was created only when
the GPG prerequisite is met and with this change the branch is
always created, which is the only change as far as I can see.  But
the tests that are added in 2 and 3 are all protected with the GPG
prerequiste.

Besides, the invocation of "git commit -S" after this change is no
longer protected by the GPG prerequisite and it may even cause the
'setup' step to fail on a host without GPG.

What am I missing?  I do not quite see any reason to take 1/2; I
only see a possible downside without any upside.

The main two steps 2&3 looked good.

Thanks.

> 	* Mistake regarding branch in [patch v2 2/2] has been
> 	  corrected.
> 	* Tight coupling between the tests in [patch v2 2/2] has
> 	  been resovled.
>
> I would like to thanks Eric Sunshine for his feedback on previous
> series [1].



>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/297648 
>
> Mehul Jain (3):
>   t4202: refactoring of test
>   log: add "--no-show-signature" command line option
>   log: add log.showSignature configuration variable
>
>  Documentation/git-log.txt |  4 ++++
>  builtin/log.c             |  6 ++++++
>  revision.c                |  2 ++
>  t/t4202-log.sh            | 32 ++++++++++++++++++++++++++++++--
>  t/t7510-signed-commit.sh  |  7 +++++++
>  5 files changed, 49 insertions(+), 2 deletions(-)
