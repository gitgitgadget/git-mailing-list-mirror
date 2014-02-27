From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Thu, 27 Feb 2014 15:37:49 -0500
Message-ID: <CAJHY66H2M2aQvQ8MLN7XB4uYiFohRfhhsXhd56hwDR5qMGi6Tg@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7iO-00059J-6K
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaB0Uhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 15:37:52 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:40576 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaB0Uhu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 15:37:50 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so4621422qap.16
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l6OPnMBbvlh108qOxQNGKApyB1CLw4Zs5V939mFiU3I=;
        b=Kg/BfxgeLlv3fWbZGP5HPJVmDR1f5bYOx8korT0+epKKl+xJKk9xjMyqJMxzhP7LZy
         mg4iW7V1MxXHV2aziQA8t978hIpP8s49OPExwfU2+OhsJ6NCiubzA3sbO9O3eWN2jiyt
         TOiUAmL+vPEHkiGigEoZDKoEYh91PwidejNVQlYmWsbkERg686AfpvGnBuxrX9AK8rdq
         DeIzasiClogaCIWILKqeZh0CFed9YIs3BNs9cEbysAjIigZpOJXgKZhg4+Ur3b+salNi
         M79/G0dfoktGcAMJkvQBZ+hq3/hTKyEnYO5SrifvH5D8+S3/nXD6ItOIffQoEmIB2OQw
         XCiQ==
X-Received: by 10.224.166.137 with SMTP id m9mr19789763qay.81.1393533469840;
 Thu, 27 Feb 2014 12:37:49 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Thu, 27 Feb 2014 12:37:49 -0800 (PST)
In-Reply-To: <530FA0C1.3000109@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242855>

> Perhaps git-{branch,tag}.txt and possibly gitrepository-layout.txt
> in Documentation/ may need a new "*Note*" section to warn against
> this.

A little more documentation never hurt anyone :).

> Or we can possibly trigger this function at the the of
> "checkout -b" or "fetch" commands ?
> Only when core.ignorecase =3D=3D true ?

This would essentially make git always use packed-refs when
core.ignorecase =3D=3D true, correct? Are there any downsides to always
using packed-refs?

Thanks,
-Lee

On Thu, Feb 27, 2014 at 3:32 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> On 2014-02-27 20.50, Junio C Hamano wrote:
>> Lee Hopkins <leerhop@gmail.com> writes:
>>
>>> Last week I ran across a potential bug with branch names on case
>>> insensitive file systems, the complete scenario can be found here:
>>>
>>> https://groups.google.com/forum/#!topic/msysgit/ugKL-sVMiqI
>>>
>>> The tldr is because refs are stored as plain text files except when
>>> packed into packed-refs, Git occasionally cannot tell the differenc=
e
>>> between branches whose names only differ in case, and this could
>>> potentially lead to the loss of history.
>>>
>>> It sounds like this is a known issue, and after some more digging I
>>> did find some older threads related to this topic, but nothing rece=
nt.
>>
>> Yes, it is not limited to branch names but also applies to tags and
>> filenames in your working tree.
>>
>> Perhaps git-{branch,tag}.txt and possibly gitrepository-layout.txt
>> in Documentation/ may need a new "*Note*" section to warn against
>> this.
>>
>> Thanks.
> There is a possible workaround:
> git pack-refs --all --prune
>
> If this can be triggered by a hook, I don't know (I never used a hook=
)
>
> It uses the C-function pack_refs(flags) in builtin/pack-refs.c
> Or we can possibly trigger this function at the the of
> "checkout -b" or "fetch" commands ?
> Only when core.ignorecase =3D=3D true ?
>
>
>
>
>
>
>
