From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sun, 01 Jan 2012 01:11:34 -0800
Message-ID: <7v8vlrwzw9.fsf@alter.siamese.dyndns.org>
References: <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4EFB8E78.4090205@tu-clausthal.de>
 <7vlipwz5xs.fsf@alter.siamese.dyndns.org> <4EFD40CF.8000801@tu-clausthal.de>
 <20111230135423.GA1684@sigill.intra.peff.net>
 <4EFDD06A.3010708@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sun Jan 01 10:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhHSD-00027x-2K
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 10:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab2AAJLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 04:11:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab2AAJLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 04:11:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 929AB6EE3;
	Sun,  1 Jan 2012 04:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AfVy/Kqoigdhe9ZfqP5wKHcoArU=; b=R8V8W9
	9cH6NEKwm6ErULqEDKkO7Cz9XJ2c+YGfrLsAgPZgBdC4HCbQvvPVggNzW6uHwbd9
	haTSJZHgXaJL5VlzIYAirP9tQknmdGVjpwWGCqfdzPuFpy5K/kYC0ctBmlPKNSk0
	QXVhDVH6fbAd4CV6OAgR2mOI0dGqbop5dddJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kJ5993J4m7Fa1IWGEhFgZqxwwa0XqGGA
	4n3lu0ZIXkRRyC55DgK5njiNOyV8Gi2T1EXcV0CWsdg9Ma+0D3zhccI7EGJMwYMw
	lInxxWJoUAILdCnCKgczl/Ul02LT0RHoj2hK7OQ5k2iRatMbO0BHZzRQMsFqzp1j
	CF6jOLfzqbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8976D6EE2;
	Sun,  1 Jan 2012 04:11:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C45C6EE1; Sun,  1 Jan 2012
 04:11:36 -0500 (EST)
In-Reply-To: <4EFDD06A.3010708@tu-clausthal.de> (Sven Strickroth's message of
 "Fri, 30 Dec 2011 15:53:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B127842-3458-11E1-9A38-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187821>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 30.12.2011 14:54 schrieb Jeff King:
> ...
>>   Username: <text input>
>>   Password: <text input>
>>   Remember password? [checkbox]
>> 
>> I was planning to do something custom for credentials as an extension to
>> the credential helper protocol, but this could also fall under the
>> heading of a general prompt helper.
>
> This might be problematic, because (for git-svn) username and password
> are not requested together.

I do not think Peff means the dialog must ask these three items at the
same time. The point is that other codepaths know they need to ask them
and would benefit if they can instruct the dialog external helper to ask
them in a single interaction. So if your callsite does not ask them
together, it is OK. You can keep asking them separately in two dialog
interactions.
