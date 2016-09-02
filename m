Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7081FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbcIBTYb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:24:31 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33005 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbcIBTYb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:24:31 -0400
Received: by mail-ua0-f177.google.com with SMTP id l94so186374968ual.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=zr6EXg/1oMNOvbMmeJkRaF3j11EjfAZs2A4wwr5Q108=;
        b=NzInlU/Jc263mB8iXYsEfiSjKo5EZ55Q7IibwBb3l8zkyVve5OBDlM3ARbbuFWjoTb
         5XZdB8XkOQ8ah34ZdYPnlLbLuC2ofpn2xINk6VVsBjon+sYkQFMifjWHrsVwykQTn7SO
         s95rz+oCmtTc4BbxOuQiuWdQlo9VmXI/wAuz3rktMLrAw+YZrj3uyF/Wf0C+ovcREase
         5MRHPAZ3oooRm1MWDd6ekYtgCo8mDWEM3O+nY0yL0QnWD6UmSmI9b7wMS6Z+ArC2OSmk
         +CM6dop2tCPbECnQdYhUC0X+tULNME7kKqqmlxndAtA2ohEumaasYXzVD1VxkMg4aeXb
         UZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=zr6EXg/1oMNOvbMmeJkRaF3j11EjfAZs2A4wwr5Q108=;
        b=k/uKsVA0+zjXXlWfKhDOmtVYa6DkbZMN+jajzmhJ0g8pVVFYra4Ion9hfJyQm3LvAf
         Ltv+ce9V6zRqff70M0OugXtY+I9/dXhV8oBy9HS0dHQkApKZUq5D1zi6Klvb8yWd97jQ
         e5iLmB9fwV978Gb1vA4tZ8qLCi4G19aD7Oe7Hr6B+OccgZ4OMO6utiWk9GeP4ne4tdeZ
         jMcwrFflPuNZ8kX+LLs4QFVbcc+g33ZTzuyFCdYTQVR7q6AZF2TH/kdUFiq0CSisIPtX
         IkJdLf+fEGUEgJRPqt3f7JjWIiE4G1Qg7YcER15CqT5yqUVefzI2CVU70v7b0+kyFd8S
         HlfA==
X-Gm-Message-State: AE9vXwMROQJBEbypXCkn5pN+BSp+qppb67CW957+aZT+aOpM6v2EN8wRJmQOpdvqBE9gTFRwAw+Ft2BgDRj+vg==
X-Received: by 10.159.55.199 with SMTP id q65mr14903435uaq.12.1472844269098;
 Fri, 02 Sep 2016 12:24:29 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.4.230 with HTTP; Fri, 2 Sep 2016 12:24:28 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 2 Sep 2016 14:24:28 -0500
X-Google-Sender-Auth: -pcHJCA1JHC8tXvANw3YswGRLlw
Message-ID: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>
Subject: Fixup of a fixup not working right
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose I have a branch with 4 commits, in the following order (as you
might see during interactive rebase):

pick 123 Original Change
pick 789 fixup! Original Change
pick 456 Some Other Thing
pick abc fixup! fixup! Original Change

However, let's say the first commit is already pushed upstream on a
topic branch. Since there are multiple developers on this topic
branch, I do not want to rebase right now. Instead, I want to document
future fixups via fixup commits and then when we're ready to merge, do
a final rebase prior to the merge to master to clean things up after
we're all done collaborating.

For this specific situation, since the first commit is already pushed,
I want to perform a fixup on the 1st fixup commit. When I perform an
interactive rebase against upstream topic, I get the following:

pick 789 fixup! Original Change
pick 456 Some Other Thing
pick abc fixup! fixup! Original Change

The tip commit (abc in this case) is not marked as a fixup. What I
expect to see is:

pick 789 fixup! Original Change
fixup abc fixup! fixup! Original Change
pick 456 Some Other Thing

Is this by design, or a defect? I assumed that Git would only look at
the first occurrence of "fixup!" and treat everything else after as
the commit description to match. But it seems in this case that it
stops at the last occurrence of "fixup!", which would explain why it
isn't matching in the interactive rebase. I haven't looked at the
code, though.

Thoughts? Also I'm perfectly willing to accept feedback involving me
just using the feature wrong or as not intended. Thanks in advance.
