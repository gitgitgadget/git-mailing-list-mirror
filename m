From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] Column display
Date: Sun, 26 Feb 2012 23:46:55 -0800
Message-ID: <7vipisbtw0.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <7vaa45dwq7.fsf@alter.siamese.dyndns.org>
 <CACsJy8AyZcNSPEY8S0WczVu0ychGKr61BoBm0iy39ZsVM=zHpA@mail.gmail.com>
 <7v8vjpcaz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 08:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vIX-0002ow-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997Ab2B0Hq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 02:46:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab2B0Hq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:46:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28772809;
	Mon, 27 Feb 2012 02:46:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HgWi/2uo7N4ITsITbIXCFRF3FTY=; b=dowyyP
	89okMIJgJdPq/lY4nEZdM7/9P4+DEqb3UK+bp7lD4f9gf9uPTYLadvp6+OBO8Nsu
	hicVS8o8Cmtw1V7QMHiy+6vwH6HDSK1CqJX67nWr+iPH0U6pANbshbv86LnHVlu/
	8IEZnp5pjtkmv+YIrGk/OkZIn3Xe88QdNfXPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BOCftdFCYkigzFWFBvmvCSzZm4hdZNxu
	QRf5p0B5/wcYkmn4DFM+BY7rmTX/lUsaj327g3YDO9PNG237Bu7Iu8vi3R37E/+w
	Wj79jgjKU61ihKLb6bES8qve+j5fLIKs46Vu4YJaMIfZboHuSe0TgRWVEssuED6S
	2HZeN+Dsh64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D83282805;
	Mon, 27 Feb 2012 02:46:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C1072802; Mon, 27 Feb 2012
 02:46:57 -0500 (EST)
In-Reply-To: <7v8vjpcaz3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 26 Feb 2012 17:37:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 396A1384-6117-11E1-998C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191603>

Junio C Hamano <gitster@pobox.com> writes:

> But at least with your series, "git column" is as invisible as git-sh-setup
> and git-stripspace by being marked as purehelpers, so your patch may be
> the best we could do.  I dunno.

I finally realized the true reason why I was so reluctant to take this
series.  If the series were presented like the following, I wouldn't have
had any problem:

    There is a widely used program, "column", that takes a data stream
    one-item-per-line as its input and produces columnar output.  Some
    lists we produce as our output, e.g. "git tag --list", are often too
    tall and sufficiently narrow, that "git tag --list | column" is a
    useful thing to do.  The first patch in this series teaches "git tag
    --list" to do just that but internally, so the user does not have to
    pipe manually from the command line.

    Luckily, "column" is a free software, and more importantly, it is
    written modularly enough so that we can reuse its primary logic to
    produce lines for columnar output without having to feed its input
    from the standard input or drain its output directly to the standard
    output.  Build an API around its core, and plug that logic to "branch
    --list", "help -a" and other commands.

But that is not the case.

Yes, there is "column" that comes with BSD, and I am not suggesting to gut
it and reuse its code, but by adding our own "git column" and implementing
it as a built-in internal, we are making it harder for the outside world
to benefit from our implementation, even when our "git column" some day
becomes polished enough to the point that people who are used to the BSD
"column" start to wish their "column" had extra features offered by "git
column", without swallowing "git" as a whole.

Come to think of it, that is really the same distaste I had against both
"diff --no-index" and "grep --no-index".  We know adding our enhancements
over non-git versions of these programs is a better gift to the outside
world, but we instead added the --no-index mode to Git to only keep the
benefit to ourselves, because it is far easier for us to do so.

But I do not deeply care either way.
