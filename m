From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sun, 11 Apr 2010 10:06:00 -0400
Message-ID: <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
	 <20100410042609.GA24295@coredump.intra.peff.net>
	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
	 <20100411102255.GB20484@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 11 16:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0xnt-0001Hy-PU
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 16:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab0DKOGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 10:06:05 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58914 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab0DKOGC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 10:06:02 -0400
Received: by bwz19 with SMTP id 19so314582bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uU9JXwxjj42qZyrM4YNGfR9nz2/LC2faK3WEbpSxizw=;
        b=NF3s2kwkPA/JrA0ukAIyReg9NXSnDCb3znoenW9L657zEFI92UY6hclK/PNtu6NgmZ
         VM3SBhdkq7ResPiIpdpV3ZM98ZU1Ly68hC2pYb2NJkZs2MIs9Sh9GAyNWmMReUy29FZN
         3f2gLhhvKn0oR+QmhyI5vcsEYAnbIa3bm/F0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ED1M7REi1vPjR3g/Er0a3cDIhDcCGshW3S733aYbwLvv/jMIBHjKiJnZpf9VxI4uIu
         1QQFtDB7a3fCq/110UkODAtewWm0s7tKYR4fRHAuQofvZuPSe1hXJcNhYeqiviE/si9w
         HClzZXK89PtHPywpXKxHPkuqVh/POKrzHwqtg=
Received: by 10.204.97.202 with HTTP; Sun, 11 Apr 2010 07:06:00 -0700 (PDT)
In-Reply-To: <20100411102255.GB20484@coredump.intra.peff.net>
Received: by 10.204.81.145 with SMTP id x17mr3179036bkk.31.1270994761010; Sun, 
	11 Apr 2010 07:06:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144649>

I got your point about the HEAD which is by default get's added to the
end of the command, so it becomes

git rebase --onto master topic HEAD

I will think about it it more.

I'm pretty sure that i was surprised by the fact that i've got
different behavior in interactive and non-interactive variants, but i
will recheck.

I forgot to mention it was in windows version of git.
I will try to provide the printout of my actions tomorrow when i will
get to this machine.

Thanks a lot,
Eugene

On Sun, Apr 11, 2010 at 6:22 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 10, 2010 at 06:10:53PM -0400, Eugene Sajine wrote:
>
>> Actually no, i was not thinking about what you think i was;). What i
>> was trying to understand with this command (git rebase --onto master
>> topic) is the behavior of the system when the topic branch is indire=
ct
>> descendant of the master and the direct parent of topic (next) is
>> omitted, skipped.
>
> But in "git rebase --onto master topic", the relationship between mas=
ter
> and topic is irrelevant. It is the same as:
>
> =C2=A0git rebase --onto master topic HEAD
>
> which will consider the range between topic and HEAD as the set of
> commits to rebase.
>
> Did you want to do:
>
> =C2=A0git rebase --onto master next topic
>
> ? That would take the commits between next and topic (i.e., just "top=
ic"
> in your example), and rebuild them on top of master.
>
>> Now the problem i have is that:
>>
>> git rebase -i --onto master topic
>>
>> actually worked and did something, what i would not expect it to do.
>>
>> So, the problem is: non-interactive rebase DOES NOT execute the
>> command, interactive DOES execute.
>
> That's not the result I get. The non-interactive rebase _does_ do the
> same thing. Try this:
>
> =C2=A0mkdir repo
> =C2=A0cd repo
> =C2=A0git init
>
> =C2=A0echo content >>file && git add file && git commit -m one
> =C2=A0git checkout -b next
> =C2=A0echo content >>file && git add file && git commit -m two
> =C2=A0git checkout -b topic
> =C2=A0echo content >>file && git add file && git commit -m three
>
> =C2=A0git rebase --onto master topic
>
> You will see that "topic" has been reset back to commit one, the same=
 as
> master.
>
> If that was not happening before, it was likely because you were not
> actually on the "topic" branch before. So who knows what the implicit
> "HEAD" argument referred to.
>
>> The bug is in the fact that rebase works differently in interactive
>> and non-interactive variants.
>
> I don't think it does, as shown by my example above. If you still thi=
nk
> so, please create a short test case that demonstrates the difference.
>
> -Peff
>
