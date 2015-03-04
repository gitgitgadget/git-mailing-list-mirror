From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Segfault with rev-list --bisect
Date: Wed, 04 Mar 2015 15:44:19 -0800
Message-ID: <xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
References: <CAMo-WNYNeShbbhNfG455o7krGfY7_9zVU3dMpJ7b4Smh_AiATg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Troy Moure <troy.moure@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 00:44:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTIxn-0006xB-17
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 00:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbbCDXoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 18:44:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752403AbbCDXoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 18:44:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCFFC3CD22;
	Wed,  4 Mar 2015 18:44:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OlFKButuHlJfdP0ofI+HilWc6Z4=; b=mMr4aS
	g7J2LIcKJyaDbQNp/qF9IQMBM3JtRahyNybMzD5zwoOwA5gOYz+52Mt96rgfUdv1
	16awsfUO56ZPDkFgHT7UCZiByN2viiaVgBYQ5xzQXPsSAKUEEN2YMkhxml8sRxDj
	2Ipi9I36awnEwv+43pgoUsEqU+ZDotpDCL58s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aS80A/B6OAvVoUVFnhM4sK20AodKGPhB
	Yj6Kv8TP553D9RXFGn4OBrMljBZdV0iZdwnndGIkzxOx/8ttTk+VdCiQI3ZE2+Cn
	NQzeQyCqdspDUI5aS34Bwe803I93npG7uUpJXr930U7BHq5dFRgYp0WCLlKiutvv
	v8U2AYs0nYY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4B843CD21;
	Wed,  4 Mar 2015 18:44:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BEB53CD1F;
	Wed,  4 Mar 2015 18:44:20 -0500 (EST)
In-Reply-To: <CAMo-WNYNeShbbhNfG455o7krGfY7_9zVU3dMpJ7b4Smh_AiATg@mail.gmail.com>
	(Troy Moure's message of "Tue, 3 Mar 2015 09:19:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60E13AD0-C2C8-11E4-9DBC-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264793>

Troy Moure <troy.moure@gmail.com> writes:

> git rev-list --bisect --first-parent --parents HEAD --not HEAD~1

Hmm, as "rev-list --bisect" is not end-user facing command (it is
purely an implementation detail for "git bisect") and we never call
it with --first-parent, I am not sure if it is worth labelling it as
a BUG.  Surely, the command can refuse to operate when it sees both
options given, but that would be a fairly low priority.

Of course, if you are planning to do "git bisect --first-parent", it
is one of the things that needs to be addressed, together with
counting the rounds and bisecting the linear set of commits on the
first-parent chain correctly.
