From: Junio C Hamano <gitster@pobox.com>
Subject: Re: John (zzz) Doe <john.doe@xz> (Comment)
Date: Tue, 20 Jan 2009 19:12:54 -0800
Message-ID: <7vzlhlic7d.fsf@gitster.siamese.dyndns.org>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
 <20090115194926.GA6899@roro3.zxlink>
 <7vd4eos3rp.fsf@gitster.siamese.dyndns.org>
 <20090116080807.GA10792@landau.phys.spbu.ru>
 <7vd4enacf2.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901161253411.3586@pacific.mpi-cbg.de>
 <20090118145429.GA27522@roro3.zxlink>
 <7vmydoxxcr.fsf_-_@gitster.siamese.dyndns.org>
 <20090120191446.GB5721@roro3.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Wed Jan 21 04:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPTXv-0000Vq-MY
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 04:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbZAUDNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 22:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbZAUDNE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 22:13:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbZAUDNC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 22:13:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46D7E92CF2;
	Tue, 20 Jan 2009 22:13:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5F1992CF1; Tue,
 20 Jan 2009 22:12:56 -0500 (EST)
In-Reply-To: <20090120191446.GB5721@roro3.zxlink> (Kirill Smelkov's message
 of "Tue, 20 Jan 2009 22:14:46 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6927B0FC-E769-11DD-BA01-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106561>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> On Sun, Jan 18, 2009 at 10:50:12AM -0800, Junio C Hamano wrote:
>> So we can separate "John (zzz) Doe <john.doe@xz> (Comment)" into:
>> 
>> 	AUTHOR_EMAIL=john.doe@xz
>>         AUTHOR_NAME="John (zzz) Doe (Comment)"
>> 
>> and leave it like so, I think.
>
> Ok, here you are:
>
> Subject: [PATCH 1/3] mailinfo: cleanup extra spaces for complex 'From'
>
> As described in RFC822 (3.4.3 COMMENTS, and  A.1.4.), comments, as e.g.
>
>     John (zzz) Doe <john.doe@xz> (Comment)
>
> should "NOT [be] included in the destination mailbox"
>
> On the other hand, quoting Junio:
>
>> The above quote from the RFC is irrelevant.  Note that it is only about
>> how you extract the e-mail address, discarding everything else.
>>
>> What mailinfo wants to do is to separate the human-readable name and the
>> e-mail address, and we want to use _both_ results from it.
>>
>> We separate a few example From: lines like this:
>>
>> 	Kirill Smelkov <kirr@smelkov.xz>
>> ==>	AUTHOR_EMAIL="kirr@smelkov.xz" AUTHOR_NAME="Kirill Smelkov"
>>
>> 	kirr@smelkov.xz (Kirill Smelkov)
>> ==>	AUTHOR_EMAIL="kirr@smelkov.xz" AUTHOR_NAME="Kirill Smelkov"
>>
>> Traditionally, the way people spelled their name on From: line has been
>> either one of the above form.  Typically comment form (i.e. the second
>> one) adds the name at the end, while "Name <addr>" form has the name at
>> the front.  But I do not think RFC requires that, primarily because it is
>> all about discarding non-address part to find the e-mail address aka
>> "destination mailbox".  It does not specify how humans should interpret
>> the human readable name and the comment.
>>
>> Now, why is the name not AUTHOR_NAME="(Kirill Smelkov)" in the latter
>> form?
>>
>> It is just common sense transformation.  Otherwise it looks simply ugly,
>> and it is obvious that the parentheses is not part of the name of the
>> person who used "kirr@smelkov.xz (Kirill Smelkov)" on his From: line.
>>
>> So we can separate "John (zzz) Doe <john.doe@xz> (Comment)" into:
>>
>> 	AUTHOR_EMAIL=john.doe@xz
>>         AUTHOR_NAME="John (zzz) Doe (Comment)"
>>
>> and leave it like so, I think.
>
> So let's just correctly remove extra spaces which could be left inside
> name.
>
> We need this functionality to pass all RFC2047 based tests in the next commit.
>
> Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> ---
> ...
> Is it ok?

I think the patch text looks good, but what you have as the proposed
commit log message does not look anything like log message we usually use.

 - If you agree with my comment that "should NOT be included" from the RFC
   you quoted is irrelevant, then I do not think you would even want to
   have anything before "On the other hand,...".

 - If you disagree, then why are you bending the patch text to match what
   I say? ;-)

Also I am not sure "passing RFC2047 based tests" is a valid purpose nor
justification for adding this patch (because you could argue that the
tests and the results the tests expect are faulty).

The way we (and your patches) do thinks is to have the desired outcome
designed first, and then have tests to make sure that the implementation
matches the desired outcome.

Given that, what I would probably suggest would be...

-- 8< -- cut from here -- 8< --

mailinfo: handle comment fields in From: line sanely

Most commonly, people have their human readable name and their e-mail
address on their From: line in one of two formats:

    Kirill Smelkov <kirr@smelkov.xz>
    kirr@smelkov.xz (Kirill Smelkov)

In addition, you can have "Comments" in parentheses at random places, like
this:

    John (zzz) Doe <john.doe@xz> (Comment)

RFC822 defines rules to extract the "destination mailbox" out of such
input (and we correctly extract "kirr@smelkov.xz" and "john.doe@xz" from
these examples).  It however does not specify how to pick up the human
readable name from the remainder, and the existing code randomly dropped
pieces of information in <<<this and that way --- explain the breakage you
wanted to fix with your patch, perhaps "and left a newline in the result"
may be one of the breakages>>>.

This patch changes the rule so that <<<explain what it does here.  I think
what the code does is (1) remove the e-mail (and angle brackets around
it), (2) sanitize LF into a single SP to keep the result a single line,
and (3) as a special case, if the result is enclosed by () pair, remove
them---this rule is to format the second common case listed above
sanely>>>.

A subsequent patch using From: lines taken from the example section of
RFC2047 will test this feature.

-- >8 --
