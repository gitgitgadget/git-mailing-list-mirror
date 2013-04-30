From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 21:02:19 -0700
Message-ID: <7vip34fyyc.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<20130426101946.433f2d12@chalon.bertin.fr>
	<517A3E47.6010606@viscovery.net>
	<7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
	<7v8v45vvuy.fsf@alter.siamese.dyndns.org>
	<CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
	<7vobcxl3ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 06:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1lr-000340-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 06:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810Ab3D3ECX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 00:02:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38196 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab3D3ECW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 00:02:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E38411C57;
	Tue, 30 Apr 2013 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sAyi2rGv+UWL3wtXkSRb+TdCPe4=; b=OUxihE
	qisxDyeZ5Sxn2a7lkA7KEpVAr2ydIw6o4BSwYzl5jJQw7wtewmzPZpQAAdw8EoHd
	/aGVenXbjkpMZ9SY4zBafrFAOdAjlnJh9o5WwmOr9zfHbbHXh1owdKSTQXWVgQYh
	41ir73TFAIKOTGxo2NGgyRD35NHURdOPMMf+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnHq+LTrlb+JCnphdDhzAhhwJiuwiDsc
	RXWU6rM1jiWmOxekytDOuFtPkoXnfaM/WF3ZYGJx2z75Z99tOTybFJ4YBVSuS704
	/op9Zffj/JCScOHCPuFHBIKE3SmC3lb+plC8tBViXvqAuy/cgDRySkJhGK8tWdVi
	Ef1Jog3nEwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 733AB11C56;
	Tue, 30 Apr 2013 04:02:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C06EC11C55;
	Tue, 30 Apr 2013 04:02:20 +0000 (UTC)
In-Reply-To: <7vobcxl3ui.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 29 Apr 2013 09:05:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1947F0E-B14A-11E2-897B-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222904>

Junio C Hamano <gitster@pobox.com> writes:

> A much larger issue is that the current setup_revisions()
> infrastructure does not let us express an operation that involves
> two or more DAGs.  People sometimes wish to say an equivalent of
>
>     git show $(git rev-list A..B) $(git rev-list C..D)
>
> but obviously
>
>     git show A..B C..D
>
> is not the way to say it, and this limitation comes from it.

Just a clarification. Technically, this is _not_ impossible.  With
some (read: quite a lot of) work to move objects.flags out of the
object and to allow unbounded number of flag bits, you could support
arbitrary number of ranges that are UNION'ed together by pretty much
the same code structure as the current revision machinery.  You need
2 x N bits (for the above example, 2 x 2 bits) per commit.

I am not saying it is easy or we should start working on it, though
;-).
