From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 02 Dec 2014 09:19:41 -0800
Message-ID: <xmqqlhmqm0k2.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	<xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
	<xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
	<xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com>
	<xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
	<xmqqa936ohs3.fsf@gitster.dls.corp.google.com>
	<xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info>
	<xmqqtx1em2fu.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412021744490.13845@s15462909.onlinehome-server.info>
	<xmqqppc2m1fz.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412021804210.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvr77-0003dr-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbaLBRTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 12:19:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754062AbaLBRTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 12:19:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4612623438;
	Tue,  2 Dec 2014 12:19:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AAocEwlELyBx
	5S/n1pVoV5mY97U=; b=FaG/dFxGd3J1lSlEeQUJE/qcw0iOLSCvist984fvcG+z
	kAaU/RYCcUDd8XjTgABE16A9kvjyN9b3TGkNUO2j4vEgdbdBN4Fda/B1RazHUphc
	GPViB620rScnfDm45V+EbcKv3uNQNwFZC+SfS6AWp3kfyaVJhvL2Xto/PqjT6Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bLik+2
	zM7qZadwR5yUGNybgFfXNZCK/OSTwWpgXMgUqL4xaoMrNFsIwPIgtrFoZ5YzbPts
	MjRsDC4yE8nZ+vzLFEePElFtCIhBFHeBJ+DKGcgdmhjJnuCfMH2jF4eSWFZVz/7h
	D6d0o+R4kjsEe01ILRSIK2RYIoWXTwILL4Pcs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CC7323437;
	Tue,  2 Dec 2014 12:19:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 962DA23436;
	Tue,  2 Dec 2014 12:19:43 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412021804210.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 2 Dec 2014 18:12:50 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6821DD82-7A47-11E4-88C6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260579>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... (i.e. by only lightly testing obscure code paths that will be
> executed rarely, risking bugs in favor of adding tests when fixing sa=
id
> bugs when =E2=80=93 and if =E2=80=93 they arise).

I'd like to learn a bit more about this part, not because I want to
say you are wrong, but because I want to find out what you say is
practically useful and can be adopted by the project.

The part I find most troublesome is this.  Without tests covering
"obscure" cases, how would you expect to notice when the codebase
regresses, at which point you plan to fix and add tests for the fix?

Not that I think the "minimally these need to be tested" list I sent
earlier are anything obscure (they are all essential part of the
feature; without them working, the feature would not be useful).
