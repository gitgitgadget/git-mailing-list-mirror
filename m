From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Fri, 30 Oct 2015 14:31:28 -0700
Message-ID: <xmqqmvv0jb67.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
	<xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
	<20151027053916.3030.8259@typhoon.lan>
	<20151027055911.4877.94179@typhoon.lan>
	<20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsHGp-0007rg-5t
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727AbbJ3Vbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:31:31 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758824AbbJ3Vba (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:31:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC90828F2E;
	Fri, 30 Oct 2015 17:31:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OX46Pfms94hO41KG6HdVtEvYZow=; b=laYD/Y
	0fwPGbM+f5qKQqsnDH29Jb6a34NE9X/RCGq1vjy2fFXnOz9QoYaMOFgysHSeHKQ7
	1EMiQQuTRP4OcxcA7yIcEaDntFCHYCtpVakfaGcmeK7IiFDGk213Dlex9E29miX/
	BsjAWNMgeW/Zib2K7WC4WbBpYCEmHp3lnu4wA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwjWNq6r4p7RXP88S9ArBKZulqxSKKlv
	2FWieVj47ZqxcIxtKv25NkyD6fzC26V4JB2H7RntKGF18qQzRwKjY7AmaJMokouk
	7I9bMmH/cH1+P9o1b3z/UyvQWmRAsPiOFTRrutadL87DwlSKIjnyskcw6IyEYhzE
	DbnzXBV2k9M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C31A428F2D;
	Fri, 30 Oct 2015 17:31:29 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 48D0128F2C;
	Fri, 30 Oct 2015 17:31:29 -0400 (EDT)
In-Reply-To: <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
	(Lukas Fleischer's message of "Tue, 27 Oct 2015 15:32:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94F76640-7F4D-11E5-A2A3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280545>

Lukas Fleischer <lfleischer@lfos.de> writes:

> 1. There does not seem to be a way to pass configuration parameters to
>    git-shell commands. Right now, the only way to work around this seems
>    to write a wrapper script around git-shell that catches
>    git-receive-pack commands and executes something like
>    
>        git -c receive.hideRefs=[...] receive-pack [...]
>    
>    instead of forwarding those commands to git-shell.

This part we have never discussed in the thread, I think.  Why do
you need to override, instead of having these in the repository's
config files?

Is it because a repository may host multiple pseudo repositories in
the form of "namespaces" but they must share the same config file,
and you would want to customize per "namespace"?

For that we may want to enhance the [include] mechanism.  Something
like

	[include "namespace=foo"]
        	path = /path/to/foo/specific/config.txt

	[include "namespace=bar"]
        	path = /path/to/bar/specific/config.txt

Cc'ing Peff as we have discussed this kind of conditional inclusion
in the past...
