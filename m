From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 14:09:42 +0100
Message-ID: <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 15:09:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2bz-0003eG-IL
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab3E3NJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 09:09:44 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61360 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3E3NJm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 09:09:42 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so477178obq.7
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Nd9raqlLEqSWJMhq9+3sW21dPVTgsndPyaB6IkPD/g0=;
        b=EHZWEMngq44XDP6AjZRgsnMrjdN4RImgTPOtJzqwfw4I4ryjjFjSytZsV5TNLYiEZO
         KGiMER5VQ3uo045EsUFr8xjhpkIWjDWwLbCEc+cPRPonioeBmVeqyysUh6zDTD/sGx4F
         PoQRlpx/6dl7MN0Ii3zwwi2xo6QDSiRcLvt95roZDDsoVtNVkw48CTNQxfilGVfnq/1L
         6Xyj+FaRBlHHy3mLwHZ4Oac4uO6CRLUXUVtxkVLH3bSepnJp975ElFZ1ZVDTz+Zd6/zN
         lIYW1xKWhcjS8FpViDmlx8Vo7tNnkI3aOUsdeBjmHAuzRB7uRkKnAQ1EUlZu01F87yeg
         HO5A==
X-Received: by 10.182.38.201 with SMTP id i9mr3973079obk.55.1369919382233;
 Thu, 30 May 2013 06:09:42 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 06:09:42 -0700 (PDT)
In-Reply-To: <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
X-Google-Sender-Auth: CaMlNpsQJIGYpILfPrhWbESy1FY
X-Gm-Message-State: ALoCoQkSmTrfg+aZFlSWxkkBKSZ0MsNUys8qqEGLdmXD4qEOc+CmWm07NKPBWNWdkHbvPntxj3CT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225983>

It looks like it's a file caching effect combined with my repo being
more pathalogical in size and contents. Note run 1 (cold) vs run 2 on
the linux file tree:

13:52 ajb@sloy/x86_64 [linux.git] >time git describe --debug --long
--tags HEAD~10000
searching to describe HEAD~10000
 annotated         57 v2.6.34-rc2
 annotated       1688 v2.6.34-rc1
 annotated       7932 v2.6.33
 annotated       8157 v2.6.33-rc8
 annotated       8381 v2.6.33-rc7
 annotated       8637 v2.6.33-rc6
 annotated       8964 v2.6.33-rc5
 annotated       9493 v2.6.33-rc4
 annotated       9912 v2.6.33-rc3
 annotated      10202 v2.6.33-rc2
traversed 10547 commits
more than 10 tags found; listed 10 most recent
gave up search at 55639353a0035052d9ea6cfe4dde0ac7fcbb2c9f
v2.6.34-rc2-57-gef5da59

real    0m7.332s
user    0m0.308s
sys     0m0.244s
14:03 ajb@sloy/x86_64 [linux.git] >time git describe --debug --long
--tags HEAD~10000
searching to describe HEAD~10000
 annotated         57 v2.6.34-rc2
 annotated       1688 v2.6.34-rc1
 annotated       7932 v2.6.33
 annotated       8157 v2.6.33-rc8
 annotated       8381 v2.6.33-rc7
 annotated       8637 v2.6.33-rc6
 annotated       8964 v2.6.33-rc5
 annotated       9493 v2.6.33-rc4
 annotated       9912 v2.6.33-rc3
 annotated      10202 v2.6.33-rc2
traversed 10547 commits
more than 10 tags found; listed 10 most recent
gave up search at 55639353a0035052d9ea6cfe4dde0ac7fcbb2c9f
v2.6.34-rc2-57-gef5da59

real    0m0.298s
user    0m0.244s
sys     0m0.036s

Although the perf profile looks subtly different.

=46irst through the linux tree:

 22.35%   git  libz.so.1.2.3.4    [.] inflate
 18.56%   git  libz.so.1.2.3.4    [.] inflate_fast
 17.48%   git  libz.so.1.2.3.4    [.] inflate_table
  7.84%   git  git                [.] hashcmp
  3.93%   git  git                [.] get_sha1_hex
  3.46%   git  libz.so.1.2.3.4    [.] adler32

And through my "special" repo:

 41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse3
 33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
 10.39%   git  libz.so.1.2.3.4     [.] adler32
  2.03%   git  [kernel.kallsyms]   [k] clear_page_c

 I'm not sure why libcrypto features so highly in the results


 --
 Alex.

On 30 May 2013 12:33, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Alex Benn=C3=A9e wrote:
>>>time /usr/bin/git --no-pager
>> traversed 223 commits
>>
>> real    0m4.817s
>> user    0m4.320s
>> sys     0m0.464s
>
> I'm quite clueless about why it is taking this long: I think it's IO
> because there's nothing to compute?  I really can't trace anything
> unless you can reproduce it on a public repository.  On linux.git wit=
h
> my rotating hard disk:
>
> $ time git describe --debug --long --tags HEAD~10000
> searching to describe HEAD~10000
>  annotated       5445 v2.6.33
>  annotated       5660 v2.6.33-rc8
>  annotated       5884 v2.6.33-rc7
>  annotated       6140 v2.6.33-rc6
>  annotated       6467 v2.6.33-rc5
>  annotated       6999 v2.6.33-rc4
>  annotated       7430 v2.6.33-rc3
>  annotated       7746 v2.6.33-rc2
>  annotated       8212 v2.6.33-rc1
>  annotated      13854 v2.6.32
> traversed 18895 commits
> more than 10 tags found; listed 10 most recent
> gave up search at 648f4e3e50c4793d9dbf9a09afa193631f76fa26
> v2.6.33-5445-ge7c84ee
>
> real    0m0.509s
> user    0m0.470s
> sys     0m0.037s
>
> 18k+ commits traversed in half a second here, so I really don't know
> what is going on.



--=20
Alex, homepage: http://www.bennee.com/~alex/
