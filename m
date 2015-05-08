From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Fri, 08 May 2015 12:59:04 +0200
Message-ID: <87r3qrwd1j.fsf@hank.tgummerer.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com> <1430988248-18285-12-git-send-email-pyokagan@gmail.com> <05adfac12cb9a7ad183281974d991e00@www.dscho.org> <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com> <554BB93A.3090000@kdbg.org> <8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 08 12:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqfzu-0000HN-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 12:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbbEHK7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 06:59:09 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:32804 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbbEHK7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 06:59:07 -0400
Received: by wgin8 with SMTP id n8so69017389wgi.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=ooprltrfpsqbP6oqloEc7eWvFS/5XDgoQJITkKsz3+A=;
        b=Z8DVbLMNPnjjeXKLvQltPTbasYCZvjVFur8YsXV+iiiZrsgjTbDAto7b3hExwWvdFp
         wsoJoy3qcb+3oye0Un0HbQWMRle8NVJ+nwUCr9wBC/ShW6QioEgYter6boSF7dy401oW
         xxiXPGyQcGcZR2gj0GRQyMZB4GSh6oEqtG375bA5sUwF//UAlePdXJ56lFbW89cMQJec
         W5TjqH1li9BgUE6zGNRYI5FmYNmOrZoI3eUkSvvPDFr7O1FW/5M4XRgSRJ1LdkENpBpz
         xvYlWZQBK8+l9nFU46NrWmbgI8EpLxQSG9WUpf18zj2wyoWR3/M+GWRm1kmHXwyrnaLs
         8Y9g==
X-Received: by 10.180.211.2 with SMTP id my2mr5037105wic.78.1431082746039;
        Fri, 08 May 2015 03:59:06 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id jq3sm7819120wjc.22.2015.05.08.03.59.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 03:59:04 -0700 (PDT)
In-Reply-To: <8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
User-Agent: Notmuch/0.19~rc1+3~g0d8251d (http://notmuchmail.org) Emacs/24.5.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268612>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Hannes,
>
> On 2015-05-07 21:12, Johannes Sixt wrote:
>> Am 07.05.2015 um 19:06 schrieb Paul Tan:
>>
>>> On Fri, May 8, 2015 at 12:28 AM, Johannes Schindelin
>>> <johannes.schindelin@gmx.de> wrote:
>>>
>>>> On 2015-05-07 10:44, Paul Tan wrote:
>>>>> @@ -32,4 +35,18 @@ test_expect_success pull '
>>>>>   )
>>>>>   '
>>>>>
>>>>> +test_expect_failure '--log=1 limits shortlog length' '
>>>>> +(
>>>>> +     cd cloned &&
>>>>> +     git reset --hard HEAD^ &&
>>>>> +     test `cat afile` = original &&
>>>>> +     test `cat bfile` = added &&
>>>>> +     git pull --log &&
>>>>> +     git log -3 &&
>>>>> +     git cat-file commit HEAD >result &&
>>>>> +     grep Dollar result &&
>>>>> +     ! grep "second commit" result
>>>>> +)
>>>>
>>>> I think it might be better to use `test_must_fail` here, just for
>>>> consistency (the `!` operator would also pass if `grep` itself could not
>>>> be executed correctly, quite academic, I know, given that `grep` is
>>>> exercised plenty of times by the test suite, but still...)
>>>>
>>>> What do you think?
>>>
>>> Yep, it's definitely better. Sometimes I forget about the existence of
>>> some test utility functions :-/.
>>
>> Nope, it's not better. test_must_fail is explicitly only for git
>> invocations. We do not expect 'grep' to segfault or something.
>>
>> Cf. eg.
>> http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258752
>
> That link leads to a patch that changes `! grep` to a `test_must_fail grep` and is not contested, at least not in the thread visible on GMane. Would you have a link with a more convincing argument for me?

t/README states:

   On the other hand, don't use test_must_fail for running regular
   platform commands; just use '! cmd'.  We are not in the business
   of verifying that the world given to us sanely works.

Except for a few cases that is also respected in the test scripts.

$ git grep "! grep" | wc -l
203
$ git grep "test_must_fail grep" | wc -l
19

So I think using ! grep is the right way to go.

> Thank you,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
