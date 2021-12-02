Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ADC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 03:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbhLBD6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 22:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhLBD6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 22:58:30 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CABC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 19:55:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id m192so33419943qke.2
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 19:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uaz6yCv3lC4zMSLfNhSqbLrhK7KRrFigGI2+LtJRzXw=;
        b=SxOE1mbtwlLicMbiXmo4uFQE6L7yvy8q0eBzEtQcPe1I+iI6M3lHhbfsHz33Vu1Q46
         sORvyPfm3mZv3B2DvBTSa9Qh47mws8OF7PcFO2VCsturoIhIrKskpPD/z/dKBLI5/SbD
         Bo9fozhou8nTJYCjRDEU+IGFT964w0LCmCG6U3WdWIULF3FAZObfzNI/BhsbxVnWzxQx
         q0XWcLN5AoowN/1qu6rR6BJoU49TqudQAaZBOvn6cNbg69twGjpHlbalZq6C9XXPUnz/
         jg5azDQ/bkvYxOzhTtW7vO8YevslLYBpiRyr+Fhz9ETMsJkDM29Vl2HdfgP86bwQUE65
         Xcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uaz6yCv3lC4zMSLfNhSqbLrhK7KRrFigGI2+LtJRzXw=;
        b=CnEIUe9Tpo2oZSBFkak2zryi+r1OxKYeGlNsnbA8ZU9M94TKQWx1f8cKiiaCa1TCJF
         XZanAgjUs5KQpZXd6+VjYOFnbl3+v4kD9Scmdt1oKJuvPGo+RUHBlXuUcp9F/G9WjU8x
         LIklQEkybpojKG/L5o02H3rgY6sv6khoPxJSvEvmMuafO3AgSv0L6wxvu5BJkSDb65GB
         QIxpm5nbuFIgjB+kIQr8I70xLCwm6qQvBWptsHewfkEMTdOKfYimn+Yeg6OS8hYzRa0f
         Xm9HBwoeTojTQgPG94Z3zSA32WzDQsxzZvxeujkk1sHsxYDGuIsCWzVksTkTA8M3P15Y
         Au9w==
X-Gm-Message-State: AOAM531bmfAy3RU/kWRTvJsDKHfut3E+LaJT4zPNKJrQlr4uKAlbipDS
        VrEmJrIF4MTMvu6i1XlpqQy3WkJ4iow=
X-Google-Smtp-Source: ABdhPJz5WgnYW+Pg55O9GhiGvTTbTMlCupPMjCt6bdpygVNItl5BcStdaVvRK1V9gqaWh5CQjmvUhg==
X-Received: by 2002:a05:620a:450a:: with SMTP id t10mr10518955qkp.412.1638417307925;
        Wed, 01 Dec 2021 19:55:07 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q20sm881949qkl.53.2021.12.01.19.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 19:55:07 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chris.torek@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 0/3] editor: teach it to protect itself from rogue editors
Date:   Wed,  1 Dec 2021 19:54:43 -0800
Message-Id: <20211202035446.1154-1-carenas@gmail.com>
X-Mailer: git-send-email 2.34.1.460.g364565cfab
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series reimplements a problematic series that was partially
reverted in 2.34.1, but addressing all raised concerns and being
a lot more conservative.

The first commit addresses directly the issue reported and that
required the revert, but punts several changes to future series
to make sure it is safe enough for backporting into maint if
needed, it also tries (probably too hard) to not introduce any
behaviour changes, so it might seem "incomplete", but expect
further changes that will clean it up further.

The the second one is taken from a draft[1] and is ammended by
the third, hence why this is all still an RFC.

Carlo Marcelo Arenas Belón (2):
  terminal: teach save_term to fail when not foreground
  fixup! editor: allow for saving/restoring terminal state

Junio C Hamano (1):
  editor: allow for saving/restoring terminal state

 Documentation/config.txt        |  2 ++
 Documentation/config/editor.txt |  8 ++++++++
 compat/terminal.c               | 17 ++++++++++++++++-
 editor.c                        | 22 ++++++++++++++++++++--
 4 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/editor.txt

[1] https://lore.kernel.org/git/xmqq7dcnyh5o.fsf@gitster.g/
-- 
2.34.1.460.g364565cfab

