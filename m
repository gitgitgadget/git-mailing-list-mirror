From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add post-worktree-add hook?
Date: Fri, 22 Jan 2016 09:28:57 -0800
Message-ID: <xmqqy4bhv7za.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8C9OELrkHZLzwoRx26AtzVvgouRA2+m0VH7GrJGSA8PCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:29:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMfWE-0000Wc-00
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbcAVR3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:29:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754618AbcAVR27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:28:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE6743DBC9;
	Fri, 22 Jan 2016 12:28:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UwQJI2kWcufGqxWBqtWsDk5AN/A=; b=SzXiOe
	hARyU7rxRZrlv7TaTyIG6baIf85yS8W409OkkiP/+nTKZGGjjwOVE/Enkqv5Waui
	vEo1pdebTm8/p5iq3xS6B8bTGtaQdu1E9FmVXPHkP+JgxGJqaP0CA6GxeDXWq+dn
	Tus38tKFAcBttHVQKBUG/HDOXHpFt71EHeUeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yZ/kuVJwzPLWzj4f77ijtBlgenKCAj3n
	Pe1zOPpg6ZTPOUVERR6qFirhxemSmUOXJK6/KjaUuy7e7hT5KOu6FvIGv3rRNUCZ
	1aCJwPQsjODNhR9hdTmRrEJ6OSt8cbW2xIPD8hhEG8s4isIMDCt2Sdeh8dEki/RV
	9u1wOY40FNA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B40543DBC8;
	Fri, 22 Jan 2016 12:28:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 371523DBC7;
	Fri, 22 Jan 2016 12:28:58 -0500 (EST)
In-Reply-To: <CACsJy8C9OELrkHZLzwoRx26AtzVvgouRA2+m0VH7GrJGSA8PCQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 22 Jan 2016 16:45:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E8CCB10-C12D-11E5-90C4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284570>

Duy Nguyen <pclouds@gmail.com> writes:

> I started moving my git work space to multi-worktree and found it
> annoying that every time I add a new worktree, my first step must be
> copy my config.mak over. Room for improvement. I see three options:

4) none of the above.

Everybody should learn to think before uttering post-X hook the
following:

 * Is X an end user initiated action?

 * What does the hypothetical post-X hook need to decide what to do?
   If it needs to change behaviour based on what X did, does it need
   more than what it can get by observing its outcome (i.e. exit
   status and what is left in the working tree and the repository)?

 * Does the hypothetical post-X hook need other end-user supplied
   customization beyond what argument the end user gave to run X?

The answer to these questions would often reveal that post-X hook is
a bad idea and you are much better off with a wrapper script that
runs X as the first thing (and the remainder can do different things
based on the outcome of X if you wanted it to).
