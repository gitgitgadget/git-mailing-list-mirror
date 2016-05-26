From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/2] Submodule shallow recommendation [WAS: Submodules: have a depth field in the .gitmodules file]
Date: Thu, 26 May 2016 12:16:15 -0700
Message-ID: <xmqqoa7svdds.fsf@gitster.mtv.corp.google.com>
References: <20160526000633.27223-1-sbeller@google.com>
	<xmqq1t4owuue.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKSC-vdUXg0uzb_u022TNVY-JHXuXLAc2LOT7OvpYckQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 21:16:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b60lc-0004SI-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 21:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbcEZTQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 15:16:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754728AbcEZTQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 15:16:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C4DF1D7E4;
	Thu, 26 May 2016 15:16:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1pfweCxVF0YizvnczIDBZDqqr9Y=; b=oEz7yH
	Cw0zZ2wNCst6bJLQmG6NtmLEpu6h1p4aYZhiPag6ufmUqV4wTuh6JIplf91Abpv6
	RPUhLXvGvtIJBqCxqOGfu/kT18tmtcLSbJBQMTjqyNNWZryggp5tPkEuXE4w0rWg
	ypJ+RYhryR6EiB80r6En4gtKrlsC4vw/c8b0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ys7yCQLSdnarswwc7NM9hDewxjh7imcQ
	zxv/8oldD9a5Fb49vKSI+LR3SFwwrES2NxyLjVv1OW93k8rOLJj+IBp5QKGD1d6r
	+B3EKm1YmfwH67qf1ieyUpX2OdvX/JoXaNdSCY6XNuYmurQ7le7AT8lmu0ZXGFYv
	UgdebgyIr88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 84A461D7E1;
	Thu, 26 May 2016 15:16:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 057911D7E0;
	Thu, 26 May 2016 15:16:17 -0400 (EDT)
In-Reply-To: <CAGZ79kZKSC-vdUXg0uzb_u022TNVY-JHXuXLAc2LOT7OvpYckQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 26 May 2016 11:54:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 529AB2AC-2376-11E6-AE38-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295686>

Stefan Beller <sbeller@google.com> writes:

> On Thu, May 26, 2016 at 11:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Sometimes the history of a submodule is not considered important by
>>> the projects upstream. To make it easier for downstream users, allow
>>> a field 'submodule.<name>.depth' in .gitmodules, which can be used
>>> to indicate the recommended depth.
>>
>> I have a design-level question.
>>
>> If your project consists of 600 submodules, among which 40 of them
>> you would recommend making a shallow clone, are there traits, other
>> than "most people would not care about its history", that are shared
>> across these 40 subprojects?
>
> From my understanding these 40 subprojects are a large file storage
> done different than Git LFS. In the repo world this was choosen to be
> a separate repository, such that you had versioning available as the
> large files change a few times (like a precompiled kernel for special
> hardware, etc). And this is one of the missing pieces to translate the
> current repo-tool workflow to submodules.

I am not questioning the value of being able to say "this and that
submodule need only a shallow copy".  I am trying to see
"individually mark each and every such submodules" should be the
primary interface to do so.

> So you are proposing another layer of indirection, i.e. instead of giving
> a pathspec with ":(attr:label-framework)" we would want to give a profile
> which then has the pathspec plus additional information on shallowness
> an such.

I do not understand what you mean by "instead of giving a pathspec"
at all.

When you have 40 submodules, with your design the user has to
sprinkle 40 lines of

	shallow = true

for each of [submodule "$n"] sections.  If there are other traits
(see my first question) that are similar, they will have some other
setting next to the "shallow = true" 40 times.  When a new submodule
is added to that same class, they will again have to add these two
lines.

I was wondering if a level of indirection that lets you say
"submodules in this group all share 'shallow=true' (by default)"
would improve that cumbersomeness.  When you add another similar
trait, you add that just once, not 40 times.  When you add another
submodule, you say "this submodule is also in that group", without
mentioning "shallow".

We probably _need_ shallow=true at individual module level, if only
to override the default given by such an indirection scheme.  So
don't take the message you are responding to as "no, your design is
not good, scrap it, and here is a better one".  It is more like "It
would be a good first step, but have you considered where it will
eventually lead us to?  Would the more complete future look like
this, and how well would this first step fit in that world?  Would
it be a good escape hatch, or would it have to be deprecated?"

> And you reinvented submodule groups. ;)
> IIRC we had a discussion if we want to have the submodule groups
> stored at each submodule or at a central "profile/group" setting.

As I said, it was not my intention to get into that; I am not
interested in the exact syntax, and I am not interested whether the
pointer goes from group to individual modules (i.e. [group "bar"]
says "foo" is one of its member modules), or individual modules have
pointers to groups (i.e. "module [foo]" declares its membership in
group "bar") at all.  I really do not care.

What matters in my suggestion was, after you established that group
"bar" exists, you can do:

	[profile "framework"]
        	shallow = "some notation that refers to group bar"

so that you do not have to repeat "shallow = true" many times per
submodule.

By the way, I do not see the "profile" as about "submodules" or
"submodule groups".  It is more about "Who am I?  What am I working
on?  Give me an appropriate set of settings for the 600 submodules
you have, with the knowledge that I am a framework person".

grouping submodules would merely be one mechanism to help specify
that.
