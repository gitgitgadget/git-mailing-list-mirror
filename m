From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archiving only branch work
Date: Fri, 14 Nov 2014 12:35:22 -0800
Message-ID: <xmqq7fyx34hh.fsf@gitster.dls.corp.google.com>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
	<20141113133615.GA28346@lanh> <20141113200640.GB3869@peff.net>
	<xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
	<20141113213318.GA7563@peff.net>
	<xmqqa93uzssv.fsf@gitster.dls.corp.google.com>
	<20141113213937.GD7563@peff.net>
	<xmqq61eizs9v.fsf@gitster.dls.corp.google.com>
	<20141114153222.GA23077@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:35:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpNae-0002jG-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161898AbaKNUf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:35:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161895AbaKNUf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:35:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C6171E65C;
	Fri, 14 Nov 2014 15:35:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ar0U7dOKn+njsnmZVzmlFhpehak=; b=lxgOl2
	5BrZ65LBR5l4G98ECaZ+58A5gqtEJYmFw4UzO5/gVue6J6PR8Pq3SIJ7n8UAPXHh
	rIyNpG+PoatpWvQmHD+ZSc82AkJiNP5Kn7WrCh9fKakGYc4oCv+dwA9NzG8ace4Y
	83Pyfo3sZI8LFcajwtYaM5/9ySfkbYyGwVmPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sG7RNsnMuUXWRj+xRdsRl2QYajKzwHMw
	nzhhyYDUXMQnKWtJ8u2gYk1GZ1KQC3QYmPuVeKwFmUqECv165Fi+VDsFsZrWySFV
	pi7nWvPlJOFtf4QKbIot1HkviJbK9kO3bQUVsWrdakvLucpLZn0+3h8xXBZ7hzbu
	oFMBo2b9bUk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 337781E659;
	Fri, 14 Nov 2014 15:35:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B53261E657;
	Fri, 14 Nov 2014 15:35:24 -0500 (EST)
In-Reply-To: <20141114153222.GA23077@peff.net> (Jeff King's message of "Fri,
	14 Nov 2014 10:32:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2F3EFEC-6C3D-11E4-A6FA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 13, 2014 at 01:48:12PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I agree they are technically orthogonal, but I cannot think of a case
>> > where I have ever generated actual _pathspecs_, which might have
>> > wildcards, and needed to use "-z". The point of using "-z" is that you
>> > do not know what crap you are feeding.
>> 
>> You do not have to generate, i.e. you should be allowed to do this:
>> 
>>     $ git cmd --stdin -z <list-of-patterns
>
> Right. My point is that I am not sure anybody ever really _wants_ to do
> this, versus:
>
>   git cmd -- "$pattern1" "$pattern2"
>
> Because patterns tend to be small in number and made with predictable
> characters known to the script writer. It is sets of arbitrary filenames
> that tend to be long and contain random junk.

Perhaps "<filename" may have what made it confusing, as it made it
look as if the script writer has control over it (e.g. configuration
file).  The point actually was that the script invoking --stdin may
not even _know_ the number or the nature of patterns (e.g. end user
input).  Imagine a back-end that receives an RPC request from a
gitweb like front-end that lets you pick a tree and a set of
optional pathspecs, and continue below.

>> And this is not about "flexibility".  Unless your plan is to forbid
>> a corner case you do not anticipate and always disable pathspec
>> globbing, you would need to say something like:
>
> I had just assumed we would forbid,

That design is perfectly fine by me, actually.

I somehow hoped that "--stdin" is (uniformly across subcommands) a
mechanism to let us throw the remainder of what we would have liked
to place on the command line at the command but we couldn't
(e.g. because we feared that too many of them might overflow the
command line length limit) from the standard input stream instead.
As long as you are feeding pathspecs, we should uniformly treat them
as pathspecs no matter where they come from, either from the command
line or the standard input stream.  Special casing "--stdin" with or
without "-z" did not make sense to me in that mindset.

But existing use of "--stdin" is not necessarily "you can feed what
you would otherwise place on command line".  "hash-object --stdin"
is not about reading the name of path that contains the data to be
hashed (the option is "--stdin-path" there).  "update-index --stdin"
is sort of like that but different, in that the underlying command
does not take pathspec in the first place and it takes a "list of
paths" the same way from it takes them from the command line, which
makes it a bad comparison.

So I think "git archive --stdin [-z]" that takes list of paths, not
pathspec, is perfectly fine.  
