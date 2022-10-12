Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F375C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 06:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJLGyJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 12 Oct 2022 02:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJLGyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 02:54:07 -0400
X-Greylist: delayed 44508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 23:54:04 PDT
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF85A80BE8
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 23:54:04 -0700 (PDT)
Received: from player691.ha.ovh.net (unknown [10.111.208.67])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 1BF6C24B81
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:54:03 +0000 (UTC)
Received: from ngraves.fr (met42-h01-213-44-161-47.dsl.sta.abo.bbox.fr [213.44.161.47])
        (Authenticated sender: ngraves@ngraves.fr)
        by player691.ha.ovh.net (Postfix) with ESMTPSA id 89D1F2FAB89AB;
        Wed, 12 Oct 2022 06:54:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S00167caf9da-3db7-4c83-8151-b64de72f923e,
                    48C11EF01C883BAACC61323EB83FED7696FCE8CF) smtp.auth=ngraves@ngraves.fr
X-OVh-ClientIp: 213.44.161.47
From:   Nicolas Graves <ngraves@ngraves.fr>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Error / feature-request: Signing git commits with SSH hardware key
In-Reply-To: <87r0zeuhrv.fsf@ngraves.fr>
References: <875ygqw7p8.fsf@ngraves.fr>
 <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
 <87v8oquiuk.fsf@ngraves.fr> <87r0zeuhrv.fsf@ngraves.fr>
Date:   Wed, 12 Oct 2022 08:54:00 +0200
Message-ID: <87leplv8fr.fsf@ngraves.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 7244602953433998075
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejjedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefujghffffkgggtgfesthhqredttddtjeenucfhrhhomheppfhitgholhgrshcuifhrrghvvghsuceonhhgrhgrvhgvshesnhhgrhgrvhgvshdrfhhrqeenucggtffrrghtthgvrhhnpeffudelkeejveetleeuffejfefftefhhfffuedtteethfelueelveffjedvffdtffenucfkphepuddvjedrtddrtddruddpvddufedrgeegrdduiedurdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehnghhrrghvvghssehnghhrrghvvghsrdhfrheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> error: Couldn't load public key sk-ssh-ed25519@openssh.com AAAAG[..]zaDo=: No such file or directory?
>
Sorry, I still do have this error, even though the previous one
disappeared (it verified a commit signed byb another key) and my
configuration is OK.

No such file or directory would indicate I don't own the key. I've
verified I have the key on my Yubikey5C, in the directory ~/.ssh with
the right condition, and additionnaly I've imported it in ssh-agent with
ssh-add.

Using the GIT_TRACE=2 env variable, I get this:
08:32:41.916712 git.c:460               trace: built-in: git commit -m test
08:32:41.917380 run-command.c:655       trace: run_command: ssh-keygen -Y sign -n git -f 'sk-ssh-ed25519@openssh.com AAAAG[...]zaDo=' /tmp/.git_signing_buffer_tmp6Dc0Mx

The ssh-keygen manual indicates the following:

-Y sign
             Cryptographically sign a file or some data using a SSH key.  When
             signing, ssh-keygen accepts zero or more files to sign on the
             command-line - if no files are specified then ssh-keygen will
             sign data presented on standard input.  Signatures are written to
             the path of the input file with “.sig” appended, or to standard
             output if the message to be signed was read from standard input.

             The key used for signing is specified using the -f option and may
             refer to either a private key, or a public key with the private
             half available via ssh-agent(1).  An additional signature name‐
             space, used to prevent signature confusion across different do‐
             mains of use (e.g. file signing vs email signing) must be pro‐
             vided via the -n flag.  Namespaces are arbitrary strings, and may
             include: “file” for file signing, “email” for email signing.  For
             custom uses, it is recommended to use names following a NAME‐
             SPACE@YOUR.DOMAIN pattern to generate unambiguous namespaces.

Running ssh-add -L, I can confirm that the private half is available via
ssh-agent.

I've also check that the error doesn't come from the missing input file (used to
sign), here /tmp/.git_signing_buffer_tmp6Dc0Mx . Re-running the
ssh-keygen command with a mock file fails with the same error.

I don't really know where to investigate next. What I get is that the
error probably comes from ssh (should I report it there? The problem
feels isolated now that I know which command fails). I may try to
update openssh to v9, but since I'm using guix that might be quick as
well as tedious.

-- 
Best regards,
Nicolas Graves
