From: Milton Soares Filho <milton.soares.filho@gmail.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 25 Oct 2013 18:49:43 -0200
Message-ID: <CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 22:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZoKL-00039i-4M
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 22:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab3JYUtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 16:49:45 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:47817 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3JYUto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 16:49:44 -0400
Received: by mail-qc0-f171.google.com with SMTP id i7so2519399qcq.2
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7U/BcSrDV5KcvoosBRGLB6s7PZ/Uq5g3Ut18wUcTOWs=;
        b=yuWwMld2oYHMSsh34eeuOHMitg4fgsSKM6WXpWqEIppJoOfbyI3+3iIyUnkw5Ll2a5
         /V/esQNjkbaTr0Rp7IMhT9A+bIId80w48n0/i9FKtYRc8PuoJElmOmRpvIjLsJheECc7
         z/cf+ux6orDTL56X6sCWpYv5IKwN+x96feGILMImIB1RRaE8MlUORR0XZGfVzRJjiVrP
         D+zmTPDxabFYvNFuCLUYxVcz5wivsL7ZowWvUxK4+4+dN3mK6/3otpFpsrqBJYBPsehR
         Pk3GiE1aqXyvRPFg64M0zSK0gj5B9hZd+m5EQGFWKc916bkjb1vZ6Li+FlLBIoMm5ekF
         9VZg==
X-Received: by 10.229.13.69 with SMTP id b5mr13463105qca.13.1382734183624;
 Fri, 25 Oct 2013 13:49:43 -0700 (PDT)
Received: by 10.229.84.70 with HTTP; Fri, 25 Oct 2013 13:49:43 -0700 (PDT)
In-Reply-To: <xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236713>

On 25 October 2013 15:13, Junio C Hamano <gitster@pobox.com> wrote:
> Milton Soares Filho <milton.soares.filho@gmail.com> writes:
>
>>     git log --graph --oneline
>>     * a1
>>     * a2
>>     x a3
>>     * b1
>>     * b2
>>     x b3
>
> I agree that the problem you are trying to solve is a good thing to
> tackle, and I also agree that marking a root commit differently from
> other commits is one way to solve it, but I am not sure if that is
> the best way.  If the stretches of a's and b's in your history are
> very long, wouldn't it be easier to spot if they are painted in
> different colours, in addition to or instead of marking the roots
> differently [*1*], for example?

Thanks for taking your time reviewing this patch, Junio. I didn't really thought
it would get any attention since multiple root-commits is not a very common
use-case[1]. However, if most people got excited with git-subtree new
features as I did, there is a good chance that multiple root-commits are
going to become a common-place in the near future ;-)

That said, I completely agree that painting with different colors would be
a much better fix, however I believe that it can be done in a separate
changeset by someone that understands better the impact on the rest
of the system. Personally, changing only the mark is sufficient because:

a) it'll work on terminal types without coloring support and configurations
    whose explicitly disable it
b) it'll spare myself of running a separate GUI program just
    to spot where each series begin
c) it won't require any visual design skills from a developer (me)
    without a minimal sense for it :-)

By the way, is there a visual or design guideline document for building
decorated log graphs? From where comes the inspiration of it?

> The change implemented your way will lose other information when a
> root commit is at the boundary, marked as uninteresting, or on the
> left/right side of traversal (when --left-right is requested).  I
> think these pieces of information your patch seems to be losing are
> a lot more relevant than "have we hit the root?", especially in the
> majority of repositories where there is only one root commit.

Nice. I'll try to move the logic into get_revision_mark() and hope
the priority on handling it is better suited.

> [...]
> and I even suspect that it may be asking for the moon---you may not
> even know what root "a1" (and "b1") came from when you are showing
> these commits without first digging down to the roots and then
> walking the history backwards, which may not be practically
> feasible.

It'd be nice to figure out a test-case to emerge it.

[]s, milton

[1]: In git  repository itself I could find only seven of them (root-commis)
