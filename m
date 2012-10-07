From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Sun, 07 Oct 2012 15:31:50 -0700
Message-ID: <7va9vxq5gp.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	spearce@spearce.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:32:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzOG-0006QY-0J
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab2JGWby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2012 18:31:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab2JGWbx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2012 18:31:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EC2C8C29;
	Sun,  7 Oct 2012 18:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ScHlz9WsqGjs
	lT8+er0nUvLEitw=; b=knLgbU9Tq7SpMQLNxMRrBiX0FR9Nn0B1k/qejzMkfvFx
	MbZOrTo09Wp60+CjUCmiTroHF5TEvSnEeaOTgRnbDIdnAfXMUMykFBiggNV9HF0I
	/gQbolJaWcP3oDKWpyL10cosJ7lwnWaLYpBFVJa5QlFLrp0M6j/HaKOcEVfGqzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I71q3n
	gsD7R5Ju/m1oZ7LnzklpLbfiDPy3iL9sg9NYRMcsXTqZzeKX640QWC9mIm14Ae95
	sMhxHqejWO1YERJXDa25ORkcIWpxJc+RlccwMfjFp4ffZoc0wf6dbilQNodBEcvp
	FGR5CMVU9VpR3pCgGCEd2XnoCD7HXJcqK/09g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF2398C28;
	Sun,  7 Oct 2012 18:31:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 445D88C26; Sun,  7 Oct 2012
 18:31:52 -0400 (EDT)
In-Reply-To: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 7 Oct
 2012 21:57:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA9945C0-10CE-11E2-B0CB-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207206>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Oct 3, 2012 at 9:13 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I'm creating a system where a lot of remotes constantly fetch from =
a
>>> central repository for deployment purposes, but I've noticed that e=
ven
>>> with a remote.$name.fetch configuration to only get certain refs a
>>> "git fetch" will still call git-upload pack which will provide a li=
st
>>> of all references.
>>
>> It has been observed that the sender has to advertise megabytes of
>> refs because it has to speak first before knowing what the receiver
>> wants, even when the receiver is interested in getting updates from
>> only one of them, or worse yet, when the receiver is only trying to
>> peek the ref it is interested has been updated.
>
> Has anyone started working on a next-gen Git protocol as a result of
> this discussion?

I and Shawn helped privately somebody from Gerrit circle, where the
initial ref advertisement is a huge problem (primarily because they
add tons of refs to one commit that eventually goes to their
integration branch), to coming up with a problem description and
proposal document to kick-start a discussion some time ago, but not
much has happened since.  Unless I hear from them soonish, I'll send
a cleaned-up version of the draft before I leave for my vacation.

The gist of it is that the current protocol cannot be upgraded in
place because "who speaks first" is not something you can update
with capability, so we would need upload-pack-v2 that lets the
fetching side speak first.

"What is spoken in the first message" is a separate issue, and one
of the things it can address is to allow the ends to reduce the
amount of ref advertisement that ends up not getting used in the
end, but once we allow the fetcher to speak first, we have much
wider possibilities.
