From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-svn: fix fetch with deleted tag
Date: Sat, 14 Aug 2010 19:08:42 +0000
Message-ID: <AANLkTi=FKDa4sTTd1b=9yxsWafY1jEEdPrHZ88+uPozi@mail.gmail.com>
References: <1281794831-33347-1-git-send-email-ddkilzer@kilzer.net>
	<AANLkTinpLUyQP=6XktduWAmSHg3CgcT3Y7cMJ9FQ4by_@mail.gmail.com>
	<84607.29034.qm@web30003.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sat Aug 14 21:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkM6T-0001qp-Nm
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 21:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115Ab0HNTIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 15:08:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41095 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab0HNTIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 15:08:44 -0400
Received: by gxk23 with SMTP id 23so1471449gxk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jtz49wKOE9fsperhx9Eh3U+CFpR3X8RYDVTgcJ5/ZVk=;
        b=Bo1QfD2iTNh1Pub5DkXybCHgggDA1aFvQ6PY/dOVO0JM5l5AOT4deerSlg8Lgkp/Pt
         Ru6Lu036/jd7Kqm6wLek7MXG21Sn+9VL0L96oKmKLSMnxSQNsTHZWhJSZ3lpTV5W7WrH
         z4VOttKWMiFINEAiKFC60YgEnNTgteVXerur8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cyakyav7Vz7SVMSOGr7j51Ov5Y9bCLvTD78rp4WOlN6wrgsGWZS2Xj7ZIFpSo5efXS
         WTByOrYOMDMQaxpazx8s0OGkrY7LWOLNhmpiWhD8LYQ1MmpmjMrfBcR7pe3/I6a2JwXw
         9o3CKlCTGG09m5j5fWKCTqM2twEVVUIayMkvg=
Received: by 10.231.15.195 with SMTP id l3mr3164574iba.188.1281812922894; Sat,
 14 Aug 2010 12:08:42 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 12:08:42 -0700 (PDT)
In-Reply-To: <84607.29034.qm@web30003.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153573>

On Sat, Aug 14, 2010 at 18:49, David D. Kilzer <ddkilzer@kilzer.net> wr=
ote:
> On Sat, August 14, 2010 at 7:52:48 AM, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> On Sat, Aug 14, 2010 at 14:07, David D. Kilzer <ddkilzer@kilzer.net>=
 wrote:
>> > =C2=A0+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
>> > =C2=A0@@ -0,0 +1,45 @@
>> > +#!/bin/sh
>> > +
>> > +test_description=3D'git =C2=A0svn fetch deleted tag 2'
>>
>> Any reason not to include both of these in the =C2=A0same file? Just=
 to
>> avoid having to manually reset the =C2=A0repository?
>
> It was easier to run the tests individually when working on them, and=
 I was
> hesitant to combine the setup steps from each test since it wouldn't =
be as clear
> which steps were for which test in the future.

If you think it's easier to maintain like this then by all means keep
it as it is. I was just wondering why it was like this, that's all.

> I realize this may be slower when running the tests, but it makes
> them easier to maintain, especially when one hasn't looked at the
> tests in a while.

The SLOOOOW part of running the git svn tests is definitely *not* the
tiny bit of shellscript required to execute each *.sh file :)

> Is there a nice way to reset the repository between steps?

I don't know if this applies in this case but if you need fresh repos
for each tests you can usually do:

    test_expect_success 'test #1' '
        (test_create_repo one &&
        cd one &&
    	...)
    '

    test_expect_success 'test #2' '
        (test_create_repo two &&
        cd two &&
    	...)
    '

But I haven't looked at the svn_* functions you're using, so perhaps
that's not possible here.

> Thanks for the feedback! =C2=A0I've already applied your other sugges=
tions.

Cool, good to know that it was helpful.
