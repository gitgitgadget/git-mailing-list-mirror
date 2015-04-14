From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 02:22:15 -0700
Message-ID: <xmqq1tjn3vzs.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
	<CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
	<552CD4C8.2020700@drmicha.warpmail.net>
	<CAHGBnuPepR11r9qpxb2G7pGhq0iiaqCCLnbt5NB_xohHi=cVxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 11:22:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhx33-0002RP-RK
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 11:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbbDNJWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 05:22:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752433AbbDNJWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 05:22:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C93DA438F5;
	Tue, 14 Apr 2015 05:22:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sSEXH4hSgbN7+KSzN+IsWO8JTxI=; b=kA48ZQ
	kxaXKmF03ZSyPFg4BM4iB1hOB7u1sE7+YzwAQiUEezMLctq2cKqCMdX81+B+0usp
	IReF/8HrMFkSymQkeQtAn9WXz9f7cRK1GlgGmI3BmpuMBrbcBOToDO1hjwr3NQtK
	px/skt64AkTgxyF33vjfNmMT9/7JUYofZlIWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nny411dnJelqnwreNby2L/n+L31NaP/h
	L6FPNbdfOpjVzClHy3nMi2d12Xq7u8z3x1CCL0+QiXs2+6Nua3tvE+OnxYig5GCT
	vJocrKMfMEbiwxeDDktjuZ961ocl0sfnzOxk9gqWH/vgpcabhFal1kX87xc19IDr
	LHU7YBUnNVQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1B37438F4;
	Tue, 14 Apr 2015 05:22:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A357438ED;
	Tue, 14 Apr 2015 05:22:17 -0400 (EDT)
In-Reply-To: <CAHGBnuPepR11r9qpxb2G7pGhq0iiaqCCLnbt5NB_xohHi=cVxA@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 14 Apr 2015 10:58:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE8A7FAA-E287-11E4-9237-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267125>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Tue, Apr 14, 2015 at 10:50 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>
>> "to dangle" means "to hang loosely".
>>
>> So, in the description above, "A^ dangles from A loosely" because it
>> hangs from A (you can reach it from A) but loosely, because it would
>> "drop" if A gets dropped and A is "likely" to be dropped (because it is
>> unreachable by refs). But A^ is not dangling in our terminology.
>>
>> If you *reverse the arrows*, i.e. consider A^ pointing to A, it becomes
>> more apparent that A is dangling: it is an unreferenced leaf node.
>
> That's exactly what confused me. In the very literal sense, something
> can only "hang loosely", i.e. dangle, if it's only tied at *one* end,
> and that's the case for A (which is only connected to A^) but not for
> A^ (which is connected to its parent, and A). Especially when talking
> about A as a "leaf" node, like in the leaf of a natural tree, I would
> think that A is dangling.

I am not sure if I follow, but probably it is just me who is not
strong at math, or whose eyesight is not keen enough to notice the
arrow heads on links between the commits.

I just visualize commits to be ping-pong balls with strings between
them, and then grab the root of the graph and lift the whole thing
up, while tips of the branches and tags are anchored.  Commit A will
be dangling in the wind if you shake the whole thing.

But that visualization breaks down once you start thinking about
what will happen to A^{tree} and its blobs; they are attached to A
with thin strings and they will have to float above A (i.e. sit
somewhere closer to the root of the tree) just like A^ will go
closer to the root, to make A appear the "dangling" one, as the
direction of the arrow is from A to A^{tree} just like we have an
arrow from A to A^; just like A^ is not dangling because of A,
A^{tree} is not dangling.
