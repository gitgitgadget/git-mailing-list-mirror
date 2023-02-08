Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76589C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBHP6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBHP5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 10:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EE4B77C
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 07:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675871784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=+UjfDphzA9RYGVqde3TNqEqbx7jdSrTyYcOCHpLc3xI=;
        b=eg529VZVFF1jqVjdS2sYUiPp0xvJSThc6r5qAJ4t/9CMoWuvpzUs94C4qgv5nZMHKTYrO1
        RPZrxojUYbm3SzylM7YWQjwMFF3gb5/P2no9+DQn/gwK4zxsdmTpw0htJogRSu0uTdrxq9
        iuRVPWM5wc5mVA+/3R6kFhFjxR11feA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-qItoCAouOdKc2VLnJfCXWA-1; Wed, 08 Feb 2023 10:56:22 -0500
X-MC-Unique: qItoCAouOdKc2VLnJfCXWA-1
Received: by mail-wm1-f70.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so1356842wms.4
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 07:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UjfDphzA9RYGVqde3TNqEqbx7jdSrTyYcOCHpLc3xI=;
        b=0R7ks4FmZjEMFK/tvlQUijATEn01cJsiJljOhHRziMx2e1G93U1HsnWC6oA4qe7H11
         5qQz7sXQ8DemAdssgWJPVrpt1OvKIJo0kFewwN98beBiVh2keag12MZ+0wj5Pk2sDlAa
         Z/ogcXz5YBKuYJkTvYD7LdEnj6Dd/werF6213Ct4JMBKuKBS/cfSyjX3XvBkSR8Pf/BX
         69sfA2KwThOY7paaVXV/g4sVgS+B1xNY9YRclCxcnO1Foax1lk+0QXb/V5DoXNFiVrBi
         pFzH9cR8MYZgMMmdIWcmbHaC15hByYMvuhp799rze/phNrP39sUpZDQHqC3g/pVeEFFe
         2GPA==
X-Gm-Message-State: AO0yUKUBA/Lm28/G5qsPzSCYHM8ghijGdDVYdyVqVhtRmL2N+exHccRd
        XAMG6l7JMdVrtFK2GJYtJS4NNuc3APEWh+3ZJP11FJEetGNorP5u2hzUhdOfVZcFsdrVNZE2qI4
        hzpuIFq1cPc8FX4cmWyrx+KWOVK5OU7z1WFPVZ4dsG7k4FGfBxzZ3PohHFw+lyXU2RV+5drPABA
        Ff
X-Received: by 2002:a5d:6707:0:b0:2bf:da34:2b37 with SMTP id o7-20020a5d6707000000b002bfda342b37mr7830034wru.3.1675871781110;
        Wed, 08 Feb 2023 07:56:21 -0800 (PST)
X-Google-Smtp-Source: AK7set/1UoQa0ayUWnY/TgeA4MMmwn9v/CUieywyEfhrDuEOSIMIeSbPupOdpqWW2M94HGo2OuSP4Q==
X-Received: by 2002:a5d:6707:0:b0:2bf:da34:2b37 with SMTP id o7-20020a5d6707000000b002bfda342b37mr7830016wru.3.1675871780813;
        Wed, 08 Feb 2023 07:56:20 -0800 (PST)
Received: from localhost ([2a01:e0a:1f1:7500:a3a:88ff:fe5e:fe6a])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4d8c000000b002c3e63c030bsm8670295wru.93.2023.02.08.07.56.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:56:20 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:56:53 +0100
From:   Max Gautier <max.gautier@redhat.com>
To:     git@vger.kernel.org
Subject: git rev-list fails to verify ssh-signed commits (but git log works)
Message-ID: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I was trying to implement a pre-push hook to verify my commits are
properly signed before pushing them, and stumbled upon the following
output (which looks like a bug to me):

$ git rev-list @{u}..HEAD --format='%G? %H'
commit 9497d347b048dbea7f527624f815f7926594c4bc
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
N 9497d347b048dbea7f527624f815f7926594c4bc
commit 2466c5b3c0f2053b3cdadf4af299aab35e74aa0c
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
N 2466c5b3c0f2053b3cdadf4af299aab35e74aa0c
commit ded83bc7f31df14b2e9a8d7bdfa1e95eee2bf5c1
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
N ded83bc7f31df14b2e9a8d7bdfa1e95eee2bf5c1
commit 16d17277c608d995ad4d0b495d029c753509930c
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
N 16d17277c608d995ad4d0b495d029c753509930c

While git log works and is able to retrieve the signatures

$ git log @{u}..HEAD --format='%G? %H'
G 9497d347b048dbea7f527624f815f7926594c4bc
G 2466c5b3c0f2053b3cdadf4af299aab35e74aa0c
G ded83bc7f31df14b2e9a8d7bdfa1e95eee2bf5c1
G 16d17277c608d995ad4d0b495d029c753509930c


I get the error even though I have the following config :
$ git config --list | grep 'allowed'
gpg.ssh.allowedsignersfile=~/.config/git/MY_SIGNER_KEYS
# by the way the actual config entry in ~/.config/git/config is
# 
#[gpg "ssh"]
#	allowedSignersFile = ~/.config/git/MY_SIGNER_KEYS

$ cat ~/.config/git/MY_SIGNER_KEYS
mg@max.gautier.name,max.gautier@redhat.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIL3W2Y4eAF92ySEW6ZE7d8Q+GXvP2G5quvN0zM+f1jGUAAAAB3NzaDphbGw=
mg@max.gautier.name,max.gautier@redhat.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIGBP0XfpNXRoFBIW9uEgfnCrrjgvzxr0taOYy0A03DtKAAAABHNzaDo=


Am I missing something obvious ? Or is it git rev-list running in such a
context than it can't find the allowedSignersFile ?

Thanks

-- 
Max Gautier
Software Engineer, Open Services Group, Emerging Technologies
Red Hat
max.gautier@redhat.com

