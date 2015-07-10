From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/10] ref-filter: add support to sort by version
Date: Fri, 10 Jul 2015 16:31:34 +0530
Message-ID: <CAOLa=ZROk=+mW8uVjpuxMVY9NP0eW4yk2Za8xYW5MAFWSGzXRw@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-4-git-send-email-karthik.188@gmail.com>
 <vpqfv4x792z.fsf@anie.imag.fr> <CAOLa=ZRs560_YBVMTpfKBvB1BF6ts+X_JGFTzhp7A_+YsjwqqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 10 13:02:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDW4X-0008Cz-Ph
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 13:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbGJLCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 07:02:14 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33436 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbGJLCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 07:02:05 -0400
Received: by oiyy130 with SMTP id y130so208754886oiy.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZVDnGb7DBlJe+WETlKfADWFNXCDIrDRGKZyG5xLvDA4=;
        b=dc4WATN6u8BDLY2Qz/SpQon9WpJKcjTYczC5NoHNoXCk+PibMnrim6uR1QXWF2kHHn
         kH7Cd4PjycjZdHgAb9VCctb/Np+2UGUYCt34i+kJMBIoFKrsUiqaCNxtK0kdgOBtcKaY
         3UicrI5BiSbi2+Vbnc7FcvDonOuWFEyEIoGXT1Mk70Hg7Lym+L6yfHBOIsa/pqnQ1/4c
         ZHB2KRy2db8vEfI4u0Y+5EuDmw6TZTRR9Gxi3ZTyxqgTgHNv8+tr+AiaG9ETj90p/LsB
         9g4t3I99v4Sg6KcXvPdBHsM30pX6PWwmAyjuHJWhE9N1whKrvRwFbnfwgdoBvEZy1xf5
         r1+g==
X-Received: by 10.202.180.133 with SMTP id d127mr17979069oif.104.1436526124218;
 Fri, 10 Jul 2015 04:02:04 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 04:01:34 -0700 (PDT)
In-Reply-To: <CAOLa=ZRs560_YBVMTpfKBvB1BF6ts+X_JGFTzhp7A_+YsjwqqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273815>

On Fri, Jul 10, 2015 at 4:22 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Jul 9, 2015 at 6:59 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Add support to sort by version using the "v:refname" and
>>> "version:refname" option. This is achieved by using the
>>> 'version_cmp()' function as the comparing function for qsort.
>>
>> You should elaborate on why you need this. Given the context, I can
>> guess that you will need this to implement tag, but for example I first
>> wondered why you needed both version: and v:, but I guess it comes from
>> the fact that 'git tag --sort' can take version:refname or v:refname.
>>
>> I think this deserves a test and documentation in for-each-ref.txt.
>
> I'll add it to "for-each-ref.txt" documentation.
> About the tests, there are already tests for the same in git-tag.txt and
> that's the only reason I did not repeat the tests in for-each-ref.
>

But since the porting is in a later commit, will add tests to for-each-ref.

>>
>> As-is, the code is a bit hard to understand. I first saw you were
>> allowing
>>
>>   git for-each-ref --format '%(version:refname)'
>>
>> (which you are, but only as a side effect), and then understood that
>> this was also allowing
>>
>>   git for-each-ref --sort version:refname
>>
>> A test would have shown me this immediately. Some hints in the commit
>> message would clearly have helped too.
>>
>
> Most of the sorting options have side effects in "--format", but yeah will add
> details in the commit message.
>
> --
> Regards,
> Karthik Nayak



-- 
Regards,
Karthik Nayak
