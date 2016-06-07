From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 07 Jun 2016 15:05:50 -0700
Message-ID: <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
References: <20160607195608.16643-1-santiago@nyu.edu>
	<xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
	<20160607211707.GA7981@sigill.intra.peff.net>
	<xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
	<20160607215536.GA20768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: santiago@nyu.edu, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:07:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAP8I-0002eT-GO
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbcFGWFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:05:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751475AbcFGWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:05:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECB1822717;
	Tue,  7 Jun 2016 18:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3iFAvpMdW9jNFIahaeycXVd63g=; b=TaJDl4
	Ik51jorGhFPdo0umNwkZRnGuTqVTHLB7JCMqoGPYLzbj+YeiNQpYie2/RzY1s9Ux
	id35ubv3MiCtL6Ctj25e2/QSF8WoNx8Umg1eoKyefZ4cj5uniKc+jrDfxjeLTFFM
	IJrWW3yDtolKs+byzgkMprnaf4a5CwIMHhFiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GYdBxPdRxmoFGnkpk8dxaDSeOPQpJD5n
	JaZbNFyOc+PVfrw60VUy1Z17HwrZQbTYIleub8KWGZVT9GfvNxjHZpNh5yJRlk1N
	abHXIv134qQY2O4R2W+GWiFZarZ+zjj8GcNp822iVzDrljBnw7c/4DtniGS9kouZ
	MZQiOoO3d0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E558A22716;
	Tue,  7 Jun 2016 18:05:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7053E22715;
	Tue,  7 Jun 2016 18:05:52 -0400 (EDT)
In-Reply-To: <20160607215536.GA20768@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jun 2016 17:55:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0008BDB0-2CFC-11E6-BDB8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296732>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 07, 2016 at 02:50:23PM -0700, Junio C Hamano wrote:
>
>> >> Or it could even do this:
>> >> 
>> >> 	tag="$1"
>> >> 	if ! git tag -v "$tag"
>> >> 	if ! git tag -v "$tag"
>> >>         then
>> >> 		echo >&2 "Bad tag."
>> >>                 exit 1
>> >> 	fi
>> >> +	tag=$(git tag --show-tagname $tag)
>> >> 	make dest=/usr/local/$package/$tag install
>> >
>> > It is racy. That probably doesn't matter for most callers, but it would
>> > be nice to be able to get a custom format out of the "-v" invocation.
>> 
>> Heh, you can do
>> 
>> -	tag="$1"
>> +	tag=$(git rev-parse --verify "$1")
>> 
>> upfront and it no longer is racy, no?
>
> Yes, though that doesn't quite work today. The formatted output comes
> from "tag -l", which wants a refname.

Puzzled.  I didn't even use --format=%(tagname) in the above.
