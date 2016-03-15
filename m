From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git smudge filter fails
Date: Tue, 15 Mar 2016 09:48:37 -0700
Message-ID: <xmqqfuvr8z6i.fsf@gitster.mtv.corp.google.com>
References: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
	<20160310015939.GA12709@sigill.intra.peff.net>
	<CAH8BJxFmAQtoF+1Q7Ub5qWnz5UewrPS4e8JQWms254hO_E05Hw@mail.gmail.com>
	<20160310210544.GB30595@sigill.intra.peff.net>
	<xmqqtwkec7lk.fsf@gitster.mtv.corp.google.com>
	<CAH8BJxHvg1cnzdsnVsHLYm2BAoqNxp8-mNyVxRy4CHqv0rgN6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs9H-0001bH-Th
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414AbcCOQsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:48:42 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965214AbcCOQsk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:48:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A7294C57A;
	Tue, 15 Mar 2016 12:48:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kxk1ZMPtRCr1CqeLE/Y4J+9ny/U=; b=bm4LJz
	QBqgta6Kui+fN59AmWcGMHzzgJ7/FMhpqjravVkzvA4YjiPAVmjv4gAgyzMJHhLK
	qVpBgQ7LrX0FUzGU6f2gST+zBUl3WZ615c8Yxs+eS8pGyGI8ay7/+yduorC2nnDO
	JolCrDLVAI+o6Y47zfQDCVkOVX/sOIMS97+Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDb83si0tKXB7m/YIRx1rELjwKTm5Lnt
	ZZo+wUOd/QtaXqnvGuSB/QFuUnWNZMv59T9KNddPaSzjpMaiL2zTYooC+sTa/YQV
	75TGzg6ODCKxDVaqoUrbeaTU2JkUBUOijOHhbCFPtNS06vQiniQfEfB1y+egb/T0
	6PSbYstHdbk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 226E74C579;
	Tue, 15 Mar 2016 12:48:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E23D4C578;
	Tue, 15 Mar 2016 12:48:38 -0400 (EDT)
In-Reply-To: <CAH8BJxHvg1cnzdsnVsHLYm2BAoqNxp8-mNyVxRy4CHqv0rgN6g@mail.gmail.com>
	(Stephen Morton's message of "Tue, 15 Mar 2016 12:17:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C439792A-EACD-11E5-8374-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288880>

Stephen Morton <stephen.c.morton@gmail.com> writes:

> It's perhaps beyond the scope of my original question, but for
> situations where I need a "last change date" embedded in a file (e.g.
> because a protocol standard requires it), is there any recommended way
> to do so? We've the hard way that hardcoding makes
> merging/cherry-picking a bit of a nightmare and should be avoided.

Does that "last change date" have to be embedded in a file with
other stuff in there, or can it be a standalone file by itself
(which may be used by other things via linking or inclusion)?

If it can be a standalone file, a custom ll-merge driver that knows
how yoru datestring looks like and takes the later of the versions
in the two branches being merged would not be too hard to write to
eliminate the "nightmare", I would think.
