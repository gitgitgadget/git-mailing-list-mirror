From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make test Unexpected passes
Date: Sun, 24 Apr 2016 12:09:00 -0700
Message-ID: <xmqqtwiqn7sj.fsf@gitster.mtv.corp.google.com>
References: <571A8404.5030200@ramsayjones.plus.com>
	<loom.20160423T011428-888@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Woosley <ben.woosley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 21:09:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPP6-0002Mx-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbcDXTJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 15:09:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751814AbcDXTJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:09:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4A6E15343;
	Sun, 24 Apr 2016 15:09:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dqVeKIBO5I7Owyjc3D5D4o9i81Q=; b=siUyPs
	Bbp1Z501CTO9U9dKWDLWUE5tubjCHEVCgfkyauyplo4dnI7+M8YpYW8y2QilxD41
	Oz8wGn327s0mQ+1kGbB5L/hOsTkO4mheXIukMPikMbH8YSmWuR7X0la3t0hLvTJa
	7swzdpuTMUs2UXvuzZMiebDW4YsBm35hslB0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x4/aVv2brbrP5p8Csy0PdDr3MVKNUXGO
	olu4j9vNY3NFpuEJow7cwv95Lkyct5KC9J9Iq7iAT0DdzDCzFO0HeiKgw6XFW9FX
	zcRf1UIZQ73lNlKkUszz47GOdqub70YuinVr07FZtgoMn93gxf7AqoXsxQiefDIy
	YFA3AtYFoo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3B4415342;
	Sun, 24 Apr 2016 15:09:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42A8B15341;
	Sun, 24 Apr 2016 15:09:01 -0400 (EDT)
In-Reply-To: <loom.20160423T011428-888@post.gmane.org> (Ben Woosley's message
	of "Fri, 22 Apr 2016 23:16:16 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 01100E1C-0A50-11E6-A99D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292429>

Ben Woosley <ben.woosley@gmail.com> writes:

> These know breakages:
>
> ok 50 - rebase -m --onto --root
> ok 54 - rebase -m without --onto --root with disjoint history
>
> Have to do with rebasing a root/orphan branch with the -m flag,
> which defaults to -- merge=recursive, which is the case the patch fixed.
>
> Here are the necessary changes:
> ...

Thanks, will squash them in and reword the log message accordingly.

    git-rebase--merge: don't include absent parent as a base

    Absent this fix, attempts to rebase an orphan branch using "rebase -m"
    fails with:

        $ git rebase -m ORPHAN_TARGET_BASE
        First, rewinding head to replay your work on top of it...
        ...
    Note the default rebase behavior does not fail:

        $ git rebase ORPHAN_TARGET_BASE
        First, rewinding head to replay your work on top of it...
        Applying: ORPHAN_ROOT_COMMIT_MSG
        Using index info to reconstruct a base tree...

    A few tests were expecting the old behaviour to forbid rebasing such
    a history with "rebase -m", which now need to expect them to succeed.

    Signed-off-by: Ben Woosley <ben.woosley@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
