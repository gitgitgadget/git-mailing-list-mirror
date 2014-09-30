From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Tue, 30 Sep 2014 10:39:13 -0700
Message-ID: <xmqqsij9rose.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>
	<xmqqlhp68c69.fsf@gitster.dls.corp.google.com>
	<542A8B90.50507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 30 19:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ1OZ-0006Ut-8W
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbaI3RjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 13:39:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55501 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbaI3RjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 13:39:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D20EE3F327;
	Tue, 30 Sep 2014 13:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OxFtUxfhxg8T+ej+4g5f6D/gis4=; b=esvqTY
	pMfiOq4xfG1zElaXr+npeX/TEspmNvWjL7D/b+ihYjpdoILPiea4qJGtsaBFTPJf
	5dQNZQ2ethiQNoThsgOnCERcrVc0gvnIfM13gLcJVMf9WB38KgthEJzy0SRVV6Yz
	BzhTH0Uy1JBtP4rMoqFdrujxKndBjNFY3G6A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZhwmP2C/8JFrCTLrmiJURFtOlomJ44Pe
	QwTsHeP7I6xEuRni0im/pfHwCLMHE9I8C5T1YoaXjoOaoOGuarU5FYl5GPPuE5J/
	4oUxFLXdGbQy+qEGzagdPOZtptvWSatQt8LNkvfGvmVrHr+ucoINSqoa1TLLj67m
	WBEW5d21X9k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C55393F325;
	Tue, 30 Sep 2014 13:39:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 21FD03F324;
	Tue, 30 Sep 2014 13:39:15 -0400 (EDT)
In-Reply-To: <542A8B90.50507@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 30 Sep 2014 12:53:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B26E63CA-48C8-11E4-8CA4-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257674>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I was being repetitive because I didn't want the docs to depend on the
> user remembering what the "bss" section is (which, technically, is also
> not part of the C standard). I think a better way would be to just not
> mention "bss section" at all and reword the rest. Maybe something like
>
>   The caller:
>
>   * Allocates a variable `struct lock_file lock`, initialized to zeros.
>     Because the `lock_file` structure is used in an `atexit(3)` handler,
>     its storage has to remain valid throughout the life of the program;
>     e.g., it should be a static variable or space allocated on the heap.
>
> Better?

Somewhat.  I like that you droped "BSS", though.

	Allocates a 'struct lock_file' either as a static variable
	or on the heap, initialized to zeros.  Once you use the
	structure to call hold_lock_file_* family of functions, it
	belongs to the lockfile subsystem and its storage must
	remain valid throughout the life of the program (i.e. you
	cannot use an on-stack variable to hold this structure).

>> It feels a bit conflicting between "must not be freed or ALTERED"
>> and "it may be REUSED".  Drop "or altered" to reduce confusion?  And
>> this repeats the third sentence I suggested to remove from the first
>> paragraph (above 'see below' refers here).
>
> The purpose of "or altered" is to make sure that users don't imagine
> that they should memset() the structure to zeros or something before
> reusing it (especially since the "caller" instructions earlier say that
> the object should be "initialized to zeros").
>
> Would it help if I change
>
>     s/altered/altered by the caller/
>
> ?

The fundamental rule is that callers outside the lockfile system must
not touch individual members of "struct lock_file" that is "live".
They must not free, they must not alter, they must not do anything
other than calling the lockfile API functions.

While it is natural that the readers would understand such a rule
must be followed for a lockfile that is in either the initialized,
locked, closed-but-not-committed state, I agree that it is not just
possible but likely that people misunderstand and think that once a
lockfile is committed or rolled back it no longer has to follow that
rule.  We would want to make sure readers do not fall into such a
misunderstanding.

I dunno.  Your "if you memset it to NULs, you will break the linked
list of the lock and the whole lockfile system and the element
cannot even be reused." may be the most important thing you may have
wanted to say, but it is not conveyed by that change at all, at
least to me.

A small voice in the back of my skull keeps telling me that a rule
that is hard to document and explain is a rule that does not make
sense.  Is it possible to allow commit and rollback to safely remove
the structure from the atexit(3) list (aka "no longer owned by the
lockfile subsystem")?

>> Is it allowed to tell the name of this lock_file to other people and
>> let them read from it?  The answer is yes but it is not obvious from
>> this description.
>> 
>> Also mention how the above interact with reopen_lock_file() here?
>
> I'll take a stab at it, though TBH I haven't really studied the use case
> for reopen_lock_file(). You might be better able to provide insight into
> this topic.

You would want to be able to do this:

 - hold a lock on a file (say, the index);

 - update it in preparation to commit it;

 - write it out and make sure the contents is on the disk platter,
   in preparation to call another program and allow it (and nobody
   else) to inspect the contents you wrote, while still holding the
   lock yourself.  In our set of API functions, close_lock_file is
   what lets us do this.

 - further update it, write it out and commit.  We need to read it
   first, open(2) it to write, write(2), and commit_lock_file().

The set of API functions you described in the document, there is no
way to say "I already have a lock on that file, just let me open(2)
for writing because I have further updates" and that is where reopen
comes in.
