From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Wed, 03 Aug 2011 11:12:44 -0700
Message-ID: <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qofw5-00043E-RH
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab1HCSMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:12:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147Ab1HCSMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:12:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33C905C8A;
	Wed,  3 Aug 2011 14:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dTGKeQY4ugCtWasZzHdQq3w/I8o=; b=s5AueU
	zGGlbzOmySrpRGuGBrhWCRG/psDO3IzZRDhnmkrkYaSmETBIJJPBEL1I6bjDYsyV
	zLv5iM6LmktDHI8SoP3OYgS1MdU/2nqGLg96SzCiVjCSaJM3yjnToyD8SxNmWFIc
	hK9ZwiMPG+txc9us5etBBimyLBlRD4uEqv4TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HatXynAA6c7vThNclfsQi9vIyLDGCG2n
	+gnqWUw4GH4JxOZ5bJX/nXn8mgJgHIqcytVLFPmYalfJzLJxFf7u1S356WkytqAV
	IFUiQ9fHlDGykm1GSzM3nBJDD07vNG+E2n0kf7yyX8eGnHNZqc3Rxlicq6fJkD/7
	IW1hFksIKIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2972F5C89;
	Wed,  3 Aug 2011 14:12:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 702805C88; Wed,  3 Aug 2011
 14:12:46 -0400 (EDT)
In-Reply-To: <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 3 Aug 2011 15:52:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 308C3238-BDFC-11E0-BC19-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178604>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Jul 24, 2011 at 21:23, Junio C Hamano <gitster@pobox.com> wrote:
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>
>>>  void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
>>>  {
>>> -     add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
>>> +     add_pending_object_with_mode(revs, obj, name, S_IFINVALID, 0);
>>>  }
>>
>> This seems utterly broken.  For example, fmt-merge-msg.c adds "^HEAD" and
>> of course the flags on the object is UNINTERESTING. Has all the callers of
>> add_pending_object() been verified? Why is it passing an unconditional 0
>> and not !!(obj->flags & UNINTERESTING) or something?
>
> If I understand correctly (and it's not unlikely that I don't), the
> 'flags' field is used to store the actual flags (not just a boolean).
> Would the following be appropriate?
>
> +     add_pending_object_with_mode(revs, obj, name, S_IFINVALID, obj->flags);

I would think that the information you are trying to convey is more in
line with the spirit of "name" field, not "mode". Originally, the pending
object array was to only collect the given arguments at the object level
with "is this interesting or uninteresting?" flag and nothing more, but we
later wanted to have richer information to deduce what the user wanted
from how the user gave the object information to us (i.e. "not just the
tree object named by the object name, but I meant the object at this
path"), primarily to give a better error message.

Let's clarify what I hinted as "some parsed representation of how the revs
were specified" in an earlier message with a concrete example. There is a
code block at the end of builtin/diff.c that says something like:

	If we have more than 2 tree-ishes, and the first one is marked as
	UNINTERESTING, it must have come from "diff A...B". In this case,
	we know ent[0] is one of the merge-bases, ent[ents-2] is A, and
	ent[ents-1] is B, so turn it into "diff ent[0] B".

These entries in ent[] come from the pending objects array, and because
the revision machinery loses information regarding how the command line
arguments were spelled, we have to play such games to _guess_ what the
user meant to say. This will lead to "diff ^C A B" running "diff C B",
instead of barfing with "What are you talking about???", which should
happen instead.

Wouldn't it be wonderful if the revision machinery left richer clue in
each element of the pending object array while parsing, so that the caller
does not have to guess?  For example, suppose that it parsed "A...B" into
this N element array of pending objects:

	^MB0 (the first merge base of A and B)
	^MB1 (the second merge base of A and B)
        ...
	A
	B

In addition to a single "mode" integer, which says if it is supposed to be
a tree or a blob, we could allocate a single structure that records
something like this:

	struct parsed_rev {
                enum {
			SHA1, REF, RANGE, SYMMETRIC_RANGE, REFLOG_ENT, ...
                        // there are others like OBJ^!, OBJ@!, ...
                } kind;
                const char *string;
                union {
			struct {
				const char *real_ref;
			} ref;
			struct {
				struct parsed_rev *bottom;
				struct parsed_rev *top;
                        } range;
			...
                } u;
	};

And then all the elements in the pending object array resulting from
parsing "maint...master" would all point at a single instance of this
"struct parsed_rev" that may read like this:

	{
        	.kind = SYMMETRIC_RANGE;
		.string = "maint...master";
                .u.range = {
                	.bottom = {
                        	.kind = REF;
                                .string = "maint";
                		.u.ref.real_ref = "refs/heads/maint";
			};
                	.top = {
                        	.kind = REF;
                                .string = "master";
                		.u.ref.real_ref = "refs/heads/master";
			};
		};
	};

In a similar fashion, if you wanted to make sure that you do not discard
"master" as totally uninteresting, even though the end user gave you a
list of arguments that ends up marking the commit object "master" as
uninteresting, e.g. "master^0..master", you could do so if we updated the
revision parsing machinery so that the resulting two elements in the
pending array would both point at (in addition to the "uninteresting
commit object 'master^0'") a structure that would look like this:

	{
        	.kind = RANGE;
                .string = "master^0..master";
                .u.range = {
			...
                        .top = {
				.kind = REF;
                                .string = "master";
                		.u.ref.real_ref = "refs/heads/master";
			};
		};
	};

And by looking at .u.range.top, you know that the user meant to do
something to the "master" branch.
