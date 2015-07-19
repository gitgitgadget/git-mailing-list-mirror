From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Sun, 19 Jul 2015 13:25:30 +0530
Message-ID: <CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com>
	<CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
	<CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
	<CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 09:55:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGjRh-0003y8-Dr
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 09:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbbGSHzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 03:55:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38722 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbGSHzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 03:55:32 -0400
Received: by wibxm9 with SMTP id xm9so1581255wib.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=T9yDjJze5nnxZH0pjxN4GxMVt3uvBOw4sZ8euuRTm7c=;
        b=iQCTPACNJDcpm2jRvpAsjzNnVzIy9ns5886+j2lJO5HEWvxDJE/3OM4/ZxSsKaOoXF
         xtuTJ/nJPKNsNvUzm/oukU2TIPh+1Zm1SgKcAa4dX6wxl7HDzrVLGfEKz8DaqAE9Fw0/
         xiSOEeaV98M0n1zxZUXz+ZIDW9MxtqS7FoO8vPap+L1fnFrJfeYcB85Mtea9uZlqIUmS
         IHLlKb9+fjUP7xjOdKXSkyzqWnpndecq/LQScHZ8wocS5XqDOQDZ1/zNAZcPvSDy30FO
         96eATQibyQ1Ljzn8MtkVqm/tVEiKXootCBR/SVmz2Tho7yWmoOHOnejF3x6VuNwXrIp7
         z5Gw==
X-Received: by 10.194.84.179 with SMTP id a19mr44233448wjz.29.1437292530792;
 Sun, 19 Jul 2015 00:55:30 -0700 (PDT)
Received: by 10.28.143.1 with HTTP; Sun, 19 Jul 2015 00:55:30 -0700 (PDT)
In-Reply-To: <CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274204>

@Junio: So from your detailed explanation (and Jake's comment), i
understand that since my ref wasn't updated on remote so querying the
same using "git describe" resulted in failure, and hence, code was not
entering the IF block. Correct?

Also, while i was reading your replies, i was just thinking that the
following question that i asked Jake doesn't really make sense because
a commit object _is_ being passed (on local machine) to "git
describe", which is what it expects so it should work for sure:

"If i got the above right, then shouldn't Git throw an error even on
my local machine when i'm running "git describe --exact-match
ac28ca721e67a"?"

@Junio: You wrote: "The part that I find questionable is that by
checking with "is this commit a tagged one?" and doing different
things. What makes the initial and the third special to deserve
checking (because they are not annotated with a tag) while skipping
the validation for the second (merely because it has an annotated tag
added to it)?"
> Isn't the code that i shared doing just the opposite of what you've written? It's checking for annotated tags only and skipping the lightweight ones (although it shouldn't be doing all such things in the first place). Was it a typo on your part?


@Jake: For the question you asked: "It would help a lot if we
understood exactly what you are trying to accomplish."
> I'm not sure how my colleague zeroed in on this "git describe" command but i at least know what we observed (and 'seemed' to work).  We saw that if we use git-describe and pass a commit object, it throws fatal error message. On the other hand, if we pass a tag object, it doesn't throw any fatal error. That's the reason he added that tag check portion.


@Junio/Jake: After going through all the responses that i've received
so far on this forum, i'm thinking how this nonsense code worked for
few cases in the past? When this check was put in place, devs were
getting error while pushing annotated tags. Since we use Gitolite, we
added the following to gitolite.conf and the tag push worked for them:

RW+ refs/tags=developer_name

I'm wondering why.


