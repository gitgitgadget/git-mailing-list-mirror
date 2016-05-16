From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] connect: only match the host with core.gitProxy
Date: Mon, 16 May 2016 15:30:01 -0700
Message-ID: <xmqqvb2dzlee.fsf@gitster.mtv.corp.google.com>
References: <20160516000740.19042-1-mh@glandium.org>
	<20160516000740.19042-3-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 17 00:30:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2R1n-00031B-UW
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcEPWaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:30:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbcEPWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:30:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D41B61CE80;
	Mon, 16 May 2016 18:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQ1B5U4pdS0oQZhWwgjvWA6jbpQ=; b=HbTKCy
	RJuv9px/eBd7moPIf/Z/X3TFZ8WtzzGqCWT7SsQ4f6GOzfKpcd1iLk1mMDYsq5pt
	FFULPANM4NgT5i9anULY6dyLWFRBllBvmLE2As0OmJ4LEOqZgfUOyAOrzhLsnYpa
	Mz02Jv9yTzcV9DKcbeTmehKs/6CFIzYCBwLuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oA8L00bHVCTd4SNltYld+MUKat+VhRbM
	REatAO7Mt55FwInGp85SKK/buAuOQvZYg7muoag2Df5G4wut+sn4dCZhdTjrGZZK
	Zi8LT99w7wA5I8wDJC8MV5Gl5jQny2IH9lx1ii0brnQbDRZzm61j/deulayhOEUR
	VAK0Qg8r5oU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CBC651CE7F;
	Mon, 16 May 2016 18:30:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED4C01CE7E;
	Mon, 16 May 2016 18:30:04 -0400 (EDT)
In-Reply-To: <20160516000740.19042-3-mh@glandium.org> (Mike Hommey's message
	of "Mon, 16 May 2016 09:07:33 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BCAD0CBC-1BB5-11E6-8CFC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294808>

Mike Hommey <mh@glandium.org> writes:

> Currently, core.gitProxy doesn't actually match purely on domain names
> as documented: it also matches ports.
> ...
> This per-port behavior seems like an oversight rather than a deliberate
> choice, so, make git://kernel.org:port/path call the gitProxy script in

Hmph.  The fact that hostandport, not just host after stripping
possible ":port" part, is passed to the function smells like a
deliberate design to allow people to use different proxy for
different port, so I am not sure everybody agrees with your "seems
like an oversight".

Don't existing users depend on the behaviour?  Isn't the change
robbing Peter to pay Paul?
