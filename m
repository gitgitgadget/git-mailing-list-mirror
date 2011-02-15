From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted git repository?
Date: Tue, 15 Feb 2011 12:00:50 -0800
Message-ID: <7vk4h1nk3x.fsf@alter.siamese.dyndns.org>
References: <AANLkTimMon7ztbyT26YhotiZ=jd=QpNTvOkPCKwHg+e_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 21:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpR5C-0008Mf-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 21:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab1BOUBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 15:01:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab1BOUBC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 15:01:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F6D037F5;
	Tue, 15 Feb 2011 15:02:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KveIoNAzyewVmKYYv62YMpblN5s=; b=GakzXV
	8Ifsj7IsjQcs0J2W4QfdaRxdsBmswJ0Y7pPTTnnH+6UGD0P6X9y3N6rR2dwURWBF
	eI7MkRNZ6+89WCkpv9O8Z/432gaMiqEWTHtsxJmOZlQ/r/Hs80dGqQCvEQg/YYXP
	sH41ImE7vgrqf+6gtFIWIryFM4tV0Xi/7IOS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AkkItFb/BJaUOjSLSD5lW2AT8xnQb4HM
	WwZoAoaZFrNQE3JYnkj0LOzrQ28sU1/1UFGS2NzC1gk7KMQ4eVs6/NoEIvoE0UiZ
	l/GQrc2X8Vl1xhqMoRp0DAN+pxzeLr24Z1ymS1vujqQY51T8DBOpkwz7mdm1fkx+
	WByz5CeGzS0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F000637EF;
	Tue, 15 Feb 2011 15:02:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1AE537E9; Tue, 15 Feb 2011
 15:01:58 -0500 (EST)
In-Reply-To: <AANLkTimMon7ztbyT26YhotiZ=jd=QpNTvOkPCKwHg+e_@mail.gmail.com>
 (Piotr Krukowiecki's message of "Tue\, 15 Feb 2011 15\:57\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75468E7A-393E-11E0-81E7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166871>

Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com> writes:

> it looks like my git repository got corrupted today.
>
> git status shows no changes,
> git cherry-pick says "error: Your local changes to the following files
> would be overwritten by merge:",

with some paths, or without naming any path?

> git fsck starts checking objects but hangs on one "Checking tree"

I take it that you are talking about "git fsck -v".  Is it really "hangs",
or just "takes a long time"?  You mentioned that a clone is expensive so I
am guessing that your repository has some huge trees or objects in
general.

The details you gave in your message are a bit sketchy to give you an
exact diagnosis, but if "cherry-pick" stops with the above message and
tells you the names of files that are not tracked in your current branch,
I don't see there is anything unusual going on.  You have these files with
random contents that git does not know about, and git is refusing to
lose their contents by overwriting them during the cherry-pick.

After making sure that they are indeed untracked paths, if you think you
can remove them (or move them away), first do so and retry cherry-pick,
and then everything should be Ok.
