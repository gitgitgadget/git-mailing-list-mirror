From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Mon, 14 Dec 2015 11:06:49 -0800
Message-ID: <xmqqr3iokfxy.fsf@gitster.mtv.corp.google.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<xmqq1taseh2x.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:07:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YSd-0003Th-3W
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbbLNTGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:06:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932153AbbLNTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:06:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9996931604;
	Mon, 14 Dec 2015 14:06:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JvCir82U9YxAYFrPmBJjLX+NLOM=; b=kOHBtj
	eBBkbZO6/+3Sn+gUci5JlXLYi3H+ox5QBYaIVQQ+UDclS+frxCnBBctjdCLlHzEd
	rAGuDLWuB+GW6XJQE59BoQRw5e2WcMwSLbomexCXDTybDIUxKfIKSchTGlIjK85l
	7DSjsKKtq5q1meFlIJXaozwFnqwGS7ABmTEnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQclz7p8mL8hHGf4qxPjbpofVjhs+5mL
	TMIoB2mEHASgorznEA9gJhJ+s1ARiPfHWIe9J7fWZ0Fbf4w8Vi4fNuwI/CxxisNP
	Vgx3GUyslyyDp0+Bbel1rPAJdAyyiHrqv99bAsxRGFeH6j/wdsWHXYs4V8G5+QAo
	qG+I8vvj3n0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90F6631603;
	Mon, 14 Dec 2015 14:06:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 119F131601;
	Mon, 14 Dec 2015 14:06:50 -0500 (EST)
In-Reply-To: <CAPig+cQtoUXuOZjGjev8MGYUMyjd+n_=o+jOVXkhPReSkWgxmw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 13 Dec 2015 00:40:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4EE03CE-A295-11E5-9686-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282379>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 11, 2015 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>   ref-filter: introduce a parsing function for each atom in valid_atom
>>>   ref-filter: introduce struct used_atom
>>>   ref-fitler: bump match_atom() name to the top
>>>   ref-filter: skip deref specifier in match_atom_name()
>>>   ref-filter: introduce color_atom_parser()
>>>   strbuf: introduce strbuf_split_str_without_term()
>>>   ref-filter: introduce align_atom_parser()
>>>   ref-filter: introduce remote_ref_atom_parser()
>>>   ref-filter: introduce contents_atom_parser()
>>>   ref-filter: introduce objectname_atom_parser()
>>
>> It seems that this series had seen quite a good inputs, mostly from
>> Eric.  I finished reading it over and I didn't find anything more to
>> add.  The patches are mostly good and would be ready once these
>> points raised during the review are addressed, I think
>
> I'm still a bit fuzzy about what this series is trying to achieve. It
> feels like it wants to avoid doing repeated processing of unchanging
> bits of %(foo:bar) atoms for each ref processed, but it only partly
> achieves that goal.

That's very true.

It seems you two already have hashed it out in the downthread, and I
think that is in line with an earlier suggestion by Matthieu to
fully pre-parse in the earlier thread, which was made in response to
(and is much better than) my "let's start with a half-way solution"
in $gmane/279254.

Thanks.

> strcmp()s and starts_with()s in that inner loop, and even the
> unchanging %(color:) argument gets re-evaulated repeatedly, which is
> probably quite expensive.
>
> If the intention is to rid that inner loop of much of the expensive
> processing, then wouldn't we want to introduce an enum of valid atoms
> which is to be a member of 'struct used_atom', and have
> populate_value() switch on the enum value rather than doing all the
> expensive strcmp()s and starts_with()?
>
>     enum atom_type {
>         AT_REFNAME,
>         AT_OBJECTTYPE,
>         ...
>         AT_COLOR,
>         AT_ALIGN
>     };
>
>     static struct used_atom {
>         enum atom_type atom;
>         cmp_type cmp;
>         union {
>             char *color; /* parsed color */
>             struct align align;
>             enum { ... } remote_ref;
>             struct {
>                 enum { ... } portion;
>                 unsigned int nlines;
>             } contents;
>             int short_objname;
>         } u;
>     } *used_atom;
>
> In fact, the 'cmp_type cmp' field can be dropped altogether since it
> can just as easily be looked up when needed by keeping 'enum
> atom_type' and valid_atoms[] in-sync and indexing into valid_atoms[]
> by atom_type:
>
>     struct used_atom *a = ...;
>     cmp_type cmp = valid_atoms[a->atom].cmp_type;
>
> As a bonus, an 'enum atom_type' would resolve the problem of how
> starts_with() is abused in populate_value() for certain cases
> (assuming I'm understanding the logic), such as how matching of
> "color" could incorrectly match some yet-to-be-added atom named
> "colorize".
