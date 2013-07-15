From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: Segfault in `git describe`
Date: Mon, 15 Jul 2013 16:31:38 +0300
Message-ID: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com>
References: <krrkk0$kri$1@ger.gmane.org>
	<51E3F337.8070708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 15 15:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyisU-0001Dc-LF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab3GONbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 09:31:41 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:54624 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab3GONbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 09:31:40 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so9270814lab.22
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KGl+JlTc1QSFK9/HOGnczNPYjO7dw+e9/DvqPTwNva8=;
        b=RuvrojRYVDvl4vtS/6i1G47BoL9LdioSX9YUCwHbTQxr86xVRwqsti9IAWs8jjv9PT
         4N+1pRf0O34hiwJHOXWiIVEQuAIQd7Fv/6vghIFBDhqJ8716bvKXDlw0n5b+hN2WpvRG
         1t3y5H3QbDyIIJ+hVWADgaPWlZCH57fViGn7RQPAsN+sxidWDcSSvtovZO6LoPKGBHAg
         8m5GzJP/0UmUGaf6rE2IkzDAPRlYYuhpufXb4kSO2C+5pdZpYkUH0+Yj0BmncvqUyICO
         DW/ANL+CT/nYmy7QhAnJ+Vgk31e//OvKsvui+jqQrCEeC4lCW3krmmLjLAVksHaFkzkS
         rn2g==
X-Received: by 10.112.167.100 with SMTP id zn4mr24341362lbb.44.1373895098681;
 Mon, 15 Jul 2013 06:31:38 -0700 (PDT)
Received: by 10.112.127.193 with HTTP; Mon, 15 Jul 2013 06:31:38 -0700 (PDT)
In-Reply-To: <51E3F337.8070708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230468>

On Mon, Jul 15, 2013 at 4:03 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 07/13/2013 03:27 PM, Mantas Mikul=C4=97nas wrote:
>> I have a clone of linux.git with various stuff added to it (remotes =
for
>> 'stable' and 'next', a bunch of local tags, and historical repositor=
ies
>> imported using `git replace`).
>>
>> Yesterday, I noticed that `git describe`, built from git.git master
>> (v1.8.3.2-804-g0da7a53, gcc 4.8) would simply crash when run in that
>> repository, with the following backtrace:
>>
>>> Program terminated with signal 11, Segmentation fault.
>>> #0  0x00000000004c39dc in hashcpy (sha_src=3D0x1c <Address 0x1c out=
 of bounds>,
>>>     sha_dst=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\337l\002B\=
214P\037\210ShX\022")
>>>     at cache.h:694
>>> 694          memcpy(sha_dst, sha_src, 20);
>>> (gdb) bt
>>> #0  0x00000000004c39dc in hashcpy (sha_src=3D0x1c <Address 0x1c out=
 of bounds>,
