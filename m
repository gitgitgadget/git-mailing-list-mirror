From: Junio C Hamano <gitster@pobox.com>
Subject: Re: weaning distributions off tarballs: extended verification of git tags
Date: Mon, 02 Mar 2015 15:44:55 -0800
Message-ID: <xmqqsidn7ymg.fsf@gitster.dls.corp.google.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
	<CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
	<1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>
	<20150302181230.GA31798@kitenet.net>
	<CACsJy8C3=f=esBrHE8OudSa0nUbCrLaYJtLC2in3p+tcc-d9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joey Hess <id@joeyh.name>, GIT Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:45:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSa1J-0001LW-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 00:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbbCBXpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 18:45:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753447AbbCBXo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 18:44:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ABA03D02C;
	Mon,  2 Mar 2015 18:44:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=68cOE1bzu52rCg0pSk395+fCHjE=; b=ArCC1R
	s/82rrbG4WPyC9DqtwmWu3dDKbW8bQIv83D6+RQyRuIdee4HSuSTv9N9KDIE+XPI
	euAaev0G7tWI5XuyQVjaOcOfS/uteyiKI6S2jwDlwjyhjQPsU2skkAHWplBdaCx7
	bOoUEoZiDIjsA7ocsaUavyh6QUIOk7eGzveSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JK/rd+/4FlM7CHmshHmukI+RM4AVajPv
	JNuXdbOoyejX37jnR2++rut61SXEjw2OxXsCl1SkokgDWoZuovYc3eU/BZ8IZF3U
	ofmxDqJa9kK/KqEcgg8LY4ehVr3na0z+daStXF5QMSNOLdSyv683Z+0VuTFVRgN8
	HV7DPEat1mM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 822ED3D02B;
	Mon,  2 Mar 2015 18:44:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E6713D027;
	Mon,  2 Mar 2015 18:44:57 -0500 (EST)
In-Reply-To: <CACsJy8C3=f=esBrHE8OudSa0nUbCrLaYJtLC2in3p+tcc-d9bw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 3 Mar 2015 06:20:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2258FB1A-C136-11E4-AEF8-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264636>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 3, 2015 at 1:12 AM, Joey Hess <id@joeyh.name> wrote:
>> I support this proposal, as someone who no longer releases tarballs
>> of my software, when I can possibly avoid it. I have worried about
>> signed tags / commits only being a SHA1 break away from useless.
>>
>> As to the implementation, checksumming the collection of raw objects is
>> certainly superior to tar. Colin had suggested sorting the objects by
>> checksum, but I don't think that is necessary. Just stream the commit
>> object, then its tree object, followed by the content of each object
>> listed in the tree, recursing into subtrees as necessary. That will be a
>> stable stream for a given commit, or tree.
>
> It could be simplified a bit by using ls-tree -r (so you basically
> have a single big tree). Then hash commit, ls-tree -r output and all
> blobs pointed by ls-tree in listed order.

What problem are you trying to solve here, though, by deliberately
deviating what Git internally used to store these objects?  If it is
OK to ignore the tree boundary, then you probably do not even need
trees in this secondary hash for validation in the first place.

For example, you can hash a stream:

    <commit object contents> +
    N * (<pathname> + NUL + <blob object contents>)

as long as the <pathname>s are sorted in a predictable order (like
in "the index order") in the output.  That would be even simpler (I
am not saying it is necessarily better, and by inference neither is
your "simplification").

I was about to suggest another alternative.

    Pretend as if Git internally used SHA-512 (or whatever hash you
    want to use) instead of SHA-1, compute the object names that
    way.  Recompute the contents of a tree object is by replacing
    the 20-byte SHA-1 field in it with a field with whatever
    necessary length to hold the longer object names of elements in
    the tree.

But then a realization hit me: what new value will be placed in the
"parent " field in the commit object?  You cannot have SHA-512
variant of commit object name without recomputing the whole history.

Now, if the final objective is to replace signature of tarballs,
does it matter to cover the commit object, or is it sufficient to
cover the tree contents?

Among the ideas raised so far, I like what Joey suggested, combined
with "each should have '<type> <length>NUL' header" from Sam Vilain
the best.  That is, hash the stream:

    "commit <length>" NUL + <commit object contents> +
    "tree <length>" NUL + <top level tree contents> +
    ... list the entries in the order you would find by
    ... some defined traversal order people can agree on.

with whatever the preferred strong hash function of the age.
