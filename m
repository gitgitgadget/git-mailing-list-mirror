From: Junio C Hamano <gitster@pobox.com>
Subject: Re: slow git-cherry-pick.
Date: Mon, 25 Nov 2013 09:26:40 -0800
Message-ID: <xmqqd2loz92n.fsf@gitster.dls.corp.google.com>
References: <2142926.gg3W3MsbJZ@localhost.localdomain>
	<CACsJy8CAAov1nSGPx79U+md4xROsCydidHPcipOb_sdFwNdSkA@mail.gmail.com>
	<32998962.pucYdvRloz@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: pawel.sikora@agmk.net
X-From: git-owner@vger.kernel.org Mon Nov 25 18:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkzvu-0007KX-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab3KYR0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 12:26:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230Ab3KYR0p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 12:26:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 943CD527A2;
	Mon, 25 Nov 2013 12:26:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zY7DfJbcbES2
	Q08I8UdzuBURvEo=; b=IknAftaxPyW16gPGV/pS63pkr4Dp/Pr4XmY1qq2sZmRM
	L6qwhRDk3eEowMkf97opXDN/tLxKo3cy5p9+Q6KI/wN2r7RZihZ/BlIoCIODh1Vy
	NnIhc3mGtPsS1gsMBKL+t1shxwXSf+5q4sjVqQngviq8tgXVkLBg2Das1j50NKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hZh912
	rSaiwcyRa+5OnS8bfJi5z32RzgRdwojEJ0yyx2WtnWEJVHoWSMRrzwuRp+41cF1e
	PyMGO57p1ny0ZHpnA02sykIkyALXJ4p6P/cnusa2nU2udj+0DH84BMEjTA5RSmDl
	m/89z2qevRJ7ZPfTJEZIZJBnK0cJ5O25SmaU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85A9C527A1;
	Mon, 25 Nov 2013 12:26:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8B1F5279F;
	Mon, 25 Nov 2013 12:26:43 -0500 (EST)
In-Reply-To: <32998962.pucYdvRloz@localhost.localdomain> (=?utf-8?Q?=22Paw?=
 =?utf-8?Q?e=C5=82?= Sikora"'s
	message of "Sun, 24 Nov 2013 20:17:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C0ECC696-55F6-11E3-9F14-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238323>

Pawe=C5=82 Sikora <pawel.sikora@agmk.net> writes:

> On Sunday 24 of November 2013 19:47:10 Duy Nguyen wrote:
>> On Sun, Nov 24, 2013 at 5:45 PM, Pawe=C5=82 Sikora <pawel.sikora@agm=
k.net> wrote:
>> > i've recently reinstalled a fresh system (fc20-beta) on my worksta=
tion
>> > and observing a big slowdown on git cherry-pick operation (git-1.8=
=2E4.2-1).
>> > the previous centos installation with an old git version works fas=
ter
>> > (few seconds per cherry pick). now the same operation takes >1 min=
=2E
>>=20
>> What is the git version before the reinstallation?
>
> git-1.7.11.3-1.el5.rf.
>
> i've checked this version on another machine with centos-5.$latest
> and it does similar amout of stat/read operation quickly (~6s).
> this "fast" centos-5 machine has /home on raid-0 (2x500GB) while
> my "slow (>1min)" workstation has /home on linear lvm (250G+1T).
>
> so, i suppose that my "slow" working copy crosses disks boundary
> or spread over 1TB drive and the random git i/o impacts performance.
>
> the question still remains - does the git need to scan whole checkout
> during picking well defined set of files?

We do update-index to see what local changes you have upfront in
order to avoid stomping on them (and we do not know upfront what
paths the cherry-picked commit would change, given that there may be
renames involved), so the answer is unfortunately yes, we would need
to do lstat(2) the whole thing.

Doing that lstat(2) more lazily and do away with the update-index
might be possible, but I suspect that may be quite a lot of work.
