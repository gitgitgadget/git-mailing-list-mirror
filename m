From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Mon, 7 Dec 2015 22:21:59 +0100
Message-ID: <CACsJy8CQx-jL0aWW4mpGopNQtdJV7+8YCy2SzVL=VJSbBKAwMg@mail.gmail.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net> <CACs8u9Qvqn4KDMKo+RHsQaf+dw+CGtWrOpoUJzaZAqD1rFRiuw@mail.gmail.com>
 <20151204215158.GA27987@sigill.intra.peff.net> <xmqqh9jxrfy5.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BSNm6=E6Mo6etv_Lvdd2kpqQ7EEMBAoP-AQraYy3xU8w@mail.gmail.com>
 <xmqqmvtons4j.fsf@gitster.mtv.corp.google.com> <20151206063718.GA549@sigill.intra.peff.net>
 <20151206070144.GA17902@sigill.intra.peff.net> <CACsJy8DA2Xg9bRmudsRgwy9k=BCawTRU=7bm+rEXv2KoZgoXJw@mail.gmail.com>
 <CACs8u9RzUVWw2Ld1K7JeO7Eci114JEiML8bbGy96m4pZZk=FnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Paller-Rzepka <jasonpr@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a63Ex-0006tQ-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbbLGVWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:22:31 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33085 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbbLGVWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:22:30 -0500
Received: by lfaz4 with SMTP id z4so75249lfa.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u879ypdH8OWz7P9vxgxCdBr3xhK3GGOWwW/OUrwBPMY=;
        b=uhc1rviCGibFHQBE6jxjH9AttgH2aR2JMjatJXS0bLv9w/jf6dx5+3gn1/6Z0Hji0k
         leRqKFaTQGnvgYNnZAiI2oFqYT9DfnNvcG3CAyWbpTew1gIK63FtGn6X0w/kb0S+8oyW
         J4Qbx9zQ+pC5hHdhKywtE3dYfIoZi0uWjBqbh8oMCC+/GAlZaddN/VnL5+5FdKIEaSez
         zC2vBq0zS9rnhpO3BaZGo1Pv6Ao5JA0mWI1As2s3zVfY5onf+BLcKhFl1Xscs8+ge7eT
         D3O59TSNCzqub5UZYzvU6B/t6HHpSVOvR1E51ORdym7KRN1Nj5VKUkXM2NbijrD3CMQ+
         74mA==
X-Received: by 10.25.126.5 with SMTP id z5mr15257853lfc.112.1449523349079;
 Mon, 07 Dec 2015 13:22:29 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 7 Dec 2015 13:21:59 -0800 (PST)
In-Reply-To: <CACs8u9RzUVWw2Ld1K7JeO7Eci114JEiML8bbGy96m4pZZk=FnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282127>

On Mon, Dec 7, 2015 at 8:57 PM, Jason Paller-Rzepka <jasonpr@google.com> wrote:
> Duy, you mentioned that depth=0 means "do not change depth".  I assume that
> means the server should use exactly the shallows that the client sent, and
> it does not need to traverse the tree or modify the shallow or unshallow
> sets at all.  Right?

Correct. The server might send new shallow lines anyway though, if the
server repo is also shallow and the new fetched ref needs to be cut.
But I don't know if Dulwich supports that yet.

> Duy, you also mentioned that "those lines should be rejected any way".  You
> just mean that a "deepen 0" line should be rejected, right? And that's
> because the right way to tell git-upload-pack not to change the depth is to
> omit the "deepen" line after the "shallow" lines, so there's never a need to
> send "deepen 0"?

Also correct. I didn't check the code when I wrote that. But I have
checked and upload-pack does reject "deepen 0"

if (starts_with(line, "deepen ")) {
   char *end;
   depth = strtol(line + 7, &end, 0);
   if (end == line + 7 || depth <= 0)
      die("Invalid deepen: %s", line);
-- 
Duy
