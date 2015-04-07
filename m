From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH 1/3] t7300: add tests to document behavior of clean and
 nested git
Date: Tue, 7 Apr 2015 21:27:19 +0200
Message-ID: <CAMpP7NZS5QB7YJF72OgRwSNM=ui=hm0KGaq_s35TS_5Nd40xOw@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com>
	<CAPig+cTHp3rc_o+cpgguXkPj_aUU6-Hw-Kv6RXyGv8Yt06conQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:27:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfZ9w-0004Is-I2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 21:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbbDGT1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 15:27:24 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:32885 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbbDGT1U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 15:27:20 -0400
Received: by oblw8 with SMTP id w8so55297928obl.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0nqBvVs1ZoxLuOGTwbvTAlhsyQFMseava9JmYsMutac=;
        b=lCIyLt7QIBWupjoVEgdDPXRJKJj/sBhWGVnFVcJDaDV47pmSCxqq+KkCmcQ3rpnuKK
         f1l3zzSG4o/1vTWcIl6bw5Shi7JOhUG7BMNXFZfVzV1yvI56f5CVDQ17KIxqiX2ggdlE
         NgRpuhk+N+jIGmxUjn20loiv6C+xHPhWxigFmXFyA8xI5Zq5HWnv00tJeLhTM+2DlWpi
         xM7az+lCkYR9fWjD3yc48Ba0gzGRug9ClsXYyucQ8rDYUsTAYQn4rDLih2DspWdiPy+i
         /E1MWoTfmMpbbEM3L1M13e7PS5ofTBarlTC5Kby2M306sCNhrdnGKW6UZHYgcMekHnw8
         PnYQ==
X-Received: by 10.60.123.40 with SMTP id lx8mr27450484oeb.15.1428434839650;
 Tue, 07 Apr 2015 12:27:19 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 7 Apr 2015 12:27:19 -0700 (PDT)
In-Reply-To: <CAPig+cTHp3rc_o+cpgguXkPj_aUU6-Hw-Kv6RXyGv8Yt06conQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266933>

will fix!

On Tue, Apr 7, 2015 at 12:06 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gma=
il.com> wrote:
>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>> ---
>> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
>> index 99be5d9..cfdf6d4 100755
>> --- a/t/t7300-clean.sh
>> +++ b/t/t7300-clean.sh
>> @@ -455,6 +455,88 @@ test_expect_success 'nested git work tree' '
>>         ! test -d bar
>>  '
>>
>> +test_expect_failure 'nested git (only init) should be kept' '
>> +       rm -fr foo bar &&
>> +       mkdir foo bar &&
>> +       (
>> +               cd foo &&
>> +               git init
>> +       ) &&
>> +       (
>> +               cd bar &&
>> +               >goodbye.people
>> +       ) &&
>
> (minor; ignore if desired) The above could be simplified to:
>
>     rm -fr foo bar &&
>     git init foo &&
>     mkdir bar &&
>     >bar/goodbye.people &&
>
>> +       git clean -f -d &&
>> +       test -f foo/.git/HEAD &&
>> +       ! test -d bar
>
> Here and elsewhere, you could instead use test_path_is_file() and
> test_path_is_missing(), respectively.
>
>> +'
>> +
>> +test_expect_failure 'nested git (bare) should be kept' '
>> +       rm -fr foo bar &&
>> +       mkdir foo bar &&
>> +       (
>> +               cd foo &&
>> +               git init --bare
>> +       ) &&
>> +       (
>> +               cd bar &&
>> +               >goodbye.people
>> +       ) &&
>
> Simplified:
>
>     rm -fr foo bar &&
>     git init --bare foo &&
>     mkdir bar &&
>     >bar/goodbye.people &&
>
>> +       git clean -f -d &&
>> +       test -f foo/HEAD &&
>> +       ! test -d bar
>> +'
>> +
>> +test_expect_success 'giving path in nested git work tree will remov=
e it' '
>> +       rm -fr foo &&
>> +       mkdir foo &&
>> +       (
>> +               cd foo &&
>> +               git init &&
>> +               mkdir -p bar/baz &&
>> +               cd bar/baz &&
>> +               >hello.world
>> +               git add . &&
>> +               git commit -a -m nested
>> +       ) &&
>> +       git clean -f -d foo/bar/baz &&
>> +       test -f foo/.git/HEAD &&
>> +       test -d foo/bar/ &&
>
> Alternative, here and elsewhere: test_path_is_dir()
>
>> +       ! test -d foo/bar/baz
>> +'
>> +
>> +test_expect_success 'giving path to nested .git will not remove it'=
 '
>> +       rm -fr foo &&
>> +       mkdir foo bar &&
>> +       (
>> +               cd foo &&
>> +               git init &&
>> +               >hello.world
>> +               git add . &&
>> +               git commit -a -m nested
>> +       ) &&
>> +       git clean -f -d foo/.git &&
>> +       test -f foo/.git/HEAD &&
>> +       test -d foo/.git/refs &&
>> +       test -d foo/.git/objects &&
>> +       test -d bar/
>> +'
>> +
>> +test_expect_success 'giving path to nested .git/ will remove conten=
ts' '
>> +       rm -fr foo bar &&
>> +       mkdir foo bar &&
>> +       (
>> +               cd foo &&
>> +               git init &&
>> +               >hello.world
>> +               git add . &&
>> +               git commit -a -m nested
>> +       ) &&
>> +       git clean -f -d foo/.git/ &&
>> +       test 0 =3D $(ls -A foo/.git | wc -l) &&
>
> Although in the latest POSIX, -A may not be portable.
>
> Alternative: test_dir_is_empty()
>
>> +       test -d foo/.git
>> +'
>> +
>>  test_expect_success 'force removal of nested git work tree' '
>>         rm -fr foo bar baz &&
>>         mkdir -p foo bar baz/boo &&
>> --
>> 2.4.0.rc0.37.ga3b75b3
