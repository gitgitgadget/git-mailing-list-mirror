Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2E41F454
	for <e@80x24.org>; Sat,  9 Nov 2019 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfKIVjR (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 16:39:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34978 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfKIVjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 16:39:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so7531901pfq.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2019 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tHJuApebOljYMgg83Nl7wGj+9QZGhN2TzgqDvk5kqMg=;
        b=Ec0WfzyzYinMO3dlXqjMIUeghqq+r9qd+AnnTMH4E43NFMLHzhDk8IeE1dqof4sxe2
         +fA4mq4i/Tub7eu9/EMJheOQWW48/xXEMfdO98KD7EihDB79Sg8ZPCTFqgeK1Z8IV+fo
         atHrhcREt2PVrn8HlAlk8Z6OieMN7bffQF/VzKuU54nwgETTNMXb09bzqNWcT9YiaDWb
         66VpS+NV9HetF7E4YqdJ2DCHRgOzpcUB4rGrb6l/5APVeFIRmcwr0f59qWPLDBXKaU/p
         Cd7bIqmsYr3396S8c0grJbGB+hq+74b5HtWpGc6cNVxBEw0fu8XutkNeICvXYxJ5n6Ya
         MqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tHJuApebOljYMgg83Nl7wGj+9QZGhN2TzgqDvk5kqMg=;
        b=a2kgYARDcNb26C/jdbt02Pj9BJFmnidBRKIavis0AOmuFRnO4yRY2Uu/tuurrk7TWj
         w+eTpCIwm210NRsxvzZr9e+oiMQkFs3LthTxFSg+N34nPH6nrnIsjduJzHz6VSRCkrXf
         /TKw+R4pdI7/cBQfZwhuNAAsd9C390ogLXk5WitTE0+LH0+0GiBiiTUMGZ3VhJ9o9MSf
         JYSWa6tcNyH+z5mt/xk9Bti49L2TTU+p6Fax4dAhMVEKsb+QJTFH7e+BP2zaYwup7FcZ
         uzPzemnwOCuZCFOSgL1w1RbA3E/7AX8aC9sxoLfb+iqy0NxQf5O80ML4EhrXX9O4Nrgs
         sgyw==
X-Gm-Message-State: APjAAAVoB0/5pcpyHo2yEidTqwBP3eEjqJe9KH5hTSQ42fbjHTQehBGf
        l07jVkUC4JKzt15asOFD8KHJYPW/z94dinlpGh/A+PwU
X-Google-Smtp-Source: APXvYqydn6r+awdPe60krVmhCphPeKIvMP9x9oKxhoCh18cHpwB5kbOXebMv2p/HP4fWA0oyfHDJHHuHS1BulemLGNM=
X-Received: by 2002:a17:90a:fa96:: with SMTP id cu22mr23741263pjb.121.1573335555499;
 Sat, 09 Nov 2019 13:39:15 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?R=C3=A9da_Housni_Alaoui?= <reda.housnialaoui@gmail.com>
Date:   Sat, 9 Nov 2019 22:39:04 +0100
Message-ID: <CAE0unxyojHVWP4aM3C+DdMYORmcoCuq-0wwLGjE8ok6dLj_E8w@mail.gmail.com>
Subject: Sometimes unable to lock the index during pre-commit hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I am the maintainer of https://github.com/Cosium/maven-git-code-format/.
maven-git-code-format is a code formatter plugin triggered by git
pre-commit hook.
On pre-commit, the plugin make use of https://www.eclipse.org/jgit/ to
alter the git index to format files.

When performing:
  git add . && git commit -m "Test"
The plugin works without issues

But when performing instead:
  git commit -am "Test"
The plugin fails because it can't lock the index file.

With the commit "all" command, it seems that the index is locked at
https://github.com/git/git/blob/master/builtin/commit.c#L419 and kept
locked during the pre commit hooks execution.

This difference of behaviour with or without "all" option leaves me puzzled.
Are pre-commit hooks expected to be able to manipulate the index?
If yes, can we call the current commit "all" behaviour a bug?
If no, is there a document specifying what hooks are authorized to do?

Thanks in advance
