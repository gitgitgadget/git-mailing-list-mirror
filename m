From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git diff-index' doesn't honor the 'diff.algorithm' variable
Date: Sun, 15 May 2016 11:43:16 -0700
Message-ID: <xmqqwpmv5fi3.fsf@gitster.mtv.corp.google.com>
References: <9d15b6c8-ed97-7352-3df1-efab1b4ffadb@yandex.ru>
	<xmqqshxk7aa8.fsf@gitster.mtv.corp.google.com>
	<8e5a7045-77f7-acb0-de7f-3e8f72479ec3@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dmitry Gutov <dgutov@yandex.ru>
X-From: git-owner@vger.kernel.org Sun May 15 20:43:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b210f-0005GT-Lc
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 20:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbcEOSnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 14:43:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751555AbcEOSnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 14:43:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A74E1B339;
	Sun, 15 May 2016 14:43:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xsgm01BnwacVRz0jIXyODITK+8o=; b=aNg4lC
	cu9m1MX5W/DUJkeczKDdcglne3VqxxqOBa6L2D5Scka91LZWFqKDcEd+/f9/PRwD
	b/z1QJCPnYYBLMhcNmDcPldGCxxbmxwdGt7xpaTRB7FudHdP2LL0AFQAcEF2GJNI
	nyPCFOK/P1QLvpqB5lsvFdLZVigAtjP/mL3gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxGAWgiYGsweV1rttV6FIAgh9nHwj/CN
	77rGFq6na7fLaURYLl0Lblzs3XTVNczM4xHLMuPl9Q79BYFLvJPR5ltTpR/UhYOU
	yHuVpVpDHAV9HclTPpx2kRpM29vikOlmfADzbfdWOJYBJBnTllSb7JAmqabl+34Y
	tYnTjsHy+rw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 322FF1B338;
	Sun, 15 May 2016 14:43:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E34D1B335;
	Sun, 15 May 2016 14:43:18 -0400 (EDT)
In-Reply-To: <8e5a7045-77f7-acb0-de7f-3e8f72479ec3@yandex.ru> (Dmitry Gutov's
	message of "Sun, 15 May 2016 13:25:24 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4389434-1ACC-11E6-BCFD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294676>

Dmitry Gutov <dgutov@yandex.ru> writes:

> OK, that makes sense. You might want to fix the man page, though, it
> says, like the 'git diff' one, "For instance, if you configured
> diff.algorithm variable to a non-default value and want to use the
> default one, then you have to use --diff-algorithm=default option.".

Thanks; I think the paragraph is shared among the "diff" family of
commands both plumbing and Porcelain, so I'd say "patches welcome"
at this point ;-).

> Thanks, but we don't distribute any custom Git porcelains with
> Emacs. We usually can't rely on bash being available either.

The script was an illustration of the logic--I am sure elisp is much
core capable scripting environment than POSIX shell.  Perhaps (setq
vc-diff-git-diff-use-histogram t) in ~/.emacs is not too bad ;-)

> I'll have to see why we using 'git diff-index' there directly. Maybe
> we could switch to 'git diff'.

I do not think it is a good idea.

Depending on how much understanding vc-diff wants to have on what
the diff output is saying, it may want to be read and parse parts of
the output; an end user who has diff.color=always can easily ruin
your day.

And no, running "git diff --color=never" is not a solution for that.

The Porcelain "git diff" command is not bound by any promise of
stable output and reserves the right to change the default to better
support human users.  I think the upcoming version of Git turns the
diff.renames setting on by default, for example.  We might even add
a side-by-side diff and make it the default someday.  You do not
want to be reading these "fancy" output, and you cannot keep
updating the invocation of "git diff" by vc-diff with unbounded
number options, e.g. --no-side-by-side, that will be added to defeat
configuration variables that will be invented in the future.
