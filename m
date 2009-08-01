From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCHv5] Add Gitweb support for XZ compressed snapshots
Date: Sat, 1 Aug 2009 10:12:12 +0200
Message-ID: <9b18b3110908010112va6e2ceap727c4129a054ebda@mail.gmail.com>
References: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca>
	 <4A739087.1090301@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Aug 01 10:12:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX9i2-00045M-LJ
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 10:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZHAIMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 04:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbZHAIMP
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 04:12:15 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:46661 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbZHAIMN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 04:12:13 -0400
Received: by gxk9 with SMTP id 9so4455893gxk.13
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9hq1y6H11ePfUlZbbFsgY3YmKUTjffNpw6JNnkng+cw=;
        b=Fwkya4f/Hq4VziMtW/w+LrojQFXdlLA0B9GJB5pRPAAKE6S352jOmoUQNgsjiX4rgd
         TLxq7/AJEJqiCPsYBYy2+jFFVR+PirHQPJ27Nk0Lghw3uhIvaN9BDmnTa0iPfBnNsgN8
         I/amPaYQq0ZpuM7aD/kfntfJUlqt3/BEzKzxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vmcL/gEnzc0aHty4XSvIlazhdFSMzNjqHpD5pjZ11bOlS2Ps3oIRvx9WRkMkAwIydc
         DtuQwDOWkfVzY9wyzYaerjfVy+e0ptSc0na0BqwBZYoaeBaPmp55B8+hBo2Fa8z83Uk8
         ZzuzNgdW5kGElsyGHbtgHjTA6hmo8+yT0evO0=
Received: by 10.231.18.69 with SMTP id v5mr931604iba.26.1249114332335; Sat, 01 
	Aug 2009 01:12:12 -0700 (PDT)
In-Reply-To: <4A739087.1090301@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124610>

2009/8/1 J.H. <warthog19@eaglescrag.net>:
> Mark A Rada wrote:
>>
>> =A0>Note that for me the above results are not aligned in table.
>> =A0>This is a cosmetic issue.
>>
>> The table formatting issue was due to a bad habit of mixing tabs and
>> spaces,
>> I decided to go with spaces this time :)
>>
>>
>> =A0>One thing that would concern me greatly, is not so much the CPU =
time
>> (though that's a *huge* change in comparison to gz) but the memory u=
sage.
>> =A0Where gzip and bzip2 are chewing 4M and 13M respectively, xz chew=
s 102M.
>> =A0>From a 'beefy' server perspective chewing up that much memory pe=
r snapshot
>> for that long could be bad. =A0This is likely something that needs t=
o have
>> some sort of enable/disable switch if it's going to be included.
>>
>> True, and there are two solutions I can think of for this "problem".
>>
>> =A0 =A01. My tests were at the default compression level, the XZ doc=
umentation
>> =A0 =A0says that at lower levels you will get resource usage and com=
pression
>> =A0 =A0ratios that are comparable to BZip2. However, I'm not sure wh=
ere you
>> =A0 =A0would change the compression level variable for this (globall=
y for the
>> =A0 =A0system, somewhere in $GITWEB_CONFIG, a git config variable). =
Does
>> =A0 =A0someone know the correct answer here?
>
> Well you can always call xz with -[1-9] to change the compression lev=
el
> (same as gzip and bzip2) though I think a full disabling would be 'mo=
re'
> preferable, though I'm not sure I like Jakub's suggestion of just del=
eting
> it after the fact, it would work.
>
>> =A0 =A02. Implement snapshot caching for Gitweb.
>
> I think it's slightly broken in my version (binary files don't work r=
ight
> apparently, it's on my todo list to fix in my upcoming update) but bo=
th Lea
> and I have done this long ago (caching layers in Gitweb), which would=
 be an
> acceptable workaround for this, create once and serve many - though t=
his has
> the downside of trading cpu for diskspace. =A0At least with xz there'=
s less
> diskspace used ;-)
>
> I think more my concern is more what's enabled by default, and since =
xz is
> still new (as was pointed out) it's probably worth only enabling if t=
he
> admin selects it to be enabled.

=46WIW the perl project ripped out all the snapshot generation logic
from gitweb, and replaced it with a tool that generates snapshots
correctly for our requirements (if the build process needs additional
files /currently/ git-archive does not support adding them), this
includes a disk level cache for the snapshots since creating the tar,
adding the additional files, then gziping is quite slow.

If its interesting to people I can post it and the other changes here,
although its not a "nice" change, as I literally ripped out the
existing code.

cheers,
Yves





--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
