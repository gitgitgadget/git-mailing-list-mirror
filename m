From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with
 outline
Date: Wed, 13 Mar 2013 12:38:02 -0700
Message-ID: <7vtxof146d.fsf@alter.siamese.dyndns.org>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com>
 <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 20:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFrVV-0002gb-GL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 20:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272Ab3CMTiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 15:38:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933232Ab3CMTiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 15:38:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCCEFA893;
	Wed, 13 Mar 2013 15:38:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nv6xpr/OmgbuARTePSEN2dCxTWI=; b=CUptid
	oO0Fa33RndCf3fCcyblSPWT39wchFHlVfTCdlY//krxNPHCtyvQp0D/UeCZ7c/JC
	HrCfzlv3EWuKm1k4RYaT69NJ7yb8fk1UijsSdoYGL112t71IFiqhG+3U7WpT6Yq+
	9dXm8DkYw4XI6I0yucKa2erM3lM/F5eeKKvTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1DrZfMhzAa3F0zSF5oRgmiAiqlsjZa5
	qSXTEa89lPrq3WmiWm8RyiIcRX//zvtHHmsUjzY24/W7yaABx+qilH2bEoNhjhSd
	iY0mUNML7Gitx+SklEIlli7YE6RUjx1J58t99/8SiZDMA2LCZr4HAOEk4NFn/V1g
	NpeE0eqfyKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0FF1A892;
	Wed, 13 Mar 2013 15:38:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 180E6A889; Wed, 13 Mar 2013
 15:38:04 -0400 (EDT)
In-Reply-To: <5140BC80.4000201@gmail.com> (Karsten Blees's message of "Wed,
 13 Mar 2013 18:50:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85DC6C9C-8C15-11E2-BD6D-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218084>

Karsten Blees <karsten.blees@gmail.com> writes:

> However, AFAIK inotify doesn't work recursively, so the daemon
> would at least have to track the directory structure to be able to
> register / unregister inotify handlers as directories come and go.

Yes, and you would need one inotify per directory but you do not
have an infinite supply of outstanding inotify watch (wasn't the
limit like 8k per a single uid or something?), so the daemon must be
prepared to say "I'll watch this, that and that directories, but the
consumers should check other directories themselves."

FWIW, I share your suspicion that an effort in the direction this
thread suggests may end up duplicating what the caching vfs layer
already does, and doing so poorly.
