From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file: freshen existing objects
Date: Tue, 21 Apr 2015 14:45:08 -0700
Message-ID: <xmqq4mo9gnq3.fsf@gitster.dls.corp.google.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
	<20150417140315.GA13506@peff.net>
	<CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
	<20150420195337.GA15447@peff.net>
	<xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
	<20150420200956.GA16249@peff.net>
	<CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
	<xmqqiocpif8p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:45:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykfyp-0008D5-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933759AbbDUVpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 17:45:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932096AbbDUVpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:45:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12AB64BBC9;
	Tue, 21 Apr 2015 17:45:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ISxwhOH4N30bMDI5haOa0UIjMtM=; b=M4CIc6
	Lay86jJhuv/fg2s4IQTUST3jjd7vV5awC7di+2hkgdggsBhAbghLDQzUSsyno28D
	KN/LiAZ+NDif56aplYaqBqNbGZWg4IGp3fGWaDJ+WNUO5YHU6LKiz1qjPFGxHu0m
	c93CZ/XTT8BYweEEezsdmNpKEFb5YB3zjy2ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g73yIEOy2PccH2NiwJbj/12YXgbH5EqL
	KYKiV4bb1bdaT9V4Jnk58iYeao3jE/Ww/ID6OacqeQezI89dSrquAt7AleqvDCM9
	uTbYjgEHIDAwuBjh7O6czM4wrlX2/1wcdpDeBF494Kpaoo3fPHMf3aj87iz8uljr
	XIEddzg08WQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A7964BBC8;
	Tue, 21 Apr 2015 17:45:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7765D4BBC7;
	Tue, 21 Apr 2015 17:45:09 -0400 (EDT)
In-Reply-To: <xmqqiocpif8p.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Apr 2015 10:05:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE871AD0-E86F-11E4-8E70-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267558>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Saasen <ssaasen@atlassian.com> writes:
>
>> I've noticed Peff's patches on pu which suggest they will be available
>> in git 2.5?
>
> Being on 'pu' (or 'next' for that matter) is not a suggestion for a
> change to appear in any future version at all, even though it often
> means that it would soon be merged to 'master' and will be in the
> upcoming release to be on 'next' in early part of a development
> cycle.  Some larger topics would stay on 'next' for a few cycles.
>
>> Do you Junio, have plans to merge them to maint (2.3.x) and/or next (2.4)?
>
> The topic will hopefully be merged to 'master' after 2.4 final is
> released end of this month, down to 'maint' early May and will ship
> with 2.4.1, unless there is unforeseen issues discovered in the
> change while people try it out while it is in 'next' (which will
> happen today, hopefully).

... and then if I do not forget and if the topic is really important
for real-world users, I am OK to merge it down to 2.3 and even 2.2
maintenance tracks later.  But that will happen only after the topic
hits 'maint', which will happen only after the topic hits 'master'.

What you _can_ help is the "if I do not forget" part ;-)  Also see a
similar discussion we had recently

  http://thread.gmane.org/gmane.comp.version-control.git/264365

The key sentence from my part in the thread is 

> When I say "the tip of 'master' is meant to be more stable than
> any tagged versions", I do mean it.

and the reasoning behind it that is given in the paragraph before
that, though.

Perhaps companies like Atlassian that rely on the stability of the
open source Git can spare some resources and join forces with like
minded folks on LTS of older maintenance tracks, if they are truly
interested in.
