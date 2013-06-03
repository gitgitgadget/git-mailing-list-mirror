From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Poor performance of git describe in big repos
Date: Mon, 03 Jun 2013 10:48:54 -0700
Message-ID: <7v1u8jgk55.fsf@alter.siamese.dyndns.org>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
	<87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NN8cARpPTnsCfHt3kY6gTnhZ=Vq55EzqxWBV_3ju-oczQ@mail.gmail.com>
	<CAJ-05NNgcj_pPer2Tw4HvKkVib7N1ZFo7rZOrR9z8NMV1WHQsQ@mail.gmail.com>
	<7vfvwzi29f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYsR-0007zd-TI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759407Ab3FCRs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 13:48:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759159Ab3FCRs4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 13:48:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C0E24183;
	Mon,  3 Jun 2013 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o8lH7rO2GU5W
	X0z5NMZvu1wRZNs=; b=g9Rs3/BwlDB+Buj0/Db4ws0AW2j9uqHN0PP3RoiB4Rtt
	Mrcq+sgk6o7MYScfsD3PcwZ5VldatEd3ES9+WY63bxmQwLEtIkcrtvuMmIMlOycy
	w/rTrRnG+8lbTpsf+YTCqLSKB9MnlwZAo6rnwhz621X6ajTEzWmdtrkKqdogbhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d6Oi8N
	/4FILjY55XmCGvB9Sq4zUYGe8wMRpXvD9xXPlcJDhnuUBpXFeyiurFS+Hut75MBa
	l5NDlYTyXEcpON2yaL/J+0Q0DePQ4aycz5z3oHOAKVVsbzmo7ZJHDneEw6wI8jIn
	DmFuRAYMsUfgBtv6sOQXV57eYj+vEsSWw0Les=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15BE824182;
	Mon,  3 Jun 2013 17:48:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76F6924180;
	Mon,  3 Jun 2013 17:48:55 +0000 (UTC)
In-Reply-To: <7vfvwzi29f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 03 Jun 2013 09:32:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC5E5E54-CC75-11E2-898F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226249>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>
>> Why is git attempting to parse a commit not on the DAG for the branc=
h
>> I'm attempting to describe?
>
> I think that is because you need to parse the objects at the tip of
> refs to see if they are on the DAG in the first place.
>
> If there weren't any annotated tag, conceivably you could do without
> parsing these objects.  You would:
>
>  - First read the refs without parsing anything to learn the object
>    name of the tips of refs;
>
>  - Traverse the DAG, starting from the commit and notice when you
>    see commits that are at the tips of refs you learned in the first
>    step, arranging to stop when you found the "closest" tip.
>
> But with annotated tags (and "git describe" is designed to be
> primarily used with them; you would need "--tags" option to make it
> notice unannotated tags), the object name you see sitting at the tip
> will never appear during the DAG traversal.  You will only see
> commits from the latter, so you would need to parse the tips to
> learn what commits they refer to.
>
> And of course, "then parse only annotated tags, without parsing
> commits" would not work, because you wouldn't know what the object
> is without looking at it ;-)

Having said all that, with changes by Peff and Michael Haggerty
around f85354b5c7b8 (pack_one_ref(): use function peel_entry(),
2013-04-22), recent Git does not "parse" as many refs as it used to,
only to figure out what commit an annotated tag points at when your
refs are packed, so we may be a lot closer to the optimum than I
hinted by the above description.
