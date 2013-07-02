From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] contrib: add git-contacts helper
Date: Tue, 02 Jul 2013 11:32:48 -0700
Message-ID: <7vk3l895in.fsf@alter.siamese.dyndns.org>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-2-git-send-email-sunshine@sunshineco.com>
	<7vbo6mgm5e.fsf@alter.siamese.dyndns.org>
	<CAPig+cRbBGqrXj-Anib1ESdBBbdUGM-9um4XoPcwG2QxJBubuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 20:32:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5Nn-0000ZY-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 20:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab3GBScw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 14:32:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab3GBScu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 14:32:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 563042BC99;
	Tue,  2 Jul 2013 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JHEBLba+uxR4LEAhcpcQ89KpLDc=; b=oHwnXz
	y/BoVqhbfO7jOZrRjSlKCpoUnLTK6dWYB222+ua8TllNFmgSoLIWlyUtqVHmkQjA
	vvLTdi6wp/5EaVbee8s1+wxWoGlVpxaDP9OuCjTUtg8yk2/ctNUqJ+OBEMrlMbG8
	pzdMPH/w/EfFTK7UeInLTin91fqtfr7IH/T5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sozVwf/AlPtiDgGOuXqY6qvzhoa/Tz2j
	hOUA55XJjt06xhdo3LS0h23utiphg3V0CTrMmal17Wz1snnit63iG9gYM8wRdYIi
	YyXdUP1igx6mYT8umQ3ldRgpW4ZWXHo38hAHQoqSwXvN/lqwLv5fNpk+daMQKN9U
	SnBtp4g1/Cc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7D42BC98;
	Tue,  2 Jul 2013 18:32:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2D1D2BC94;
	Tue,  2 Jul 2013 18:32:49 +0000 (UTC)
In-Reply-To: <CAPig+cRbBGqrXj-Anib1ESdBBbdUGM-9um4XoPcwG2QxJBubuA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 2 Jul 2013 04:17:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC71316A-E345-11E2-9F9C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229414>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> The author name and email can be grabbed from the "blame" output
>> without doing this (and the result may be more robust), but you
>> would need to read from the log message anyway, so I think this is
>> OK.
>>
>> Note that the names and emails in blame output are sanitized via the
>> mailmap mechanism, but "cat-file commit" will certainly not be.
>
> Thanks for pointing this out. Grabbing the author name and email from
> git-blame output does seem like a better approach.

Well, that was not what I was suggesting.  Reading from blame output
will map only the author/committer names/addresses, and you have two
choices:

 (1) if you read author/committer from blame output and other names
     from the commit object without applying mailmap, the same
     person can appear under different names, from his authorship
     (mapped name) and from his name on footers (unmapped), which
     would be inconsistent.  By reading from "author" and
     "committer" header lines in the commit object, you will be at
     least consistently using unmapped names.

 (2) if you want to apply mailmap to names you collect by reading
     the footer, you will write the mapping logic yourself anyway,
     and at that point, passing the names you collect by reading the
     "author" and "committer" header lines in the commit object to
     the same logic will give you mapped names. At that point, you
     do not gain much by reading names from the blame output.

So in either case, you would be better off not reading the
author/committer from blame output, as long as you need to pick up
other names from the commit object payload.

>>> +sub import_commits {
>>> +     my ($commits) = @_;
>>> +     return unless %$commits;
>>> +     my $pid = open2 my $reader, my $writer, qw(git cat-file --batch);
>>
>> Hmph.
>>
>> I vaguely recall that people wanted not to use open2/IPC::Open2 in
>> other parts of the system.
>>
>> I think "cat-file --batch" is designed to behave on a regular bidi
>> pipe, as long as the caller strictly does a ping-pong of issuing one
>> request, flush (with an empty line) and always read the response, so
>> if open2 becomes problematic, we could switch to regular pipes.
>
> Checking the log, I see several cases where deprecated Python popen2
> was removed but find nothing mentioning Perl. Git.pm,
> git-archimport.perl and git-cvsimport.perl appear to use open2.

OK, then I was misremembering.  Thanks for sanity checking.

> ... Extending git-blame to recognize
> multiple -L sounds even better, though definitely outside the scope of
> this series.

Yes.  I might be able to find some time to do that myself later this
week, but no promises ;-).
