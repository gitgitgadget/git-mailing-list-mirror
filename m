From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 09:41:09 -0700
Message-ID: <7v8vb6tlne.fsf@alter.siamese.dyndns.org>
References: <k5gq60$q8c$1@ger.gmane.org>
 <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joachim Schmitz <jojo@schmitz-digital.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:41:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOACp-0003NX-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab2JPQlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 12:41:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713Ab2JPQlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 12:41:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A5999EA;
	Tue, 16 Oct 2012 12:41:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0WgLb7/lG2yz+ersJujlB19tp2g=; b=PLDGXS
	/zUP9roDssixhnMzfAay2curkVM5ps3MlFvUGxrQkIQ0+2hR7niEuukuivNYORG1
	dBtK8ck9Y09A7AwiLtudr/EINId2CdAKjasSUXhQa5LB5QigdWdzfVG6LzJ4M9xB
	HUWM9dPTymodDAE+W7xanRnwcXIxWWgtux7qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s9H7cQJaLgRvxtcVTifexlbwy4fld//z
	ZovBA/GHG+iCpVjErf25B5/RWQfKreAtsYPXrKBism3mfYhS/uK7tiizcbD1R2U4
	6KVhs0WjPOsyCCDqWnn6M8StEMD9Rw8zKjZTsMfLG2DLfoXmiGp4ZuLSbAu0tDkc
	oSzt1dCQhDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE8999E9;
	Tue, 16 Oct 2012 12:41:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C852099E8; Tue, 16 Oct 2012
 12:41:10 -0400 (EDT)
In-Reply-To: <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 16 Oct 2012 13:39:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AA109FA-17B0-11E2-8089-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207846>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Some test want to use the time command (not the shell builtin) and test
> for its availability at /usr/bin/time.

As we have t/perf these days, I suspect that we should aim to remove
these uses of /usr/bin/time in the main testsuite instead.

The one in 3419 was "run this command, and while at it run it under
'time'" but it is only inside test_debug and I do not think it gives
anything more than curiosity values.

The one in 3302 is used to compare two runs (one without and one
with notes tree), so it has a little more value than just curiosity,
but its value inside the main test suite is still highly dubious. It
does not have any "under this value the test passes" criteria.

When the performance of having to look up notes tree really matters,
it shouldn't be done inside the main test suite that is designed to
be runnable unattended and the only check the humans do is to see
their "ok/fail" output.

In short, what you would get out of /usr/bin/time simply is not a
good match inside the context of these unit tests.
