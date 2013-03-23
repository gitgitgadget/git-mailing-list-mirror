From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] t5521 (pull-options): use test_commit() where appropriate
Date: Sat, 23 Mar 2013 18:08:22 +0530
Message-ID: <CALkWK0n4CT-Pfm22vTToVp2kZqT7h9kBtF-1NoPOg3vOc+MSog@mail.gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-3-git-send-email-artagnon@gmail.com> <7vy5df74yt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:39:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJNj4-0005tz-Tt
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795Ab3CWMin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 08:38:43 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:55019 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3CWMin (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 08:38:43 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so4335800iaa.15
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RhbxsWp2NgwWeJVy1w3sQB7C2dVsS1mn6ptadN+NK+k=;
        b=FQdG7orT/QQUVdb6TF0f95DoHkmzwby1t2zlPxqbdV8RL6wHkM424XwxU4DOisxCLa
         ECnBroDptuWxLl//hdoaePwQ94BLag/u+MCBgHn6nzNI9xLfUGsL/l8uwpCY8hRzVOjm
         8gN+W52W5AWRMB/rVVyzCUZYjybLxpB0Sfja41iBgS6jliDZaEa7VpkffOPPsatlXfIz
         g96GrzCxbJAi1Obf6GT3VXZfqwNy0wi7Zz7oH1mgT3S0ODSlf53F99XgMRAzfG37JYOe
         lp9LCmyOO2uiXKGlKiw6HZ6GCtm4o7vi9eLYdqPA8uj2UYZq94lilOGhthNzSyeDUIAo
         PKVg==
X-Received: by 10.42.204.79 with SMTP id fl15mr2956139icb.57.1364042322814;
 Sat, 23 Mar 2013 05:38:42 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 23 Mar 2013 05:38:22 -0700 (PDT)
In-Reply-To: <7vy5df74yt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218909>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> test_commit() is a well-defined function in test-lib-functions.sh that
>> allows you to create commits with a terse syntax.  Prefer using it
>> over creating commits by hand.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  t/t5521-pull-options.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
>> index 1b06691..4a804f0 100755
>> --- a/t/t5521-pull-options.sh
>> +++ b/t/t5521-pull-options.sh
>> @@ -7,8 +7,8 @@ test_description='pull options'
>>  test_expect_success 'setup' '
>>       mkdir parent &&
>>       (cd parent && git init &&
>> -      echo one >file && git add file &&
>> -      git commit -m one)
>> +      test_commit "one" file "one"
>> +     )
>>  '
>
> In this test script perhaps it is OK, but I'd prefer people being
> careful *not* to use test_commit in tests that involve refs (i.e.
> pushing, pulling, ls-remote, for-each-ref, describe...) and paths
> (i.e.  ls-files, diff, ...).

Okay.

> There is one good point in the helper: it creates a commit with a
> predictable timestamp.

Yes, test_tick.  I've noticed that several tests call test_tick by
hand before invoking "git commit".

> But it does a lot other *bad* things than that single good thing.
> It adds a new path, and adds a new tag; neither of which is not
> desirable in many circumstances.
>
> A better future direction would be to first make these "frill"
> features into options to test_commit helper, fix the users that
> depend on these additional tags and stuff to explicitly ask for
> them, and then start advocating it for wider use, I think.

Agreed.  In fact, the commit message is constrained, because of this;
you can't create a commit with a commit message involving spaces,
because that would result in an invalid tag name.
