From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 09:44:53 -0700
Message-ID: <7va9ong9oa.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:45:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2oY-0000Vn-5m
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab3DXQo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:44:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab3DXQo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:44:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40D1119028;
	Wed, 24 Apr 2013 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tvM+/8VC1kLu6bbpt8N5o6Nt6Ow=; b=S356VX
	9XmvEeHE9jcrYi7jk50yRKlzPfMmiuY9BIEiScGgSV/R1nPkKFFNtZJOk3wN6LYT
	A87dngXzcEarCEE8TU4v2qyFOGBlBTYzegQdTFRej8NqYbJzRm59AwotStEK7YW+
	5tU8onLTzYBnirqi4WlJGTpP9hzG3+j+wujyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CYLVpvsn/EeiyAfEHmjMk/jF53y8beAF
	SVTY+49YzHtEZo4cl8ywxaOYqTh2ZLmKJnpgOamWUrHT54c4K9Pwpq8SzLrx+eTa
	+U4pr5tZHq03QWARDpAck90gnYWthfOH3OxL0w4a57o9A5Olyt69ZOXNog+4fDod
	NURjkJrt5vI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357E219027;
	Wed, 24 Apr 2013 16:44:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFD4119026;
	Wed, 24 Apr 2013 16:44:54 +0000 (UTC)
In-Reply-To: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 24 Apr 2013 17:53:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A91C8B2-ACFE-11E2-B9A8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222270>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> What should we do to improve the
> situation?

The first thing to do is to eradicate "diff A..B" from the
documentation, and a dozen or more lines in your complaint will go
away with that single change.

As you know, diff is about two endpoints, and A..B is not a way to
specify two endpoints, and not erroring it out whenever we see a
negative revision is a mere courtesy to old timers who knew the
command line parser was shared with rev-list machinery.  

There is no reason to forbid the syntax, but encouraging its use is
counterproductive and will lead to confusions to new people as you
pointed out.

The only issue is to come up with a concise alternative way to
express "diff A...B", perhaps "diff --compare-with-base A B", and
then you can choose not to say anything but an object name (and no
range notation) on the command line (if you do not "diff A...B", it
can already be done by not using "diff A..B").
