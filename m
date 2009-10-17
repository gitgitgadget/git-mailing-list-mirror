From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 01:11:23 -0700
Message-ID: <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 10:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz4OJ-00066k-WB
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 10:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZJQILm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 04:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbZJQILm
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 04:11:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZJQILk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 04:11:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 851217A737;
	Sat, 17 Oct 2009 04:11:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jqD7n0WeS/E0
	AVtyvyWNdg/QEGQ=; b=eRBDa5jnFY3IC4i01oCTnrrk1wzxbR2fvnikQe4ryHDP
	VFRP6oKgClE+UKlzhqhhUKkyQfEAfuqX8AKTTtiQe04F9+JqJZtHER5pGQUwgVB9
	rbiieVgz+MP/Q74truYURnLfxqCPrwPR85AK0IT6h1Y1IhEV5C17z0FHuTG9oTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iES+In
	owPH3/QSPm4FvX0r2n0AMWpn1I/sVs7aM3VCWPe2IVICQrtbaVoXDRrffln+YDg6
	WiGy4v0FM3/ApvDvUFgpxru7BcATU7EV+Gc7f5aymuSED16+7xWwG+Fods6KGQyb
	MFu3S9qGJL2TCnnJ1IJZ9qyPxsFqZnH3ISe3s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16A4B7A734;
	Sat, 17 Oct 2009 04:11:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 719AC7A731; Sat, 17 Oct 2009
 04:11:25 -0400 (EDT)
In-Reply-To: <20091017075551.GA5474@atjola.homenet> (=?utf-8?Q?=22Bj=C3=B6?=
 =?utf-8?Q?rn?= Steinbrink"'s message of "Sat\, 17 Oct 2009 09\:55\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B04FF2DC-BAF4-11DE-8187-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130550>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> ... If so, it does a "git checkout --merge
> <upstream>" (possibly leaving conflicts for the uncommitted changes,
> just like "svn update").

Up to this point I was reading with quite a lot of interest.  But here =
I
strongly disagree to the point of getting actually disgusted.

"svn up" is one of the areas Subversion folks failed to make their syst=
em
a better CVS.  It has the same "local changes are lost in the merge
conflict mess in an irreversible way" failure mode, and we shouldn't be
making it easy to new people.  It is not something we should emulate.

You can and should instead refuse the update, and suggest committing fi=
rst
so that the user has a safe record of what he has done and the merge wi=
th
upstream can be retried if necessary.  As you need to have that "refuse
but guide the lost soul by telling what to do" mode anyway when...

> ... If a fast-forward is not possible, it
> complains, telling the user that he needs to use "git merge/rebase/pu=
ll"
> instead, and might want to create a branch head, in case of a detache=
d
> HEAD.