On Sun, Jul 19, 2015 at 3:52 AM, Jacob Keller [via git]
<ml-node+s661346n7635854h97@n2.nabble.com> wrote:
> On Sat, Jul 18, 2015 at 1:08 PM, Gaurav Chhabra
> <[hidden email]> wrote:
>
>> Thanks for the comments Junio/Jacob! Actually, the script was written
>> by someone before i came and the tag check was also done by my
>> colleague recently. I was also trying to implement the tag check
>> (using refs/tags which i did saw in few links online) but since my
>> colleague implemented this 'git describe' thing first and it looked
>> like it was working for few cases that we tried, so we left it as is.
>> Frankly, since everything 'seemed' to be working well so far, i never
>> really quite looked into it. Now i guess, it's time to correct it.
>>
>>
>> @Junio: From the example you gave, i could conclude the following:
>>
>> 1) : gitster garbage/master; git commit --allow-empty -m third
>>   [master d1f1360] third
>>   : gitster garbage/master; git describe --exact-match HEAD ;# third
>>   fatal: no tag exactly matches 'd1f1360b46dfde8c6f341e48ce45d761ed37e357'
>>
>>> Since after # third commit, no tag was applied to HEAD, so --exact-match
>>> resulted in fatal error
>>
>> 2)  : gitster garbage/master; git commit --allow-empty -m second
>> [master d1de78e] second
>> : gitster garbage/master; git tag -a -m 'v0.1' v0.1
>> : gitster garbage/master; git describe --exact-match HEAD^ ;# second
>>     v0.1
>>> Since annotated tag was applied after # second commit, so --exact-match
>>> did referenced the commit as expected.
>>
>> 3) : gitster garbage/master; git commit --allow-empty -m initial
>>   [master (root-commit) b18cac2] initial
>>   : gitster garbage/master; git tag v0.0 ;# lightweight
>>   : gitster garbage/master; git describe --exact-match HEAD^^ ;# first
>>   fatal: no tag exactly matches 'b18cac237055d9518f9f92bb4c0a4dac825dce17'
>>
>>> In this case, it's a lightweight tag and i read today that by default,
>>> git describe only shows annotated tags (without --all or --tags). I think
>>> it's because of the missing option (--all or --tags) that it resulted in
>>> fatal error in this case.
>>
>> Please correct me if i misunderstood any/all of the above cases.
>>
>> My queries:
>> A) When you mentioned: "I am feeding three _commits_, not tags.", i
>> didn't really get what you're trying to highlight. Is it that the code
>> i shared 'incorrectly' uses 'git describe' command because it's
>> passing the commit ($new_sha1) associated with pushing of the tag
>> _instead_ of passing the commit id that the tag actually points to?
>>
>> B) Coming to the earlier part of the code that you questioned. Thanks
>> for that. As i mentioned above, some guy had written it long time back
>> (few years). And again, since this never caused any issue, we never
>> looked into it. I did read a little about rev-list today but i think
>> i'll have to try it out on my machine to understand it well. Will read
>> more and then implement the check but yes, i do get an idea what
>> you've tried to question. Basically, for new branch or new
>> development, we are not really doing complete checks. Correct?
>>
>> You've also mentioned that "And you check everything on that list.  Why?"
>>> Was this comment for the portion where the code is validating commits
>>> (git rev-list $old_sha1..$new_sha1) for existing branch? If yes, then i
>>> didn't really get your concern. Can you kindly elaborate a bit?
>>
>> And thanks for sharing the modified version! :)
>>
>>
>> @Jacob: You're right. If i understood correctly what Junio explained,
>> then what the code is doing really shouldn't make any sense at all. :)
>>
>> By the way, you mentioned, "Ok, so the issue I believe is this: you're
>> running git describe on the local side. But the pre-receive hook
>> hasn't actually accepted the ref yet so git-describe on the server
>> will fail."
>>> When i push a tag, then as per the output i shared, the commit id
>>> associated with my tag push is ac28ca721e67a. So if i do a "git describe
>>> --exact-match ac28ca721e67a", then
>>
>> 1) First of all, it shouldn't make any sense because as "git describe"
>> should accept _actual_ commit id and not the commit id generated for
>> tag push, isn't it?
>
>
> git describe will attempt to describe the commit ID you pass it. But
> the tag object for a "new" tag push will not get "described" because
> the pre-receive hook runs before you push it.
>
> It would help a lot if we understood exactly what you are trying to
> accomplish.
>
> If you run git describe locally, it will find the annotated tag you
> made. If you run this remotely during the pre-receive of the tag that
> you now now pushing it will not. ie:
>
> $git tag -a some-new-tag ac28ca721e67a
> $git describe --exact-match ac28ca721e67a
> <succeeds and finds "some-new-tag"
> $git push origin some-new-tag
> <pre-receive runs>
> git describe --exact-match ac28ca721e67a
> <FAILS because the "some-new-tag" hasn't actually bet put into refs yet>
>
> See the difference here? Maybe this isn't what you are trying to do at
> all? What exactly behavior do you want to not allow?
>
> Regards,
> Jake
>
>>
>> 2) If i got the above right, then shouldn't Git throw an error even on
>> my local machine when i'm running "git describe --exact-match
>> ac28ca721e67a"?
>>
>
> Not with my example above. But maybe I'm incorrect entirely in what
> you are actually doing?
>
>>
>> @Junio/Jacob: I think i've asked quite a number of questions above but
>> i will really appreciate if you could spare some time to clear these
>> doubts. I'm definitely going to change this junk code but i would like
>> to be sure that i've understood your explanations well.
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to [hidden email]
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> ________________________________
> If you reply to this email, your message will be added to the discussion
> below:
> http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635764p7635854.html
> To unsubscribe from Git tag: pre-receive hook issue, click here.
> NAML
