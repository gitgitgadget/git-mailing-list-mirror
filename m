Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506DC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbiFJVKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbiFJVKh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 17:10:37 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC4B18389
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654895419;
        bh=nqGXZ59sNi8y0s09aVPlCs/C14AJrcgw8sCVTdyn0tA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sMQV0jclRHlHqwJeZkmZlSg+jVJJPbKGy4V8/bGJYOPeHrPy6t0r6uAS7pRxqTdQx
         uJ1Xa4pj1GMNnkZKDI7u1SCa8BGingaF+7A9OxBB37Cro1oLZXZaCVLIp/U//3cDlD
         tOi5HPq12G6QWJHV8ZI4OvlblHP2dliv6ZvO/te4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xjb-1nYRVB3Kdv-010Ctf; Fri, 10
 Jun 2022 23:10:18 +0200
Message-ID: <0b9bc499-18c7-e8ab-5c89-f9e1a98685bc@web.de>
Date:   Fri, 10 Jun 2022 23:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v14 2/7] object-file.c: do fsync() and close() before
 post-write die()
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>, avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, neerajsi@microsoft.com,
        newren@gmail.com, philipoakley@iee.email, stolee@gmail.com,
        worldhello.net@gmail.com, Neeraj Singh <nksingh85@gmail.com>
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <cover.1654871915.git.chiyutianyi@gmail.com>
 <a327f484f7f7466597930e87686e7156beabdc45.1654871916.git.chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <a327f484f7f7466597930e87686e7156beabdc45.1654871916.git.chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Md+ZJfkunLUpt6puXDVa+KiPeII9vwtxT5a56gJb9ZLcsd1rFbp
 rF0DkrBdHMApT4z3r7M/fQWoDFylj8pXgDB0PJGpB3SehceE9WDDxdcKW7FbOPh0kT25SSF
 t8SUn63n02OIDu5iy4iJmG6NUoyEzEk6l6UDW40LpzbGsCkJ3h3gNL9+NBhLjX7Ewsclk+7
 07qIFY/N36/z4ozP3CTOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A1XluP8a1Kk=:dxJsj7MmvTvsGHGVFsTZdJ
 5MZ5rpWVelslur9ZdcoGrZQVV8stPacVhhVdfevsB7bSfpgJWJ4JXUugZIgVjkoeVFoLNUCk7
 4E5F1ORcvOwFtOFDH41zpSf3Iw9ISVOfZCIcQPG9IL6WYqwHGr6elLfDZ+U8opdzmR3yA6s9h
 bcw8EY6f3z1FeHrs9CD0vHDM6vdeyYks+c2LAOD2GotdNlEsMLXYyY8XpvLgHvMSGMCHNokJ+
 pbwRqIEYBxuajnb1HT5HdxkpJF8O7tDA/tDtnItVWqeGxOW60abItrSo/vkXiAIAiZzGTJYaN
 FUGTmcJBN0LtXcFn8C2wQO6I1o5xG53cHkd4+N1zOhEOBVhKBquSzlog6GWD9HTvU4bhmL3bd
 6YbxQOi+FjPF/pui+tTxWgVqf74X2aGmu8EBvDSShvtcuHgR2z7i/YNxMijLdIkUf25jZ1/T6
 TwbIBjExjGZVBXpB17bzXwAcuou0QXK8OAx6Xnuhbo0lU2TedVrem0e043J+7Hd182Ya5szck
 qalxhPcCS6MgkeyehigX2ejQo/8rYFGB14RnL1Tweh3WVQnzLLmMYMfK/M9R2wunXQH42B1kP
 THK96uAxZoMf00+pUVKGKy/gqJCOl+VjpzQbDRoxcYIWOZ5QXmZr+mD9+tLKXYhez4LKxqOqo
 sNL6u+E7p+k2FT+HiwJ/8q5VurgjMNyBYfBuw+hPcEKpqKzQXAcFa0YOfFogJb7daU/gbeI7K
 6HrLyCmGXGsvlaMFYtcQQJL+sftINhPN7VX8XDyCTg1HlyZkpsBziJM/y8wbcJighIJeQ5wLn
 D0/bYztRWa1z80RIB0NVN0Mf7oUPdsWoCNBbNaw/yFWYrOp/NyvRPGj8US+hudUWjEvGJ/NZE
 4OdJvOEaHdXMQ50M5+2MVFllzUa6davAQOVGUAJlG3t1rZmFVpkCKwEahB1nRezO+jEvmPo9R
 +t9RRUKQFiCGRn4sCkmp8e0lAebimf7wVvJB45R8rpW9mlUYr+RVz86uiutV/qvKLxWT2Mw7Y
 NEM7ytdyi8esVFyAn7YsizombN+5Miu+3AKyQEY6fItqYQUHD4mGpoaJ7h4qWvh/ED5UlVGGh
 28tu4+DTIrJFg8Y6fOj15j5cIInVqtUl+Go
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.06.22 um 16:46 schrieb Han Xin:
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Change write_loose_object() to do an fsync() and close() before the
> oideq() sanity check at the end. This change re-joins code that was
> split up by the die() sanity check added in 748af44c63e (sha1_file: be
> paranoid when creating loose objects, 2010-02-21).
>
> I don't think that this change matters in itself, if we called die()
> it was possible that our data wouldn't fully make it to disk, but in
> any case we were writing data that we'd consider corrupted. It's
> possible that a subsequent "git fsck" will be less confused now.

This is done before renaming the file, so git fsck is going to see (at
most) a tmp_obj_?????? file, which it ignores in either case, right?

> The real reason to make this change is that in a subsequent commit
> we'll split this code in write_loose_object() into a utility function,
> all its callers will want the preceding sanity checks, but not the
> "oideq" check. By moving the close_loose_object() earlier it'll be
> easier to reason about the introduction of the utility function.

This sounds like a patch would move the close_loose_object() call to
some other place, but that's not the case.  The sequence below (starting
from the close_loose_object() call) is still present after applying the
whole series, so it seems this patch is not necessary.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  object-file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 79eb8339b6..e4a83012ba 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2012,12 +2012,12 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,
>  		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
>  		    ret);
>  	the_hash_algo->final_oid_fn(&parano_oid, &c);
> +	close_loose_object(fd, tmp_file.buf);
> +
>  	if (!oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>
> -	close_loose_object(fd, tmp_file.buf);
> -
>  	if (mtime) {
>  		struct utimbuf utb;
>  		utb.actime =3D mtime;
