Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E112C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC0161038
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhJEHsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhJEHsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 03:48:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB98C061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 00:46:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g21so386133qki.11
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIVYdnVarM0rIQjNNzwNEzXtclW0vMKrrI4eaNosfyg=;
        b=DEQ85tp/kefjeRNA7kJ5LOHAz+QmcbMvPiAoumtotFy1arYaO17Ar5SyS97jqtpuYH
         V9Nq7ndGRgGXE/vB73oV1aztfFlAGYm6v9Anrls43qHKDBJAx5STDP8i3wnOcF8BVKpN
         cqQVyjtqvQNCv++M6mqSwr1P1KQHUZoMw2IFRr8T3TGDlqziRVhIdZfFUEoz0qMqXL9C
         agHvAaGwAX+lHVTNsTTeOq0FWI7J418E52SHPnUbFGfDmHoVIu2R5BFpk1Q+8qbD8PDm
         BDLawmgWwAF/JNcLHqp96KJ0tlPF0yIdAQKvXYM3dWJE8lYIw+FrswXjeNHA1Cnp2RXU
         keLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIVYdnVarM0rIQjNNzwNEzXtclW0vMKrrI4eaNosfyg=;
        b=IdETZs+2e6iRNlQkeGrbWep0bsVojW4F0pbdHuyMf3iW4MXrlscVvBd0GI2Nv8F5bl
         bNnwb+tanON3IGw8VC5t9ucPpfyMQclFdJiys4FqGGsL7NxTdqgaSBfrrZoaY84BCkW0
         34cMrsikN6RU0rdkhA2sVHg/AYkDTI8+qI9Q24QfuytWkFJgT4ltbDMx/bdAQViArza6
         fDk3GKvDNHTwiol/i0SZm5QWK8s0ZoidhEktCGebbC1kb89dTQ/cly6qZDAiiEoDVx26
         nysD44SdF1iFzTzXflyWySv4JuD2tS+8gUNrdT4w8QQ+49Z0RpkSmNOueca+U2A9RCnW
         m01g==
X-Gm-Message-State: AOAM532nE3fHSrJGRIJkZiEPQwfOgotSrWlHQqbmllhOSoMbFp+jcxnO
        GZ204iIY+vVcrleYa/l869LgmFSEQqq6Rg==
X-Google-Smtp-Source: ABdhPJxNzwp+tvjZaFnW6hAqiwmUUE1EoUzsAhrdi4tTAtnIrKoXcPEQxRi3VTW3CqKmJ81t4F4cYA==
X-Received: by 2002:a37:9244:: with SMTP id u65mr14104648qkd.46.1633420018903;
        Tue, 05 Oct 2021 00:46:58 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c16sm8779285qkk.113.2021.10.05.00.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 00:46:58 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/2] protect git from a rogue editor
Date:   Tue,  5 Oct 2021 00:46:46 -0700
Message-Id: <20211005074648.86032-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211004072600.74241-1-carenas@gmail.com>
References: <20211004072600.74241-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of cm/save-restore-terminal that removes the unnecessary
forward declaration in compat/terminal that was patiently reported[1] by
Junio.

Also changed the wording used in the first paragraph of the commit message
for the first patch, which hopefully has better grammar.

The series implements a way for git to save and restore the terminal
settings around EDITOR calls to avoid having to deal with botched output
if the editor misbehaves.

Carlo Marcelo Arenas Belón (2):
  terminal: teach git how to save/restore its terminal settings
  editor: save and reset terminal after calling EDITOR

 compat/terminal.c | 75 +++++++++++++++++++++++++++++++++++++----------
 compat/terminal.h |  3 ++
 editor.c          |  8 +++++
 3 files changed, 71 insertions(+), 15 deletions(-)

[1] https://lore.kernel.org/git/CAPUEspiQrGDyYrBUmeMh0C1uPDjUE5d--5zT4vZZUdNr+xtAxA@mail.gmail.com/T/#u

Range-diff against v1:
1:  63cfeda4b7 ! 1:  cf8306816d terminal: teach git how to save/restore its terminal settings
    @@ compat/terminal.c
      #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
      
     -static void restore_term(void);
    -+void restore_term(void);
    - 
    +-
      static void restore_term_on_signal(int sig)
      {
    + 	restore_term();
     @@ compat/terminal.c: static void restore_term_on_signal(int sig)
      static int term_fd = -1;
      static struct termios old_term;
2:  0f409b6d00 = 2:  d83cd3f712 editor: save and reset terminal after calling EDITOR
-- 
2.33.0.955.gee03ddbf0e

