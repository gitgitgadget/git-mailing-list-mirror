Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A5C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 09:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiA0JcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiA0JcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 04:32:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AADC06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 01:32:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v123so1451004wme.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 01:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=lccWFiJxFjRCIpbqeGyiFcOIxw4p20dkYAaYMCwsyCM=;
        b=CJ33EvShvCKiXlVHof2gS/AutaLC6tMayrnU9fMEEd5kv4qvvNsmtV21T5JeSew2JH
         BzdUfxAgIWCqYuPaQvpweClpFTgyo2xl/FKnryJdC5M1loan1xFUobF/u5QFYH+4eysH
         aMoEWTpuGTY3JKtkR6oj29r/HQaAsa0LZ65cBBYyCwszq6q0HYa247A+TLYqUmeabGWr
         85MkhIhoWeTlIhkyKDVphZc91fTawij4DcxWvgw2JwmH6WiYGCjpYwPmjWK+mTYcjO2Y
         42duGK1N0o2I44P5W+ePtNP5TM/TNuB+a042vz+Eskg+glrvnuEkEXDpjgKtLapTpDvD
         mq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=lccWFiJxFjRCIpbqeGyiFcOIxw4p20dkYAaYMCwsyCM=;
        b=qd3FThzyj662m8Y2cncZnTUjdeSmha8zD5HlYl5gQINjPqSZwlm4qIeDMZLgrPZok4
         iXFT1kd9rzxpv3Sg00upWTgAhe1/WHhtrxEcanUsiH76H8mTa6iAiTA3G1rUBbQ6CZce
         pPGGhJyp0/jzyBZwdtrxUut9hpxMIIM1ZXIsD6Tl7LThfc0SBYeywQrKz4omr/TY760i
         XzPdsV/25mIWkRXheA5WImEPnHFFQgogey+cQsq3b4BEfb1ObJqNu+kuudTBSObP6DdZ
         fVHRSX39q58su5LUO2Nt2HvgHkOhwjSdk0YLR9bvi8IXc+X+qMCPs8kgrYDy3Z2Z2Oqr
         TpVA==
X-Gm-Message-State: AOAM532e+6uoI6nwh3r7cJAkCwCl1vOqeWLsrcLRA0PT4tEpjW5d5wJj
        Cr83YFO2905MohLKW948p/mVsNU81EvBaw==
X-Google-Smtp-Source: ABdhPJwkTCf6W0Nemdy9+qKQe8X03TDZB0jPgzW9dG/zUkmc6ry2UNY8VqQGUY0G9m/dYbTQFDjlKA==
X-Received: by 2002:a05:600c:1596:: with SMTP id r22mr2478217wmf.33.1643275933496;
        Thu, 27 Jan 2022 01:32:13 -0800 (PST)
Received: from localhost (2a01cb000f483e003b320a5f125af7b5.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:3b32:a5f:125a:f7b5])
        by smtp.gmail.com with ESMTPSA id c14sm1803639wri.56.2022.01.27.01.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 01:32:12 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Jan 2022 10:32:12 +0100
Message-Id: <CHGCP9P33XDQ.3FEWHU0PBMNU6@diabtop>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive
 when client exits
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Emily Shaffer" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
X-Mailer: aerc/0.7.1-30-g7edcc9f79409
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
 <20220126214438.3066132-1-robin.jarry@6wind.com>
 <xmqqv8y54wxc.fsf@gitster.g>
In-Reply-To: <xmqqv8y54wxc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Jan 27, 2022 at 05:36:
> I somehow feel that it is unrealistic to expect the command to be
> killed via SIGPIPE because there is no guarantee that the command
> has that many bytes to send out to to get the signal in the first
> place.  Such an expectation is simply wrong, isn't it?

Maybe I did not word that properly. Indeed, this only applies if
pre-receive has bytes to send out in the first place. This is what
I referred to with the last paragraph:

> > This does not guarantee that all client disconnections will abort
> > a push. If there is no pre-receive hook or if it does not produce
> > any output, receive-pack will not be killed via SIGPIPE and the push
> > will complete.

It would be much better not to rely on pre-receive to have bytes to send
and to expect that receive-pack will receive SIGPIPE when forwarding
them after the client has disconnected.

I thought of sending a "keepalive packet" in the socket *after* the
pre-receive hook has completed. I do not know the protocol details.
Would something like this be suitable:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8718a6dd91b4..2e0ddd1a59fe 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1990,16 +1990,28 @@ static void execute_commands(struct command *comman=
ds,
 	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
 		for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string =3D "pre-receive hook declined";
 		}
 		return;
 	}
=20
+	/*
+	 * Send a keepalive packet to ensure that the client has not
+	 * disconnected while pre-receive was running.
+	 */
+	{
+		static const char buf[] =3D "0001";
+		if (use_sideband)
+			send_sideband(1, 1, buf, sizeof(buf) - 1, use_sideband);
+		else
+			write_or_die(1, buf, sizeof(buf) - 1);
+	}
+
 	/*
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
 	 */
 	if (tmp_objdir_migrate(tmp_objdir) < 0) {
 		for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string =3D "unable to migrate objects to permanent storage"=
;

In that situation, if the client has exited, receive-pack should be
killed via SIGPIPE before completing the push.

> Is it safe to kill(2) from within a signal handler?

Even if it is, it is probably not a good idea. I did that to avoid
leaving a zombie after receive-pack has died. Maybe setting a flag in
the signal handler and checking the flag after the process has exited
would have been better.

> Why does this patch do anything more than a partial reversion of
> ec7dbd14 (receive-pack: allow hooks to ignore its standard input
> stream, 2014-09-12), i.e. "if the configuration says do not be
> lenient to hooks that do not consume their input, do not ignore
> sigpipe at all".

Indeed it is a partial reversion of that commit. Maybe the "keepalive
before migrating to permanent storage" solution is better.

What do you think?
