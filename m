From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Mon, 23 May 2011 11:58:49 +0200
Message-ID: <4DDA2FD9.5070807@drmicha.warpmail.net>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org> <1306058055-93672-1-git-send-email-davvid@gmail.com> <4DDA0044.2060207@drmicha.warpmail.net> <FE7878D1-20E4-4CD4-B3FB-96322AA75855@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Hei?= =?ISO-8859-1?Q?tzmann?= 
	<frederic.heitzmann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 11:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QORuf-0003sx-F0
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 11:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab1EWJ6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 05:58:53 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:45640 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753004Ab1EWJ6w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 05:58:52 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4ED9F20821;
	Mon, 23 May 2011 05:58:51 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 23 May 2011 05:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Zcfxdqv3rfCmqtGbbtASYF+TESs=; b=g4bMYPjELtRv9Te8ZTqssS+R6ELCU2xpHGEBEgKhHG+Pw6nUUZPxKKcJaHy3LBUjwbw1ajESWLOAy1woyxqRpezb1CR5hbTv+DrBl7eLkvV8fsCvUKseyXJPBgvFXj9kMTKnIf7HYrZ7by4ir/3YmzzynhnuMCWc7sioZlzjZ4s=
X-Sasl-enc: kx7YEbAigBiTSilB0UJFjqPe8LkUqv89+ufFi9HH6H7w 1306144730
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6F95F4022C5;
	Mon, 23 May 2011 05:58:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <FE7878D1-20E4-4CD4-B3FB-96322AA75855@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174235>

David Aguilar venit, vidit, dixit 23.05.2011 10:40:
> Added git@vger to the cc list. I sent y'all two copies of these patches because I forgot to cc the list the first time...
> 
> On May 22, 2011, at 11:35 PM, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>> David Aguilar venit, vidit, dixit 22.05.2011 11:54:
>>> GIT_PREFIX was added in 7cf16a14f5c070f7b14cf28023769450133172ae so that
>>> aliases can know the directory from which a !alias was called.
>>>
>>> Knowing the prefix relative to the root is helpful in other programs
>>> so export it to built-ins as well.
>>>
>>> Signed-off-by: David Aguilar <davvid@gmail.com>
>>> ---
>>> setup.c                 |    6 ++++++
>>> t/t1020-subdirectory.sh |   16 ++++++++++++++++
>>> 2 files changed, 22 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/setup.c b/setup.c
>>> index b6e6b5a..fc169a4 100644
>>> --- a/setup.c
>>> +++ b/setup.c
>>> @@ -603,6 +603,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>>    const char *prefix;
>>>
>>>    prefix = setup_git_directory_gently_1(nongit_ok);
>>> +    /* Provide the prefix to all external processes and programs */
>>> +    if (prefix)
>>> +        setenv("GIT_PREFIX", prefix, 1);
>>> +    else
>>> +        unsetenv("GIT_PREFIX");
>>> +
>>
>> Do we really want to unset it? This is different from the existing
>> behaviour (but not more useful). But see also my comment on 3/3: We may
>> want to do something different which is also more useful.
> 
> I thought the behavior was actually the same.
> 
> The current alias code sets the value GIT_PREFIX= in the strbuf. When prefix is empty nothing else is added to the strbuf. The run_command  function actually checks for FOO= with empty after the equals sign and translates it into unsetenv. That allows code to unset vars using that interface.
> 
> If we can do something better that'd be good. Unsetting the variable also protects us from whatever randomness might be in there, which was my primary concern.
> 
>>
>>>    if (startup_info) {
>>>        startup_info->have_repository = !nongit_ok || !*nongit_ok;
>>>        startup_info->prefix = prefix;
>>> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
>>> index ddc3921..a85b594 100755
>>> --- a/t/t1020-subdirectory.sh
>>> +++ b/t/t1020-subdirectory.sh
>>> @@ -139,6 +139,22 @@ test_expect_success 'GIT_PREFIX for !alias' '
>>>    test_cmp expect actual
>>> '
>>>
>>> +test_expect_success 'GIT_PREFIX for built-ins' '
>>> +    # Use GIT_EXTERNAL_DIFF to test that the "diff" built-in
>>> +    # receives the GIT_PREFIX variable.
>>> +    printf "dir/" >expect &&
>>> +    printf "#!/bin/sh\n" >diff &&
>>> +    printf "printf \"\$GIT_PREFIX\"\n" >>diff &&
>>> +    chmod +x diff &&
>>> +    (
>>> +        cd dir &&
>>> +        printf "change" >two &&
>>> +        env GIT_EXTERNAL_DIFF=./diff git diff >../actual
>>
>> In passsing, this also tests the fact that GIT_EXTERNAL_DIFF is relative
>> to the repo root and not to cwd...
> 
> That's true. Another thing is that this only affects built-ins. I wanted to set the variable for git-foo external programs too but that means adding a call to setup_git_directory_gently() which we currently do not do in that codepath.  I guess external scripts can call rev-parse --show-prefix themselves? Or is this worth making consistent?
> 
>>
>>> +        git checkout -- two
>>> +    ) &&
>>> +    test_cmp expect actual
>>> +'
>>> +
>>> test_expect_success 'no file/rev ambiguity check inside .git' '
>>>    git commit -a -m 1 &&
>>>    (
>>
>> Overall I think it's a good change, btw. But it leaves it up to the
>> (script) user to know whether git has actually changed the cwd or not,
>> i.e.: Is $(pwd) where the user called us from or $(pwd)/$GIT_PREFIX?
>> That may may be a non-issue, though.
>>
>> Michael
> 
> It's a non-issue for my use case but I can see it being confusing.
> 
> For example, mergetool--lib's merge mode codepath can be run from subdirectories. The diff mode codepaths all assume that we are at the root (because git diff put us there).
> 
> Thanks (and please let me know if my unsetenv analysis is incorrect),

Our run_command() would convert "GIT_PREFIX" into an unsetenv(), but it
leaves "GIT_PREFIX=" to be a putenv(). E.g., the alias

env = !sh -c 'set -u && echo $GIT_PREFIX'

gives an empty result but errors out when you misspell GIT_PREFIX
intentionally.

I don't mind either way. "set -u" is a good script checker, and I seem
to remember that on Windows, we do something extra do keep the
distinction between unset and null. Can't find it right now.

Michael
