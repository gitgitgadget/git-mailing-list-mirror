From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Fri, 7 Aug 2015 00:04:38 -0400
Message-ID: <CAPig+cTOzZ0RFd2eu43rYQDnsXmfswbRx3=vN41BJf_BHON7tA@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
	<1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 06:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNYtg-0004HY-G9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 06:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbbHGEEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 00:04:39 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32905 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbHGEEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 00:04:39 -0400
Received: by ykoo205 with SMTP id o205so79973212yko.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 21:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Kt+fKK4eRuU6AQ0L5SLqdJxU1A/8HYJJIqviiqnKW1A=;
        b=ShKqhqvleXkoU0eppsZnK1cMcO7euCSLHCh7RaqHuGIJXP9SH6bTFQaGVeFnXH3feT
         Sbqm6kdgTkxj+dssbvRocOL15GYorqQ95/Bkwtkofy8fDCmWoR8QGcUHI8aoSEDH3hq2
         BK8Kyzr4jLGqh74A+/zTFpHhWzwQ1fgDAjnbz8f8xTcuv30lO7NkvbzJji51ZL3Xvz0o
         qR5dELh6xhkzOgaA+LLHL1hV1VVbCnIpmoC/Ej1kwKRGZ66TABh92OXqOCg/Md/idzuN
         YLiomE2YNKM5yyB3IDig2hBb0D4i/2ePVUp9wNfK7Cx28wf9iEXkuEC+cHafwRFnt6Os
         1Zsw==
X-Received: by 10.129.76.140 with SMTP id z134mr5695310ywa.17.1438920278479;
 Thu, 06 Aug 2015 21:04:38 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 21:04:38 -0700 (PDT)
In-Reply-To: <1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: Wp3yDHj8MJ3Uovnt4XHnKSxayOI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275459>

On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which will act as a modifier atom and align
> any string with or without an %(atom) appearing before a %(end) atom
> to the right, left or middle.
>
> It is followed by `:<type>,<paddinglength>`, where the `<type>` is
> either left, right or middle and `<paddinglength>` is the total length
> of the padding to be performed. If the atom length is more than the
> padding length then no padding is performed. e.g. to pad a succeeding
> atom to the middle with a total padding size of 40 we can do a
> --format="%(align:middle,40).."
>
> Add documentation and tests for the same.

I forgot to mention in my earlier review of this patch that you should
explain in the commit message, and probably the documentation, this
this implementation (assuming I'm understanding the code) does not
correctly support nested %(foo)...%(end) constructs, where %(foo)
might be %(if:), %(truncate:), %(cut:), or even a nested %(align:), or
some as yet unimagined modifier. Supporting nesting of these
constructs will require pushing the formatting states onto a stack (or
invoking the parser recursively).

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
