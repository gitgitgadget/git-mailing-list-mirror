From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Tue, 17 Mar 2015 00:04:40 +0800
Message-ID: <CABwkPcoRK9SGx=euPy3wjk58_TcOgN_uQYhvWvPyEn3JyrogGw@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com> <CAPig+cS07W6gtW8L5wbQwZuxSLxb-r0s6KNO4eDO5BYdBDbWjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:05:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXVs-0006c5-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 17:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935408AbbCPQFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2015 12:05:04 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34284 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933806AbbCPQFB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 12:05:01 -0400
Received: by pdbni2 with SMTP id ni2so62055347pdb.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FL/CWQFlay51ChVt9ha4GuetGvPz+YrYok/gYim0s6M=;
        b=WHSXLjhL0K1iM0L8zjXtxp4IR0eEQGdHisBUZbY38ymhWJ5cigobMQnSKlSnmMZGio
         JjSFurFvKMfBbbyutMeLGIfCDc6YUirwd8fw1ec/2IY8tYak5zuAiFYjoyIKGcG05AlD
         xvvruOpq8kOLDKIznsIrz7URsK5MYhpVO69ckj4jdPVdsjPUxHxeoPGj+YV3cg//qIu7
         +ihFsxQqCdDVGLO8hFAM0tdZ9hWW18SpL4oIPBUCqN4LxqNHldjANm9niLgiJcIkxijf
         8FGWl3eU1o4d4MmWzZpLlwHJtA+szdfvhA8tbd1NEhojXlPaG1inbjTxB4NUOmB1AUd2
         UlYQ==
X-Received: by 10.66.185.230 with SMTP id ff6mr140713127pac.102.1426521901082;
 Mon, 16 Mar 2015 09:05:01 -0700 (PDT)
Received: by 10.70.78.225 with HTTP; Mon, 16 Mar 2015 09:04:40 -0700 (PDT)
In-Reply-To: <CAPig+cS07W6gtW8L5wbQwZuxSLxb-r0s6KNO4eDO5BYdBDbWjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265568>

Hi Eric,

Sorry for my late response. Thank you for your suggestions! I will try
to use them in my next patch version.

Best Regards,
Dongcan

2015-03-14 3:42 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Fri, Mar 13, 2015 at 9:04 AM, Dongcan Jiang <dongcan.jiang@gmail.c=
om> wrote:
>> This patch is just for discusstion. An option --deepen is added to
>> 'git fetch'. When it comes to '--deepen', git should fetch N more
>> commits ahead the local shallow commit, where N is indicated by
>> '--depth=3DN'. [1]
>> [...]
>> Of course, as a patch for discussion, it remains a long way to go
>> before being complete.
>> [...]
>> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
>> ---
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 655ee64..6f4adca 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -295,6 +295,7 @@ static int find_common(struct fetch_pack_args *a=
rgs,
>>                         if (no_done)            strbuf_addstr(&c, " =
no-done");
>>                         if (use_sideband =3D=3D 2)  strbuf_addstr(&c=
, " side-band-64k");
>>                         if (use_sideband =3D=3D 1)  strbuf_addstr(&c=
, " side-band");
>> +                       if (args->depth_deepen)  strbuf_addstr(&c, "=
 depth_deepen");
>
> For consistency, should this be "depth-deepen" rather than "depth_dee=
pen"?
>
>>                         if (args->use_thin_pack) strbuf_addstr(&c, "=
 thin-pack");
>>                         if (args->no_progress)   strbuf_addstr(&c, "=
 no-progress");
>>                         if (args->include_tag)   strbuf_addstr(&c, "=
 include-tag");
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index d78f320..6738006 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -708,4 +708,15 @@ test_expect_success 'fetching a one-level ref w=
orks' '
>>         )
>>  '
>>
>> +test_expect_success 'fetching deepen' '
>> +       git clone . deepen --depth=3D1 &&
>> +       cd deepen &&
>
> When this tests ends, the working directory will still be 'deepen',
> which will likely break tests added after this one. If you wrap the
> 'cd' and following statements in a subshell via '(' and ')', then the
> 'cd' will affect the subshell but leave the parent shell's working
> directory alone, and thus not negatively impact subsequent tests.
>
>> +       git fetch .. foo --depth=3D1
>> +       git show foo
>> +       test_must_fail git show foo~
>> +       git fetch .. foo --depth=3D1 --deepen
>> +       git show foo~
>> +       test_must_fail git show foo~2
>
> Broken &&-chain throughout.
>
>> +'
>> +
>>  test_done



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
