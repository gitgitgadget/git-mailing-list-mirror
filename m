From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 20:52:47 +0200
Message-ID: <539B487F.4030104@gmail.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io> <1402601942-45553-4-git-send-email-caleb@calebthompson.io> <20140613065942.GB7908@sigill.intra.peff.net> <20140613163644.GB85151@sirius.local> <539B3205.5010208@gmail.com> <20140613174745.GA88614@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Fri Jun 13 20:52:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvWav-0000OT-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 20:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbaFMSwx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 14:52:53 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:46684 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaFMSwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 14:52:53 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so3153273wgh.14
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LCSfjml0up1tR+QSq6UjYqIIBoqapU3CGglTLOxpToo=;
        b=pjQXHQZRjc7tIhJfyBtU3A1uLK9uzm5SWrG5JynKSMLRdZrTxqKsxDNQOGo1VFXlq/
         4Jas/rfVK6CMo+MroZcBvJ3pSM0W+JosxGiZJ3vJZStfKLDxoV8aWleSj/Pfxhauxtmu
         Uz0Xr5AXPOWJgrzZv8+cXzrCyCxfvGT+1+R/3N/odfn1HE26RqmTWfM+ZUew5JBhnipf
         VBJLboNmuOzjanU6nzWhJJ+aOPIqo9njLseoYX1If02pL/XWmG1taMoucFyiHazctFEk
         DZzZByzZEdFngG2YPSZYw/H2kUC6g8IC+6xKW3glAeNapZESOy8tM9ItA89a8S8DFJSq
         rZsQ==
X-Received: by 10.194.246.234 with SMTP id xz10mr6779413wjc.77.1402685571878;
        Fri, 13 Jun 2014 11:52:51 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id e6sm13558537eem.44.2014.06.13.11.52.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 11:52:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20140613174745.GA88614@sirius.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251628>

W dniu 2014-06-13 19:47, Caleb Thompson pisze:
> On Fri, Jun 13, 2014 at 07:16:53PM +0200, Jakub Nar=C4=99bski wrote:
>> W dniu 2014-06-13 18:36, Caleb Thompson pisze:

>>>      t/t7507-commit-verbose.sh was using a global test_set_editor c=
all to
>>>      build its environment. The $EDITOR being used was not necessar=
y for
>>>      all tests, and was in fact circumvented using subshells in som=
e
>>>      cases.
>>>
>>>      To improve robustness against global state changes and avoid t=
he
>>>      use of subshells to temporarily switch the editor, set the edi=
tor
>>>      explicitly wherever it will be important.
>>>
>>>      Specifically, in tests that need to check for the presence of =
a diff in the
>>>      editor, make calls to set_test_editor to set $EDITOR to check-=
for-diff
>>>      rather than relying on that editor being configured globally. =
This also
>>>      helps readers grok the tests as the setup is closer to the ver=
ification.
>>
>> This also allows to run only specified subset of tests
>> with TEST_SKIP without requiring to remember which tests
>> are setup tests and have to be not skipped, isn't it?
>
> I don't see any references to TEST_SKIP in the code. Do you mean
> test_skip() from t/test_lib.sh? If so, it isn't clear to me what the =
use
> case would be for that, so I'd have to take your word.

I meant here GIT_SKIP_TESTS, but I see that test_set_editor was not in=20
first test i.e. test_expect_success 'setup', so it wouldn't matter.
Before and after both work correctly with GIT_SKIP_TESTS, before becaus=
e
of global setup.

I'm sorry for the noise, then.

--=20
Jakub Nar=C4=99bski
