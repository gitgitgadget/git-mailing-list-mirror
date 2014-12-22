From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/18] fsck: allow upgrading fsck warnings to errors
Date: Mon, 22 Dec 2014 14:15:39 -0800
Message-ID: <xmqqbnmv8h6c.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<c70409e8e6a42bdc7cacd19cbd49d5d1adbedd1a.1418055173.git.johannes.schindelin@gmx.de>
	<xmqq4mt3idho.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222259070.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:15:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BGV-0007Tm-DH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbaLVWPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:15:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754702AbaLVWPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:15:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3B4729717;
	Mon, 22 Dec 2014 17:15:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M8Km3Uy39hyhyYtu1TmWcjDZiCM=; b=HqW8Ri
	ZoW5N2W3YWw44gWeCLEE8l1gb+3gK6t0oINfIPVTPaz/STsGYU5llwfVulcI/qYY
	Z/NJ3bgeTn+bb2cckPthVVZZaCILLu5yV/tc2bNYr02UHnnjfruPJHIVuDj9i3/T
	PKlt3Da0h0V6ZuGP4Sa5vT+acVus9vwVZ9yCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tPvSUTDrd+x99i4rnlH+x67wHC+3ufq4
	Xj1ecfyOLNbsIjlkXcul8ib9/NIPX5pPF2qrXepD26K1aP/HgGztJBvCBvvSBYoN
	KrPI1MueY7tLMf75AMR9FSlhUMS/bfNUPpChHQanm231yDQnmPvoxNP79VnzJL5l
	aLdR52Jku34=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9822C29716;
	Mon, 22 Dec 2014 17:15:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1939B29715;
	Mon, 22 Dec 2014 17:15:41 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222259070.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 23:01:11 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10AE6692-8A28-11E4-8CAE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261681>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 10 Dec 2014, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > The 'invalid tag name' and 'missing tagger entry' warnings can now be
>> > upgraded to errors by setting receive.fsck.invalid-tag-name and
>> > receive.fsck.missing-tagger-entry to 'error'.
>> 
>> Hmm, why can't all warnings promotable to errors, or are the above
>> two mentioned only as examples?
>
> Those were the only ones that were always shown as warnings but never
> treated as errors.

Sorry but I don't quite understand this comment; I suspect the root
cause might be that we have different mental models on these
tweakable error severities.

Because I come from the school "To these N kinds of events you can
independently assign different (i.e. info, warn, error) outcomes",
moving the FIRST_{INFO,WARNING,...} position in the array would only
affect what happens by default, never hindering the user's ability
to tweak (in other words, there is no linkage between "now you can
tweak" and the order of events in the list, the latter of which only
would affect what the default severity of each event is).

It appears that your design is from a different mental model and the
order and position in that list has more significance than what the
default severity of each event is but how much the severity can be
tweaked, or something, which I somehow find incomprehensible.

Puzzled...
