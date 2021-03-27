Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEDC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D44A619B1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhC0SbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhC0SbO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 14:31:14 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF8C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 11:31:13 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id q9so4599576qvm.6
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=S8mugO9vpbWaLmzeM66qN5LHbIdx+z0JxcLcv53wIJ4=;
        b=WAHOxKT3rWWtEGFFa25EgFahvQaKhJWh3xL7dyadAxO2Uvpa0XEWzJEq0rGMhELUar
         CRB+ulQv0nHOtI5CRddXFzlrhKvNXr+u/YLsoLbVU/G208Bsmuh32JiMra7eWtVX3+I9
         v2/sSbwNRstmmzvVmnxhe/znVsSgDvVrj/b3mrnOuM0IxCdT3yYl/zzdieyTdwOkemNS
         gHZvjOlm+AxPgTq5N7Ofivsb/afAqAumAfBa/kS6D3b0cB1O8dHBh6Oq59/Hkf+N6ooz
         2mokn7ZAU4msFO2nSXqa/812jYL/za9RGedwe0cxBVRFi1uayidrJGYZSvp5LbxQByF3
         fnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=S8mugO9vpbWaLmzeM66qN5LHbIdx+z0JxcLcv53wIJ4=;
        b=CaYaZ5yHWRPguJANvPLvwOE+ux/boJjpDmiBYAg+Qpvp1ct6LmtfoCDbbubenpKRGV
         UG5IcJ7j/5JqFOdnAyf6e+hx8+8WycY8BEqEzp+vrhwWfjAFpulQGJPMGbgv26MwLYon
         X746ZisiYG66Gzhw5qYw6WnZUl5q9IepwWENdTxXSoCiEzqDjbqPiDRpEC3vVvcHMyOW
         eaCzM50I7wj/tTPwrPoExQgDtiiPsS/KOBstYpU6CThlbfHh7VBBGZOqtr+8pCKtudc+
         lGwcYvu9XpiKYGyZwNiGCvZrJDcXqYc/B0/TFz+NTnvujrMKvpNc/LH9QgfPIUASUstX
         3Kjg==
X-Gm-Message-State: AOAM531BZvHGEtgwq2ryFposkZMv4usI0MVYvERpXF3gouVnIahRLHoU
        KuiNHYaW12JWlXWoN4UZCOybOcqs3DL6lg==
X-Google-Smtp-Source: ABdhPJzVMFWTwG4GZazwvh98J1H79YudnusJm6y8L4fsoRR3OLNB+7L+SvOvA8wOPtZCjpgmjuUE5A==
X-Received: by 2002:a05:6214:4ae:: with SMTP id w14mr18482838qvz.45.1616869872528;
        Sat, 27 Mar 2021 11:31:12 -0700 (PDT)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id s6sm9505100qke.44.2021.03.27.11.31.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 11:31:12 -0700 (PDT)
From:   Utku <ugultopu@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [BUG] Git is not using the configured SSH key when there is another
 SSH key added to the SSH agent
Message-Id: <967BFF88-A8E1-4EEC-B298-668012E42C03@gmail.com>
Date:   Sat, 27 Mar 2021 14:31:10 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Versions

- Git 2.30.1
- macOS 10.15.7

# Steps to Reproduce

- Have two SSH key pairs on your machine, one with a passphrase and
other without. The keys were created by running `ssh-keygen` in my
case.

- Add the key with a passphrase to the SSH agent by running `ssh-add`
and entering the passphrase.

- Have an entry like the following in your `~/.ssh/config`:

      Host someName
          HostName bitbucket.org
          User git
          IdentityFile ~/.ssh/private-key-of-the-pair-without-a-passphrase


- Add the public key of the pair without a passphrase to your BitBucket
account.

- Run `git clone someName:path/to/your/repository.git`. You will get a
not authorized error. As far as I can tell, this means that Git has
tried to use the key with the passphrase (which is added to the SSH
agent). Since this key is **not** the key that was added to the
BitBucket account, we received a not authorized error.

- Add the key without a passphrase to your SSH agent by running
`ssh-add` and try the same command (`git-clone`) again. It will work.

- Now, remove both keys from the SSH agent by running `ssh-add -D` and
try and try the same command (`git-clone`) again. It will still work.

I didn't test but don't believe this has something to do with the key
having a passphrase or not. Also, I believe that I'm not using macOS
Keychain to store the decrypted keys.

# Expected Behavior

The `git-clone` command to work as expected, regardless of which keys
are present in the SSH agent, since the information that I provide to
Git (via the `Host` information in the `~/.ssh/config` file) is
sufficient.

# Actual Behavior

Git is trying to use the SSH key that is present in the SSH agent,
instead of using the SSH key which is explicitly declared in the
`~/.ssh/config` file.

