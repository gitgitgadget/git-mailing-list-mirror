From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of a different type
Date: Wed, 28 Aug 2013 12:32:37 -0700
Message-ID: <xmqqa9k1a9wq.fsf@gitster.dls.corp.google.com>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
	<20130827194828.11172.73829.chriscool@tuxfamily.org>
	<xmqqk3j6c1x0.fsf@gitster.dls.corp.google.com>
	<878uzmclva.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, <git@vger.kernel.org>,
	"Philip Oakley" <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 28 21:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElU0-0006vb-AI
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab3H1Tcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:32:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab3H1Tcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:32:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C82933C1D3;
	Wed, 28 Aug 2013 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j81OgS0KInJ2zWj4Ya43QHDizII=; b=YRR3cb
	eqP7ffjC/gGHcMZOI0zij18hlbrmeLw0Ftl4Tr8/uOtuo7nEpxP/6XZwgwUUM5u8
	OIuRroOZhS5byaSrWNbVROzgQA2tJyQunumn5tz4sHllfuhzGscBXVihgRwyNnsi
	2B44Fw0C1GeTsZz5tGd8HV5BWDxK9n4qkSphw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udn1tLcIrBRLCBqQCgL/Fe7srC41v/7N
	X8uooRM6GecNCm+PuQSTiGY6755z40k7TYZ7n6jdY+9eMG4QCnSjBZgnHlmrG0El
	9CSNM0jBoHgHZWPJRiJegWOO3PVgTTilStB1ERuy68XAI+HqqMg/DMZr7is1csJ2
	u6+BgotNS4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCAA53C1D0;
	Wed, 28 Aug 2013 19:32:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F22F3C1CB;
	Wed, 28 Aug 2013 19:32:39 +0000 (UTC)
In-Reply-To: <878uzmclva.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 28 Aug 2013 09:31:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99D6DA8E-1018-11E3-8E78-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233203>

Thomas Rast <trast@inf.ethz.ch> writes:

> Hrm, you're right, that's a flaw in my logic.  You could do the same in
> all other cases too, e.g. replace a tree so that an entry is of a
> different type and at the same time change the type of the object
> itself.  You however have to carefully go through all objects that refer
> to the one that was replaced, and fix the type in all of them.
>
> It still seems an extremely unsafe thing to do with trees...
>  ...
> Should we add a --force flag of some sort to allow the user to do this,
> while keeping the normal safety checks?

As long as we do not forbid such an unusual replacement on the
reading side, we won't break people who are more inventive than we
are (I am not convinced that we know people's workflow well enough
to definitively say that no sane workflow, which benefits from being
able to replace an object with another from a different type,
exists).

Preventing "git replace" wrapper from creating such a replacement by
default will make it harder to do and may reduce mistakes, without
breaking them too much, I think.
