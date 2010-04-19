From: SungHyun Nam <goweol@gmail.com>
Subject: Re: git diff too slow for a file
Date: Mon, 19 Apr 2010 09:43:17 +0900
Message-ID: <4BCBA725.2020307@gmail.com>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Apr 19 02:43:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3f5D-0001u6-QK
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 02:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab0DSAnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 20:43:12 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:47052 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0DSAnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 20:43:10 -0400
Received: by ywh32 with SMTP id 32so2427142ywh.33
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6zQQqghytpkK9EeLFuQVyqcLVqr2JgtSN1iUCTxV08s=;
        b=KlRrrbSR2xLSaveBqzQJvJ9FiFg+yTZZhzsJnI6W725/LKOaxNhQREJjbI2eiBmlET
         JPyX1pyAqWo/s/yjY/awtq+HjITm3JH0zuF5Vy02V3UoCYYgfBkkOwrMNt3M9jzGvSFK
         O6qwaAxpkhZ3h9dBjbRokykMPESNBvG1D7boE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pg0wJj60JhLe3haaP90UWH1flBF7aNlxlX2IyG5tlZp4XRggiO5xv3zpVLsl3PZTT8
         pc8oM7yF14a4HLJCtvAYa8VEcv4Y4rzdBqfe8akco1/o3PnxayHij37NBgW971hJ1Acz
         lEq5W6f7oPzRtwNrHnLwkONj06RAB5MbgPrc8=
Received: by 10.101.176.24 with SMTP id d24mr9574891anp.44.1271637789686;
        Sun, 18 Apr 2010 17:43:09 -0700 (PDT)
Received: from [210.181.13.12] ([210.181.13.12])
        by mx.google.com with ESMTPS id 9sm1389938yxf.65.2010.04.18.17.43.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 17:43:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BC9D928.50909@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145260>

Ren=C3=A9 Scharfe wrote:
> Am 29.03.2010 03:42, schrieb SungHyun Nam:
>> Hello,
>>
>> If I run a attached script for bunzipped attached files, I get:
>> (To reduce size, I removed many lines and bzipped.)
>>
>>      $ ./mk.sh
>>      time diff -u x3 x4>/dev/null 2>&1
>>
>>      real    0m0.011s
>>      user    0m0.000s
>>      sys    0m0.010s
>>
>>      time git diff>/dev/null 2>&1
>>
>>      real    0m0.193s
>>      user    0m0.190s
>>      sys    0m0.000s
>>
>>      $ git version
>>      git version 1.7.0.2.273.gc2413
>>
>>      $ diff --version
>>      diff (GNU diffutils) 2.8.1
>>      ...
>>
>> Well, though the files are ascii file, they includes a random
>> hexa-decimal datas, so that I don't interest the diff result at
>> all.  But the real problem is 'rebasing took so long if the file
>> was changed'.  Because the git tree includes several such a file,
>> if they changed, rebase took some miniutes for every branch.
>> Such a branch includes a few lines of changes for a C source file,
>> though.  Now I'm waiting an hour to finish rebasing all the
>> branches and yet a rebasing script is running... :-(
>
> I can reproduce it; I concatenated your example files five times to g=
et
> meaningful timings (x1 =3D five times x3, x2 =3D five times x4).
>
> The difference between GNU diff and git diff is that the latter is tr=
ying
> hard to minimize the size of the diff.  Each user of the xdiff librar=
y in
> git turns on the XDF_NEED_MINIMAL flag, which makes it very expensive
> (specifically the function xdl_split()).
>
> The following patch is not meant for inclusion, but rather to start a
> dicussion.  Is XDF_NEED_MINIMAL a good default to have?
>
> The patch removes XDF_NEED_MINIMAL and replaces it with XDF_QUICK, wi=
th
> reversed meaning.  XDF_QUICK is only set if the new option --quick is
> given, so without it the old behaviour is retained.  Some numbers:

The patch is great for me.  Thanks!

Added 'time git diff --quick' to the mk.sh and ran with a
original file (about 180000 lines):

     $ ./mk.sh
     time diff -u x3 x4 >/dev/null 2>&1

     real	0m0.794s
     user	0m0.720s
     sys	0m0.010s

     time git diff >/dev/null 2>&1

     real	0m44.687s
     user	0m44.670s
     sys	0m0.020s

     time git diff --quick >/dev/null 2>&1

     real	0m1.853s
     user	0m1.840s
     sys	0m0.010s

Thanks!
namsh
