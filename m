From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Tue, 25 Nov 2014 12:20:10 -0800
Message-ID: <xmqqk32jrq11.fsf@gitster.dls.corp.google.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
	<xmqqbnnwwcg0.fsf@gitster.dls.corp.google.com>
	<CANCZXo7yDJCuhKVFG3QfSSoem+KN_9VCbGerTd+5tqQuzA7dbg@mail.gmail.com>
	<CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
	<xmqqbnnvtbac.fsf@gitster.dls.corp.google.com>
	<CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:20:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtMaz-0001yO-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 21:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbaKYUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 15:20:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751198AbaKYUUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 15:20:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78A1C1E37E;
	Tue, 25 Nov 2014 15:20:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lEJdH16rx6+kAX0UvHt8VE6xVm0=; b=s78sca
	W+u4Ektk4NbMZbgzsAOuRijvRe4IwAGOG8XPIQRM+qakkVvBX/drzvGR1+W/zWKh
	0MD++KqzZgIHLafA2QJEN7SxzRXQxaN24ZivnItwq74z6Bd+dUDgKIP1w4rAFfZZ
	VhuUHmKnWh2ua3t3eAtFllzB9EN1w7SMVnQ4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7cJbhKHpTl29LCSPtQt7F2lz+tyHnAx
	HnRzgvxSqE6byapNadU7BC5i0WkNQsiOB5NZgGjUCB2r1Ut1a1e9nex2xfv4SFol
	o9FLndDFOcknL24WaWqwD/UvFpJlj5YCOp3Us10ClzL4P43r8rm7jarunj1HOpo+
	6uojnYKpOJk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DB881E37D;
	Tue, 25 Nov 2014 15:20:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFFE21E37C;
	Tue, 25 Nov 2014 15:20:11 -0500 (EST)
In-Reply-To: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
	(Alexander Kuleshov's message of "Wed, 26 Nov 2014 00:03:54 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 755F52D4-74E0-11E4-8124-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260239>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Ah, you little ahead me, so we do not care about config.c in this way,
> because it takes git_etc_gitconfig() in the same way as
> git_etc_gitattributes

Yes, but looking at the file, you would notice that the
"use_local_config" codepath assigns a string obtained from
git_pathdup() to given_config_source.file, which means that somebody
later in the code path would not know if given_config_source.file is
merely pointing at a piece of memory owned by somebody else
(e.g. came from git_etc_gitconfig()) or if it owns the piece of
memory (e.g. came from git_pathdup()).  In the former case the
memory should never be freed, but not freeing in the latter would
leak the memory.

Assignment to given_config_source.file I see in that function that
borrows (i.e. the current code that does not fee is correct) are:

  - getenv(CONFIG_ENVIRONMENT)
  - NULL ;-) obviously
  - git_etc_gitconfig()
  
All the other assignment to given_config_source.file (including the
ones obtained from a call to home_config_paths()) makes us
responsible to free that piece memory, so they are technically
leaks.

But cmd_config() is a moral equivalent of main() in a typical
program, so it might not be worth worrying about allocating a single
piece of memory that is used throughout the lifetime of that
function and leaving it without freeing.

    
