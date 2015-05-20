From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 19:19:59 -0700
Message-ID: <xmqqegmcour4.fsf@gitster.dls.corp.google.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	<6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	<CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	<1432070690.14498.4.camel@kaarsemaker.net>
	<xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
	<1432072167.14498.12.camel@kaarsemaker.net>
	<xmqqmw10p6ad.fsf@gitster.dls.corp.google.com>
	<1432074626.14498.16.camel@kaarsemaker.net>
	<CAPc5daUF_yotXVf_=CFz_q1GBXVdq8pJxeuNuv=BAC54TJVT9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed May 20 04:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YutcG-0005hz-V8
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 04:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbbETCUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 22:20:04 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37829 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbbETCUC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 22:20:02 -0400
Received: by igbsb11 with SMTP id sb11so29283215igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ipailJQyA8tLo5u6Tgc97/QWKDRaokJ7XD8PMusWQa4=;
        b=Et9u0DSZ/oa+LR9KYMB0fYD7iR/ppUODZB4BKpEuqdb31lWNtGHER3REChxY71iKKJ
         sJDfbvDo1afeGt9Y6Ut05MEGj7QKlmCjw3CpjWUZ2qCIY9C2KEeCOBliOrmRbvRFj3m8
         nV89TRB3q/g8AoVfIGzUQEDs9iBa+T0vcB1AC4r1HpXBbfXs1TxrQ0K9JWPZmkOAoDHY
         ggnwaBeSRrGitAwdEhJCvnVwHFkwLJe7Sm+Ni4SwYFtP+ln7OWtZxGodlVsikWeIOVFn
         e3klnG8cC1yy9F4UAf69L8d+isa1DYajnLNnm5LMNwO8dKPJ7gLZFIA2/2UvVDrpCkkX
         MKNg==
X-Received: by 10.43.19.72 with SMTP id qj8mr32711372icb.68.1432088401688;
        Tue, 19 May 2015 19:20:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id h138sm11379940ioe.2.2015.05.19.19.20.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 19:20:00 -0700 (PDT)
In-Reply-To: <CAPc5daUF_yotXVf_=CFz_q1GBXVdq8pJxeuNuv=BAC54TJVT9w@mail.gmail.com>
	(Junio C. Hamano's message of "Tue, 19 May 2015 16:14:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269434>

Junio C Hamano <gitster@pobox.com> writes:

> On Tue, May 19, 2015 at 3:30 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> On di, 2015-05-19 at 15:10 -0700, Junio C Hamano wrote:
>>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>>
>>> > I've actually done it differently while implementing:
>>> >
>>> > 1) Make test_commit recognize --tags and stop creating tags unless
>>> >    specified
>>> > 2) while ! prove --state=save,failed {
>>> >        Find and fix tests that now need --tags
>>> >    }
>>>
>>> That was what I feared.  The result of that process is the hardest
>>> to reason about and review.
>>
>> I'm not quite sure I understand what you're trying to say. You seem to
>> be worried that there will be silent successes for tests that should
>> fail after N/N if I take the proposed approach. I have no idea how that
>> could happen though.
>
> You are placing too much faith in the tests. We would want to see
> a conversion that is reasonable and indeed reasoned by eyeballing
> the change for correctness.

To put it in another way, imagine this scenario.

Six months ago, you found a bug in "git frotz" command.  The bug
triggered only when a commit had an extra tag pointing at it.  You
fixed the bug, and in order to protect your fix from getting broken
by other people, added a new test that would have failed with the
bug present, perhaps like this:

    test_expect_success 'commit with an extra tag' '
	test_commit sample &&
        git frotz HEAD
    '

Fast forward to today.  You changed "test_commit" and it no longer
creates a tag by default with your step 1.

You run this test again.

It will pass.

Why?  "git frotz" command used to break when you had tag, but did
not break if you didn't have the tag even without your bugfix six
months ago.

Next week, somebody will accidentally break the bugfix you did six
months ago.  "git frotz" again does not work correctly when the
commit is pointed at by a tag.  But with the test will not catch
this breakage.

The problem was that your step 1 broke this test, and your step 2
of running the test did not catch the fact that you broke it.

Hopefully now you have some idea how your approach is problematic.
