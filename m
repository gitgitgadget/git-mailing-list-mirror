From: Luke San Antonio <lukesanantonio@gmail.com>
Subject: Re: [Bug] git stash generates a different diff then other commands
 (diff, add, etc) resulting in merge conflicts!
Date: Tue, 13 Aug 2013 01:31:57 -0400
Message-ID: <5209C4CD.8040607@gmail.com>
References: <CAP+CFTZWzoAg=ni6t1aif-85y6W4-2JUT4wooapTvD0oGH+HRw@mail.gmail.com> <CABURp0oATJ58POmgYLjSmy-y84LTjkP0PTh4=3M-vc04_AoMdg@mail.gmail.com> <520872CC.3040507@gmail.com> <CABURp0rWMAs9vT791vp4BEYS-Y9Jmzjmt4bbuB+po8=vkiqUWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 07:32:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V97DO-00043h-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 07:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab3HMFcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 01:32:00 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:41737 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3HMFcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 01:32:00 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so6354030veb.31
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b+qPoN4HdPngH6l3kf+OnFNK+LCaej1Y5ynK2lIWYII=;
        b=HCkGrtw2zI5vFN6WmtMglYu8iR2vTP9V808Ull0XmlSZawbUrOtjVOsKfX9QCxhTWN
         HuYpvPoLBpiy96gJdnzEOKH1kbE0SdQAUU2QyAGtr4an5zAZ9kIbUwfqn8X2pK9AyNL0
         PVkK5qsF/FJZuSqYJmLkrVLNX+fCs4ax5jHMlgrC/YUWY4dp5qSGnMr/CwfHgQK+hPqG
         CNX48Oo/SRRdM5+Trs48lJWcQImF1dK+V2MiVU64VNZ9D5wJ5TMcal9fgE7DnxmTnzpJ
         CAJ5B/tDwA7xap5F62woFOpoPmeD21E2LgV+PQZLuUGgRXe7HtysT8+b8HVHBbKA5vzc
         eBPA==
X-Received: by 10.52.187.162 with SMTP id ft2mr2163266vdc.10.1376371919150;
        Mon, 12 Aug 2013 22:31:59 -0700 (PDT)
Received: from [192.168.1.6] (ool-457405c6.dyn.optonline.net. [69.116.5.198])
        by mx.google.com with ESMTPSA id jw6sm16595258veb.3.2013.08.12.22.31.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 22:31:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CABURp0rWMAs9vT791vp4BEYS-Y9Jmzjmt4bbuB+po8=vkiqUWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232211>

