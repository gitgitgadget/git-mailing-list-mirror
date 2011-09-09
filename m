From: neubyr <neubyr@gmail.com>
Subject: Re: git repository size / compression
Date: Fri, 9 Sep 2011 10:09:23 -0500
Message-ID: <CALFxCvxAn9tEaOWM6r2A8UiDjkTrrzky1Q10VtqCiA-vhQxrug@mail.gmail.com>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
	<1315556595.2019.11.camel@bee.lab.cmartin.tk>
	<CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
	<m339g5u5pm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, pjweisberg@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R22ht-0002n5-KY
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759224Ab1IIPJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 11:09:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63598 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758649Ab1IIPJY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 11:09:24 -0400
Received: by wyh22 with SMTP id 22so1659344wyh.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/cEFwLvZyLD8zj3zGh3ftofH5zS//SQ7fqP4M/hKmwE=;
        b=rcSa4CWKCRRAUK7ypplnuNYHSW2y4fmnvHC14R7JSWxQ0dAJBE0KBSFHNviED3+r9g
         +qdLkCM5qG2OA//g1trsJdmDGHEB4ssXPl7yaJWbe0pryz0XJyA/UI+L4aMvlJcPdN2K
         Qu3fjdt2Qiz5fmnV844uRPn0SvwaxT9EWYYSY=
Received: by 10.227.202.70 with SMTP id fd6mr2088111wbb.114.1315580963185;
 Fri, 09 Sep 2011 08:09:23 -0700 (PDT)
Received: by 10.227.145.210 with HTTP; Fri, 9 Sep 2011 08:09:23 -0700 (PDT)
In-Reply-To: <m339g5u5pm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181076>

2011/9/9 Jakub Narebski <jnareb@gmail.com>:
> neubyr <neubyr@gmail.com> writes:
>> On Fri, Sep 9, 2011 at 3:23 AM, Carlos Mart=C3=ADn Nieto <cmn@elego.=
de> wrote:
>> > On Thu, 2011-09-08 at 21:37 -0500, neubyr wrote:
>
>>>> I have a test git repository with just two files in it. One of the
>>>> file in it has a set of two lines that is repeated n times.
>>>> e.g.:
>>>> {{{
>>>> $ for i in {1..5}; do cat ./lexico.txt>> lexico1.txt && =C2=A0cat
>>>> ./lexico.txt>> lexico1.txt && mv ./lexico1.txt ./lexico.txt; =C2=A0=
done
>>>> }}}
>>>>
>>>
>>> So you've just created some data that can be compressed quite
>>> efficiently.
>>>
>>>> I ran above command few times and performed commit after each run.=
 Now
>>>> disk usage of this repository directory is mentioned below. The 41=
9M
>>>> is working directory size and 2.7M is git repository/database size=
=2E
>>>>
>>>> {{{
>>>> $ du -h -d 1 .
>>>> 2.7M =C2=A0 =C2=A0./.git
>>>> 419M =C2=A0 =C2=A0.
>>>>
>>>> }}}
>
> Have you tried the same but with
>
> =C2=A0 $ git gc --prune=3Dnow
>
> before running `du`?
>

Nope, I hadn't run git gc before. Here are du results after running
git gc command. That's about 55% less space now.. Great!

{{{
$ du -d 1 -h
924K    ./.git
417M    .
}}}


>>>> Is it because of the compression performed by git before storing d=
ata
>>>> (or before sending commit)??
>>>
>>> Yes. Git stores its objects (the commit, the snapshot of the files,
>>> etc.) compressed. When these objects are stored in a pack, the size=
 can
>>> be further reduced by storing some objects as deltas which describe=
 the
>>> difference between itself and some other object in the object-db.
>>
>> Does git store deltas for some files? I thought it uses snapshots
>> (exact copy of staged files) only.
>
> When creating packfile from loose objects (e.g. via `git gc`), it
> does perform delta compression.
>
> --
> Jakub Nar=C4=99bski
>

thank you everyone for explaining in detail..

--
neuby.r
