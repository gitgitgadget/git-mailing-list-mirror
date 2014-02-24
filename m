From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] demonstrate git-commit --dry-run exit code behaviour
Date: Mon, 24 Feb 2014 09:16:01 -0800
Message-ID: <xmqqha7obfe6.fsf@gitster.dls.corp.google.com>
References: <1393010214-32306-1-git-send-email-rctay89@gmail.com>
	<xmqqa9dk43pi.fsf@gitster.dls.corp.google.com>
	<20140222083423.GF1576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:16:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHz8t-0000zr-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaBXRQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:16:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbaBXRQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:16:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C69496CBAD;
	Mon, 24 Feb 2014 12:16:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enXv5CExSyUjj7UOS/U55eVEu6M=; b=tjA6km
	jQBABRpBzpsvCubW67ymjECZKg0szv7gjs3LFyPUE0UVVuQKYYY6RCPuAXogDQRa
	usQtxUk+NK5crBghdsYFJQXAbHrWv2Xn9qH3Fkcm0ckzEi1e9gbFG3hT54vUzw7X
	/QH7HyVjXiCGZQOyHYm2Kpk/gT503FnUtQuLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sTJe0Uw0oESDxXSJAdOJAaoGzqGxHoT3
	qWHbDcJKGWyBEWBcjJ6tenSZIzTvxyAcvOcddMOZXmsTQT5Rqndfvi9gRYEjHI1U
	fettVZvG1krxkDMsyndjUDyR3cvvFztIrQMtOmj7ZUlG8+M9Z5otzVfe8uCY7o41
	E7kfhJVeJkA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B9B6CBA6;
	Mon, 24 Feb 2014 12:16:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 960D86CBA3;
	Mon, 24 Feb 2014 12:16:11 -0500 (EST)
In-Reply-To: <20140222083423.GF1576@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 22 Feb 2014 03:34:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BB0EFAA-9D77-11E3-93E0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242615>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 21, 2014 at 12:21:13PM -0800, Junio C Hamano wrote:
>
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>> 
>> > In particular, show that --short and --porcelain, while implying
>> > --dry-run, do not return the same exit code as --dry-run. This is due to
>> > the wt_status.commitable flag being set only when a long status is
>> > requested.
>> 
>> I am not sure if --short/--porcelain should even be accepted by "git
>> commit" in the first place.  It used to be that "git status" and
>> "git commit" were the same program in a different guise and "git
>> status <anything>" were merely a "git commit --dry-run <anything>",
>> but the recent push is in the direction of making them totally
>> separate in the end-user's minds.  So if we want a proper fix, I
>> would actually think that these options should *error out* at the
>> command line parser level, way before checking if there is anything
>> to commit.
>
> I do not think they are any less useful than "git commit --dry-run" in
> the first place. If you want to ask "what would happen if I ran commit
> with these arguments", you can get the answer in any of several formats
> (and --porcelain is the only machine-readable one).

Hmph.

> I have never found "commit --dry-run" to be useful, but I assumed that
> somebody does.

Same here, and I did not really consider "commit --short" was
intentionally a valid short-hand for "commit --dry-run --short", but
its working as such was an accident, hence my comment.
