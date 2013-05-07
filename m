From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/11] sha1_name: improvements
Date: Tue, 7 May 2013 17:11:56 -0500
Message-ID: <CAMP44s3-vVUB4VnZP4uBMLAbviV+BMTqDcbO_TxkX+5RE6cnSg@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 00:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZq79-0004db-6W
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391Ab3EGWL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:11:59 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:63047 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3EGWL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:11:58 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so1110122lab.17
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=spTfic0ookA55bdzJ913suUb953AczEMIKkHmVQL2Ag=;
        b=RgBZB9vt/cpApDGq0Vxa24ij5JHgNfFNX+oq0And4O6rTYo7tAra8ZEqe4GG6a2eVy
         CenoEEWlXine2g4QheHtTB7cJiWnVtuVmc2W7ynt+SN5mQkPR1t63LzbWHtfjfg+TE6+
         VxjFWIvRauzeHtSegOWXzTGvlfb0Aq+slVauIJdVA+Cb39D+dakEYEAtIYJL/ig/kjdV
         BqYjYVpwAM778CZdW905KPXowHBRYT9qD6EhU1guyyixQrHWB8y0b3lJyNOHcpMcZuZX
         cAWCKCDWEvfB71l7iJ1W7DvREaSlM/HISJaoC38UWscgjs4Jbrj8SQP0Nx6BqeyuHTK4
         6uxQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr1818345lbb.59.1367964716931;
 Tue, 07 May 2013 15:11:56 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 15:11:56 -0700 (PDT)
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223622>

On Tue, May 7, 2013 at 4:55 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> While trying to add support for the @ shortcut lots of cleanups arised. Here
> they are in a single series.
>
> Felipe Contreras (7):
>   tests: at-combinations: simplify setup
>   tests: at-combinations: check ref names directly
>   tests: at-combinations: improve nonsense()
>   sha1_name: remove no-op
>   sha1_name: remove unnecessary braces
>   sha1_name: avoid Yoda conditions
>   sha1_name: reorganize get_sha1_basic()
>
> Ramkumar Ramachandra (4):
>   tests: at-combinations: increase coverage
>   tests: at-combinations: @{N} versus HEAD@{N}
>   sha1_name: don't waste cycles in the @-parsing loop
>   sha1_name: check @{-N} errors sooner

When merging this series to the @ shortcut one, there will be
conflicts, this is how I propose fixing them:

                return len; /* syntax Ok, not enough switches */
-       if (0 < len && len == namelen)
+       if (len > 0 && len == namelen)
                return len; /* consumed all */
-       else if (0 < len)
...
++      else if (len > 0)
 +              return reinterpret(name, namelen, len, buf);

- check "@" new-two
- check "@@{u}" upstream-two
...
++check "@" ref refs/heads/new-branch
++check "@@{u}" ref refs/heads/upstream-branch

If that creates some kind of problem I would rather throw away this
series rather than the other one.

Cheers.

-- 
Felipe Contreras
