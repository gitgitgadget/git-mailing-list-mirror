From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Mon, 25 Mar 2013 22:23:13 -0700
Message-ID: <7vhajyviny.fsf@alter.siamese.dyndns.org>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org>
 <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
 <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de>
 <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com>
 <513B7D08.20406@web.de>
 <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
 <514782D3.5060200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 06:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKMMR-0005LO-9V
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 06:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933822Ab3CZFXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 01:23:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933505Ab3CZFXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 01:23:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D849ECE;
	Tue, 26 Mar 2013 01:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vTAwwIFJBtL4crTG8mrJ5/VhL6A=; b=Sr9254
	hymcdyIZuS7jQLzINcW8yWrE3ZWoRDL/y4pT8xkq1PaX+cEHjwfPIz/0BBpocTo4
	RUJeB9y6lygy41zPz/mq+auaw9UEZ392K0SoGoW5CLiumRcc9f+9GFCTc/EmJijc
	YPUmuEpOA65W1P+BcuDeXAm3IqtsF4tD7FHs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IeAdQ8uH9UEEeVU15wjQfnzT42dHJ1Ow
	1LZbQvaDOntX8dqnHMqZy8zYe9znbesGtifA2JcO0rym/SddaFblL+L8JsL+Ur6/
	Eyw8V32/r2MLAR2yQmxDMSTAoCG0U1aj3iH9QAyNyuRBMO3DP7MTKlYbSPH5tNjT
	zLh0g0n8Fkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269E49ECD;
	Tue, 26 Mar 2013 01:23:16 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 578929EC8; Tue, 26 Mar 2013
 01:23:15 -0400 (EDT)
In-Reply-To: <514782D3.5060200@web.de> (Jens Lehmann's message of "Mon, 18
 Mar 2013 22:10:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42ABE78A-95D5-11E2-A2A9-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219134>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 12.03.2013 17:01, schrieb Phil Hord:
>> On Sat, Mar 9, 2013 at 1:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 05.03.2013 22:17, schrieb Phil Hord:
>>>> On Tue, Mar 5, 2013 at 3:51 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>>> Am 05.03.2013 19:34, schrieb Junio C Hamano:
>>>>>> Eric Cousineau <eacousineau@gmail.com> writes:
>>>>>>> ...
>>>>>> I am not entirely convinced we would want --include-super in the
>>>>>> first place, though.  It does not belong to "submodule foreach";
>>>>>> it is doing something _outside_ the submoudules.
>>>>>
>>>>> I totally agree with that. First, adding --include-super does not
>>>>> belong into the --post-order patch at all, as that is a different
>>>>> topic (even though it belongs to the same use case Eric has). Also
>>>>> the reason why we are thinking about adding the --post-order option
>>>>> IMO cuts the other way for --include-super: It is so easy to do
>>>>> that yourself I'm not convinced we should add an extra option to
>>>>> foreach for that, especially as it has nothing to do with submodules.
>>>>> So I think we should just drop --include-super.

FWIW, after thinking about it a bit more and especially after
thinking about the nested submodule layout, I changed my mind.

The reasoning is very simple.  In short, your "top-level" may be
somebody else's submodule.

If you have a project A, that has a submodule B & C that in turn
have submodules D, E & F, G, like this:

	        A
               / \
              B   C
             / \ / \
            D  E F  G

you may want your "submodule foreach [--post-order]" that is run at
the top-level to visit B D E C F G (or D E B F G C).  A is not a
submodule, and it may be rational to do without --also-toplevel
option from the point of view of yourself.

But if "submodule foreach [--post-order] B" run at the top-level
visits B D E (or D E B), wouldn't it be more natural if you had a
way to optionally make this

	cd B && submodule foreach [--post-order]

visit the same modules in the same way?  The story is the same if
your top-level project A is bound at a path in somebody else's
project as a submodule.  His "submodulle foreach" will visit your
top-level A while visiting the hierarchy of your submodules (and
other submodules he has as your siblings).

I do not know if foreach should visit your top-level by default;
changing that may be too late and too disruptive.  But I think an
optional "I want this traversal to also visit the top" would not be
so _wrong_ even at the conceptual level.

Of course, it may make the implementation simpler, too ;-)  foreach
could just scan the immediate submodules, chdir into each of them
and then run the equivalent foreach with --also-toplevel option,
with the same --post-order (or --pre-order) option.
