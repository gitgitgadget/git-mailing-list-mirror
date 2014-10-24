From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/technical: signature formats
Date: Fri, 24 Oct 2014 10:10:38 -0700
Message-ID: <xmqqbnp1gzqp.fsf@gitster.dls.corp.google.com>
References: <cover.1413990838.git.git@drmicha.warpmail.net>
	<13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net>
	<xmqq7fzshqrb.fsf@gitster.dls.corp.google.com>
	<544A71F3.1020607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 19:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhiNy-00034k-D3
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 19:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992AbaJXRKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 13:10:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932421AbaJXRKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 13:10:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0090A146AC;
	Fri, 24 Oct 2014 13:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S0Lzoh+OmTu3jEk4nBevf+mUQZU=; b=cDuFWc
	EzfU03ONyN0vYgybmRWu0Z8lryPwHTE2TV10Fs8SpRyjowlq6pnPY6fKP/2eCyy9
	m3MSI5jfouT/D0y00Jjq0Kc7M1NDCECLNjC6DrZeye6pCEc8KljwbxfxBuhTUPqd
	8R3n1HPJ38xpN++hNGF/opWRlWl9JJapUBRiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MdFv1Zl0WHEtr+6QnwVAqRbyWPBAxjon
	kWcXyNaVM7lte3LXMQrjve76lptEOOfisZaH+lfZZO4itN731CUs1+xSbEsVLNgx
	tGN4X4/GL934Ef1xwUrwq47nn5QMqAzDJFu2BGjJYYYzh8nkPDMxjUEIPwrfwr2D
	NHlvi290s20=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB038146AB;
	Fri, 24 Oct 2014 13:10:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76DE8146AA;
	Fri, 24 Oct 2014 13:10:40 -0400 (EDT)
In-Reply-To: <544A71F3.1020607@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 24 Oct 2014 17:36:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE4A15CE-5BA0-11E4-832C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano schrieb am 22.10.2014 um 21:02:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> Various formats for storing signatures have accumulated by now.
>>> Document them to keep track (and maybe avoid yet another one).
>> 
>> I haven't looked at the description closely, but it is a good thing
>> to describe signature in a tag and in a commit in detail, which we
>> failed to do so far.
>> 
>> The principle is essentially the same between the signature on a tag
>> and on a commit: a detached PGP signature over the remainder of the
>> object data is created, and then the signature is inserted into an
>> appropriate place in the resulting object.  That "appropriate place"
>> is influenced by the type and nature of the object.
>
> Yes, the detached signature can't easily be appended to a commit object
> the way it follows a tag object. Conversely, signed tag could easily
> look like signed commits do (sig in header), but that would require a
> migration procedure.

I do not see much point in doing such "migration", though.  Whom
is it supposed to help?

>> A mergetag is not fundamentally a "signature" in the above sense,
>> though.  It is just a dump of the object content in a regular object
>> header field (hence indented by one SP), and its contents having PGP
>> SIGNATURE is merely a natural consequence of the object recorded
>> being a signed tag.  So the description of it in the same place as
>> description for signed tags and signed commits feels a little bit
>> out of place, but I do not think of a better place to describe it.
>
> I guess referencing the tag object (like other objects do) rather than
> embedding it would have had its merits, but that is beating up a dead
> horse.

Such a format would have defeated a major point of mergetag.  The
header embeds the data, not a reference to an external object, so
that the resulting merge commit can be validated without having an
extra tag.  The resulting repository does not have to keep a tag
reference that nobody else is interested in, which is an added
bonus.

I however agree that if there were no downside having to reference
and maintain an extra tag, having the data there (i.e. the real
"mergetag" format) and a reference there (i.e. your alternative)
would have the same level of security and assurance.

That tells us that whatever is on "mergetag" is "not fundamentally a
signature", as I said already, doesn't it, though?

The description of "mergetag" in this document should not have to
change, even when the mechanism used to sign underlying "tag"
objects were to change in the future.  For that, you can just say
that it is just a bit-for-bit copy of the tag object that was pulled
into the history with the merge.  The way how bits from the tag
object are recorded there needs to be described.  What the bits
mean (e.g. it has a detached GPG signature over what appeneded in
what way) does not need to be (and I think should not be) repeated
in the description of "mergetag".
