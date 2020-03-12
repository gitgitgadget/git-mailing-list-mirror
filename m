Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E365DC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8725206E9
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJYPNoYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCLNbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:31:34 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:34232 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 09:31:34 -0400
Received: by mail-pg1-f178.google.com with SMTP id t3so3099798pgn.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nwyn+uvrQSVwFFU037C0/iV1nwL5hGxVBzt/oyn7eUg=;
        b=VJYPNoYi8Z+ZppJ7IHOI2oKuE9AHuCTN/67zGG1F1/5uRSWtszeTuPNYGl2HgQN5CJ
         zXCzVrG+AH7Kb+Yk1i0FW+/yhZy4+uTE2nSjelyvYRamXl6qJk1Lz8B50MnnrhRvq+De
         6cSjx59farFOZr1tj5LYJzezndbPgzxot0jyOQ27Qo9nSfjOORprF5N7DSBoyssaMiVD
         O/YdVTCyibOLOWtcOD9iQqVV2JmPNUscwFIzROMxVZsmQFHKCYGFPoqu5oQZmPNl+30s
         Q+9TQVqzhQxeNCZC0ImvEIqQw8MgmW5y35z6TtAlqSF0ugyQsPf+HRKoTR07mdv/gIo/
         0QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nwyn+uvrQSVwFFU037C0/iV1nwL5hGxVBzt/oyn7eUg=;
        b=ujFI+dfex113vbcMcYRrUEuQnOvzzitZJRuy3t331QJlgydzFHtUs9QaZB3Nx0IKFf
         TOyCqTavlf6S/1fWas5AkUihbPifrPuzjK1p6hmMiGCurtc/EkUQAXU5i7GoRuSjNx2y
         U2Iw497fTljDznG1YG320WoleR8OOhBq3Pa1TLeAw3FWc9WqNBI+GWPQdct8mo7uqJKM
         xYQ1GbdqBW92WDCWshTuo9gpFwLi/xMC0xlFcQVSYE4W9QrwtuD4DZz0iSuSvl1JYjg2
         stomUFmwo9S5ljWppAqAKxF9i2WZGJL97FWOoUk6TNH7QRKXteWwayIlRs3IlKddhfHy
         nj8g==
X-Gm-Message-State: ANhLgQ2ZiycLMli3YIeTB/Wl5JHqUE1B9kZ3gT36pn5Bzl7UFdQsoEqp
        TgdaDRJOLADx4RqVC7cv3SczlD5p0NCh1w==
X-Google-Smtp-Source: ADFU+vs1YcXg7G/KvYWl6UxQ0XujDFSQtqHPqO9/8cmPQ+ydxLElIyY2kbbtGtRkYKTmE/PKZ0etLg==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr8016622pgm.316.1584019893004;
        Thu, 12 Mar 2020 06:31:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id f17sm42267432pge.48.2020.03.12.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:32 -0700 (PDT)
Date:   Thu, 12 Mar 2020 06:31:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: [TOPIC 16/17] =?utf-8?B?4oCcSSB3YW50?=
 =?utf-8?Q?_a_reviewer=E2=80=9D?=
Message-ID: <20200312133127.GK212281@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 03:14:25PM +1100, James Ramsay wrote:
> 5. Jonathan N: patchwork exists, need to learn how to use it :)

We've actually got a meeting with some Patchwork folks today - if
anybody has a burning need they want filled via Patchwork, just say so,
and we'll try to ask.

 - Emily
