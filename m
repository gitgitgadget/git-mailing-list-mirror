From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More builtin git-am issues..
Date: Fri, 4 Sep 2015 18:06:44 -0700
Message-ID: <CA+55aFw-PObyj2boqpeA9DDcKeAuCGouT7Qd2Zw02+sxvd2CgA@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY1xE-0002nR-4j
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 03:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934999AbbIEBHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 21:07:01 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38702 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535AbbIEBGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 21:06:45 -0400
Received: by igbut12 with SMTP id ut12so25833949igb.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 18:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w8NFbyD7SY9M9/qITbVNUbpELajgscFitnqqyd6zx6M=;
        b=BT3so8kkQBgC7U17ta9rJq3eju9t5BJr8suAHGNGeaU4cjX9UCWsXl0xNxff5rCMaT
         RjF46ETCHv461vjcLMlxLLQSxaoc6jdSsSJxz6G1GC+izyUjGyCH9QbaaMwMY7VNiC4i
         ekpDD+NMBqFASx/RObMNxTt/DF42EbTatRKRyz8NFEoyQ9A50V7NocFufz3106QPfOGo
         413FgAjMAGasuD7VoFO6p0AkNxb9C+rVVPRE5bWHRbTyRqxT9+H1Rt93006wn//9XxDg
         u/ZmVbGhC3+Fl0yrQBzKEPQWacqsg1+uy0gPG3rfAVJZ3p/1L+2crOiQB/Z71DqwKMWd
         84Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w8NFbyD7SY9M9/qITbVNUbpELajgscFitnqqyd6zx6M=;
        b=dmYykh3T+fTr0DvvDP64SJ+5zaJQuHQdNEMEQiHfP6JUPk77VQYGjCz9MyTZqy4T+O
         oyrvc0VJ1Bc0V1/AHX10o2cz9PytHZHMTGY+XfJWHV3J0yTpiIkI9A+l+b4ryXI2GGT1
         bsVxQxXGAkzX4uJQ6p1/cntHtVJxS4Vi1dA4A=
X-Received: by 10.50.61.209 with SMTP id s17mr12007241igr.45.1441415204403;
 Fri, 04 Sep 2015 18:06:44 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Fri, 4 Sep 2015 18:06:44 -0700 (PDT)
In-Reply-To: <xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: l1XSPs2yJY3Xt3sLaTpLuferrVE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277354>

On Fri, Sep 4, 2015 at 5:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> How about a bit looser rule like this?
>
>     A block of text at the end of the message, each and every
>     line in which must match "^[^:      ]+:[      ]" (that is,
>     a "keyword" that does not contain a whitespace nor a colon,
>     followed by a colon and whitespace, and arbitrary value thru
>     the end of line) is a signature block.

No. That's still broken.

The thing is, and that was what the report was all about, not every
line _is_ of that format. We have commetns from the sign-off people.
Things like this:

    Signed-off-by: Noam Camus <noamc@ezchip.com>
    Acked-by: Vineet Gupta <vgupta@synopsys.com>
    [ Also removed pointless cast from "void *".  - Linus ]
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

or

    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    [ Updated comments and changelog a bit. ]
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/1424225886-18652-3-git-send-email-andi@firstfloor.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

so no, it is simply not true that "every line must match".

I'm not even seeing why you argue for that, since clearly having a
sign-off-line is actually a safer choice too. The "every line must
match" rule is bad, not just because it's not true like above, but
also because it can be true without it being a sign-off block.

For example, it's not at all unlikely that you have perfectly normal
comments that just list some subsystem and their changes. Which could
easily look like

   Trivial fixes all over the tree

   drm: fix whitespace
   mm: speeling errors
   kernel: indentation and codign style

The above looks like a perfectly sane commit log to me.

Do you seriously think that it makes for a better "sign-off block
test" than one that actually checks for "is there a sign-off line"?

I'd much rather have special cases like testing for specific keywords
or looking for things that look like emails, than make it about being
"every line has this very generic format".

                     Linus
