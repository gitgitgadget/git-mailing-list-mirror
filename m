From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 17 Mar 2015 17:09:53 +0100
Message-ID: <CAP8UFD12UX+3psD2=9_RsGv8JA2C8N54qAYGydYgr7n5ta7dzw@mail.gmail.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
	<xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
	<20150316163306.GB11832@vps892.directvps.nl>
	<xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
	<065AE7977A54488198B39564E3E174E6@PhilipOakley>
	<xmqqr3sops9f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, Kevin Daudt <me@ikke.info>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:10:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXu47-00074G-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbbCQQJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:09:54 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36672 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbbCQQJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 12:09:53 -0400
Received: by iegc3 with SMTP id c3so14906385ieg.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xNiudB/MTHepYHgPYxvUlAOHWyRfvo+pImAzvraBU1Y=;
        b=kifUD+wuf5tZn6Hpjo2vWabqS9oLcbKdhyACDTczi6UBAcFdJ0RBTL9bupWP/QtLMm
         Tyk4BXkT2foWvlO7PpQUl9tgi0gpAMZ6HZc/vonxARL9cwm8Wp81Vz/S5uHmwpCHvj4b
         wOkGYxp3Wi7j3DgaDCyWoDD2ZPSKuHfbZRwlOnfMqVC0EG1N2BzdtiT/utr4BIPAxh5D
         RFtS0sIp3EWyl1HBzhw81HGgqj2Y4OoK8xhDzJTQbWzsMjI0n915c1b1T++Lxdb5g6/3
         hhCeavAafG2r8q3qakHr5gQ9fo2ZpZWMRJLTf6giJSkJRR1gs4nSRK4WIB4KG7svEggU
         sYAg==
X-Received: by 10.50.79.163 with SMTP id k3mr146673467igx.30.1426608593228;
 Tue, 17 Mar 2015 09:09:53 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Tue, 17 Mar 2015 09:09:53 -0700 (PDT)
In-Reply-To: <xmqqr3sops9f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265646>

On Mon, Mar 16, 2015 at 10:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>
>>> Hence, if you have a history that looks like this:
>>>
>>>
>>>   G...1---2---3---4---6---8---B
>>>                    \
>>>                     5---7---B
>>>
>>> it follows that 4 must also be "bad".  It used to be good long time
>>> ago somewhere before 1, and somewhere along way on the history,
>>> there was a single breakage event that we are hunting for.  That
>>> single event cannot be 5, 6, 7 or 8 because breakage at say 5 would
>>> not explain why the tip of the upper branch is broken---its breakage
>>> has no way to propagate there.  The breakage must have happened at 4
>>> or before that commit.
>>
>> Is it not worth at least confirming the assertion that 4 is bad before
>> proceding, or at least an option to confirm that in complex scenarios
>> where the fault may be devious.
>
> That raises a somewhat interesting tangent.
>
> Christian seems to be forever interested in bisect, so I'll add him
> to the Cc list ;-)
>
> There is no way to give multiple "bad" from the command line.  You
> can say "git bisect start rev rev rev..." but that gives only one
> bad and everything else is good.  And once you specify one of the
> above two bad ones (say, the child of 8), then we will not even
> offer the other one (i.e. the child of 7) as a candidate to be
> tested.  So in that sense, "confirm that 4 is bad before proceeding"
> is a moot point.
>
> However, you can say "git bisect bad <rev>" (and "git bisect good
> <rev>" for that matter) on a rev that is unrelated to what the
> current bisection state is.  E.g. after you mark the child of 8 as
> "bad", the bisected graph would become
>
>    G...1---2---3---4---6---8---B
>
> and you would be offered to test somewhere in the middle, say, 4.
> But it is perfectly OK for you to respond with "git bisect bad 7",
> if you know 7 is bad.
>
> I _think_ the current code blindly overwrites the "bad" pointer,
> making the bisection state into this graph if you do so.
>
>    G...1---2---3---4
>                     \
>                      5---B

Yes, we keep only one "bad" pointer.

> This is very suboptimal.  The side branch 4-to-7 could be much
> longer than the original trunk 4-to-the-tip, in which case we would
> have made the suspect space _larger_, not smaller.

Yes, but the user is supposed to not change the "bad" pointer for no
good reason. For example maybe a mistake was made and the first commit
marked as "bad" was not actually bad.

> We certainly should be able to take advantage of the fact that the
> current "bad" commit (i.e. the child of 8) and the newly given "bad"
> commit (i.e. 7) are both known to be bad and mark 4 as "bad" instead
> when that happens, instead of doing the suboptimal thing the code
> currently does.

Yeah, we could do that, but we would have to allow it only if a
special option is passed on the command line, for example:

git bisect bad --alternate <commitish>

and/or we could make "git bisect bad" accept any number of bad commitishs.

That could give additional bonus points to the GSoC student who would
implement it :-)

Thanks,
Christian.
