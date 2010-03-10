From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/13] several notes refs, post-rewrite, notes
 rewriting
Date: Wed, 10 Mar 2010 13:23:53 -0800
Message-ID: <7vwrxjrhue.fsf@alter.siamese.dyndns.org>
References: <7vd3zurmoa.fsf@alter.siamese.dyndns.org>
 <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 10 22:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpTO4-0002YH-7P
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 22:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab0CJVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 16:24:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab0CJVYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 16:24:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D26A0DFC;
	Wed, 10 Mar 2010 16:24:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1DrWI8L5F7TkG9mOErt013TV5E=; b=UpzDOv
	JmixT+ZgWpQj5V9mfZ43qppF4HO3jb3qeXo4nArt99TLhDwq8+iUAzQPn0yJr9wb
	XnUEnMtiy8+UqB9Vltd1Hd8B/322eUFoRLSN755eM81vgjO8hicgua4iFo0YKTIM
	MUwXbNA6NXf/sk7QPKClrWVliFfb2e35AnY0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mGB+KrO4XWHXtjpxC0G9FMkDMj0AkURS
	yQRC3HPpupWFybl0FGfMVw4V2jOkaoH9ttpm9ykyVp/SlMCldtaDWyfq1hXHjwqz
	GkVVrTJP6fQ3W/IvxL5UoTnolywXJIMnCtwm91jGhWb7WZxvPTrrzq43MUdv7O9Z
	9eBWk7xYyis=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58931A0DF5;
	Wed, 10 Mar 2010 16:24:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E751A0DEB; Wed, 10 Mar
 2010 16:23:55 -0500 (EST)
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 10 Mar 2010 15\:03\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E6106F8-2C8B-11DF-B1FD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141921>

Thomas Rast <trast@student.ethz.ch> writes:

> I'm not aware of comments by anyone else, so if I missed them please
> point them out.

Yes, please ;-)

>>  - "git notes add" and friends honor GIT_COMMITER_* and GIT_AUTHOR_* as
>>    usual.  Since I use post-applypatch hook to record the message-id from
>>    "git am", I ended up getting my notes written by original submitters.
> [...]
>>  - As to the determination of committer/author identity, I think what the
>>    code currently does (i.e. honor the environment and user.* config) is
>>    perfectly sane, but at the same time I think it would be surprising for
>>    unsuspecting users.  We may want to advise users about this in the
>>    documentation.
>
> I added a small patch that writes this and the history recording down
> in git-notes(1).  However, I'm hesitating to directly say "and this
> will bite you if you use it in post-applypatch"; isn't the latter an
> implementation detail of git-am?

Probably.  We haven't documented what can and cannot be used by pre- and
post- applypatch, but I think at least post-applypatch should not rely on
the authorship information exported from the caller; if it wants to find
out, it can parse HEAD, and because it is a post-hook, it should always be
correct no matter how git-am implementation will change in the future.
