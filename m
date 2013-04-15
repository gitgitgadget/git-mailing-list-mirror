From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 15:05:17 +0530
Message-ID: <CALkWK0nNn_dGgr8F-kcQZm9UfkZAKwBd0bPSW9yCex4L9F+4Qw@mail.gmail.com>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org> <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org> <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:36:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfpV-0003mb-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925Ab3DOJgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:36:00 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:63919 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934577Ab3DOJf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:35:59 -0400
Received: by mail-ia0-f182.google.com with SMTP id u20so4122416iag.41
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eijABIxyNeGb83ykw6mqwWSgTxw8cxbhF2VJlTlyHNw=;
        b=M0UhXcFC6o55op/3zkiWpXqflq/R5/dW4allvuzrKCUGBIHvVRRMmHyuenyWaIbfpD
         sqTr0GhsT+NvnnXoPjrPbSBaCTNvHN4uQtxADJOcfuxDtYLDSXnSH5J+01wSFix2+azk
         BbUrZ4BCYkKgRxsz46VRRxB6i2DDj4ka3USPACLUVeqh0DngO5rYZ+oCiuQXnS3FOLzy
         mU28tHZ0fZs2/MZJYtzTD4g6rodv89+AYBW2mtDE++1NaHSZ8tdH+yCiGIvqffmEGO0q
         MocXcC4KJAGdvhfwqU9f1j/ZdCKhBkQcbAyxKHk5X2+A2nZxTrEGyhTx6r2lEd8IzhUA
         UtZQ==
X-Received: by 10.50.50.71 with SMTP id a7mr4710190igo.14.1366018557611; Mon,
 15 Apr 2013 02:35:57 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 02:35:17 -0700 (PDT)
In-Reply-To: <7vppxw335o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221210>

Junio C Hamano wrote:
> That "changing the meaning of <name>" in the middle, and doing so
> will be confusing to the users, is exactly the issue, isn't it?

Yes, but we have to change _something_ if we don't want to hit a WTF
like 'git push master next' pushing master and next to
branch.<HEAD>.pushremote.  In my opinion, this seems to be the less
evil (or disruptive) change.  After all, we're not proposing to change
the current behavior of any current git invocations: a plain git push
can still consider branch.<HEAD>.pushremote, and it's not a problem in
my opinion.  After all, a git fetch also considers
branch.<HEAD>.remote, and we all agree that this is fine.

1. We are changing the meaning of branch.<name>.remote, but this is
not inconsistent with the current behavior of push.default at all
(even push.default=matching).  We just have to improve the
push.default documentation.

2. We are not changing the meaning of _any_ existing git push
invocations.  Pushing "unrelated branches" to the "corresponding
remote" has not been possible until now (unless you check out each of
the branches, set push.default=current, and git push), and we're
inventing a new syntax that makes this possible.  I see no problem
with changing the meaning of branch.<name>.remote/pushremote for this
purpose.

> Just like Peff, I am sympathetic to people who want to omit "where
> to" and have Git automatically make a guess, and would be happy if
> we can find a reasonable solution to that problem.
>
> But I am not convinced what we discussed in these threads are good
> solutions. At least not yet.

There are only so many possibilities, Junio*.  You either decide that
the logical alternative that I proposed is too confusing and drop the
idea, or think about how to move forward minimizing friction.

* If you think there are other possibilities, I'd be glad to hear them.
