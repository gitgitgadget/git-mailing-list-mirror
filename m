From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 03:00:53 +0530
Message-ID: <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pq-0000sy-5G
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762413Ab3DGVbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:31:34 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:54380 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761402Ab3DGVbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:31:33 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so4626442iak.4
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4YGHy2c7Odp8wxp/Su8UpqZxu0NL2anG9ZPvICTEDvk=;
        b=lWeSeTkpGdLdTXYDoNKTC4j4gPArSSD6vBPoKs6VNECuA5jGlxWd6E4LhA9nErksNa
         2Gszxfzqyw12a2cFJlRw3cxp9KoWa+pJiAHywvsmC0PkCpvo81mLimC8oZqW4FJCgtMA
         ek0lYNc9BWhtAC07xpgIsO44ByrcbngtpxkseyzXPaL8GTLVw6gvyZSmjMUjw4IDlqL5
         r26dhfpuupcR+fikjzU7e9PfguUdNhE0CLeMMsL9rSbJ2OrOBEd/+dAoMuEr/0awZyqD
         mlzA4g4XPAf0Toq7VrLfRSrL/ZZc8QiuQ6QxtXYbeojTeKLF9FaWmhXDe+XrQ2AuB+D5
         f+Yg==
X-Received: by 10.42.204.79 with SMTP id fl15mr10242568icb.57.1365370293072;
 Sun, 07 Apr 2013 14:31:33 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 14:30:53 -0700 (PDT)
In-Reply-To: <20130407212342.GA19857@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220380>

Jonathan Nieder wrote:
> What's stopping the core object code of git parsing .gitmodules?

Nothing, except that it's perversely unnatural for object parsing code
to parse something outside the object store.

> What
> is the core object code?

parse_link_buffer(): the conventions have already been set by
parse_blob_buffer(), parse_tree_buffer() etc.

> How does this compare to other metadata
> files like .gitattributes and .gitignore?

.gitignore and .gitattributes are parsed in dir.c, where git "treats"
worktree paths.  It's quite nicely integrated.
