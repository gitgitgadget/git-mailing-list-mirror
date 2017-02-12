Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E061FCC7
	for <e@80x24.org>; Sun, 12 Feb 2017 12:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdBLMPZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 07:15:25 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38126 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdBLMPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 07:15:25 -0500
Received: by mail-wm0-f51.google.com with SMTP id r141so76865602wmg.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 04:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qw2VxlxTVDdNuIQZ9FIU+9imI2GtB9G8MHAAa1STUto=;
        b=pwQTkJJZS/U9jD4u1oknY4laY6xhHQlQRMheVZ1XdoWzC/NCpEqjzdfFhAklA1/jBz
         b8zYi9Mgjk58njXujuLl4/2XeLARxn08PtQ7CdXHHLGWC+R9aS2GClUkeTRVuZ8sco+J
         GQ84/lUtEPHDPoJtL3Nfq9iXDwr/baF9XR6fTHAHjrGsGrlewN29LGQ2Hie9VST9qYLQ
         rTtOYc09Yy1eYW8Sp46z9sVh4XKyzUzm8ufEwx0prsMk+bsCEw1Vk8fkL1QLpg9sbiVl
         uvXVjOA2oxtGS1HCbRLs+yohkSnPoByOATL4N9oth3r5OrrOACKNMVW9rALqTcT8HRyU
         w/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qw2VxlxTVDdNuIQZ9FIU+9imI2GtB9G8MHAAa1STUto=;
        b=DdGxONSQ70wQW+nOsppkDirwdPfDarQ93FGwaaquBgoUPYjxGs2a15vdYSjJzX0kDD
         lnZg7x/RuAXLJ/JCS88YPRU3YVuEjINSrd3CslWA3GkpmJmIxlITgdRoCYhG0ohqb3X6
         qchwQY1o1WwGA0gV70N9afvX1ywjAduIa2lwd/wsXzMx/ljPGWbqifs1aLApfElkP158
         2wn5oSsnAcZoMFMXoLvQCi82bESm5vE/NNbFw77mboBVUTngc5gMcogG39Z0GePW6bir
         AXrtoscOwIBj5CH86cAOMPhoJZkjIkJwVHNbEEeP+JyN109DMXG/liB6UF9FjCvE5ifv
         33Lw==
X-Gm-Message-State: AMke39l58BUIskdYt4nLa5C4+4N/5OyLuPbCFrdwk1n1ktvZFGCuDfQALmum7hjPOjUK0XwkVRUDJuufazDqIA==
X-Received: by 10.28.188.213 with SMTP id m204mr32955676wmf.0.1486901723411;
 Sun, 12 Feb 2017 04:15:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.159.227 with HTTP; Sun, 12 Feb 2017 04:15:22 -0800 (PST)
From:   Istvan Pato <istvan.pato@gmail.com>
Date:   Sun, 12 Feb 2017 13:15:22 +0100
Message-ID: <CAOcUJQwnCJOhUUU2RqJP2H5YxUr4qCEpyDj_XiiQSe4V6rcBmg@mail.gmail.com>
Subject: Bug in 'git describe' if I have two tags on the same commit.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't get back the latest tag by 'git describe --tags --always' if
I have two tags on the same commit.

// repository ppa:git-core/ppa

(master)=E2=9A=A1 % cat /etc/lsb-release
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D16.04
DISTRIB_CODENAME=3Dxenial
DISTRIB_DESCRIPTION=3D"Ubuntu 16.04.2 LTS"

(master)=E2=9A=A1 % git --version
git version 2.11.0

(master) [1] % git show-ref --tag
76c634390... refs/tags/1.0.0
b77c7cd17... refs/tags/1.1.0
b77c7cd17... refs/tags/1.2.0

(master) % git describe --tags --always
1.1.0-1-ge9e9ced

### Expected: 1.2.0

References:

https://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.1.1.txt

* "git describe" did not tie-break tags that point at the same commit
  correctly; newer ones are preferred by paying attention to the
  tagger date now.

http://stackoverflow.com/questions/8089002/git-describe-with-two-tags-on-th=
e-same-commit

Thanks,
Istvan Pato
