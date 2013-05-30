From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 20:47:35 +0530
Message-ID: <CALkWK0=6xg8X7ZLXoaTk_ZgRnhgXWsftsTzr6JAWFBJvmVOgFw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
 <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
 <CALkWK0=bgM+fYcVEwjHHF8k2Q8wMmjdbM5bxXdPH6s9StDH_Ng@mail.gmail.com> <CAJ-05NMt6h=JFLLCP+LASKMcToENhF=BSsk1dPML0024hJTwTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 17:18:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4cP-00022b-1L
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab3E3PSS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 11:18:18 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:35473 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244Ab3E3PSQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 11:18:16 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk14so228311bkc.15
        for <git@vger.kernel.org>; Thu, 30 May 2013 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MX704mTHWrbvCoKDoRNvoYGn0NuwPK+nqJCkc7Wm69Q=;
        b=V59S48N8rjLxt006mZJIE+ud93mT/CeFBq1O0FA/MCh5Be+MV6Gm5nNLHM1UR2M6Fo
         f6ESGBO9Y4f3bHk+N9IMsJvIDRuG5PV7oH1ZcoFVXrkpF4+Kburvx4XrbtgfPLevEZyY
         MGXTByvXvyUnaE2zWO336XpyGlHpXYJzcX7SRct0ejhEAtFR+tmYCMpXfF/6T4ba3bIQ
         0ffnd3QHyeP4agm49hFNgwXquntRQITn6IRmYLbWxPQomi9piuQ3GmDNu2lk2AqE2PkS
         2dRxHIlgd5JTbwDLXaZpBwWG0lGweXBwd8i0pwpax06WS5Y8sp5BCBBIBWIY5N7Js/IQ
         Xx+w==
X-Received: by 10.204.109.200 with SMTP id k8mr2021959bkp.82.1369927095514;
 Thu, 30 May 2013 08:18:15 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Thu, 30 May 2013 08:17:35 -0700 (PDT)
In-Reply-To: <CAJ-05NMt6h=JFLLCP+LASKMcToENhF=BSsk1dPML0024hJTwTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226011>

Alex Benn=C3=A9e wrote:
> 15:50 ajb@sloy/x86_64 [work.git] >time git log --pretty=3Doneline | w=
c -l
> 24648
>
> real    0m0.434s
> user    0m0.388s
> sys     0m0.112s
>
> Although it doesn't take too long to walk the whole mainline history
> (obviously ignoring all the other branches).

Damn, non-starter.  linux.git has 361k+ commits in mainline history.

Nit: use git rev-list --count HEAD next time.

> 15:52 ajb@sloy/x86_64 [work.git] >git count-objects -v -H
> count: 581
> size: 5.09 MiB
> in-pack: 399307
> packs: 1
> size-pack: 1.49 GiB
> prune-packable: 0
> garbage: 0
> size-garbage: 0 bytes

linux.git has 2.9m+ in-pack.  The pack-size is much lower at about
800+ MiB, but I don't think 1.49 GiB is a problem in itself.  Looking
forward to your big-files report to see why it's so big.

> It is a pick repo. The gc --aggressive nearly took out my machine kee=
ping
> around 4gb resident for most of the half hour and using nearly 8gb of=
 VM.
>
> Of course most of the history is not needed for day to day stuff. May=
be
> if I split the pack files up it wouldn't be quite such a strain to wo=
rk
> through them?

Really out of my depth here, sorry.  Let's see what Duy (or the
others) have to say.

>> 2. You have have huge (binary) files checked into your repository.  =
Do
>> you?  If so, why isn't the code in streaming.c kicking in?
>
> We do have some binary blobs in the repository (mainly DSP and FPGA i=
mages)
> although not a huge number:
>
> 15:58 ajb@sloy/x86_64 [work.git] >time git log --pretty=3Doneline -- =
xxx
> xxx/xxxxxx/*.out ./xxx/xxx/*.out ./xxx/xxxxxxx/*.out | wc -l
> 234
>
> real    0m0.590s
> user    0m0.552s
> sys     0m0.040s

log is streaming, and is not a good measure: it doesn't even walk the
entire commit graph.  How big are these files?

> How can I tell if streaming is kicking in or now?

I use callgrind (and kcachegrind to visualize).  Can you post
callgrind output?  It will be helpful in figuring out where exactly
git is spending time.
