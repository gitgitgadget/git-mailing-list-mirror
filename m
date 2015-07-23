From: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>
Subject: Re: Git doesn't detect change, if file modification time is restored
 to original one
Date: Thu, 23 Jul 2015 11:14:11 +0200
Message-ID: <CABEDGg_R49K61wiV9SsTnLS9SztHDjEQhOHjwzYn2JJwrrb-KA@mail.gmail.com>
References: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
 <55B09E95.4000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 11:15:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZICag-0000Wk-8h
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 11:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbbGWJOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2015 05:14:54 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36493 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbGWJOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2015 05:14:51 -0400
Received: by wicgb10 with SMTP id gb10so133643060wic.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=47njMYl2y3bj6HDTk+Xsp+637VTQ7Z6h9Aeh5+ufb0A=;
        b=eaCHLI08HivRccZbZFODNZ6a2FpQNP5xSHRUHcipBzT6se/Oi+U+1uv6csHvDUtnIl
         YXfDWGkisu4uomtdwO7fYurJYPVDBH8Hg3bnQWWxKRv1J0UG35u9Mcw/+g7ie8kdlusI
         aOuDoe75uSc00QOeF2/mw4CUKaKnIzwsXR262HtQrgCi/p2LqMTrrJkCGuoHtITMUWJl
         ajN5xh/j9GEn8XJlryBuwAZ+x9O2u0Ksxtd4FFOpb9R686teJZYdtbS0LpL7VLByOcHR
         5TflLP6t0hU2vPCFVLwzGRjHmjIxPWkANgBmW0oMGOB6+gia0OrNTXl65qi4qFmM9BCq
         6HWw==
X-Received: by 10.180.91.76 with SMTP id cc12mr51758996wib.67.1437642890841;
 Thu, 23 Jul 2015 02:14:50 -0700 (PDT)
Received: by 10.28.21.4 with HTTP; Thu, 23 Jul 2015 02:14:11 -0700 (PDT)
In-Reply-To: <55B09E95.4000700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274489>

Based on [1] I found some solutions which makes the changed files
appear again as changed:
a) touch -m --date=3D01/01/1980 .git/index
So it is a touch, but only a single one, instead of touching all the
files in the work dir.

b) git read-tree HEAD
Also working well.


I accept these solutions as workarounds, but the real solution would be=
:
Dev suggestions:
1) Add a --force-reread option to git status, so user can force reread =
tree.
git status --force-reread

2) Add status.force-reread (true or false) option to .git/config so
user can set this variable permanently for a repo.
status.force-reread =3D false (should be default)


Could be possible to implement 1) and 2) features to next git release?


Thanks,
Konrad Lorinczi


[1] https://github.com/msysgit/git/issues/312

2015-07-23 9:58 GMT+02:00 Sebastian Schuberth <sschuberth@gmail.com>:
> On 7/23/2015 9:29, Konr=C3=A1d L=C5=91rinczi wrote:
>
>> Interesting, that git status doesn't show replaced changes, if the
>> mtime is same as original.
>
> See the somewhat related FAQ entry at [1] and also the lengthy discus=
sion at [2] about a similar issue. That said, deleting the .git/index f=
ile should make these files appear as modified.
>
> [1] https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_pre=
serving_modification_time_on_files.3F
> [2] https://github.com/msysgit/git/issues/312
>
> Regards,
> Sebastian
>
