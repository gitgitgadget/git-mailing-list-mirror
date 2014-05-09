From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] contrib/subtree bugfix: Can't `add` annotated tag
Date: Fri, 9 May 2014 17:36:15 +1000
Message-ID: <CAHYYfeFfo=xVDezAGFyCvuhx=bkzMF6KyDCAjZNKNoGnytXDWA@mail.gmail.com>
References: <1399511079-1994-1-git-send-email-nod.helm@gmail.com>
	<xmqqoaz841d3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Kevin Cagle <kcagle@micron.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 09:36:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WifLz-0006hS-1h
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbaEIHgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:36:17 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:38458 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbaEIHgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:36:16 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so4734711vcb.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=54CJZlxC16JB7PjiZzK7XCawvtIK9OMY2PdDh3cZDlY=;
        b=jrIzOKbHsArK5jbFAev9dsbCuQT+ckqhvUNIRtY93uqgZczqoyNNMK6NMVcRlxkAwJ
         U9OSj0zQUXbm6Ja4H/RoCKdFNWTaDeStgV90rfvpI9Au04T7L2vIQdQ7LuzXCnH7DHlz
         IOKCxOiBsFR9j6CqZeJgu91kf/GFTfzmRmpT8JB1r0n2h8rPOWT4qkalHLTAy8zO+zdJ
         TPHM8YQHoWPPpbiRRasQ8ZbtBxTa9Li+b4kleVESgEKzEWMPuyYbCSjLI+8T1YzOnsWi
         MoegD4e95sibpcnP8GlfbetLvEyyMHtj5bh1WMR5ufXbyO3nB0VbBiNIA3F2bPTdvNbZ
         XiFg==
X-Received: by 10.52.99.168 with SMTP id er8mr6039679vdb.26.1399620975221;
 Fri, 09 May 2014 00:36:15 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Fri, 9 May 2014 00:36:15 -0700 (PDT)
In-Reply-To: <xmqqoaz841d3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248525>

Junio C Hamano <gitster@pobox.com> wrote:
> The "rev" (not "revs") seems to be used by more things than the
> final commit-tree state.  Are we losing some useful information by
> peeling it too early like this patch does? (...)

You're not wrong, actually, peeling at the last minute (or at least
later) would be a better choice. I'd suggest that we aren't losing
currently-useful information (as it'd be rare-if-ever that a user would
look at a hash in their commit logs and think "Oh, that's that tag!"),
but certainly with future development in mind it's more ideal.

> I see that add_msg does not use anything useful from latest_new, so
> with the current state of the code, it does not make that much
> difference (except that it says "from commit '$latest_new'", and by
> peeling, the fact that the user wanted to use a tag is lost from the
> result).

Yeah, that might be a worthy thing to porcelain-up in the future with
logging the tag name rather than, or in addition to, the hash, as well
as a similar change in add_squashed_msg.

> Would it be sufficient to do
>
>         git commit-tree $tree $headp -p "$rev^0"
>
> in that "not squashing" codepath instead?

On line 561, sure. Do you want me to do a re-roll?
