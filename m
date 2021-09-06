Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3144C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 00:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A195D6101C
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 00:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhIFAH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhIFAH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 20:07:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBBC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 17:06:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id me10so9900818ejb.11
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TcE9Vh9tNzY4KK6ScUKYOgJyiRDefbCQJvz7WDl3OXQ=;
        b=pbIpbJCdZvMC8c4PdSTxImna5WzKM0iDQlvAkoCTi4jHpUo4TkkYvowXsrS3VG4n2i
         aJA+PZQjIliNVO+5SEnY1RKmXr3SqNp+1hY33D0vFveTF6C8mKus2fuLb4T6MPMgkJMW
         JpzTMSYewlzvowOAforto1lbEPEoj6Gsz7P+A93X9sUdFE81SilcxFSICMiF8S+U9pGS
         ACUPQjlbMTelo7DKS8RlQPX8F/EFCoKEk09Jmny5TrSeDqMR9hMicauLnRrYiU+Wl8j9
         eB3h+/nml8FnSQ2lE2k46MKqRn4PoRrcTlgLCA3oYMECKTz40ALSP0C7ubrUMEitjUGR
         94dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TcE9Vh9tNzY4KK6ScUKYOgJyiRDefbCQJvz7WDl3OXQ=;
        b=Jb0rnt2rnRoRjxzn6R3TX3UaiWOCTGzmKjWU7Ig8BZbrJBlPYzkJyx4CEdBRKI843j
         jh5Wo3tg/jaIcfPbV8SJKJLBxbC1/byM/iZchBtIB7ewTv/zMoqJF7+iLgJqood7GJQv
         1+OzSJGw3JLIKvkxOEBFTztOwwAdVbdc2eVTwq8xQL9wQfM7T9noCkiSrw7Fe3nsMxm2
         C8ovpLXnDWJd5y6DTlQBVc5tJy/HdV5n1chXG+aCknNEYuSy2KcMkL8QZWLvpUlYg3BE
         xBR7nh9XIfpNTbTxlR7+2l/GbcoEpGRrSCMqJi+8B61och7PXITncjEw1KK8iCR6Tnh+
         C4tA==
X-Gm-Message-State: AOAM533Tz0n2O4PLLavZXhen1yVpF/GwaJ2fYlaUCn+orO6m+WLhH/B9
        t+8qw1SqFR0iDo9tK+dHaOQc3MrN5VHG4A==
X-Google-Smtp-Source: ABdhPJyVHO3rW3cI0dFRRDLJpFplvlNV+uCExCwolsPNUNhFc4LpcJejkaCZq8XzR3YI7KfcI+V2iw==
X-Received: by 2002:a17:906:1451:: with SMTP id q17mr10854211ejc.214.1630886810436;
        Sun, 05 Sep 2021 17:06:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w3sm3505653edc.42.2021.09.05.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 17:06:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: Regression in git send-email parsing sendemail.* config values
Date:   Mon, 06 Sep 2021 02:04:44 +0200
References: <e86f64ff-0395-26f7-5d5b-7df2e6e63ff4@archlinux.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <e86f64ff-0395-26f7-5d5b-7df2e6e63ff4@archlinux.org>
Message-ID: <87k0jupnxi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 05 2021, Eli Schwartz wrote:

> I recently noticed that git send-email was attempting to send emails
> using the wrong email address. I have a global email configuration in
> XDG_CONFIG_HOME, and a specific one set in the {repo}/.git/config of
> some repos... this was trying to use the global configuration.
>
> `git config -l | grep ^sendemail.smtpserver=` reports two emails

Don't you mean s/emails/servers/, ditto "wrong email address" should be
"the wrong server", right?

> `git config --get sendemail.smtpserver` reports only the second,
> repo-specific one
>
>
> I bisected the issue to commit c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9fb
>
>     send-email: move trivial config handling to Perl
>
>
> Using this commit, git-send-email disagrees with git config --get on
> which email to use.
>
> Using commit f4dc9432fd287bde9100488943baf3c6a04d90d1 immediately
> preceding this commit, git send-email agrees with git config --get.

That's a pretty bad bug, sorry about that. I believe that the following
patch should fix it (needs tests obviously). I.e. when we had N config
keys we'd previously pick the normal "last key wins", which my
c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9fb changed to "first wins":

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0bb..6c7ab3d2e91 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -376,7 +376,7 @@ sub read_config {
 			@$target = @values;
 		}
 		else {
-			my $v = $known_keys->{$key}->[0];
+			my $v = $known_keys->{$key}->[-1];
 			next unless defined $v;
 			next if $configured->{$setting}++;
 			$$target = $v;
