From: Junio C Hamano <gitster@pobox.com>
Subject: Re: exit code from git reset
Date: Sun, 09 Dec 2012 15:04:11 -0800
Message-ID: <7vzk1mddzo.fsf@alter.siamese.dyndns.org>
References: <CANiSa6i0LXE18Pyb5norRTm7PM+TMo3JvxDjoS5JOWt_qjHLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 00:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThpvE-0003b9-5m
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 00:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab2LIXEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 18:04:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356Ab2LIXEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 18:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9B1A4DD;
	Sun,  9 Dec 2012 18:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x859AjTD3zDGZ8PSy2nbb7cEoKc=; b=w1Ax/L
	l5BExHJF/kNjOy/tfczzGxTPrHtWP6Lg6/pMzW41bxB+4sgcGWm/7FREYCqJVzur
	Vx7SIZog46RgLnhYJPc7tegOz/bvJwUu327xZH9876zCekHDfLjaZ2sghhkwJr0K
	Nbw3tsdx1m8sKe6o6wEtwFwK21+vEJzfa2aTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ahO/sAsNPZMVbnUF4jgVVpoXkjPD42O/
	fFvB1JBWFMbtJX7guI4gg7lWkZrrUnyGAKTFgyT3arzK3woZr5Yh/vkCBw2yOe9q
	QR27abBYFAPUPuv5C/rFOHPO9xXs6+GDIZiIOZHUKF3wKBoWal5+XtobFAHG3zEJ
	L7bVJQt8AeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 867A7A4DC;
	Sun,  9 Dec 2012 18:04:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC40BA4DA; Sun,  9 Dec 2012
 18:04:12 -0500 (EST)
In-Reply-To: <CANiSa6i0LXE18Pyb5norRTm7PM+TMo3JvxDjoS5JOWt_qjHLHw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Sun, 9 Dec 2012 14:23:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF5CD6BA-4254-11E2-8B70-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211244>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> "git reset" currently returns 0 (if successful) while "git reset
> $pathspec" returns 0 iff the index matches HEAD after resetting (on
> all paths, not just those matching $pathspec).

So in short, you observed that either of them reports with its exit
code if the resulting index (not just any subpart, but always the
entire thing) matches the HEAD, e.g. "do we have change that will be
listed on 'will be committed' section in git status output?"

Sounds like one sane and consistent semantics to me.  I am not
saying that there cannot be other behaviours that are internally
consistent (e.g. the error code could have matched the number of
paths that are different between the index and the HED, or the error
code could have been zero for successful reset, non-zero for some
failure), but I am saying that the current behaviour gives _one_
sane and consistent meanings regardless of how you ran the command.

> The exit code doesn't seem to be documented.

Please make it so.

> Changing "git reset $pathspec" to return 0 on success, regardless of
> diff between HEAD and index, breaks 10 test cases (in
> t2013-checkout-submodule.sh and t7102-reset.sh). These seem to do
> "test_must_fail git reset $pathspec", but I have not been able to find
> any motivation for expecting the failure.

See above.
