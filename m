Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2B6C388F9
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 07:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E76C222EA
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 07:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIhw7agN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771038AbgJZHuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 03:50:03 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:43457 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771035AbgJZHuD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 03:50:03 -0400
Received: by mail-io1-f46.google.com with SMTP id h21so9005712iob.10
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vBsZb4gx54elQxE9WUOC2+h4U0WVnlynSdzgnWglzrY=;
        b=JIhw7agNLiiyt36dbONrtnnIzabM+75Ue262n3fksQYdxpfak5nFnszlLf7Sh+wbHN
         MmDBdn2f4WK/zFl2fJiJ1JJntidgBdiq0Oz30qNkT81DHqF7rHsG2VCc0VroUfcHSJMQ
         Gkkz9zSQbBn659Ob0QZAOPFUst5iRjDE7Ngm2Mmp0lkYq/hGL9d7y7yWfxeDi9s34RMH
         j/6XOUY3pVy0/Wfeo7ZZsODBFSujZtdcMcrQpFAoQDFgWCXsuPs65fO/dxfioRkIA5Os
         Zvd4nqtkLu7jAyozv7mI6Beb1HJlOYvqQLZg9wbBVdTMddQBkAUfLptG/v4FoGbTG/nR
         nfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vBsZb4gx54elQxE9WUOC2+h4U0WVnlynSdzgnWglzrY=;
        b=IQxYDhJtAZnrpjBHcSdrA1yG/JIqg1kY4CMuHgWndI5qGzJRuavZ+hDJwQ2RTaE6nl
         RDOFlUWoD9zShxdv5dK5jhesdtiBjkDtcIIQL7WqOLS0Qqy/1Y0AuLEu1e8BRQ1CezL7
         nvGBBNsNLyzHj7clXmRUoVJx7tn+pMYy5t7p6vYIV3KN8Lett9PT/4Sb2XM2tIgpWAFc
         RqMS/0Cd+QNlv0ZhoaTfaJfS6RnoZKJJ4pJ4M+hlqQjr2tIZiHw9uqVfcowlMBdOW6xl
         /g/h++S4f6fmGcudoF5kHTvrqGGg/74cdCRwQVvhatoBVwOBArhTZ2hiqtHBM6+pc4M8
         FGLg==
X-Gm-Message-State: AOAM533oItOK/i8FczX/XgAowFLYkJMgtHUvUXw+Ccnkbx9T8dO7s6Po
        3XCcSSN4mDNIFhB4rG1tQ8KEWx+vqQc6CofBoYk=
X-Google-Smtp-Source: ABdhPJxeZYUL3tFoZwAs8n1BvPj/+KaB7F2jlw3eFQw8rNwrhHm5JhsfNlHCRH4ndTTPKTvW0WIMygEMueOJGTt9xMA=
X-Received: by 2002:a5d:87c7:: with SMTP id q7mr9456995ios.162.1603698601509;
 Mon, 26 Oct 2020 00:50:01 -0700 (PDT)
MIME-Version: 1.0
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Mon, 26 Oct 2020 13:19:50 +0530
Message-ID: <CAHjREB6Hh+urW3j2c9p45ZudSdDv0rUP28Lb4e4TZasqTzRmDA@mail.gmail.com>
Subject: [Outreachy][Proposal] Accelerate rename detection and the range-diff
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        christian.couder@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone,

I would love to participate in outreachy this year with Git in the
project "Accelerate rename detection and the range-diff command in
Git". I have contributed to the microproject "Unify the meaning of
dirty between diff and describe"[1] which is still under review, but
through the process, I have got myself familiar with the mailing list
and patch review system. I am also contributing to another issue[2]
which is still under discussion[3] about `git bisect` and `git
rebase`.

[1] https://lore.kernel.org/git/pull.751.git.1602781723670.gitgitgadget@gma=
il.com
[2] https://github.com/gitgitgadget/git/issues/486
[3] https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gma=
il.com/

Coming to the project, I have read more about it[4] and have created
the initial version for the timeline. I would really love to have
comments on it.

[4] https://github.com/gitgitgadget/git/issues/519

Also, there's a column for community-specific questions in the final
application. Is there anything specific that I have to fill in that?

Please let me know if I missed anything.

Looking forward to working and learning with you all.

Thanks and Regards,
Sangeeta

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Link to docs: https://docs.google.com/document/d/15mgqy4id1fXZWE1NvBEERWvET=
9zy-ZEfhp4x0NNv_d4/edit?usp=3Dsharing

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

## Accelerate rename detection and the range-diff command in Git

# Timeline

## Nov 23 - Dec 1(Before intern officially starts)

* Getting to know the mentors.
* Bonding with the community.
* Understanding the structure of the code and familiarizing myself
with the requirements during the internship period.
* Create a concrete workflow for outreachy tasks.


## Dec 1 - Dec 20

* Study about various Approximate Nearest Neighbor Search algorithms.
* There are various comparisons for the Approximate Nearest Neighbor
algorithm like:
* [ANN benchmarks](http://ann-benchmarks.com/)
* [How to benchmark ANN
algorithms](https://medium.com/gsi-technology/how-to-benchmark-ann-algorith=
ms-a9f1cef6be08)

* Would compare all the algorithms and would narrow down to one or two
best algorithms for our use case.

## Dec 11: Initial point of feedback

* Would take feedback from the mentors and would ask about all the
expectations that mentors and the community have from me.

## Dec 21 - Jan 05

* Would study how Locality Sensitive Hashing (data-independent) or
Locality Preserving Hashing (data-dependent) can improve our accuracy
(or even complexity).
* Would study various hashing algorithms and combine them with our
nearest neighbor search algorithm.

## Jan 06 - Jan 20
* Study if a pre-trained Support Vector Machine can add something to
our use case.
* Study how different organizations(eg Gerrit) decide if two commits
are similar or not.
* SVM=E2=80=99s have accuracy disadvantage as compared to nearest neighbor
algorithms. Therefore, I would look into ways if we can create a
hybrid algorithm which uses SVM=E2=80=99s and nearest neighbor algorithms a=
nd
get better accuracy. There are also some research papers on the same.
I would study that and would finalize the algorithm after discussion
with mentors and the community.

## Jan 12: Midpoint feedback
* Would take feedback from the mentors and would ask about ways where
I can improve or places where I was lagging.

## Jan 21 - Feb 15
* Implement the finalized algorithm.
* Benchmark its accuracy and complexity against existing methods.
* Use it for the rename detection and for commit matching in `git range-dif=
f`.
* Update the documentation for the same.


## Feb 16 - Mar 02 ( Wrap up)
* Buffer period for incomplete work.
* Wrap up the code.
* Implement the reviews and suggestions given by mentors.
* Write documentation for the code if required.
* Get my patches merged.


## Mar 02: Final feedback
* Would take the final feedback from the mentors and would ask about
ways where I could have improved on.
* Would talk about ways to connect even after the Outreachy period.


## Post-Outreachy
* I intend to keep contributing even after the Outreachy period ends.
* Would love to co-mentor(if possible) in the next outreachy and GSoC round=
s.
* Would love to review patches of other contributors and take part in
the mailing list discussions.


# Other Involvements
* Blogging is an important part of Outreachy, therefore I would love
to write a blog every weekend or every fortnight, as discussed with
mentors, writing in it the summary of work done so far, anything I
learned in that week, and my experience.
* I would also be glad to help other contributors and users solve
their issues and help the maintainers in reviewing patches over the
outreachy period and even after that.
