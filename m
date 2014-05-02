From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 12:29:48 -0700
Message-ID: <xmqqbnvgasib.fsf@gitster.dls.corp.google.com>
References: <536106EA.5090204@xiplink.com>
	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
	<536152D3.5050107@xiplink.com>
	<5361598f8eaf7_4781124b2f02b@nysa.notmuch>
	<536173F5.7010905@xiplink.com>
	<53617877b41a9_41a872f308ef@nysa.notmuch>
	<20140501094610.GB75770@vauxhall.crustytoothpaste.net>
	<5362664C.8040907@xiplink.com> <20140501175623.GY6227@odin.tremily.us>
	<53628CB1.8010302@xiplink.com> <20140501183008.GZ6227@odin.tremily.us>
	<5362ACD6.50505@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJ9h-0008HG-EV
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbaEBT3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:29:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55623 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbaEBT3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:29:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E7941237D;
	Fri,  2 May 2014 15:29:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PeCPul38hdG0HoLmui5hMVxU0bs=; b=kkHgf8
	gLpbBrjUvCM7GPKKWFg8MU1X9z91wv47a2FPBmfC5M+VqjK6xrLknB/o23SVsdDb
	bArSAA8e2XTAS5rbLTObMiKRBtkPxTyH+39ZKYOV5ZpR6j3TWRKhqaMDjyvqdVp5
	fwvhw0ReFmjxPSIr2aSsgOVX7+1+A/8F9q0Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MR8HPVk3RsW3y/g3xkft7czszuz618rd
	WC1a0Gl0HH5Y5m5Ce0Po3c9Q/cmq5XcV14xQJVnNB160FMcLRkjp3kxw3ENVg/mU
	Vo1rWZpzaPHS9ixfjemAmsVtz1xheK8osBb2dS/v3J/hCjsiUnCnLBcSUDofhD5y
	aRUwZb/Mupk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84CF91237C;
	Fri,  2 May 2014 15:29:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DAA51237B;
	Fri,  2 May 2014 15:29:49 -0400 (EDT)
In-Reply-To: <5362ACD6.50505@xiplink.com> (Marc Branchaud's message of "Thu,
	01 May 2014 16:21:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20BBD002-D230-11E3-ADC0-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247958>

Marc Branchaud <marcnarc@xiplink.com> writes:

> I may be mistaken, but I think "git pull" evolved to try to address the
> detached-HEAD risk (at least in part).

You are totally mistaken.

"git pull" was part of the things to make git usable by Linus before
1.0 release, and matches the integrator workflow perfectly well.
The detached HEAD came much much later.

The issue we are discussing with "git pull" is that if a non
integrator does a "git pull" from the upstream, in order to push the
result of integrating the local work with it back to the upstream,
by default "git pull" creates a merge in a direction that is wrong
when seen in the "first-parent chain is the trunk" point of view.

One way to solve that _might_ be to use the detached HEAD as you
illustrated in your long-hand in the thread that had Brian's
example, but that is not even a failed 'git push' recommends to do
to the users, and there was no link between how 'git pull' behaves
and use of detached HEAD at all.
