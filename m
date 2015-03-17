From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Tue, 17 Mar 2015 20:00:41 +0800
Message-ID: <CABwkPcq2AawTCQLwfvyR8gbx4Z7BhA8vKd_ON3LSCVcxFX9b4w@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
 <CACsJy8AAsAO6gjWg0nsdiOXFEsZ4583pH9mkUx1Js3Yop5KHHQ@mail.gmail.com>
 <CABwkPcrF9oFvNkbp6rFV28U3w-szyV9k4LFviYyFkoJvp8pjbA@mail.gmail.com> <CACsJy8AO1w0tYmYkOLjB6osw50gYpc01_6iUt5JZLqL0xtDPrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 13:01:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXqBI-0007Br-F2
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 13:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbbCQMBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2015 08:01:04 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35660 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbCQMBC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 08:01:02 -0400
Received: by pdbop1 with SMTP id op1so7882020pdb.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YqUVD35CjDeCUHcx3kEjYJcebWnk+vVFDWqXslESyDI=;
        b=qLeP19YHoVsRbZdk8zb8EuF2usgX1rSLFAJE1NgJfa3ltXcT8xqV54K47dpf2Rv8BR
         TUcROHyy3WPpmMafSPRzJnzy/v62PuHGGn4O9/ldcIlv3CTbYbcYeNvNcZqq16CV17PG
         la4kIiKaa9YV+BYYzOHA5RnIRTdugk1bhHDpiKgmbTTWp/h9wykfZeLy8/Q9yYs6gE8Y
         QCjzsFWh+Y6eX239dB7+P6Jp5yBkOEfsTe/YDdvgboONEi8bE32UtG/IKaITp6ROuY4q
         eME3DT+1PRlVOca3DQJ9EnUlQ4gQ7bqcAI/HfNwiPnbslErL6eb3iNtYfPeE3h5ifHMX
         kvCw==
X-Received: by 10.70.0.207 with SMTP id 15mr57671649pdg.56.1426593662088; Tue,
 17 Mar 2015 05:01:02 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Tue, 17 Mar 2015 05:00:41 -0700 (PDT)
In-Reply-To: <CACsJy8AO1w0tYmYkOLjB6osw50gYpc01_6iUt5JZLqL0xtDPrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265627>

> C Git is not the only client that can talk to upload-pack. A buggy
> client may send both. The least we need is make sure it would not
> crash or break the server security in any way. But if we have to
> consider that, we may as well reject with a clear message, which woul=
d
> help the client writer. And speaking of clients..

Actually, I mean that the upload-pack in this patch will not crash,
whatever it receives.
e.g. "depth N", "depth_deepen", "depth N"+"depth_deepen"

Because "depth_deepen" is just a boolean signal to tell the upload-pack
that "depth N" means "deepen N", it takes effect only when "depth N"
is given. Otherwise, "depth_deepen" will be ignored.


> You missed Junio's keyword "existing". Your new client will work well
> with your new server. But it breaks "git clone --depth" (or "git fetc=
h
> --depth") for all existing git installations.

Oh, thank you for pointing out this. And sorry Junio. I misunderstood
what you said. I haven't realized the problem of existing git server.
You've reminded me of the importance of compatibility. Thank you!

2015-03-17 18:44 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Mon, Mar 16, 2015 at 11:10 PM, Dongcan Jiang <dongcan.jiang@gmail.=
com> wrote:
>> Hi Duy,
>>
>> Sorry for my late response.
>>
>>> we need to make sure that upload-pack barf if some client sends bot=
h "deepen" and
>>> "depth".
>>
>> Actually, in my current design, when client just wants "depth", it
>> sends "depth N";
>> when it want "deepen", it sends "depth N" as well as "depth_deepen".
>> For the latter
>> case, it tells upload-pack to collect objects for "deepen N".
>>
>> Thus, I'm not so sure whether upload-pack needs to check their exclu=
sion.
>
> C Git is not the only client that can talk to upload-pack. A buggy
> client may send both. The least we need is make sure it would not
> crash or break the server security in any way. But if we have to
> consider that, we may as well reject with a clear message, which woul=
d
> help the client writer. And speaking of clients..
>
> On Mon, Mar 16, 2015 at 11:08 PM, Dongcan Jiang <dongcan.jiang@gmail.=
com> wrote:
>>>> -             if (starts_with(line, "deepen ")) {
>>>> +             if (starts_with(line, "depth ")) {
>>>>                       char *end;
>>>> -                     depth =3D strtol(line + 7, &end, 0);
>>>> -                     if (end =3D=3D line + 7 || depth <=3D 0)
>>>> -                             die("Invalid deepen: %s", line);
>>>> +                     depth =3D strtol(line + 6, &end, 0);
>>>> +                     if (end =3D=3D line + 6 || depth <=3D 0)
>>>> +                             die("Invalid depth: %s", line);
>>>>                       continue;
>>>>               }
>>>>               if (!starts_with(line, "want ") ||
>>>
>>> I do not quite understand this hunk.  What happens when this progra=
m
>>> is talking to an existing fetch-pack that requested "deepen"?
>>
>> In this hunk, I actually just changed the one command name in upload=
-pack
>> service from "deepen" to "depth". I made this change because the nam=
e
>> "deepen" here is quite misleading, as it just means "depth". Of cour=
se,
>> I've changed the caller's sent pack from "deepen" to "depth" too (Se=
e below).
>
> You missed Junio's keyword "existing". Your new client will work well
> with your new server. But it breaks "git clone --depth" (or "git fetc=
h
> --depth") for all existing git installations.
> --
> Duy



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
