Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6CC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbiDYNyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbiDYNyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 09:54:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3553A79
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:51:16 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m13so2304001iob.4
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=24/InwghAWqYH1s+/ycdQxcY9Jbj/NKzduiItcEZLeA=;
        b=f24UjStKkYGQLnR2UWRXtYSBEfZaKlSxWrDqcp+p8xMVGvrq7kpS2vCQ9ctu5/WtIw
         E3Fq0w9OEtHC/ji16BnkHXt2qPIy7moMtGH77vOsAG8ARZu9IY/Mann8ctOeG5IUvywi
         T4VlDB9fxgTYaSor/tuHR6/5v/6N+mQRNIb+6qxe4SQu7ACVhxDHuZVZ0u2tUuXuzFfL
         lkytPoByXCiwsStuTm4mMbxlidoF+cpQIM7wfYCFmSducrItqKWDrMFS/UBmO0R+8NFm
         BSZWO/Q5xWsovahjKvvm176Q3j7URzrtbHmLGTrdM+5kYofxrag6d9wRgBWdCOeO6TrW
         kAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=24/InwghAWqYH1s+/ycdQxcY9Jbj/NKzduiItcEZLeA=;
        b=oE8FF8lXEFFBjYZiAXo2tYgOqeY8diMrqXRegk7GxP6q86+yc1q9Zpe/gT0fPv0Wsf
         qTzPcLjmf1sQ3rDPKOsDe3qJypMNPXYF9yaLbjf4WtLwEUCOPU8FyrJrXaZWB5LOqboq
         fCJVbup1O3boAPtQaeAXLaKSDI4sTwm0vy5rJoPMQQKjluJpYN9BHS1KXP7bti/2N7kj
         7/n3r/l4XJt9k78JFPi9dwWWlQLBx8XXt0wyq/3wvnuZCR7nvrrbrVxeH6nIsrec1SG5
         sPGVClAx/qnDzdHdTRf6MC0TYFCzvalijBkhIKJIdwJ0WWNHLFHUEyOMnVLnZYLu/JNp
         FQ8g==
X-Gm-Message-State: AOAM533H4mvaLYRpX9p4/HrqvJa2y6GS3wAizBQIGmptCnVIQxf0L5Uf
        aSkGo8NA3RdgSKhPrGZX/0XFN7uFHP/pZktoD+N94uAK/mHSkQ==
X-Google-Smtp-Source: ABdhPJzpqFSu2bjBUWgbVafUoj7BWr0QFwTsbdybDSR/G4YOelWTXDgYZ5s5RlB8dK2t39NTYg/HSXZ8+IxYCOrk1Dg=
X-Received: by 2002:a05:6602:c3:b0:64f:d28f:a62c with SMTP id
 z3-20020a05660200c300b0064fd28fa62cmr7162015ioe.212.1650894673915; Mon, 25
 Apr 2022 06:51:13 -0700 (PDT)
MIME-Version: 1.0
From:   Wannes Sels <wannes.sels@gmail.com>
Date:   Mon, 25 Apr 2022 15:50:59 +0200
Message-ID: <CAK7pLR1Se_woAr6ntUvka1Qfb_WBen5tXw7=Ybx0cPQrHM-X8w@mail.gmail.com>
Subject: No MERGE_HEAD available in pre-merge-commit hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MERGE_HEAD ref is not available in the pre-merge-commit hook, but
it is available in subsequent hooks prepare-commit-msg and commit-msg

From https://github.com/git/git/blob/master/builtin/merge.c#L843 :
in prepare_to_commit() the call to write_merge_heads() is after
run_commit_hook("pre-merge-commit")

Can the write_merge_heads() call be moved up? At first glance it
doesn't look like it would break anything.
