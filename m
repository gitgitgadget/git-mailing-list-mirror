From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support pathspec magic :(exclude) and its short form :-
Date: Thu, 21 Nov 2013 10:43:24 -0800
Message-ID: <xmqqpppt4mur.fsf@gitster.dls.corp.google.com>
References: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
	<1384911691-11664-1-git-send-email-pclouds@gmail.com>
	<xmqqhab663ef.fsf@gitster.dls.corp.google.com>
	<CACsJy8AeL+EVZme3BPocXDfRqPpqKDA8nCuwx3buiS66L7G4fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 19:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjZE0-0000Ep-7n
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 19:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab3KUSnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 13:43:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab3KUSn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 13:43:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 135775204E;
	Thu, 21 Nov 2013 13:43:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqfqwYWqpB3+uX4SlBWlbWcbTrA=; b=lZXgUH
	K3TIdwE9P5kGxNo7VBe7YMqAPxJs2xy8Lb9xONFqtYZRldXVVj+/S0aNVp1X2Kec
	6qgnabvQzcsNoqoOC+trikff5ajw+Ab89ZeSqYEhqkw4QxWQwLlh77y5JpigFAIo
	rlJwzu9F/j/n68ccBBYHj7AMW1mAT2YUbBAxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EMmqPSLD0cg4oScuXtwDDTPtei26E3xb
	LWHGk0Jsf5aFZ3IDuscWqucdzwLB7+v1ikQZoN14Ol6R+vCUvFrBN1uY2xOrNOMf
	IkVThetbDL7L688big2LLY37/rIjIeGop89FYToxvGdA4sEcbWdJyaXA4l8BWU1o
	DEvyUFkJgSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0148E5204D;
	Thu, 21 Nov 2013 13:43:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE245204B;
	Thu, 21 Nov 2013 13:43:27 -0500 (EST)
In-Reply-To: <CACsJy8AeL+EVZme3BPocXDfRqPpqKDA8nCuwx3buiS66L7G4fA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 21 Nov 2013 09:10:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF2D1E44-52DC-11E3-B86C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238133>

Duy Nguyen <pclouds@gmail.com> writes:

> Btw I'm thinking of extending pathspec magic syntax a bit to allow
> path completion. Right now the user has to write
>
> git log -- :-Documentation
>
> which does not play well with path completion. I'm thinking of accepting
>
> git log -- :- Documentation

Please don't.  That does not help our users, but actively harm them.
They have to stop and wonder why a single pathspec is spelled as two
tokens on the command line of some other people.

Doing that stupidity only to help those who polish the tool (namely,
"bash completion") to be lazy is doubly wrong (in the meantime, the
users can type your second variant and then edit the result).

For the same reason why I do not think rewriting

	echo "hello, world!"

to

	echo "hello, world-"

only to work around a pitfall of a particular tool (namely "bash")
makes any sense, I do not think it makes sense to make _our_ tool
inconsistent by using "!excluded" in the files (and --exclude) and
"-not this pattern" only here.

>>> +     if (nr_exclude == n)
>>> +             die(_("There is nothing to exclude from by :(exclude) patterns.\n"
>>> +                   "Perhaps you forgot to add either ':/' or '.' ?"));
>>
>> ;-).
>
> Hey it was originally not there,...

I am not objecting. I noticed it and was commending on it as "a nice
touch" ;-)

>>> +     /*
>>> +      *   #  | positive | negative | result
>>> +      * -----+----------+----------+-------
>>> +      * 1..4 |   -1     |    *     |  -1
>>> +      * 5..8 |    0     |    *     |   0
>>> +      *   9  |    1     |   -1     |   1
>>> +      *  10  |    1     |    0     |   1
>>> +      *  11  |    1     |    1     |   0
>>> +      *  12  |    1     |    2     |   0
>>> +      *  13  |    2     |   -1     |   2
>>> +      *  14  |    2     |    0     |   2
>>> +      *  15  |    2     |    1     |   0
>>> +      *  16  |    2     |    2     |  -1
>>> +      */
>>
>> Not sure what this case-table means...
>
> Sorry, because tree_entry_interesting_1() returns more than "match
> or not", we need to combine the result from positive pathspec with
> the negative one to correctly handle all_not_interesting and
> all_interesting. This table sums it up. I'll add more explanation
> in the next patch.

I managed to have guessed what the three columns on the right meant;
I was wondering about the meaning of the "#" column and where it is
defined/explained.
