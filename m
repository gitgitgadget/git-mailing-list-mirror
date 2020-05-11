Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77989C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FE720735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="k4NQTLhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgEKLrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:47:04 -0400
Received: from mr85p00im-ztdg06011201.me.com ([17.58.23.181]:51410 "EHLO
        mr85p00im-ztdg06011201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgEKLrE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1589197623;
        bh=vjBvx9YJ/JNLskp3zfAw0WTuX4BXN8dEMQ27QrIuipU=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=k4NQTLhNGydvTTyDLU/2MA9xGzQ8vOgJgKgqFEVFob5U1rXrBjTz8TplbKtNCH9gx
         ca6SeEH9m0s2wmpqkqn/E2zvNAXmH8iI0bCkGrnXtzfTmNAH18nOiLSBmt+ctF0JVm
         PhMHQmFZI3RkIzCfVuJjO+4TNIrj8qcNBi0W+T+GDaxBmq4ulCM+kIPWjoVtPVEyOr
         PrL7pvjFY6AkCZ4j3vupgBXETXRe1dJ840bj3kTqI0J8tKfm+RDY+noGtuCpcsgrov
         onbdSyIY2nxpRD1E04QeZQWDpPGkSxJ+yobweVQeYQPMbgMc7JMA6s4zlRfB/CrdoV
         P6m5I/DkJe1SA==
Received: from toms-mbp.hub (unknown [101.114.127.198])
        by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id E5448400623;
        Mon, 11 May 2020 11:47:02 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC] subtree: handle unmerged history trees
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CA+GP4bou+_bvGjnd3Z+fctXX4V2sE=Ta9ivCnYmbn1+JUxKRQg@mail.gmail.com>
Date:   Mon, 11 May 2020 21:46:59 +1000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <57CDDE09-7AF8-4F0B-80A0-53E288455AE5@icloud.com>
References: <CA+GP4bqEjK2V7fGqXsJMkRURod8zVzZAQQ7woUUtqybxfnmSVg@mail.gmail.com>
 <CA+GP4bou+_bvGjnd3Z+fctXX4V2sE=Ta9ivCnYmbn1+JUxKRQg@mail.gmail.com>
To:     Claus Schneider <claus.schneider@eficode.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_04:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2005110097
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 7 May 2020, at 12:00 am, Claus Schneider =
<claus.schneider@eficode.com> wrote:

> - In bare mode it pushes changes to a separate branch containing the
> prefix changes which is fine. You get a problem when you run the next
> split. Either you re-split all the commits again - Or you add the
> -rejoin parameter with the result that the splitted prefix patches are
> part of your history twice or even more if you have further extracts.
> So this is either a performance issue or a usability issue.

A simpler way to link a split without including both histories would be =
to add a mainline commit with a git-subtree-split annotation, but =
without having the subtree commit as a parent. That would give you a =
reference to a commit not reachable from HEAD though, so plenty of =
opportunity to shoot yourself in the foot.

Persisting the cache between runs would be enough to avoid any potential =
performance penalty on subsequent splits, and is just a matter of =
changing the directory used. My unrelated patch implements that for =
other reasons, along with letting you specify specific commit mappings =
from script if that=E2=80=99s what you need.

> - Add traceability to each extracted commit in new history
>  - It enables humans to trace from the extracted commit to the
> original commit by basic reading, clicking in tools like gitk and
> scripting if desired
>  - Enable subtree itself to utilize the above mentioned traceability
> and simulate the add repository or rejoin merge commit. Subtree can
> then "behave" similarly independent of the method being used.

Have you considered how your annotations will behave if you import the =
same subtree repo into two different mainline repos? The subtree history =
would then have references to a bunch of commits that don=E2=80=99t =
exist. Adding similar annotations to merge commits on the mainline side =
seems like a good idea though, and would let you use =
find_existing_splits to avoid regenerating too many commits.

For the human readable link from the subtree repo to your original =
monorepo, perhaps a custom annotation would be a better fit - something =
like

git subtree split dir - - =
annotate-mainline-commit-as=3D=E2=80=9Cid-in-monorepo=E2=80=9D

>  - Add option for rev-list so it can list based on
> prefix/subdirectory. I have not been able to find any error, issues or
> side effects adding the "-- $dir" to the rev-list command. All the
> manual tests, I have done, behave correctly in my total patched git
> revision. It gives a heck of performance for many-commit repositories.

Have you tested the rev-list dir option against preexisting history =
without your new annotations or created without split? If any of the new =
commits has a parent that is not in the rev-list, it will look up that =
commit individually and recursively. A git-subtree-mainline annotation =
will shortcut that, but without it the individual lookup is massively =
slower than working from even a very large rev-list.

