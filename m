From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in t1508
Date: Mon, 25 Jan 2016 01:22:21 -0500
Message-ID: <CAPig+cQfbJUtqu2F497Usaz3Ysf-5-vQgtg-0y8qh+FUQ=HeTA@mail.gmail.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de>
	<xmqqa8nubekj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Braun <thomas.braun@byte-physics.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 07:22:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNaXo-0004aM-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 07:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763AbcAYGW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 01:22:28 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36608 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbcAYGWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 01:22:22 -0500
Received: by mail-vk0-f68.google.com with SMTP id e64so5406824vkg.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 22:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=obwMcLNEHFgx6YZMMcpJe/ePxOLGJiswT2CppEyigRE=;
        b=TRWZ/s7v4y4VDjImTlZOCwkIB9kHsPUFYCKEMHmLnfO1Yhh7CaYHyxVPtCjzebJz2i
         fVk5GssLVPE/+2NdSE0uOSBjlW1vVEz+fHO8rDDZA4fErE1U7i6ZCVJT3oaLxbiTiUUy
         C10s4gCRueiyX2eTu7ZvpKRgQ0XCWj84SNDsf93PhSfykx113Ao9LflUN3nyUb++Pf65
         MIA9HdDMRUeXD1uZXZ9Pi/TNk3SfcWySBbbG5sQjLgAMg57axoFPcbewX4WEsTR6HKa/
         TePd5bswwTeOBNfMsaz3tExpnwTi57gzShfzFLKahweV0hwxQ3lb7iOn0tzHDKwGLlui
         xiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=obwMcLNEHFgx6YZMMcpJe/ePxOLGJiswT2CppEyigRE=;
        b=XVmu9UhM/CEFd7WLFCQ9e7cEEiWYIoVU9rO3zrYiA3bPeq18b8XUgZahdJbmbQH8gH
         gndeUZ2PMWYc9qeIoh6a6zQ7+c8JrqBCFDiTNjk30Tgf1YAtpt4R2Z+Q9k5E1fa0lA5C
         kTWcIYcrj/qC1r85P+1DYo+k6t5iEWSXnTM2lDsnWjkHolV052E8EJSAI3x6gFqbAd4W
         fbfmPyqNqXfbxoqO+aL76KlEiEYgr/yoNIsAxzHVhU3kQbM3ItbZBoC5ZU6WYbQZL2gJ
         6aM69dZ5swPj1ArLQY4JLSU/zILDPkU/jUZZpJsrs9G7KGDkEFFpbmOqap11Om+OkVpk
         ryOA==
X-Gm-Message-State: AG10YORH2/bAsT+UHl4JcijrITlDPQf/tUIyysQscclXigzPIxGw8NKO05zRITYEZUufNVim9FaTQGv+q/LJvQ==
X-Received: by 10.31.41.20 with SMTP id p20mr3321155vkp.151.1453702941461;
 Sun, 24 Jan 2016 22:22:21 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 24 Jan 2016 22:22:21 -0800 (PST)
In-Reply-To: <xmqqa8nubekj.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 8y2l8UFSvbKV5qar61Nmn9OsJIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284718>

On Sun, Jan 24, 2016 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> A string of the form "@/abcd" is considered a file path
>> by the msys layer and therefore translated to a Windows path.
>>
>> Here the trick is to double the slashes.
>>
>> The MSYS2 patch translation can be studied by calling
>>
>>       test-path-utils print_path <path>
>
> This feels wrong.
>
> The point of this test is that you can ask to checkout a branch
> whose name is a strangely looking "@/at-test", and a ref whose name
> is "refs/heads/@/at-test" indeed is created.
>
> The current "checkout" may be lazy and not signal an error for a
> branch name with two consecutive slashes, but I wouldn't be
> surprised if we tighten that later, and more importantly, I do not
> think we ever promised users if you asked a branch "a//b" to be
> created, we would create "refs/heads/a/b".
>
> The new test hardcodes and promises such an incompatible behaviour,
> i.e. a request to create "@//b" results in "@/b" created, only to
> users on MINGW, fracturing the expectations of the Git userbase.

What the commit message doesn't explain is that the MSYS2 Bash shell
automatically translates command-line arguments which look like
absolute POSIX paths into Windows paths on behalf of the program being
invoked. For instance, given the command-line:

    myprog /fish

the shell will translate /fish to a Windows pathname, such as C:\fish
before invoking myprog.exe. While this is often the desired behavior,
sometimes the argument represents something other than a path, and the
translation is unwanted. MSYS provides a way to suppress the behavior
manually by doubling the slash, so:

    myprog //fish

will invoke myprog.exe with literal argument /fish (notice the single slash).

This commit message is trying to say that MSYS shell undesirably sees
@/fish as an absolute path, thus tries translating it to a Windows
path, such as @C:\fish. The only way to suppress this unwanted
translation is to manually double the slash, hence the patch makes the
test use @//fish which, when finally seen by the program, is just
@/fish, as was intended in the first place. So, doubling the slash on
MINGW is not promising incompatible behavior for MINGW users; it's
just working around unwanted path translation of the shell.
