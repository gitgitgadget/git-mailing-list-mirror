Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE100EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGHHQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 03:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHHQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 03:16:24 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DC31FF6
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688800575; x=1689405375; i=l.s.r@web.de;
 bh=eLZs3Ac5QZsRLq2NHIDVMw3gy4nOEf9LlVxzqlMCojE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oBL7dWgCsuKYX5vCE/JBMj3X8n62IzLvf4/ySSUIEw6kMvK7T09tYQZ67rInCnok/UQOj+c
 hnuMSNJDPbgGY7fWfKPDA4FloEwTN0/XORlThnjta6c+eZKi9PjU7PZi6uccnmLT7eZmsmyyl
 JddLIWzMtMq27LwVIf+dfouvJKKYGQgHJwWEuh+JPWmHXESRKgeAaAXG8CpoL/+LnW9GAuO6e
 kqj65UJN73JmoVm0nOhd600FjcUY+vOxMbZ00/GrOg1ZZGuCd4mJIigVyq2N0d+hvWKwzwDpO
 XLfzJJVhogNZuiF8NVSfPWuafpMadVWmroOFL+FXTNFN+0Lg9V+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTGt-1pgUQp44lt-00bhsd; Sat, 08
 Jul 2023 09:16:15 +0200
Message-ID: <f592e7c9-2a73-41f3-02a5-d77b7be574f1@web.de>
Date:   Sat, 8 Jul 2023 09:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] dir: do not feed path suffix to pathspec match
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Matthew Hughes <mhughes@uw.co.uk>
References: <20230707220457.3655121-1-gitster@pobox.com>
 <20230707220457.3655121-3-gitster@pobox.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230707220457.3655121-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O/zw3kVO+xWRjylbsxa5qJLbsPQPuSZ3wWwKJ2rtNohxZcnWlx5
 kFyVbIwV4wQQbBNnKZNmRaXVJevd/NBDd5I4hpHMUwTG9iAymJKhDwAb66W5nEcHrIYn7/f
 cDestUIxR56iEZkcyuDdr414XJpZ+aK83/xiaoAwHI/sxMEBY1EDizuigzEVhwhF5wyJu1v
 U0H5Ln4fHn3tuywg+xuYA==
UI-OutboundReport: notjunk:1;M01:P0:HSw8XMvYTEw=;pa+RqS6uFoYJS/e6t2h5QQVjFRZ
 8S14XPr5SVel76tkOdOojAj6r0sy84fXZiGDEoEGTycXznSYypQkxwV0fGTg5ibtdh5yyarVS
 decs8AfMVDfJB1yYaXsTlzl1FjosnY+/ZZJ7jrNF7wllwcLXYcXxm0euzxdCTHSdEhyfL6zEX
 VLRvnR1E0rPdWqLomDZLB3P8vY43FeUo4/MLRhszoXPNPR3NTshCI9hzkAImY9h4e0qWQCL66
 7pY3to19CAL32BYqFnpvPNWSdE0uxRgIpaBOO13M+41IcbVXw0OcZeYswSRfbJRyvUtCAPYEf
 sobH07dR2tYIV2H031crZ2usYwxgap7ZvATsVj6CsT/vCkfSUFlojxWgWGgsGeQvAVY3T1oTt
 vFp+NoB7rjBH28ADFf315Y0Y5jwovvCvNCKnj3BiTh6DyBsLCOKOFTOP0OulLGb+6AvJlDheT
 cZgeUA9XE0iVH5m8cDVAY+P4HI78Ui7xYxA+ATiGAvAD51n+BEATj4e4D4QWg+ZxjCaKY+2JP
 b0QBQdNdcvunJC8EdIoVEYegqlWK9WaWZcCjUdvApxXK1/4E4QOKzL/OUh5tEh1LxH01mPInm
 E7ud7CvnBEXovsI2eI2X/wxLnPdO9yi8LgV3wMF6Sg4j5XAzenuWNtJmFFYtsKvSoG/zUa/6u
 XLRH3CxUbGkimFZ0edtMl271Y3hM1cROvJ9qfadRPKl1dzrOKcMCPEn7JXjzYcErfLvTtqo6l
 g50+4xzdC0MZpWVWV02KOVSijVdKi8QrhVAbFe0Gu8G7awyKUiIXbXQ1DWq6sTiUcGF7o8ICc
 9PXzPCILxSYeqEKs0TWoM0/NjfwoDWggtKksjWbFAfij+YZSqto53PHquz8ACZoYXpvJC+PJA
 G6hMuG/TdwJV7GpLWtSVqSjgjkkJEnTuu3dpidyGipj15Va5YNjMHYjhrVFOPt3ZX+NuBg/v1
 8VLA8g+fddvfYRqxha/9PGBefIA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.23 um 00:04 schrieb Junio C Hamano:
> diff --git a/dir.c b/dir.c
> index 3acac7beb1..6116022ae6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -488,9 +476,6 @@ static int do_match_pathspec(struct index_state *ist=
ate,
>  			return 0;
>  	}
>
> -	name +=3D prefix;
> -	namelen -=3D prefix;
> -
>  	for (i =3D ps->nr - 1; i >=3D 0; i--) {
>  		int how;
>
> @@ -506,8 +491,8 @@ static int do_match_pathspec(struct index_state *ist=
ate,
>  		 */
>  		if (seen && ps->items[i].magic & PATHSPEC_EXCLUDE)
>  			seen[i] =3D MATCHED_FNMATCH;
> -		how =3D match_pathspec_item(istate, ps->items+i, prefix, name,
> -					  namelen, flags);
> +		how =3D match_pathspec_item(istate, ps->items+i,
> +					  name, namelen, flags);

With that, the parameter "prefix" of do_match_pathspec() becomes unused
and can be removed.  This cascades to match_pathspec_with_flags(),
match_pathspec(), dir_path_match() and builtin/add.c::prune_directory(),
and fill_directory() can lose its return value.

The code continues here like this, though:

                if (ps->recursive &&
                    (ps->magic & PATHSPEC_MAXDEPTH) &&
                    ps->max_depth !=3D -1 &&
                    how && how !=3D MATCHED_FNMATCH) {
                        int len =3D ps->items[i].len;
                        if (name[len] =3D=3D '/')
                                len++;
                        if (within_depth(name+len, namelen-len, 0, ps->max=
_depth))
                                how =3D MATCHED_EXACTLY;
                        else
                                how =3D 0;
                }

And "name" here would be affected by "prefix" no longer being added.
Does it fix or break --max-depth?  I think neither: builtin/grep.c --
the only user of PATHSPEC_MAXDEPTH AFAICS -- passes a prefix of 0.

Ren=C3=A9

