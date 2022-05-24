Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C844DC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbiEXVQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiEXVQI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:16:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699025D
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653426960;
        bh=KZg0xrs/QUU5nZimmW/l8n9VrjuXAYfXr79vpJ4BP10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bkh/C7RQUwaqcXynLklq7FI6HffAgszrzkhXgg+4e3PEEpB6grNoQnojcta2Kb8ms
         a5xD9tA9vTgZFxoRDT0/VAOFekTaaZGEq+v8eIrMAQy06YRtD7JB0dE8SditFIZ68I
         3tjAGziTscSTHQcdzQV7qRvN1bjUH8R6r941874E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1nyZhN44Cw-0051H2; Tue, 24
 May 2022 23:16:00 +0200
Date:   Tue, 24 May 2022 23:15:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
In-Reply-To: <xmqq35gyhf11.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>        <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>        <220524.86fskzxsvq.gmgdl@evledraar.gmail.com> <xmqq35gyhf11.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vQSVoM1QQPFcwx8YRbqSvpi+bW5V1VEk5Xsaiyx0/OD/SULFjQa
 qg9elv2WafESYVuCDDhfuYbsI4Du7AaXZpyrRY09OqISZoRjNYXAPQe8zHdINi0RX9GBw6W
 9AeFiTfn8NAc/VumJEt6pbrgA4oGx1si3eEBIUHshbRpXTEghh3+4DZNQw8uWiUskTW6wIO
 ka3oPu7NlsEPurothr8pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:23vbHXoZoxw=:CkT8KJA5HG+q5e/3tqk8IH
 hzjdW37Xsamd8jFjPG4tbVeNyzeBCJRvsNhqbC75UhOGtR82s7BajxGw5qquLgdNSO+We4gJU
 QMwBaCoM0axdfHCFGXxBv0YpygGTV+k3iTES3cWxzL8o/3wg7NFDeMnvWToczQRpu0vxoKgjI
 /+3hglKTYz/9fjYessCNNyGrqA8cCjqpWo8oQJUotmuJdt2QsO7K1eiiDv01b+R3glvmGP4PE
 sBBjI55jcNd3wBTKH1PKsdL3gn0aVFZCsRPYGq1a4Mqig0XAC7HO4pEVdgU4rHppyV9IfwlT/
 TjQKrTFkj54wiurXxzVSiGAOGAilzcnppBfn9pyGTKorsA3dVjjZF9KIxHzJMB5ifjl2a5BTe
 +UbIFs9VsDdfNb0pI8N5VYIDbKcJGqV7lqmBNgM4jnCGwfUIAVvtyEgnOV0Apt7uQb+CL6tlp
 GxaPDwsvfUQ7bUahNsHrIF+Y//b78GPO28pNhqsD+BN1r+/MkM90ZLjXaCQvEBHThbnOTk/Bq
 n5N0usfxydUfg4ORuaGmAGdGzRW1WiMAnnWCN7sBMwNAjQQWmr+hPBqDlI+Sdq7XeIll7okBB
 a/QzYcc1x8aqV1Tl5qNEM5tzZEbP2k+/4KEzf+ogisWys58nMqsKRTUDR6+jUlo/SWqZZRaV1
 l8nsD2L0vZ7NZD0ZSoi9/TgMkOV14XKkClYxePKRd1s4FBYmCJTLoPWelazXL5JvQV/cNCIny
 WYNVUIJpINZPVDf4httgbL+lxG/ELmFGMeOWW/6va313DKNXncNvLUpnsvzxLJC2/lwu1e6/y
 j+gCg5sIEjCinbgzjSO9LZnT7RCPljyG8WgQt6Q+a7Z3AI3n7xuEUwSHZecVtsSBhHreaJpI/
 XifY9iq4kcx5CR2HujA3g6rbzdWk4GhUt5L6FEfOMbGzhbB21EQFcbWnNiXHBZuCtCZiMHnHi
 K2ofG80Jn193wzFtF4GQEEYD6m9rUjrL7kFhFPbSuxwgoogszcZ/2EvTwq35YA97sZT43x7cO
 DLHUjnrVGVQkm24fw2rNCZRioQkZ3bnAH5aA7ssC1hlDxLbcPklfqZnfNukmHsyjzh9obFavv
 EFTHvxmLHhYg74tC28T17NUDiNJ+02TW3iY4Hksy8xIykLkWQQkaOM0qA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 May 2022, Junio C Hamano wrote:

> The "clear slot->finished", by the way, is what I think is the right
> thing to do, especially that the objective is to squelch the false
> positive warning from a new compiler.  If there is a way to annotate
> the line for the compiler to tell it not to warn about it, that would
> have been even better.

We could do something like this:

=2D- snip --
diff --git a/http.c b/http.c
index b08795715f8a..2ac8d51d3668 100644
=2D-- a/http.c
+++ b/http.c
@@ -1365,7 +1365,14 @@ void run_active_slot(struct active_request_slot *sl=
ot)
 	struct timeval select_timeout;
 	int finished =3D 0;

+#if __GNUC__ >=3D 12
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdangling-pointer"
+#endif
 	slot->finished =3D &finished;
+#if __GNUC__ >=3D 12
+#pragma GCC diagnostic pop
+#endif
 	while (!finished) {
 		step_active_slots();
=2D- snap --

That's quite ugly, though. And what's worse, it is pretty unreadable, too.

Ciao,
Dscho
