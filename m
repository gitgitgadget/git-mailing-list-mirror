From: Junio C Hamano <gitster@pobox.com>
Subject: Re: syntax error in git-rebase while running t34* tests
Date: Tue, 10 May 2016 12:11:59 -0700
Message-ID: <xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 10 21:12:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0D53-0003Iz-D5
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbcEJTMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:12:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752447AbcEJTME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:12:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3514A18D09;
	Tue, 10 May 2016 15:12:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z05zyXr6JciP4iBpcWNnOB4S6G4=; b=PJ/yXC
	4AwCHDpXnp14tpvRjxpVzSCQ1tzW6u7gQ54XMBE1E/PgCTKFyMUDEbtgygVUO6IR
	rhnf2t3CxZSstdPln70z5/bPqLvJRrvu275sPvDfIK0gksFEyyx2jt/D/z7vlSXB
	SHoVUcBKcxCX3XbkhNrl6YapVITjsVoeEknHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cou/smYwyMDBJCMatY30Z83gvWGstmoW
	3PxV6EJ2x3YoTCv5RLXIRaFgszKxA9X8lQlboyIWvezQmir3gdCiWO4RBNtB0q+c
	lm/hVgKEOwifSvVJhMm5/n4T/n0hQ8uD6H2QIbFjXptcgqFOZ/yiik4ZBUEKkJyx
	PoZNucsHy1Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C78A18D08;
	Tue, 10 May 2016 15:12:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9891A18D07;
	Tue, 10 May 2016 15:12:02 -0400 (EDT)
In-Reply-To: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
	(Armin Kunaschik's message of "Tue, 10 May 2016 19:29:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13C47328-16E3-11E6-8CA2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294174>

Armin Kunaschik <megabreit@googlemail.com> writes:

> I fail to see why eval is really necessary here.

It is necessary to work correctly with any strategy option with $IFS
in it, I would think.  The calling script "git-rebase" accumulates
--strategy-option values after passing each of them through
"rev-parse --sq-quote" for that reason.

which means that eval'ed string here:

> My quick and dirty hotfix is to place a
> test -n "$strategy_opts" &&
> in front of the eval.
> The tests run fine after this change.
>
> What do you think?

I do not see why "test -n &&" is necessary here, and would be very
hesitant to accept a change that nobody understands why it works.
