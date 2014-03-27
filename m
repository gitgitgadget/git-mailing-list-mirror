From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 15:47:01 -0700
Message-ID: <xmqqha6jcl96.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.86408.chriscool@tuxfamily.org>
	<xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
	<20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
	<xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
	<xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
	<20140327223406.GA32434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	mhagger@alum.mit.edu, dan.carpenter@oracle.com, greg@kroah.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:47:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJ5K-0007K1-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 23:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348AbaC0WrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 18:47:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879AbaC0WrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 18:47:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 153FC781E7;
	Thu, 27 Mar 2014 18:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQkAUFmFffr1zl+1/F9Tza4Fe08=; b=sTMQEE
	XmHum0a2Vp2vCVz6vme9+BbU+Z5FE7TMHp9obm5hxu4vbap4yyPOzshXX27YQX8l
	nUgidJdasm4PFYz5O/R4Y/y4MASBFRT8E7waiF8LIB9hNsOLbFBFXhRq6iKoRFsC
	jLkGqrgK6uxKb7OedjTpz1x1Txc8JsFUNsTh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NdQxQfrR1ffW9eKxTzA5PmH4+8jBvbEo
	X43cvLhra4r3zX8bxAmecM6yLAIvsQyLfCOisHOpZ58OPS4J7QbPOYAMFBgu40jV
	0dP/NyvUHiXmcfkwELcRLnDa+rC3rKJ9lAVrR6g9fSU9eapKAkctztHwKQos2bj1
	NSF9wlUiJ2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED30781E6;
	Thu, 27 Mar 2014 18:47:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12D00781E5;
	Thu, 27 Mar 2014 18:47:04 -0400 (EDT)
In-Reply-To: <20140327223406.GA32434@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Mar 2014 18:34:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B78821DE-B601-11E3-85FA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245331>

Jeff King <peff@peff.net> writes:

> All bool config values allow "tRuE".

I was expecting somebody will bring it up, but think about it.  Bool
is a very special case.  Even among CS folks, depending on your
background, true may be True may be TRUE may be 1.

Conflating it with some random enum does not make a good argument.

> Ones that take "auto" often use
> strcasecmp (e.g., diff.*.binary). "blame.date" and "help.format" choose
> from a fixed set of tokens, but use strcmp.

I would say that the latter is the right thing to do.

> In general I do not see any reason _not_ to use strcasecmp for config
> values that are matching a fixed set. It's friendlier to the user,...

Actually, I think it ends up being hostile to the users to accept
random cases without a good reason.  If you see two trailer elements
whose where are specified as "after" and "AFTER" in somebody's
configuration file, wouldn't that give a wrong impression that a new
line with the latter somehow has a stronger desire to come later
than the former?

If you consistently take only the fixed strings, you do not have to
worry about many people writing the same things in different ways,
confusing each other.

I would however fully agree with you that using strcasecmp() would
be the cleanest when reading and maintaining the code **IF** we want
to accept values in random case, but I do not agree that accepting
random cases is a good thing, so...
