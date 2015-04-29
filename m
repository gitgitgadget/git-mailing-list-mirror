From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: redo tasks that die during cherry-pick
Date: Wed, 29 Apr 2015 12:41:24 -0700
Message-ID: <xmqqtwvy4t97.fsf@gitster.dls.corp.google.com>
References: <1430261720-9051-1-git-send-email-hordp@cisco.com>
	<42512fad738e0ec47a8cdb6e6e92e994@www.dscho.org>
	<xmqq7fsu6ek4.fsf@gitster.dls.corp.google.com>
	<CABURp0odQWJC9LfQMywHKUarKAe7EY45fHET8xVVEsoBYDzBPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phil Hord <hordp@cisco.com>, Git <git@vger.kernel.org>,
	Fabian Ruch <bafain@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnXrP-0005aR-U5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 21:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbbD2Tl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 15:41:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbbD2Tl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 15:41:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6DFE4C27E;
	Wed, 29 Apr 2015 15:41:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ru/TFMkRjrNcTaO3YwygjeKSU5k=; b=x7PbOE
	i/X05fpWy9MrixZ1HcfdeCq7vCKEbpFWzrsUcRZSU+mHxK2EB/D3Nw/M5xFgv9zI
	rv57pHlKI5fVAUUASdyegtW6TjwkBNXm4KIqVNNbA1HC95zN2OVuZbQkMjLy+sg9
	4bbeIRbIsEqEIkgm937FUDwe1k6za4y4Y7HqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CZ10EG8wQQMjcGKKG6MMb7xUbn9Nfvaq
	6AWEP+L2nuQyylORIQ7aFe+ZRpcOjjVHuiGnVkq2pt0xdK7ebaaws2lFYNBm90e0
	Cd3dLgrAn9RuG4AaVbZd6Au4gQheVo6Z0yuKNDTAMw/1KzDuINPR76ay6SetbVrJ
	sa79vOWibzA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEC614C27D;
	Wed, 29 Apr 2015 15:41:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 677034C273;
	Wed, 29 Apr 2015 15:41:25 -0400 (EDT)
In-Reply-To: <CABURp0odQWJC9LfQMywHKUarKAe7EY45fHET8xVVEsoBYDzBPg@mail.gmail.com>
	(Phil Hord's message of "Wed, 29 Apr 2015 15:32:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8BEB754-EEA7-11E4-86E0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267996>

Phil Hord <phil.hord@gmail.com> writes:

> On Wed, Apr 29, 2015 at 1:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Thanks, will queue.
>>
>> Aside from the "much more invasive" possibility, the patch makes me
>> wonder if it would have been a better design to have a static "todo"
>> with a "current" pointer as two state files.  Then reschedule would
>> have been just the matter of decrementing the number in "current",
>> instead of "grab the last line of one file and prepend to the other
>> file, and then lose the last line".
>
> That's an interesting idea.  Changing it now would impact anyone who
> now depends on the current todo/done behavior, and I imagine there
> are many.

Yeah, in case it wasn't clear, I was merely lamenting over water
under the bridge, not seriously suggesting to break users to
simplify our logic.
