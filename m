Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00382C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F37206EB
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEX6FW+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgCOSmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:42:24 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36320 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgCOSmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:42:24 -0400
Received: by mail-lj1-f169.google.com with SMTP id g12so16122724ljj.3
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8TYgxHiYvmsIqkydwwFkv2Y1Xw3hHFwPrdwqoNt7wGA=;
        b=gEX6FW+7sCYoX67f23BVhM8zWgNA/DdHE11+SRnANc8JGbYj/nigIYiQwLh0IKTS4s
         u3vruqhoBMYDyU7GZhgKNjB6lsThpYX4AO8XitRvjzrTz/HiOVSF3oJGtuDLHi0Aqcj6
         BRITcFtCByayXp0CRM39DxyfNkciNoY+INvAwG1xvYYdnchT4jtBoYCCNJMdHs4yT7d5
         kB52dMywSNZOkhgExAIaQ8X5aSQQjaYv/qfcy72H9YnzS3vAdBS76SznVAvQ4MDJ1PhI
         GJ00hEcpo3CztL+RwBBKrRmgs64A5alJQ4e68bKz6/2CcHNl/BO66MaRdtQ9xkA1XSuK
         dDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8TYgxHiYvmsIqkydwwFkv2Y1Xw3hHFwPrdwqoNt7wGA=;
        b=ZkxemT/u2z6EJZ50VevGo+mpad3jWghC2BU5xG7xzpFDRNmSCSpCGzeTSjRXUe5uBb
         3vR5qpLcQMvhEDRJcX2Wd2mlc3eMCbXcSGIVxOnJ+XhREfGCYbNBtnTsBWmeITEA3Y7w
         H369VjAw24xDS/YfEx6WJQyvMeDNQTSkEwmQF9zTymOIHAMIHfu0wOOyrlxgT/suI1k1
         EbO+P17cmI9cuqDdzINUt5aMRJNewcYqSF5A3tKQOVLEV0AP+t9upKRY8rQ+KKnaffW/
         8C9zCfPegvLdgVBl9/ymKG0fwM3Yul4CyvleQ3x2N/hLyQcXp82BQrCHUGNN9lDIFxnX
         pB/Q==
X-Gm-Message-State: ANhLgQ1Ebe2vTndZ8bfJRuLJZiT6J8ecdnkPglLaMl6z5u/51g/+1nWt
        tVCKAbkwVjUmlkpXwSGzMiQCPNNhUe4=
X-Google-Smtp-Source: ADFU+vsl2ljQBiGnBBwfwZxUDdo8Uyp3x+OtYqrxy7AmzeUizYs/42z3mMdFt7ZPtptPfW0jDOnvuw==
X-Received: by 2002:a2e:9dc6:: with SMTP id x6mr13496965ljj.24.1584297742190;
        Sun, 15 Mar 2020 11:42:22 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id s23sm5945815ljg.94.2020.03.15.11.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 11:42:21 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "James Ramsay" <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: Notes from Git Contributor Summit, Los Angeles (April 5, 2020)
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
Date:   Sun, 15 Mar 2020 19:42:19 +0100
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au> (James
        Ramsay's message of "Thu, 12 Mar 2020 14:55:21 +1100")
Message-ID: <86pndd794k.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"James Ramsay" <james@jramsay.com.au> writes:

> It was great to see everyone at the Contributor Summit last week, in
> person and virtually.
>
> Particular thanks go to Peff for facilitating, and to GitHub for
> organizing the logistics of the meeting place and food. Thank you!
>
> On the day, the topics below were discussed:
>
> 1. Ref table (8 votes)
> 2. Hooks in the future (7 votes)
> 3. Obliterate (6 votes)
> 4. Sparse checkout (5 votes)
> 5. Partial Clone (6 votes)
> 6. GC strategies (6 votes)
> 7. Background operations/maintenance (4 votes)
> 8. Push performance (4 votes)
> 9. Obsolescence markers and evolve (4 votes)
> 10. Expel =E2=80=98git shell=E2=80=99? (3 votes)
> 11. GPL enforcement (3 votes)
> 12. Test harness improvements (3 votes)
> 13. Cross implementation test suite (3 votes)
> 14. Aspects of merge-ort: cool, or crimes against humanity? (2 votes)
> 15. Reachability checks (2 votes)
> 16. =E2=80=9CI want a reviewer=E2=80=9D (2 votes)
> 17. Security (2 votes)

Thank you very much for sending split writeup to the mailing list.

One question to all participating live (in person): how those topics
were proposed, and how they were voted for?  This was done before remote
access was turned on, I think.

Thanks in advance,
--=20
Jakub Nar=C4=99bski
