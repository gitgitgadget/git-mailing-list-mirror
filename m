From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 21:17:41 +1100
Message-ID: <CACsJy8C4nEQmgtTGSvwcVMdgksVuOj9mssuFinXp3=ZqLJtgUg@mail.gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org> <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org> <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, peff@peff.net,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 12:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHv8D-0000CY-Ob
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 12:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab1JWKSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 06:18:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48823 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab1JWKSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 06:18:12 -0400
Received: by bkbzt19 with SMTP id zt19so6845618bkb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g1vHGgfMUQLO26aJt/3NHOyTNKslcMCdlyIIZqJYWYI=;
        b=E67uta5cA1zCz7+272clR0pGUzoa9HTOLU3ZEjz2+YQzOsAJ9ZEKFJZeVWT2KqrKsH
         LXmEWt0Tj1YZgRV7DA5Sqf2T/ZmCO1DLWWiBUXv5wb++AA3fVnxZZngYb2jl1X50ByEP
         shaKc/V2E5TiIk1pig7mG+MApgCpQdxccKtLw=
Received: by 10.204.34.75 with SMTP id k11mr14622131bkd.68.1319365091086; Sun,
 23 Oct 2011 03:18:11 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Sun, 23 Oct 2011 03:17:41 -0700 (PDT)
In-Reply-To: <7vehy459bg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184133>

On Sun, Oct 23, 2011 at 8:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Sun, Oct 23, 2011 at 4:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> The low level object format of our commit is textual header fields, each
>>> of which is terminated with a LF, followed by a LF to mark the end of
>>> header fields, and then opaque payload that can contain any bytes. It does
>>> not forbid a non-Git application to reuse the object store infrastructure
>>> to store ASN.1 binary goo there, and the low level interface we give such
>>> as cat-file is a perfectly valid way to inspect such a "commit" object.
>>
>> cat-file is fine, commit-tree (or any commands that call
>> commit_tree()) cuts at NUL though.
>> I wonder how git processes commit messages in utf-16.
>
> That is exactly what I am saying.
>
> Perhaps you didn't either read or understand what you omitted from your
> quoting; otherwise you even wouldn't have brought up utf-16.
>
> Let me requote that part for you.
>
>> But when it comes to "Git" Porcelains (e.g. the log family of commands),
>> we do assume people do not store random binary byte sequences in commits,
>> and we do take advantage of that assumption by splitting each "line" at
>> LF, indenting them with 4 spaces, etc. In other words, a commit log in the
>> Git context _is_ pretty much text and not arbitrary byte sequence.
>
> Think what would cutting at a byte whose value is 012 and adding four
> bytes whose values are 040 to each of "lines" that formed with such
> cutting do to UTF-16 goo, even if it does not contain any NUL byte. As far
> as Git Porcelains are concerned, it is no different from random binary
> byte sequences.
>

I'm sorry. The utf-16 was an afterthought when I was nearly finished
with the reply and already cut that quote.

The assumption that people do not store random binary byte sequences
in commits sort of conflicts with "encoding" field in the commit
header though. The assumption is documented in i18n.txt. I guess it's
just me who did not read document carefully. But maybe it's good to
stop people from shooting themselves in this case (i.e. setting
encoding to utf-16 or similar).
-- 
Duy
