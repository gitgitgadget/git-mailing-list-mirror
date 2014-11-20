From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] parse_color: refactor color storage
Date: Thu, 20 Nov 2014 11:37:31 -0800
Message-ID: <xmqqlhn53bpg.fsf@gitster.dls.corp.google.com>
References: <20141120151418.GA23607@peff.net>
	<20141120151704.GD23680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:37:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrXY2-0004zr-UI
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 20:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547AbaKTThm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 14:37:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757268AbaKTThm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 14:37:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D7191E35B;
	Thu, 20 Nov 2014 14:37:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3rMvr+R456PWYxS0N72KrUaOh0E=; b=nR8kdg
	LBai+q7ib3cWFjD0xA+zlnxQgGDOOv8+85Dr/9TkvXu8Y0hIi8kx2xN3hPpQgTL0
	+jzv1VM8tfKXKPJgPkF2VtCazu5ix7ymGdeSW5ojtqsvaywUhcVShyE2TgqlpRIk
	m6om0SA0Dy98gYZbgPyuYIRT1Ez161kWaVwJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kMcHJVVuHj86u1vi+KaPDM3QaiiJAe55
	tyOPEIF6FPWDysTmTI3OMvdzlce/DYVULE2RDxp34dCqOYfXy8Hb9OGRrUc3YFQo
	a5QTpJLNmk3YnJWUP4hsRqSJpZIoQC3Yx4g6yF9OoM+6W7Gwawu63W83ub8dzyBQ
	mzmen3EIYJk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 441241E35A;
	Thu, 20 Nov 2014 14:37:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76D851E359;
	Thu, 20 Nov 2014 14:37:38 -0500 (EST)
In-Reply-To: <20141120151704.GD23680@peff.net> (Jeff King's message of "Thu,
	20 Nov 2014 10:17:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF620564-70EC-11E4-993F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The result is also slightly less efficient to store, but
> that's OK; we only store this intermediate state during the
> parse, after which we write out the actual ANSI bytes.

You need up to 24 bits for the value and then 2 bits for what type
of color specification you have (what you called "state"), for which
32-bit should be sufficient.  That would mean it is more efficient
than a single int on 64-bit archs, and you can arrange the struct
to be packed if we ever need to keep dozens of these things.  Until
then, the updated simple struct is just fine, and either way it is
much easier to read ;-)

Thanks.
