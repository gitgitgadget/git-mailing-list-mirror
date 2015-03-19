From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 11:15:19 +0700
Message-ID: <CACsJy8CUbe4-f4rpieAKYzHb4rpKg8JW+uXB5yA4c1HFG6r4dg@mail.gmail.com>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org> <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan> <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com> <20150319012722.GA26867@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:15:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYRsA-0003Cl-9t
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 05:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbbCSEPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 00:15:50 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35154 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbCSEPt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 00:15:49 -0400
Received: by igcau2 with SMTP id au2so82586918igc.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pCokNS5hovPSxBmbk+ntmyIFJahbwIknAby9RJbrOes=;
        b=Q61UQDDIlmUJ/m6iek857GplqiV+o6lqvevUOEqIkgsGlez4goppTLxwJ9mQA4Wl8q
         e+HRxGLnXdrJ7Zu/bRLo27mAGiDdR0qpLCSpLlKDRAcnxpQIPCgbzJ6k469zpg492rPV
         Lj9LMYqvmmGS76RDqCSq6VgA9MmFGXqIsnuM/QyPq+k7wyzHYP+JchiMffyr42my6aze
         AqXQR4K0oIBhCFHOuyeHAsIMgdjv7neGy4KKRACY7FS6UrmLWI+k/zTh4x+4KygfU/b+
         cuAboLgpHB7RPiOQPqASW9aObVj4C+5GfWY89bHwpDrY3E7At/tABAAPMv1cVO+XNicA
         t/7g==
X-Received: by 10.50.1.48 with SMTP id 16mr12916555igj.45.1426738549326; Wed,
 18 Mar 2015 21:15:49 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 21:15:19 -0700 (PDT)
In-Reply-To: <20150319012722.GA26867@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265780>

On Thu, Mar 19, 2015 at 8:27 AM, Jeff King <peff@peff.net> wrote:
> Keeping a file that says "I ran gc at time T, and there were still N
> objects left over" is probably the best bet. When the next "gc --auto"
> runs, if T is recent enough, subtract N from the estimated number of
> objects. I'm not sure of the right value for "recent enough" there,
> though. If it is too far back, you will not gc when you could. If it is
> too close, then you will end up running gc repeatedly, waiting for those
> objects to leave the expiration window.

And would not be hard to implement either. git-gc is already prepared
to deal with stale gc.pid, which would stop git-gc for a day or so
before it deletes gc.pid and starts anyway. All we need to do is check
at the end of git-gc, if we know for sure the next 'gc --auto' is a
waste, then leave gc.pid behind.
-- 
Duy
