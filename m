Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B4B1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 13:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdJ0N4H (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 09:56:07 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:44721 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdJ0Nz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 09:55:59 -0400
Received: by mail-io0-f178.google.com with SMTP id m16so12875490iod.1
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Unsjl4emMup9Q6YpzQanRGhqh/Ckl8KyYc6qRxVyPG8=;
        b=E+/KPV7xsvBG5y2KzYndR+ocMK9p+Bg/Au2W1sv0QwjZ1wPgiq8x5QnhRkfSADvIlA
         +XQlpKljRcaQutfanN6Oqg4tJy6NMAA3YHbJiIcTRYvT+7mzdhzudruWw+jOpZq94hMj
         eHfJIsmOQhrfPE2jlUY+o4unZz7Ru3uT/SEu6Xv1ip5DrvV0FwcPHN7ZxjL6cpwKPSDf
         5y9TbH3isROC6fhn4em90MdormvR1cnl/k26w+ifDF0yN9VvifG/Q00MadpQEJj/ssJQ
         NUMzQXyLLft4NM+U8hPf3EaCkGwhl8hIPHsgmFbtCZYwIKh3/GQcHB+5ABVFPaYOgwKA
         DfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Unsjl4emMup9Q6YpzQanRGhqh/Ckl8KyYc6qRxVyPG8=;
        b=FhwrOo0A45Has7Ybq/dc4OfqFC0rSmGgUB5VS1cogeApsJWf40q1xy/TTFYzFhghTe
         bvumOQMthE7OEcgi0QgMA/ji4/mSzz576bEZik3nqqVqLXNon57bYF5umpIlxc8OS3Dt
         mjVfUrJVt0NqSYq92dxXYZEUspSLsFQtlmNG52htAdtktkVUcctrSvMMhek1iRlyH4EY
         i20Y11D/4WNwp+0xGQ/QEreAeuVz4/5IzbsM61qx2JDigKmtfuV6jTuVx+4ICtlaLcLn
         5zw3IB1FA7qV/LVc9o8buagn64N8X5kISnm/jm5jQvOGopv0uM/Qz0cM/l9TXkwY5CXU
         8HDQ==
X-Gm-Message-State: AMCzsaWA9QRtzMRS6ampOsHoYYUs9tCJAEUNP66GbiUWhDv+0uOFz6A6
        G88J70Xd5GYQNOGWMQqC3ofG6E7ecS2VwdXUhiO9ZiXf
X-Google-Smtp-Source: ABhQp+QCWn1OM6vRSQhrxIXxQNLTMhaMHyMBe+N3DvJ7D3xC9Y2JaqobUd3ZiZbyX/O/dHW+kLm3/tbqrY7tz+v7y+8=
X-Received: by 10.36.92.195 with SMTP id q186mr693158itb.57.1509112558794;
 Fri, 27 Oct 2017 06:55:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.126.89 with HTTP; Fri, 27 Oct 2017 06:55:58 -0700 (PDT)
From:   Adrian Kappel <atkappel@gmail.com>
Date:   Fri, 27 Oct 2017 09:55:58 -0400
Message-ID: <CAEm1wifEZ5CXH7N_cCJpXQN-1dWBRZ1OQ=bJH-X=kR15Bg0Sdw@mail.gmail.com>
Subject: [Bug Report] [includeIf] does not parse case insensitive -> case
 sensitive symlink gitdir
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all, not sure if the issue I've come across is a known bug or
addressable, but wanted to report it just in-case.


** Summary
------------------------------------------------------------------
Using the [includeIf] configuration statement with a symlink'd gitdir
will not work if the symlink is on a case insensitive volume and the
location it references is on a case sensitive volume.

** Steps to reproduce
------------------------------------------------------------------
1. Create symlink (case insensitive -> case sensitive):
/Users/usera/dev -> /Volumes/CaseSensitive/dev
2. Create two files: .gitignore and .gitignore-work, both stored in
/Users/usera/

.gitconfig
-------------
[user]
  name = First Last

  [includeIf "gitdir:~/dev/work"]
    path = .gitconfig-work

.gitconfig-work
--------------------
[user]
  email = email@address.com

3. cd into a subfolder of ~/dev/work that has been git initialized.
Let's say ~/dev/work/repo
4. Run git config --includes user.email
5. See that nothing is output from the command
6. Update the [includeIf] statement in .gitconfig to be the real
location i.e. "gitdir:/Volumes/CaseSensitive/dev/work/repo"
7. Rerun the command from [4]
8. See that email@address.com is output from the command

** Other variations that were not tested
------------------------------------------------------------------
- symlink on case sensitive volume referencing a location on a case
insensitive volume

** Environment Information
------------------------------------------------------------------
git --version: 2.14.1
OS: macOS Sierra 10.12.6


If a fix is not feasible or likely to be implemented, I would
recommend that we update the git site's documentation to reflect this
gotcha. After verification of course.

Best,
Adrian Kappel
akappel <https://github.com/akappel/>
