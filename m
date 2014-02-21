From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Fri, 21 Feb 2014 09:36:14 -0800
Message-ID: <xmqq4n3s5pwx.fsf@gitster.dls.corp.google.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
	<xmqq4n3warni.fsf@gitster.dls.corp.google.com>
	<CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
	<CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
	<xmqqd2ij9be1.fsf@gitster.dls.corp.google.com>
	<CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
	<CAEjYwfU7un6wuA0Z-hSycROSWNdfQq1NawC7=+cNZeNu4-DpJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Jaeger <chrjae@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 18:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGu1Q-000527-QF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933447AbaBURgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:36:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933198AbaBURgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:36:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 870256D6F3;
	Fri, 21 Feb 2014 12:36:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uqMf1uSRoHUvdEV/Fe2drQIocao=; b=Xe7EYG
	FjV1ti+X2dw6WoHGnJCpVgt7ROwzB3MBB2TLpbxHKo+gVMRRdu6yOKCnv2S19b2I
	uZjCZk/OsaraI+ziaBnSIeaL2RIHqTxhxUoc4U+vvL/Q1SrFn6NuZy9YkAzpXnPB
	NVuP+8oh8dupK+8hFExXIXVo0JeDuuywLF28Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OJw1Y1Y8Go/36LJu8Kxpx0tNFh1M3umP
	oIUDDIMMnOYhSlIShuP99DR1T9xgR8zoUpZ4LsxwFrfoEebPRxkk4gtzlo6e+GMN
	ZhqWONwsgLA0ctFXwj21lZk/j6N9H+cSUf8VhwVP9iVhihH93b6PKcT88vwCh/fV
	krWiWMaackM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A72A6D6F2;
	Fri, 21 Feb 2014 12:36:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C4286D6F0;
	Fri, 21 Feb 2014 12:36:17 -0500 (EST)
In-Reply-To: <CAEjYwfU7un6wuA0Z-hSycROSWNdfQq1NawC7=+cNZeNu4-DpJg@mail.gmail.com>
	(Christian Jaeger's message of "Fri, 21 Feb 2014 00:32:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB42BE14-9B1E-11E3-B466-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242479>

Christian Jaeger <chrjae@gmail.com> writes:

> Also, in "man git-gc" document --aggressive that it leads to slower
> *read* performance after the gc, I remember having red that option's
> docs when I ran it, and since it didn't mention that it makes reads
> slower, I didn't expect it to, and thus didn't remember this as the
> source of the problem when I noticed that things were slow.

Good point. We would at least need such a documentation update to
warn users.

> (But, I took from the discussion that increasing the gzip window size
> (?) would make things smaller anyway, so perhaps all that isn't even
> necessary?)

If you are talking about "--window" in "git repack --window=xxxx",
that is not related to gzip.  It is how many other "similar" objects
an object will be tried to delta against to find a smallest delta
that can represent it in the pack.  Such a better delta, if found,
can give you a packfile with a smaller depth that is as small as
another packfile created with a larger depth, which is an overall
win, and using a wider window is a way to achieve such a result.
