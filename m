From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 03 Jul 2013 01:54:57 -0700
Message-ID: <7vhagcgh0e.fsf@alter.siamese.dyndns.org>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	<7vk3l8in2c.fsf@alter.siamese.dyndns.org>
	<CAETqRChiW49TwrZiZoi6vCwe9yOjurn97QpPEcJ2pb6fvp3ZBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIqG-0003ww-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab3GCIzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 04:55:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab3GCIzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 04:55:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A212CF2E;
	Wed,  3 Jul 2013 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Qn1SsJVbEWYc
	tCNL1RvuP9m7cME=; b=IQCy1HqEB5RlOVnTXrOHNghAb59uJm60zLFVRtswf23K
	W96Pz7jb/lssNNQy1MhCbiOJZzkWFEdIUk7h3KSYh5SCgl5WRixSACNxD+2wm3Z5
	QQTi9Cea9xQKS12bPHg4r1IpLIiXENs9vgodXBHYoekirNoGJ7OozHiKBzQMQEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gz7PAH
	a5VhOn5ahOL/p48HV3BRZ1vzInp15q9peqkl9PZ94ksM4zZDL7lVbrXfpMwBIWvP
	s9DRCMexqe4z1hRxOeSsNohx0/3QyANUZwXG+NBzxMBQk8LOv/wXpLak/2ocj7Pt
	u5Zc/39FWmLbjdDhfvNGN3rKzZtD4mIOVX1rA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC38F2CF2D;
	Wed,  3 Jul 2013 08:54:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ED662CF29;
	Wed,  3 Jul 2013 08:54:59 +0000 (UTC)
In-Reply-To: <CAETqRChiW49TwrZiZoi6vCwe9yOjurn97QpPEcJ2pb6fvp3ZBQ@mail.gmail.com>
	(=?utf-8?Q?=22Beno=C3=AEt?= Person"'s message of "Wed, 3 Jul 2013 01:19:19
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DAE3120-E3BE-11E2-A5FD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229470>

Beno=C3=AEt Person <benoit.person@ensimag.fr> writes:

>> Do we want to add that ':' unconditionally?  Could GITPERLLIB be
>> empty?
>
> For now, GITPERLLIB is only used in that kind of statements:
> use lib (split(/:/, $ENV{GITPERLLIB} || ... ));
>
> The trailing ':' does not really matter, split will ignore it.

That may be true with the current use, but "For now" leaves funny
taste, doesn't it?

It is not too much trouble to fix by writing

  GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'"${GITPERLLIB:+:$GITPERLLIB=
}"

and we will not have to be worried about future changes breaking
today's assumption.
