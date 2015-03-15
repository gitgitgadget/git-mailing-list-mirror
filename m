From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2015. Microprojects
Date: Sat, 14 Mar 2015 19:59:08 -0700
Message-ID: <xmqqtwxnufsz.fsf@gitster.dls.corp.google.com>
References: <CAHLaBNLX8KGUhROzW80SiM507=YpbfqdSiPm7Vm9vwK6vW-Z+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 03:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWylp-0000k7-AS
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 03:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbbCOC7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 22:59:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751260AbbCOC7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 22:59:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE2C64190E;
	Sat, 14 Mar 2015 22:59:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=05D0Ar/gcZTzQtDB7KctYysnjWQ=; b=TwNTjE
	o9DHFDE51wFn75q9rfYQow143LgJwFNB3Selzf8FwzW8YT4nGdw8uvhU7FvQvkbX
	QFKvhNxtrK1zDOj7ZWHyDaBFgSdiyWKQ8Oskv2sWhE/8mBhY1iZiVV+uPUW2RwPE
	6f9UqJWRrujVNNE9YoUr8hOzxmX0Q1yV+fnC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aAaNr7R+6KH1P0AoxmOrL6sNJg8m9fAP
	3haaR2hV4ycbBPx7X8wDDaFB30czyPbBd83vjbyLQ2dAw+70S5L92xZjjkppXZht
	FKWdhhMgkPDq47iFvz2GJdLTcQNwVmd/w0OmCcm6H3XN/hm7sczGMF9vBAFdbCqC
	fI1ixL9Z92s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACF0E4190D;
	Sat, 14 Mar 2015 22:59:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13F2D4190C;
	Sat, 14 Mar 2015 22:59:10 -0400 (EDT)
In-Reply-To: <CAHLaBNLX8KGUhROzW80SiM507=YpbfqdSiPm7Vm9vwK6vW-Z+Q@mail.gmail.com>
	(Yurii Shevtsov's message of "Sat, 14 Mar 2015 22:24:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40B211F4-CABF-11E4-9696-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265479>

Yurii Shevtsov <ungetch@gmail.com> writes:

> As I understood there are four unsolved microprojects. I think I can
> deal with "Make "git diff --no-index $directory $file" DWIM better"
> but I don't understand what exactly should I do.

OK.

> I tried to run 'git
> diff --no-index ~/git/ diff.h' cmd on git sources but it says 'error:
> file/directory conflict: /home/localhost/git/, diff.h'.

There you have it.  Do you think erroring out is useful?  

Imagine a user who is used to the way ordinary "diff" command (not
"git diff") operates.  What would be the behaviour that may match
the expectation of such a user better?

In other words, if you have the source tree of git in ~/git and
then you have "diff.h" in your current directory, perhaps prepared
by doing something like this:

    $ cd $HOME
    $ git clone git://git.kernel.org/pub/scm/git/git.git git
    $ mkdir junk
    $ cp git/diff.h junk
    $ cd junk
    $ echo hello >>diff.h

what would the ordinary "diff" say when you do these commands (still
in that ~/junk directory)?

    $ diff -u ~/git diff.h
    $ diff -u diff.h ~/git

Wouldn't it be wonderful if "git diff --no-index" worked the same
way as these?
