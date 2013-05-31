From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 09:14:49 +0100
Message-ID: <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 31 10:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKUP-0002kl-4x
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab3EaIO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:14:58 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:50677 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab3EaIOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 04:14:51 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so2466483obc.17
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=1RCtukshvp6+iWzfjpszPt5pjfpyq3ffFy0Z9kb60hA=;
        b=fGITMEswU56IwjRlfLA2kVOvTKjMpIpsOu7PR1n7iCYZrN8QKa2ea4/5mYna2vMAqT
         nkDzeicS/HhoFNUdT3fKhRZYnmqOfYsKwr45Qt3JOKJ8U2WlsECeef8OmgDHJQgFy1eE
         KB5uMTvHAXj4R3WTcdGwhdOR2ZpnM48HsBKi8QUsiJZKQv9VsaOibYhHOs2Rm68Ijdci
         54k+jIemVM+HvUsyhUEqVLvkMTF5fy+GhTHX2PFZ9mUWzZMZceUr+a9vNuj8fAnVu4Dr
         antlZ8AH08AbAbjE9GhaBTbGiGVtUzBPzKwEDF2DLiasnhZ1SjickE4qlVFJm58rQOeg
         E+rw==
X-Received: by 10.60.116.202 with SMTP id jy10mr5393257oeb.82.1369988089453;
 Fri, 31 May 2013 01:14:49 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Fri, 31 May 2013 01:14:49 -0700 (PDT)
In-Reply-To: <20130530193046.GG17475@serenity.lan>
X-Google-Sender-Auth: svlwR5S29smPFB1v1Hrj_qsVTUg
X-Gm-Message-State: ALoCoQmXlgnjjhP+FW8dm2gXTp8q39AEVhibK3c6ku3WQkNszI8HsmtR8FeCfPp4b/8a/Db1oMsJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226075>

On 30 May 2013 20:30, John Keeping <john@keeping.me.uk> wrote:
> On Thu, May 30, 2013 at 06:21:55PM +0200, Thomas Rast wrote:
>> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>>
>> > On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
>> >> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
> <snip>
>> > Will it be loading the blob for every commit it traverses or just =
ones that hit
>> > a tag? Why does it need to load the blob at all? Surely the commit
>> > tree state doesn't
>> > need to be walked down?
>>
>> No, my theory is that you tagged *the blobs*.  Git supports this.

Wait is this the difference between annotated and non-annotated tags?
I thought a non-annotated just acted like references to a particular
tree state?

>
> You can see if that is the case by doing something like this:
>
>     eval $(git for-each-ref --shell --format '
>         test $(git cat-file -t %(objectname)^{}) =3D commit ||
>         echo %(refname);')
>
> That will print out the name of any ref that doesn't point at a
> commit.

Hmm that didn't seem to work. But looking at the output by hand I
certainly have a mix of tags that are commits vs tags:


09:08 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags"
| grep "commit" | wc -l
1345
09:12 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags"
| grep -v "commit" | wc -l
66

Unfortunately I can't just delete those tags as they do refer to known
releases which we obviously care about. If I delete the tags on my
local repo and test for a speed increase can I re-create them as
annotated tag objects?

--=20
Alex, homepage: http://www.bennee.com/~alex/
