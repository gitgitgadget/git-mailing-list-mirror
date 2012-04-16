From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 11:33:54 -0700
Message-ID: <CA+55aFyAsF4jNvNMKC6divzAfyVmgrHvxJtnX0fjkpp_bLHkPQ@mail.gmail.com>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl> <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
 <7v7gxfwpc8.fsf@alter.siamese.dyndns.org> <CA+55aFwPrjtAttsH75tTGHO=14g_2GbyOtUt4eY9LPHbtcXvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJqkt-0007eL-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 20:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab2DPSeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 14:34:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40792 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab2DPSeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 14:34:16 -0400
Received: by wejx9 with SMTP id x9so3534354wej.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=QoKpAnO2cm7Skld1w0uiBpSA03hEE1DDZjf/gIPAvWw=;
        b=J2PHB6ThoUbXiAeeP0fdaTrY2qFVpKQVo/P8DXYKLYYlHVFO3TIRYkIIyYbBLDTgGx
         wRIMvyJrBzwB/Fva9ppsfdTq6n1/hV2mYURawJ9WhZpQi/fPU65Y02YQFQ0QC+yVh6/j
         XKvrZBkh/abxky69ao41rU+ILg3qGCDxxLa/HrfSuu8MpOgRK9kRKF55yz7UroEQEVIx
         LT0CcG5cLfSSdItyhBCBmuqbyTOf4SQMowON6hp0h+dpXiZXbp3t2NXg3WqWIUQEc11j
         EM6oaysgyg3dUsjleLTa4QzlCfu3hhWgD7lRKhPyuG4gO1lJesHuKbWQUklAFYitSAWS
         NP8w==
Received: by 10.216.200.90 with SMTP id y68mr7326499wen.49.1334601254968; Mon,
 16 Apr 2012 11:34:14 -0700 (PDT)
Received: by 10.216.221.167 with HTTP; Mon, 16 Apr 2012 11:33:54 -0700 (PDT)
In-Reply-To: <CA+55aFwPrjtAttsH75tTGHO=14g_2GbyOtUt4eY9LPHbtcXvcQ@mail.gmail.com>
X-Google-Sender-Auth: bFYJf_pXp31_harV2tjUP84_m_0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195676>

On Mon, Apr 16, 2012 at 11:02 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oddly, running that test in verbose mode seems to imply that it's the
> *rebase* that succeeds, not the merges in that test. Maybe I'm reading
> the test results wrong, I didn't really try to understand the test
> itself ;(

Yes, it's the rebase that succeeds. "git log -g" in the trash
directory shows that we ended up successfully rebasing J2:

  commit 5fc34ec1a8ed96664198fefc74121cd052b10861
  Reflog: HEAD@{1} (C O Mitter <committer@example.com>)
  Reflog message: rebase -i (pick): Merge made by the 'recursive' strategy.
  Author: A U Thor <author@example.com>
  Date:   Thu Apr 7 15:28:13 2005 -0700

      J2

while a successful test will fail that.

However, I don't actually see what changed.

Oh - one thing to note is that the *patch* of that successful rebase
is empty. That may be the big clue: we successfully finish the merge
without noticing that it didn't change any state, and we should have
failed it as an empty commit. Hmm?

                   Linus
