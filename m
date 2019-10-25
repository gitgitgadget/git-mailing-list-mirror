Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCE21F4C1
	for <e@80x24.org>; Fri, 25 Oct 2019 00:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfJYAOJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 20:14:09 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:41073 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfJYAOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 20:14:09 -0400
Received: by mail-pf1-f172.google.com with SMTP id q7so321431pfh.8
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9kwStckybnnkm6wwVYf8NvhXxYctMsW9uFxXS0w6ULA=;
        b=bbUyy9Uxz6cnXnYlPDuGWThwQpo6ezp739knI3msJaBGKr2OTRuv/eXX5Wxgsx4NVs
         pTSGmv90wfURP0V5T+wpvEzftIxr0tM+nZTZWDEO0WzssQN6e4AVvK/Tfd0m+iM/4Bg+
         PCX3HWjz9OUMlJRZLOrQHPlu1SGlFSOZBzFxLuajMR1x80BJYP+HwG591rT6zBrxXnKX
         1STzFiXRCDzu4sO7Z8oEEvV9KEcqtW5N5hJC6wHDMczpLxj6WIuccSsxWg3qhCIQNPxm
         bDqWIfUU1DyNPVHu00lwV4QZ6VnMmM9C7LH7xdl8ezxv4BveqoRz6ndZGFQLOoYlhoXo
         2mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9kwStckybnnkm6wwVYf8NvhXxYctMsW9uFxXS0w6ULA=;
        b=nZaKeCFETM+EsXwwGcB3WKAc3nxFoITe7U7aBfaCICt0LEyVfsjILExDeGUNB3kU1H
         mN4azN8joBOV1yjEEC8EC2rsgEvUsR13EAqvmGVdqXE0t9ylO6s+FN5HhtA64IAvlj/J
         UorEpQHLnX/jnoeA1/Ij5oPijwX1C83u/oJOuxN2AMTBL1VSDX4N7D2QI8X+kgQd1iTx
         XXO/xHE23+rIgKD3252sesqomXEnXc6oo8WEYt1XLcjfd3EcO/VXyCM0QBPlIumw0W6L
         5dPDEKdzD7CuWjCYq8yJF6xOXxTSNkfCeM5qNp7Rep7TyfftpgSlhJCZ7uz+xY9dDIs2
         1XRw==
X-Gm-Message-State: APjAAAXphKbivmB+ARoJlz2vJ2vujo9orpmp3kq7g7E9XnGyGsa1y6h3
        Tw2jcEXIEaMmVFi4rD7l3/+/VNzVasRXqOUWom5zPPsjH5k=
X-Google-Smtp-Source: APXvYqwEoif7601DEFryZIbZMBMsql659fF8fA7Zp8zp4AOCJKx0prz0BHpmCZiJSAoSKQaDu91PiqLv2t5vsTXc2Cg=
X-Received: by 2002:a65:6203:: with SMTP id d3mr858360pgv.272.1571962448388;
 Thu, 24 Oct 2019 17:14:08 -0700 (PDT)
MIME-Version: 1.0
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Thu, 24 Oct 2019 18:13:57 -0600
Message-ID: <CAOc6etaQvNChdRZ70xsYQxqtgmZVxaKV9K7_zZeET3JuQ4HEXg@mail.gmail.com>
Subject: conflict markers on recursive strategy with diff3 enabled
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm sitting down hunting for conflict examples and while looking
through past conflicts in git I found one that has a format that I
hadn't seen before. When merging the parents of 8b79343fc0 we get
this:

<<<<<<< HEAD

/*
* Unlink the .pack and associated extension files.
* Does not unlink if 'force_delete' is false and the pack-file is
* marked as ".keep".
*/
extern void unlink_pack_path(const char *pack_name, int force_delete);
||||||| merged common ancestors
>>>>>>>>> Temporary merge branch 2
=======
>>>>>>> 8b79343fc0^2

That is with merge.conflictStyle set to diff3. What I would like to
know is if the details about how the additional information that is
not normally seen on a conflict has to be interpreted (to be read as
"the part about the temporary branches"). I see some explanation about
it in [1] but when checking inside "git help merge" all I see is that
when you are using diff3 you will get the content of the parent but
there's more stuff than just that. Is it documented somewhere?

Thanks!

[1]https://stackoverflow.com/questions/31392513/git-diff3-conflict-style-temporary-merge-branch
