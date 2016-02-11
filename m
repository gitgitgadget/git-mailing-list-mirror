From: Junio C Hamano <gitster@pobox.com>
Subject: Re: assert failed in pathspec.c
Date: Thu, 11 Feb 2016 08:13:21 -0800
Message-ID: <xmqq7fibxm1q.fsf@gitster.mtv.corp.google.com>
References: <56BC0714.1010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Dingyuan Wang <abcdoyle888@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 17:13:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTts0-0006OM-UG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 17:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbcBKQNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 11:13:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750771AbcBKQNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 11:13:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CCEF3F877;
	Thu, 11 Feb 2016 11:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qyO5QXxljqdQjyMMCYdU68RcInc=; b=jpm2ql
	M9rcvhvkgl0vXOYWVz0dvhZXKdiAz3gciO04p7nkTpG+wlUV8oYD6kZ4BQr6/0uS
	81tELZZ9MA2u9zotkg+nIGvA34eNOqyaWw6fWFhgB1aFB8bhGs1Ic56nXnI6KlR9
	u/Jsuku+EG251u1TrHAQzRlKrIKs2gOrSxExc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EC+76f45o/U/JXNsgM3Gz/tijld0OaXE
	VtA+AfAxXeAXGW7I8mUTxaKq+AlRT13YA0jpYp5kk4ssaWh5qbCYcE1ZZQn4IZ1Z
	INSslhfJyNfUwqYfhSmEvMP5SsTA6pgs+fmUEdMI4XxvT71KSjX/2aQPhG8bAEnY
	CEOq9DWPG4M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 650223F876;
	Thu, 11 Feb 2016 11:13:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCD793F875;
	Thu, 11 Feb 2016 11:13:22 -0500 (EST)
In-Reply-To: <56BC0714.1010007@gmail.com> (Dingyuan Wang's message of "Thu, 11
	Feb 2016 11:59:16 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F8CA52C-D0DA-11E5-B083-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285983>

Dingyuan Wang <abcdoyle888@gmail.com> writes:

> Hi all,
>
> I've got an assertion error when `git add .`
>
> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <=
> item->len && item->prefix <= item->len' failed.
> Aborted (core dumped)

Sounds like http://article.gmane.org/gmane.comp.version-control.git/283549

>
> I think the repo doesn't have anything interesting.
> No submodules or subrepos. It's like:
>
> repo/
>  .gitignore
>  .git/
>  scripts/
>   .gitignore
>   foo.py
>   bar.json
>  something/
>  someanother/
>  other/         (gitignored)
>   scripts.git/  (original .git for scripts/)
>   foo.txt
>
> With
>
> modified:   ../something/a.txt
> modified:   ../someanother/b.txt
> ...
>
> Working directory is repo/scripts.
>
> I think the bug is related to this post: [assert failed in submodule
> edge case](https://marc.info/?l=git&m=142894416621088&w=2).
>
> (gdb) r
> Starting program: /home/gumble/software/git-master/git-add .
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> git-add: pathspec.c:317: prefix_pathspec: Assertion
> `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.
>
> Program received signal SIGABRT, Aborted.
> 0x00007ffff6fc8507 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:55
> 55	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff6fc8507 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:55
> #1  0x00007ffff6fc98da in __GI_abort () at abort.c:89
> #2  0x00007ffff6fc159d in __assert_fail_base (fmt=0x7ffff70fe6b8
> "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>     assertion=assertion@entry=0x56ffe0 "item->nowildcard_len <=
> item->len && item->prefix <= item->len", file=file@entry=0x5701a6
> "pathspec.c", line=line@entry=317,
>     function=function@entry=0x5701d0 <__PRETTY_FUNCTION__.22386>
> "prefix_pathspec") at assert.c:92
> #3  0x00007ffff6fc1652 in __GI___assert_fail
> (assertion=assertion@entry=0x56ffe0 "item->nowildcard_len <= item->len
> && item->prefix <= item->len", file=file@entry=0x5701a6 "pathspec.c",
>     line=line@entry=317, function=function@entry=0x5701d0
> <__PRETTY_FUNCTION__.22386> "prefix_pathspec") at assert.c:101
> #4  0x00000000004deb3e in prefix_pathspec (elt=0x7fffffffe3f5 ".",
> prefixlen=8, prefix=0x7e71f3 "scripts/", flags=50, raw=0x7fffffffe0a0,
> p_short_magic=<synthetic pointer>, item=<optimized out>)
>     at pathspec.c:316
> #5  parse_pathspec (pathspec=pathspec@entry=0x7fffffffd530,
> magic_mask=magic_mask@entry=0, flags=flags@entry=50,
> prefix=prefix@entry=0x7e71f3 "scripts/", argv=argv@entry=0x7fffffffe0a0)
> at pathspec.c:417
> #6  0x0000000000406423 in cmd_add (argc=<optimized out>,
> argv=0x7fffffffe0a0, prefix=0x7e71f3 "scripts/") at builtin/add.c:364
> #7  0x0000000000405cc8 in run_builtin (argv=0x7fffffffe098, argc=2,
> p=0x7b2520 <commands>) at git.c:352
> #8  handle_builtin (argc=2, argv=0x7fffffffe098) at git.c:542
> #9  0x0000000000404e7a in main (argc=2, av=<optimized out>) at git.c:665
>
>
> --
> Dingyuan Wang