>>>     sha_dst=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\337l\002B\=
214P\037\210ShX\022")
>>>     at cache.h:694
>>> #1  peel_ref (refname=3Drefname@entry=3D0x1fe2d10 "refs/tags/next-2=
0130607",
>>>     sha1=3Dsha1@entry=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\=
337l\002B\214P\037\210ShX\022") at refs.c:1586
>>> #2  0x0000000000424194 in get_name (path=3D0x1fe2d10 "refs/tags/nex=
t-20130607",
>>>     sha1=3D0x1fe2ce8 "\222V\356\276S5\tk\231Hi\264\r=3D\336\315\302=
\225\347\257\300N\376\327\064@\237ZDq[T\246\312\033T\260\314\362\025ref=
s/tags/next-20130607", flag=3D<optimized out>,
>>>     cb_data=3D<optimized out>) at builtin/describe.c:156
>>> #3  0x00000000004c1c21 in do_one_ref (entry=3D0x1fe2ce0, cb_data=3D=
0x7fffc0b4d7c0)
>>>     at refs.c:646
>>> #4  0x00000000004c318d in do_for_each_entry_in_dir (dir=3D0x1fe1728=
,
>>>     offset=3D<optimized out>, fn=3D0x4c1bc0 <do_one_ref>, cb_data=3D=
0x7fffc0b4d7c0)
>>>     at refs.c:672
>>> #5  0x00000000004c33d1 in do_for_each_entry_in_dirs (dir1=3D0x1fdf4=
d8, dir2=3D0x1fd6318,
>>>     cb_data=3D0x7fffc0b4d7c0, fn=3D0x4c1bc0 <do_one_ref>) at refs.c=
:716
>>> #6  0x00000000004c33d1 in do_for_each_entry_in_dirs (dir1=3D0x1fdf1=
f8, dir2=3D0x1fd62d8,
>>>     cb_data=3D0x7fffc0b4d7c0, fn=3D0x4c1bc0 <do_one_ref>) at refs.c=
:716
>>> #7  0x00000000004c3540 in do_for_each_entry (refs=3Drefs@entry=3D0x=
7a2800 <ref_cache>,
>>>     base=3Dbase@entry=3D0x509cc6 "", cb_data=3Dcb_data@entry=3D0x7f=
ffc0b4d7c0,
>>>     fn=3D0x4c1bc0 <do_one_ref>) at refs.c:1689
>>> #8  0x00000000004c3ff8 in do_for_each_ref (cb_data=3Dcb_data@entry=3D=
0x0, flags=3D1, trim=3D0,
>>>     fn=3Dfn@entry=3D0x424120 <get_name>, base=3D0x509cc6 "", refs=3D=
0x7a2800 <ref_cache>)
>>>     at refs.c:1724
>>> #9  for_each_rawref (fn=3Dfn@entry=3D0x424120 <get_name>, cb_data=3D=
cb_data@entry=3D0x0)
>>>     at refs.c:1873
>>> #10 0x0000000000424f5b in cmd_describe (argc=3D0, argv=3D0x7fffc0b4=
ddc0, prefix=3D0x0)
>>>     at builtin/describe.c:466
>>> #11 0x000000000040596d in run_builtin (argv=3D0x7fffc0b4ddc0, argc=3D=
1,
>>>     p=3D0x760b40 <commands.21352+576>) at git.c:291
>>> #12 handle_internal_command (argc=3D1, argv=3D0x7fffc0b4ddc0) at gi=
t.c:453
>>> #13 0x0000000000404d6e in run_argv (argv=3D0x7fffc0b4dc78, argcp=3D=
0x7fffc0b4dc5c)
>>>     at git.c:499
>>> #14 main (argc=3D1, av=3D<optimized out>) at git.c:575
>>> (gdb)
>>
>> According to `git bisect`, the first bad commit is:
>>
>> commit 9a489f3c17d6c974b18c47cf406404ca2a721c87
>> Author: Michael Haggerty <mhagger@alum.mit.edu>
>> Date:   Mon Apr 22 21:52:22 2013 +0200
>>
>>     refs: extract a function peel_entry()
>>
>> The crash happens only in repositories that have at least one replac=
ed
>> object in the branch's history. Running `git --no-replace-objects
>> describe` avoids the crash.
>>
>> The crash happens only if there are any tags under .git/refs/tags/ t=
hat
>> do not exist in .git/packed-refs, or if I remove all "peeled" lines =
from
>> .git/packed-refs (including the '#' line; /^[#^]/d).
>>
>> A quick way to reproduce this with git.git master is:
>>
>> git tag -f test-tag HEAD~10
>> git replace -f HEAD $(git --no-replace-objects cat-file commit HEAD =
\
>>   | sed 's/@/@test/' | git hash-object --stdin -t commit -w)
>> ./git describe
>
> Thanks for the bug report.
>
> I think the cause of this bug is that peel_entry() is causing a neste=
d
> call to do_for_each_entry() to look up the replace reference, which
> resets current_ref to NULL between the test and the dereference of
> current_ref in peel_ref().
>
> Unfortunately, I cannot reproduce the failure by following your recip=
e
> (though I didn't have a lot of time yet for this).  I suppose that my
> repo starts out in a slightly different state than yours and therefor=
e I
> don't get the same results.  If you could find a recipe to reproduce =
the
> problem, starting either with an empty repo, or perhaps a fresh clone=
 of
> git.git, and double-check that you don't have any unusual config opti=
ons
> that might be affecting things, that would be very helpful.

Hmm, yes, just creating a new tag doesn't break in another
freshly-cloned repo, either.

However,

> =E2=80=A6or if I remove all "peeled" lines from .git/packed-refs (inc=
luding the '#' line; /^[#^]/d).

still works for reproducing the crash. When packed-refs does not have
any peeled refs, older git versions do it manually (I assume for
compatibility with even older git versions), while the latest one
crashes. This recipe should work:

git pack-refs --all --prune
sed -i '/^[#^]/d' .git/packed-refs
git replace -f HEAD $(git --no-replace-objects cat-file commit HEAD \
    | sed 's/@/@test/' | git hash-object --stdin -t commit -w)
~/src/git/git describe

--
Mantas Mikul=C4=97nas <grawity@gmail.com>
