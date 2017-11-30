Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6181620954
	for <e@80x24.org>; Thu, 30 Nov 2017 07:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdK3HCd (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 02:02:33 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41263 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdK3HCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 02:02:32 -0500
Received: by mail-wr0-f175.google.com with SMTP id z18so5602249wrb.8
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 23:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9MZTd/KubcYPOW/QrelLoRKCE4pvohPRO8TVe144qFQ=;
        b=eGP1V49o2kQP/w2N2mvlSY70DveOEKy9SA8unyXgUcNi5SsUwNDFeJOfDPrEzFwR7w
         jVckTRpFBzpFXqLEGxDXJvxtkA0O+n+LBAokVlnVmiAvdaJXtT0mxizjrh+Ruf2bKPpt
         uC/aRZI81AqqDaYxa6n5zysEeGoEWH7+pxrRO2XZ3FBD4GhH5kV0xK36nBDLERME6oXz
         ktNG7JzAhVJpOx6ll4cFj+JhHjL1ZA/kDTWzg3e0B3nn7EJIMM+RwsYs6TL3t5SzvS7W
         fVoac/8esOmxNBzPQkq/KjdtiSxAQIF54liytleLfzX+3P0QByOz/0ueblxxiZcYtWYs
         sRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9MZTd/KubcYPOW/QrelLoRKCE4pvohPRO8TVe144qFQ=;
        b=WUmV5Duh8lZ4reyzeqA/BRRiIHY3pNBn5anG1nQPpPXgejcO2RPduxyL6nQKyudHER
         a2YFfES3UCa0N6tp8WPgzmYj3lJf1NvMpXulTdsEybyDMlSaKHtX+sx41DyQPTKg7JEF
         MLPPkclgr8lIvyHpQzV8dmz802eDKwNRX1PunL5yMFzDqIhC9wEqNrpha0C4wUffnQ/I
         IlwHCdtHIG2x56B5QQNoKtaUnprkQ1Fg5HE+cuIUG8JbjF1okiXREBVTOl1ghDVw2DZ7
         rGphLdQnFxWIsYy7SkJ16qj7JPrST+NOjSBxher5MzaGkf8RKnG5qPHbHw6S8rxhv2fr
         h7yQ==
X-Gm-Message-State: AJaThX4HLeSinwJbas42gVbjb2vDr0MThkcNEbAo7xpt6okkfNJtljDt
        MFN1VPhdzyEjnQ+HCT8Krj9G4zaJImnDvNe2PAZjbw==
X-Google-Smtp-Source: AGs4zMZnPWRFnPEpVO+jGQDDpBMs6cGC3MlBSl1GuaPuzcBWeXwOwHPKhgY+aD90YILW9ZrlRDhSVQ3YT4UunK6Z6LY=
X-Received: by 10.223.139.196 with SMTP id w4mr987789wra.51.1512025350895;
 Wed, 29 Nov 2017 23:02:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.152.107 with HTTP; Wed, 29 Nov 2017 23:02:10 -0800 (PST)
From:   marc PINHEDE <marc.pinhede@gmail.com>
Date:   Thu, 30 Nov 2017 17:02:10 +1000
Message-ID: <CAJsT1ck6dCPLLMLjgq9jrQmOAC-6jF6kFEX6aaRJGw3Hn9He=w@mail.gmail.com>
Subject: Git stash (or git rev-parse) doesn't inherit the '--work-tree' parameter
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello guys,

I don't know if this is a normal behavior, so I'll just explain it here.

* Behavior:

from a directory OUTSIDE my git repo, I can run this command successfully:
 $ git --git-dir=/my/repo/path/.git --work-tree=/my/repo/path pull origin master

But this one:
 $ git --git-dir=/my/repo/path/.git --work-tree=/my/repo/path stash
Will fails with :
 'fatal: $program_name cannot be used without a working tree.'
(Yes, the error message has been corrected since, but I use debian, so
I'm at least 6 month late).

* A bit of investigation:
I don't know many about git internal functioning, but with a bit of
googleing, I would point out git-sh-setup.sh:204, in function
require_work_tree, called by git-stash.
I could test (from outside my git repo, again):
 git --git-dir=/my/repo/path/.git --work-tree=/my/repo/path rev-parse
--is-inside-work-tree
return:
 false

What surprise me is that 'git-dir' seems to be passed ok to rev-parse:
 git --git-dir=/my/repo/path/.git --work-tree=/my/repo/path rev-parse --git-dir
returns:
 /my/repo/path/.git

* Question
Is this a normal behavior? Stash can only be applied in current
working directory?
If yes, I'll have to change my script to
 (cd && git command)
If not, should I push a bug report somewhere?

Marc
