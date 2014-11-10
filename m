From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 9 Nov 2014 18:56:45 -0800
Message-ID: <CAPc5daUJBs-GwEkJPwru6wjb6pJOMSceEAznXQ+ZW-mOyr-ipw@mail.gmail.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 03:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnfAG-00076K-8N
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 03:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbaKJC5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 21:57:07 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53645 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaKJC5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 21:57:06 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so7333823pad.3
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 18:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4Zm8fw9JJIrHZk+wZxcbMjHYXne8nCnG912xRoufRC0=;
        b=KxpvnSL9302/9Yjebx12sZmKrGdKIfVmQJlB3DfwkKV8lcKtF/5+F8/YmXnjzNnsPO
         k/4ClcpSlO3PUQDHiXlcY0W0FmHzjIjQ9BAAPa/X/FlMwL3xCAehx7eSMj2u9d67HlNm
         46EPRE3AaT9FHczdH6XnJsScFfsB7mWXA4gGiWZ3SPMT5iR4v3IB+p+wuz05d0iu5Cal
         jqCdXe1xzBH7w6wnHfnTQSMkxdd590kp0A2AP0cnnjc/lTyZZQTrDdbT9bk1uBxlnOnf
         kocwz1x09QEdV0um2aS/36Jldo9jpCLyCxvE57tQ343xzP1Uoj+OyqmOHx2J8bElQdM/
         6C4A==
X-Received: by 10.66.118.201 with SMTP id ko9mr29327209pab.46.1415588225190;
 Sun, 09 Nov 2014 18:57:05 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Sun, 9 Nov 2014 18:56:45 -0800 (PST)
In-Reply-To: <20141109015918.GA24736@peff.net>
X-Google-Sender-Auth: 2ySnI3D7VBu4LH6x_lBHWXSFnbk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 8, 2014 at 5:59 PM, Jeff King <peff@peff.net> wrote:
>
> Two tests recently added to t1410 create branches "a" and
> "a/b" to test d/f conflicts on reflogs. Earlier, unrelated
> tests in that script create the path "A/B" in the working
> tree.  There's no conflict on a case-sensitive filesystem,
> but on a case-insensitive one, "git log" will complain that
> "a/b" is both a revision and a working tree path.

Thanks for a clear problem description.

> We could fix this by using a "--" to disambiguate, but we
> are probably better off using names that are less confusing
> to make it more clear that they are unrelated to the working
> tree files.  This patch turns "a/b" into "one/two".

Hmph, but the branch a and the file A _do_ have names that are
unrelated to each other, and it is only the case insensitive fs
that is confused ;-).  Renaming is not so bad and certainly is
not wrong per-se as a workaround, but I have this suspicion
that it sends a wrong message to people on such a filesystem,
namely, "you cannot use Git to manage a file called 'master'",
or something silly like that. Disambiguation with double-dashes
does not have such a problem, and instead shows a way how
scripts that are meant to be portable is written. More importantly,
that is more in line with the problem description (i.e. we complain
pointing out the ambiguity, implying that everything is fine as long
as you disambiguate).

So I would rather see the workaround done that way.

But that is only if this were before you actually wrote the patch.
The above is not a preference strong enough to make me ask
you to reroll ;-)

Thanks.
