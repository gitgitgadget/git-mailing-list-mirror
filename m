From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Mon, 13 May 2013 07:46:09 -0700
Message-ID: <7v38tros3y.fsf@alter.siamese.dyndns.org>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
	<CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
	<20130511214900.GF2299@serenity.lan>
	<CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
	<7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
	<20130512085934.GG2299@serenity.lan>
	<7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
	<20130513075906.GP2299@serenity.lan>
	<7vzjvzoujq.fsf@alter.siamese.dyndns.org>
	<20130513140243.GQ2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 13 16:46:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubu14-0002OQ-38
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab3EMOqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:46:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab3EMOqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:46:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD9D1D67E;
	Mon, 13 May 2013 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QaFx9YTgBE1pxIdmxJ1G+Issa9Y=; b=jh9CcL
	8o1lZMPI7jmGI1SwSO3U2cslOUHknHQcxnhWEcjD97XuWFZPtk3FtMAw/SKV+OdM
	Snw8ZkJt47Rs4RzA7jbbMALpi3TlhsAFpslXLPay/GpmWNOJF2Mf/3FDE5HgH9TU
	Ov5G7vJxOJSFqqX0rxMzlS5p1si0oR00ibqwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ee+sP31bfBdW3TuHQNIBzHmfXsZFf5kV
	Vi+78/UMVjDoQlNYoDg5fKoPPiftWg2KX+a+7BZSu839tInkjZuU+jMDuBglF4w+
	QMEtVtsRchuJNpp7OSPMMWp5uoJxiAQwC5zC9BXIWkSC957Zq0vhKg8ld4k9fb/m
	jV0Yo4RHMo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D36571D67D;
	Mon, 13 May 2013 14:46:11 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 341201D679;
	Mon, 13 May 2013 14:46:11 +0000 (UTC)
In-Reply-To: <20130513140243.GQ2299@serenity.lan> (John Keeping's message of
	"Mon, 13 May 2013 15:02:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA7ABCF4-BBDB-11E2-86FA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224158>

John Keeping <john@keeping.me.uk> writes:

> On Mon, May 13, 2013 at 06:53:29AM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > The caching layer could also introduce false positives though, which is
>> > more serious.  If you cache patch IDs with a pathspec restriction ...
>> 
>> What?  What business does patch-id have with pathspec-limited diff
>> generation?  You do not rebase or cherry-pick with pathspec, so
>> unless you are populating the patch-id cache at a wrong point (like,
>> say whenevern "git show $commit" is run), I am not sure why pathspec
>> limit becomes even an issue.
>
> revision.c::cherry_pick_list() sets the pathspec to what was specified
> in the revision options.  It's done that since commit 36d56de (Fix
> --cherry-pick with given paths, 2007-07-10) and t6007 tests that it
> works.

Then the caching should be automatically turned off when pathspec is
given.