On 08/12/2013 12:05 PM, Phil Hord wrote:
> On Mon, Aug 12, 2013 at 1:29 AM, Luke San Antonio
> <lukesanantonio@gmail.com> wrote:
>> On 08/08/20130 04:54 PM, Phil Hord wrote:
>>> Luke,
>>>
>>> I think the issue is that your working directory receives your cached
>>> file when you say 'git stash --keep-index'.  When you restore the
>>> stash, your previous working directory now conflicts with your new
>>> working directory, but neither is the same as HEAD.
>>>
>>> Here's a test script to demonstrate the issue, I think.  Did I get
>>> this right, Luke?
>>>
>>>    # cd /tmp && rm -rf foo
>>>    git init foo && cd foo
>>>    echo "foo" > bar &&  git add bar && git commit -mfoo
>>>    echo "bar" > bar &&  git add bar
>>>    echo "baz" > bar
>>>    echo "Before stash  bar: $(cat bar)"
>>>    git stash --keep-index
>>>    echo "After stash  bar: $(cat bar)"
>>>    git stash apply
>> Actually no, in your script, the bar file has a modification in the working
>> tree which is in the same hunk as a change applied to the index. In my
>> project the changes that were added to the index are not modified further
>> in theworking tree.
>>
>> --------
>>
>> Not only that, but I found out why git was generated different patches!
>> I realized that when I removed a hunk appearing before the merge conflict
>> from the working tree and index, the merge conflict disappeared! Turns
>> out, we can forget about stashing for a minute!
>> First the hunk in my working tree:
>>
>> @@ -56,12 +56,14 @@
>>       bool running_ = true;
>>
>>
>>       /*!
>> -     * \brief The default font renderer, global to all who have a pointer
>> to
>> -     * the Game class.
>> +     * \brief The font renderer implementation, obtained from the config
>> file.
>>        *
>> -     * It need not be used at all!
>> +     * It should be used and passed along to member objects by GameStates!
>> +     *
>> +     * \note It can be cached, but not between GameStates, meaning it
>> should be
>> +     * cached again every time a new GameState is constructed!
>>        */
>> -    std::unique_ptr<FontRenderer> font_renderer_ = nullptr;
>> +    FontRenderer* font_renderer_ = nullptr;
>>
>>       int run(int argc, char* argv[]);
>>
>> Most of this is unimportant, but notice the line number spec:@@ -56,12
>> +56,14 @@
>> The line number of this hunk doesn't change! Then I addeda few lines *above*
>> this hunk, (around line 30 I think). Here is the diff again:
>>
>> @@ -56,12 +58,14 @@
>>       bool running_ = true;
>>
>>
>>       /*!
>> -     * \brief The default font renderer, global to all who have a pointer
>> to
>> -     * the Game class.
>> +     * \brief The font renderer implementation, obtained from the config
>> file.
>> +     *
>> +     * It should be used and passed along to member objects by GameStates!
>>        *
>> -     * It need not be used at all!
>> +     * \note It can be cached, but not between GameStates, meaning it
>> should be
>> +     * cached again every time a new GameState is constructed!
>>        */
>> -    std::unique_ptr<FontRenderer> font_renderer_ = nullptr;
>> +    FontRenderer* font_renderer_ = nullptr;
>>
>>       int run(int argc, char* argv[]);
>>
>> Notice the new line number spec:@@ -56,12 +58,14 @@
>>
>> It moves two lines down, because I added those two lines before it, makes
>> sense!
>> But also notice that the patches are different, just because of the two
>> lines
>> above it!
>>
>> I thought I might be able to fix this problem by changing the new
>> diff.algorithm
>> config option to 'patience', but it seems to only affect how patches look,
>> not
>> how they are stored internally... Same problem!
>>
>> Also, I'm wondering why that line was picked up by git if the patches don't
>> match,
>> shouldn't git give me a conflict with the whole hunk, or is the system
>> smarter
>> than that?
> Git does not store patches.  Git stores the entire file.  I do not
> think the diff algorithm you choose will have any effect on the
> results of the merge.  But I am pretty clueless about the merge
> engine, so I could be off-base on this last part.
>
>> What if merging suppressed the conflict if both possibilities are the same?
>> Isn't
>> that reasonable, or is there some 1% where this could cause (silent but
>> deadly)
>> data loss.
> I think that is what Git is meant to do.  But I am confused now about
> where the failure is occurring for you.  Can you demonstrate the
> problem by modifying my test script?
>
> Is this more like it?
>
>    cd /tmp && rm -rf foo
>    git init foo && cd foo
>    printf "1\n2 foo\n3\n4\n5\n6\n7\n8 foo\n9\n10\n" > bar &&  git add bar
>    git commit -mfoo
>    printf "1\n2 XXX\n3\n4\n5\n6\n7\n8 foo\n9\n10\n" > bar &&  git add bar
>    printf "1\n2 XXX\n3\n4\n5\n6\n7\n8 XXX\n9\n10\n" > bar
>    echo "Before stash  bar: $(cat bar)"
>    git stash --keep-index
>    echo "After stash  bar: $(cat bar)"
>    git stash apply
>
> Phil
So I found an isolated case, it's very strange...

Here's a script!

   cd /tmp && rm -rf foo;
   git init foo && cd foo;
   git config --local diff.algorithm myers
   printf "\n\n-----------------\n\n\n    /*"'!'"\
\n     * ---------\n     * ^^^^^^^^^\n     *\n     \
* =========\n     */\n    |-----------|\n" > foo;
   git add foo && git commit -m "foo";
   printf "\n-----------------\n\n\n    /*"'!'"\
\n     * #########\n     *\n     * !!!!!!!!!\n     \
*\n     * @@@@@@@@@\n     * &&&&&&&&&\n     */\n    \
|===========|\n" > foo
   printf "s\nn\ny\ny\ny\n" | git add foo --patch > /dev/null
   git stash save --keep-index

Let me start off by apologizing for that! =D

... Copy and paste that into a terminal and you should have a recreated 
version of my repository there! Now that the file is partly stashed and 
partly in the index, check out the difference in diffs:

try:
   git diff --staged
then try:
   git stash show -p

You see the difference? Then pop the stash and you'll see a very 
obfuscated and verbose sample of what I am talking about!

Also, sorry about the typos in my last message, I guess I looked past 
them...

Thanks Phil, for you know, helping me out!
- Luke
