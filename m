From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Tue, 25 Aug 2015 12:30:50 +0200
Message-ID: <23CB37E8-9704-4A9D-8CAB-2812AD59394D@gmail.com>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com> <55DC111A.6090501@diamand.org> <55DC285D.9030500@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com, gitster@pobox.com
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 25 12:31:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUBVQ-0006Dg-3z
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 12:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbbHYKa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 06:30:59 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34975 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134AbbHYKa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2015 06:30:58 -0400
Received: by wicne3 with SMTP id ne3so10636770wic.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d1I5oHMpJR44HX9MW7CttYni5bpyAHLEdQrVHLDkqbY=;
        b=EeMzfqVKdyKzDQUy8psFHeGYujpcJ37ZZAUv1riqkLP97t2YdD+bQZE4kTYjj/4J3B
         NGDRyS0445/Rvj4tq4qE0lzqczryVJUGEj47zqjMQQmGb8yUF08rVqbio5Q3EGlYZfGX
         IRSZWhy2TR9lJAHk/DcL4Xn6Z8GnM17W5DQQHX+G/cg3mTSCA1imov18K8/vhyLGi5Mr
         xV6qJT9fZrNRhxamMT8O51WduvcMm/JfGrpIDo8Q+CY46tOVToMwM5JqKGdyWUPNuX5R
         WUJIiV7mFgMs4Ha0asbcK+tzSIArVffYcPCmCFKODOQozEPqQbIRCIuyk2wSOE1Y0OJp
         1DMA==
X-Received: by 10.194.117.133 with SMTP id ke5mr49251522wjb.116.1440498657242;
        Tue, 25 Aug 2015 03:30:57 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xs1sm27413415wjc.7.2015.08.25.03.30.53
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 03:30:56 -0700 (PDT)
In-Reply-To: <55DC285D.9030500@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276516>

On 25 Aug 2015, at 10:33, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 08/25/2015 08:54 AM, Luke Diamand wrote:
>> On 24/08/15 22:30, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>> Thanks to Luke Diamand I realized the core problem and propose here=
 a
>>> substiantially simpler fix to my PATCH v4.
>>>=20
>>> The test cases remain and prove the problem. In particular
>>> "8 - Clone path (ignorecase)" and
>>> "Add a new file and clone path with new file (ignorecase)" fail wit=
h the
>>> current implementation on OS X and Linux.
>>=20
>> That's a lot simpler, thanks!
>>=20
>> Could we give this its own command line option and git config variab=
le?
>>=20
>> Core.ignorecase gets set if the client is on a filing system that ig=
nores case. This is slightly different - it squashes case in depot file=
s for people with depots that have incorrectly jumbled-up case.
>>=20
>> Conflating the two seems like it would cause confusion at some point=
 - for example, I have no idea how the rest of git behaves if core.igno=
recase is set to True on a case-preserving file system.
>>=20
> That doesn't work as expected and is not allowed (or say strictly for=
bidden, or strongly recommended not to do)
>=20
> Remembering older discussions about importers from foreign VCS:
> This should work best for most people:
> Look at the command line option, if no one is given,
> look at core.ignorecase.
>=20
> So the command line option overrides core.ignorecase,
> and the  user can either run
> --ignore-path-case
> or
> --no-ignore-path-case
Unfortunately the command line option is not sufficient as the resultin=
g paths are still messed up. I added the switch but it looks like as co=
re.ignorecase does some additional magic on fast-import. You can see my=
 changes here:
https://github.com/larsxschneider/git/commit/b4399179ff542161c2c5b83c34=
c5b4901287ceb0

You can also run the unit tests to see the results here:
https://github.com/larsxschneider/git/tree/lars/fix-path-v5-with-comman=
d-switch

The only way I could image to fix that is to request every path from P4=
 as shown in my PATCH v4. This would be slow and the change would be ra=
ther huge.

I am curious:=20
I run all my P4 -> git migrations on a Linux box with EXT4 and core.ign=
orecase=3DTrue. I did not realize that this might cause trouble. What c=
ould happen and what should I look out for?=20
One thing to keep in mind: This is a one time migration and we don=92t =
develop on these Linux boxes. We usually develop on Windows and Mac. I =
just use the Linux boxes as migration workers as these scripts usually =
run a while.

- Lars