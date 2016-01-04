From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: git bisect merge to usable base
Date: Mon, 04 Jan 2016 14:38:40 -0800
Message-ID: <xmqqfuydm0lr.fsf@gitster.mtv.corp.google.com>
References: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
	<xmqqsi2jem15.fsf@gitster.mtv.corp.google.com>
	<CALCETrUO2Gx9vRqkGLaGWLsuMs98k5d3PKEPfx3RZf4+fpko4Q@mail.gmail.com>
	<xmqqa8olnl1r.fsf@gitster.mtv.corp.google.com>
	<CALCETrV_JAEbuU3v+V352_8PVyaB1noGQAfJG+HVVanVpUbRZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andy Lutomirski <luto@kernel.org>, git@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:38:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGDm3-0000uY-Og
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 23:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbcADWio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 17:38:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752012AbcADWim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 17:38:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC0B537D1C;
	Mon,  4 Jan 2016 17:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NV7XfPjbKm2rLpwnDBBGSSYSBUM=; b=TxZBO8
	qBMXDF8avIWVMzz070WJqZSAk3P5+WClG8oJ0Z2me0eh7W6ocxmrXxNLYmb6C+GS
	tReig02AJ9bl1iuH4dY3toFaza9TB7Q6CWCKrJZM+24FQ6VtPXld9r3V/FjmVwgk
	3FzIF+2fRORHwv/V/RXDS0NUN2DnRnxZzCdLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mbAtfxiDhv4F2mt8lYwIinyPFo7VvnI0
	VqE3Tg25zE7pgjPJhLQjJJv37w12pBqzKEZvpoEswQszm0N0HVBCWOoEhiZqUdDS
	vpFOnwFtzK+BnB5qqcxhmvLtbe+Puaq5AZNNuJU4noXAHKuaOBPubS63/ioZT/Up
	chXyx2D1HDU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E352A37D1B;
	Mon,  4 Jan 2016 17:38:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6169B37D1A;
	Mon,  4 Jan 2016 17:38:41 -0500 (EST)
In-Reply-To: <CALCETrV_JAEbuU3v+V352_8PVyaB1noGQAfJG+HVVanVpUbRZw@mail.gmail.com>
	(Andy Lutomirski's message of "Mon, 4 Jan 2016 14:20:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E78C5E6E-B333-11E5-897A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283331>

Andy Lutomirski <luto@amacapital.net> writes:

> Anyway, the idea of merging test commits up to some lowest common
> denominator seems generally useful to me, and the idea of specifying a
> 'prepare the checked-out tree' (as you suggested, where 'git merge
> --no-commit whatever' would be specified) would also be handy, and
> both of these are useful even in cases where git bisect run isn't
> being used.

Yes, I didn't mean to say "bisect run" is always great.  What I was
hinting at was that even if you are _not_ using "bisect run" (which
almost always _requires_ you to write a small script that does the
test and says yes/no), once you start working on a project that is
sufficiently complex (like bisecting a regression in the Linux
kernel), your procedure to build and test a single revision becomes
complex enough that it is worth to write and use a small script for
a single step _anyway_.  And with that in mind, "how do I prepare
the checked-out tree for building and testing" can be part of that
script.

Which in turn means there is nothing to add to "bisect", not even
the "--fixup my_fixup_script" I alluded to, let alone "--merge-to"
that is way too specific to the case you happened to have had before
you sent your message.
