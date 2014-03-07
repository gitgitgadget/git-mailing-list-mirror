From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/11] trailer: read and process config information
Date: Fri, 07 Mar 2014 14:16:27 -0800
Message-ID: <xmqq4n39u01w.fsf@gitster.dls.corp.google.com>
References: <20140306221409.29648.10706.chriscool@tuxfamily.org>
	<xmqqmwh1u2gf.fsf@gitster.dls.corp.google.com>
	<87ob1hbrfp.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 23:16:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM34H-0001JK-F0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 23:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbaCGWQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 17:16:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbaCGWQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 17:16:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C27B727D1;
	Fri,  7 Mar 2014 17:16:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r+Jh2bJWZmsR/rxeS4qNaTeUfkI=; b=XpVJf+
	VJ3Gh3aRvc8WWYrh40qF3Jm+8rM6rYJK5ee/t8NngGofk/8ZjxB05I5Wmt95PJNk
	B7BAIluYHnfkNvh+X8mBmFUmsvT6H9l86wDK+gk6sJ4e1/dYwrof/EZXkq4uFuhF
	QrHyadoS196bput3EiEn7E2xva8qxlsrjWXNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7EkspGm4K49/nJkOVjGQX7kJgm4kGpi
	9tO3yV+1JYIavd0rdIR6t6abZYD7t5Iigp50XZwrGMBCKv0aUwW2/DfexGLUzRO+
	Wfhx56JwjMg1vNu9OQ9GftVlKQ+8ke7YEEhyl23pW7brlXmR/6g9E+6rdSoxM8x/
	Q3RDvLv2ml4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F29727D0;
	Fri,  7 Mar 2014 17:16:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 949A6727CF;
	Fri,  7 Mar 2014 17:16:30 -0500 (EST)
In-Reply-To: <87ob1hbrfp.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 07 Mar 2014 22:59:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 227001C2-A646-11E3-A23E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243633>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> The config information is stored in the list
>>> whose first item is pointed to by:
>>>
>>> static struct trailer_item *first_conf_item;
>>
>> If feels somewhat strange ...
>
> Can't say I agree here.  Basically all my doubly-linked lists are not
> for traversing data forwards and backwards ...
> Having a "last" pointer is an orthogonal concept ...

Yeah, that is where "somewhat strange", not "wrong", comes from ;-)
