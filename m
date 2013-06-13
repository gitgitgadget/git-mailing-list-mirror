From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 00:18:44 +0530
Message-ID: <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnCaQ-0008Qc-6b
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758959Ab3FMSt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:49:26 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46188 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab3FMStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:49:25 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so14307101iee.34
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IuiU7Toi7RoWVcs7Ja3SgxX+dyJb8u9BaGxORu7h0Z8=;
        b=CXXLVtSsM7tA0c5TFIK8xCH2GO1+t6xtsD8Y47T2e+7kBbYev6MlpJb3tcBv4Geoad
         qkvOhnSXhumXVb6LdeMm19uzgSPrAx3JscKyq3wKs0nXieCmmASC6+CToGeZmxwjCTDy
         P9/xXcB1gSI48xVfvhW+TGsuIkG9MyrHzpe87dWp8JQXy52ZvGhEK4ZRUxicJ86VVqeu
         ibtEw62j2AgOP3xenIj0b0FpscjzH0KDBwY3nNL/0WMqHVqkYzHum8tqxePKKWejB3F2
         haptiSLFjjaowbU1k1BmNf5HRT0e6tPnv86sQ6OTw7zW4ijL9L27AVcKW28F9kLMcR10
         yaCw==
X-Received: by 10.42.80.9 with SMTP id t9mr654163ick.14.1371149364796; Thu, 13
 Jun 2013 11:49:24 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 11:48:44 -0700 (PDT)
In-Reply-To: <7vvc5hubox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227772>

Junio C Hamano wrote:
>> At this point, the utility of such a message is in question.
>
> You can question, but I am not convinced the answer is an
> unambiguous "not useful"

I am not arguing for an unambiguous "not useful".  I am arguing for a
practical compromise: this patch locks things up too tightly, and
makes life hell for contributors who want to improve reflog messages.
To be clear: the problem is not the feature, but rather in the
_implementation_ of the feature.

> You were at 1.8.2 but no longer are, so in the following sequence:
>
>     $ git checkout v1.8.2
>     $ git status
>     $ git reset --hard HEAD^
>     $ git status
>
> the former would say "detached at v1.8.2" while the latter should
> *not*, because we are no longer at v1.8.2.  "detached from v1.8.2"
> is too subtle a way to express the state, and is confusing, but I
> would not be surprised if people find it useful to be able to learn
> "v1.8.2" even after you strayed away.

What is wrong with git describe?  Is this cheaper, or am I missing something?

>> Moreover,
>> there are several tests in t/status-help that explicitly rely on rebase
>> writing "checkout: " messages to the reflog.  As evidenced by the
>> failing tests in t/checkout-last, these messages are completely
>> unintended and flaky.
>
> The above only helps to convince me that "rebase should not affect
> what the last checked-out branch was by letting 'checkout' it
> internally calls to write reflog entries for it"  With patches 6, 2,
> and 3, I thought you fixed that issue.

I also thought of ignoring the first line in the actual output ("HEAD
detached from/to"), and comparing the rest to make the tests pass.  At
that point, you start to wonder: what is this fantastic feature that
we are bending over backwards for?
