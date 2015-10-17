From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: git tag --contains now takes a long time
Date: Sat, 17 Oct 2015 12:14:58 +0530
Message-ID: <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
References: <20151016220739.GF17700@cantor.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 08:45:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnLFY-0004oe-MX
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 08:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbbJQGp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 02:45:29 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34181 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbJQGp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 02:45:28 -0400
Received: by vkat63 with SMTP id t63so80222652vka.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lS7PNzeohTHcZYbCOWxCEjDWMntTbRxaOc54tFCvk0I=;
        b=CSI5h03hJ8oTEpVUUoUXej8v7dCJ+KGMfxHqKFMS3HQ0YBggUsPoH5eV7yhykGIz4g
         u+AGVQ7eavfN0nvXVVtMNtRXyndFseLqE4QRhDI6poAaX26ysGrzDv/mIpt3KCD33XFd
         PWH7fJzwzAjCsKwiQfOLycf+EpUhO7A+G/gXzn8Y2Zobl5UEWNOCN/dKG/4Qw9ZF4bem
         0n2afWLxhBDuSHR4zrsHh7qHWQ+6+HlZvOFvEmdFA9Fz6VaGc5Nqa6mY3tnNdYZHAcfK
         3tHKpjvzQexHMrSY5OCFByfm2dryBT4T2OV5W1ZvkzRwflxCUSmm5F8osGSOZij49Dy1
         Sn8w==
X-Received: by 10.31.36.151 with SMTP id k145mr13598261vkk.71.1445064327452;
 Fri, 16 Oct 2015 23:45:27 -0700 (PDT)
Received: by 10.103.65.76 with HTTP; Fri, 16 Oct 2015 23:44:58 -0700 (PDT)
In-Reply-To: <20151016220739.GF17700@cantor.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279779>

On Sat, Oct 17, 2015 at 3:37 AM, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> Is this known and being looked into? I've seen a jump from 12 seconds
> to over 9 minutes with running git tag --contains on my kernel repo.
>

This wasn't known, thanks for bringing it up.

>
> snits ~/dev/linux> git --version
> git version 2.6.1.145.gb27dacc
>
> snits ~/dev/linux> time git tag --contains 825fcfc
> next-20151012
> next-20151013
> v4.3-rc5
>
> real    9m4.765s
> user    8m56.157s
> sys     0m2.450s
>
>
>
> snits ~/dev/linux> git --version
> git version 2.5.0.275.gac4cc86
>
> snits ~/dev/linux> time git tag --contains 825fcfc
> next-20151012
> next-20151013
> v4.3-rc5
>
> real    0m12.842s
> user    0m11.536s
> sys     0m1.098s
>
>
> b7cc53e92c806b73e14b03f60c17b7c29e52b4a4 is the first bad commit
> commit b7cc53e92c806b73e14b03f60c17b7c29e52b4a4
> Author: Karthik Nayak <karthik.188@gmail.com>
> Date:   Fri Sep 11 20:36:16 2015 +0530
>
>    tag.c: use 'ref-filter' APIs
>
>    Make 'tag.c' use 'ref-filter' APIs for iterating through refs, sorting
>    and printing of refs. This removes most of the code used in 'tag.c'
>    replacing it with calls to the 'ref-filter' library.
>
>    Make 'tag.c' use the 'filter_refs()' function provided by 'ref-filter'
>    to filter out tags based on the options set.
>
>    For printing tags we use 'show_ref_array_item()' function provided by
>    'ref-filter'.
>
>    We improve the sorting option provided by 'tag.c' by using the sorting
>    options provided by 'ref-filter'. This causes the test 'invalid sort
>    parameter on command line' in t7004 to fail, as 'ref-filter' throws an
>    error for all sorting fields which are incorrect. The test is changed
>    to reflect the same.
>
>    Modify documentation for the same.
>
>    Mentored-by: Christian Couder <christian.couder@gmail.com>
>    Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>

As Junio mentioned I did notice ~13x slower speed.

 $ git version

[12:02:08]
git version 2.5.0.275.gac4cc86

$ time git tag --contains HEAD~300
                                                    [12:06:03]
next-20150924
next-20151016
v4.3-rc1
v4.3-rc2
v4.3-rc3
v4.3-rc4
v4.3-rc5
git tag --contains HEAD~300  2.89s user 0.14s system 99% cpu 3.031 total

After applying b7cc53e92c806b73e14b03f60c17b7c29e52b4a4

 $ git version

[12:07:33]
git version 2.5.0.276.gb7cc53e

 $ time git tag --contains HEAD~300
                                                     [12:07:35]
next-20150924
next-20151016
v4.3-rc1
v4.3-rc2
v4.3-rc3
v4.3-rc4
v4.3-rc5
../Git/git tag --contains HEAD~300  38.30s user 0.19s system 99% cpu
38.519 total

So I did poke around a little. I think I missed this out on the
original commit (b7cc53e92c806b73e14b03f60c17b7c29e52b4a4).

diff --git a/builtin/tag.c b/builtin/tag.c
index 977a18c..2c5a9f1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -49,6 +49,7 @@ static int list_tags(struct ref_filter *filter,
struct ref_sorting *sorting)
                format = "%(refname:short)";

        verify_ref_format(format);
+       filter->with_commit_tag_algo = 1;
        filter_refs(&array, filter, FILTER_REFS_TAGS);
        ref_array_sort(sorting, &array);

After applying this and running the test again, we get:

 $ git version

[12:09:13]
git version 2.5.0.276.gb7cc53e.dirty

 $ time git tag --contains HEAD~300
                                                [12:12:00]
next-20150924
next-20151016
v4.3-rc1
v4.3-rc2
v4.3-rc3
v4.3-rc4
v4.3-rc5
../Git/git tag --contains HEAD~300  2.85s user 0.18s system 99% cpu 3.031 total


Could you Squash that in, Junio?

-- 
Regards,
Karthik Nayak
