From: Junio C Hamano <gitster@pobox.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 03 Oct 2012 12:13:08 -0700
Message-ID: <7vd30z4bej.fsf@alter.siamese.dyndns.org>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	spearce@spearce.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIS-0001DP-A3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab2JCTNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 15:13:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2JCTNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 15:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9319AA6;
	Wed,  3 Oct 2012 15:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WTTx5Anf5Giu
	kOoi4jWlWXVJVJc=; b=iySqN311DyOMTgQW9jUHtPDHRwsXbYr46OrTbEOzZSBH
	Ah1jbSvXdScWqWcGbNsmbJmwwht+TjImjiFpf9m40tca7//6uOh0pjI9zfd0RxA8
	hmU1VL10hh3Z+OxptAahkWWj9F/ZvYLkQAcJHHGjbf3QQdGQOgIBMaoLa2jbKNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZBUt1r
	Ai91th2UQrPICcdlmeYh4HOdcWF/q/r71ldSIdzueK4BUD/oU69qfE7YD3cy68KX
	+8VIAMWqWw+x9Tnvh5gSPENmTk12cODyvQLP/m1PNtjIluVPo8Bam8NKL85Hrhwx
	gaYIBjfLZtfJdEbHT5xJ1p+d1WRRb+48u5pVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1BD69AA5;
	Wed,  3 Oct 2012 15:13:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25EC09A98; Wed,  3 Oct 2012
 15:13:10 -0400 (EDT)
In-Reply-To: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 3 Oct
 2012 14:36:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5ECE5094-0D8E-11E2-924C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206931>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm creating a system where a lot of remotes constantly fetch from a
> central repository for deployment purposes, but I've noticed that eve=
n
> with a remote.$name.fetch configuration to only get certain refs a
> "git fetch" will still call git-upload pack which will provide a list
> of all references.

It has been observed that the sender has to advertise megabytes of
refs because it has to speak first before knowing what the receiver
wants, even when the receiver is interested in getting updates from
only one of them, or worse yet, when the receiver is only trying to
peek the ref it is interested has been updated.

I do not think upload-pack that runs on the sender side with
millions refs, when asked for a single "want", feeds all the refs
that it has to the revision machinery, and if you observed it does,
I cannot explain why it happens.
