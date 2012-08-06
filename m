From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Mon, 06 Aug 2012 10:46:14 -0700
Message-ID: <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 19:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyRNp-0006W4-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 19:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab2HFRqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 13:46:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab2HFRqR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2012 13:46:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20BE37121;
	Mon,  6 Aug 2012 13:46:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9iPFfn9DCD9X
	L1S6GTS9M02elWg=; b=Ny+6VyjY0gQU07xJpadHkDw3O5fCxQ6Fv0QeqRoGhiok
	Io3ahlsGvCi+O0ui+5KkdoL5YTeUAkRIgUhikzqiLuPn3OmUb9WTfatve6NrMZiR
	Ut/HiUeqeBMf52PUv67rqDyzXKPIzLOEJnoO71S0Q2FNnnXziljrJY6mkko6eUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=imy/ij
	fRqGHgh6NDAdF4/ro7ez/cHWsJkeLicyUZWdp+63Qfil4lulLgbL47rwbwYJEro8
	R5e2lfduDfUZOj4/aGQTb+lY2rFFQG0JrqA7vep0YlyjmOoxQA40Dt2uh+0yER1J
	40I124YM9lfNEtw3F3OoGit1WkpQDjYNhA1Qk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0987120;
	Mon,  6 Aug 2012 13:46:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 536A3711D; Mon,  6 Aug 2012
 13:46:16 -0400 (EDT)
In-Reply-To: <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Aug
 2012 21:35:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F2EAFB2-DFEE-11E1-B596-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202973>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> These mails are about cosmetics only. But I think it helps maintenanc=
e
> in long term. I notice in your series we have many functions with _v2
> and _v5 mixed together. Worse, some functions that are _v2 only are
> not suffixed with _v2. I still think separating v2/v5 changes is a
> good idea. So I played a bit, see how it might become.
>
> The next two emails demonstrate how we take v2-specific code out to
> read-cache-v2.c, then add v5 code in the next patch. Notice there's v=
ery
> little change in read-cache.c in the second patch. I wanted to see ho=
w
> v5 changes affects v2 users and the second patch shows it.
>
> I'm not happy with the first patch either. Ideally it should consist
> of code move only, no other changes. All updates in read_index_from
> and the introduction of struct index_ops should happen in patches
> before that.

Right.

> Then of course you need to split the second patch into several logica=
l
> patches again. We can drop _v5 suffix in read-cache-v5.c (I haven't
> done that). When we add partial read/write for v5, we can add more
> func pointers to index_ops and implement them in v2 (probably as no-o=
p
> or assertion)

The index_ops abstraction is a right way to go, and I like it, but I
think the split illustrated in this patch might turn out to be at
wrong levels (and it is OK, as I understand this is a illustration
of concept patch).

=46or example, add_to_index() interface may be a good candidate to
have in index_ops.  Because your in-core index may not be holding
everything in a flat array, "find the location in the flat array the
entry would sit, replace the existing one if there is any, otherwise
insert" cannot be a generic way to add a new entry.  If you make the
whole thing an abstract API entry point, a sparse implementation of
the in-core index could still implement it without bringing the
untouched and irrelevant parts of the index to core.

        Side note: with a tree-like implementation of the in-core
        index, "find the location the entry would sit", "get the
        entry at the location", "insert the entry at the location",
        could still be a set of good abstract API, though.  The
        definition of _location_ may be quite different from "the
        offset of the entry counting from the beginning of a flat
        array", which is what index_name_pos() returns.

The story is the same on the removal front.  The current
remove_index_entry_at() interface is tied to the flat array
implementation, so "remove the nth entry from the beginning" is an
inappropriate interface for anything but such an implementation
(unless we come up with an abstract notion of the "location" that is
usable efficiently in a tree-like implementation, that is).

I wish that the development of this topic was done more in a
top-down direction, instead of bottom-up, so that it identified the
necessary access patterns to the in-core index early and come up
with a good set of abstract API first, and then only after that is
done, came up with in-core and on-disk format to support the
necessary operations.
