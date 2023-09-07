Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB16EC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjIGU0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIGU0X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:26:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC0CA1
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694118377; x=1694723177; i=johannes.schindelin@gmx.de;
 bh=3eeqpx0v5TZUejJRDAaDUfBjheQtTZlsZp8sRwI1B6A=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=Ghk4IZ36v8OfRFqkTw59lTdakzjjuJDl6SLlPY85sMNsxzWTQCYtWj/IE2NXlRcDAH8emMC
 JVoB3+5ezl5KyhscfzIopl9veQJXw0LNF/CwDz4z9bXR2dGpWGLrBtC8jKfCbQNPhYQPG6w15
 d+kO/nLM5abHDmBc97ZoA9w1AqGOqb+805jEhfQu4CaymzvOhtLMgu2ilx0aA+R6tkVAjbHA6
 10VFWjd78IfC6s1FN7xQ7HFTg1h4eVh8HlXxVF0T1gDHJO1gUfKR721zmT6VD9qnVMayqC/VU
 K51Q/EbHgzL9iQWtLDqOK08hQLjkKPGmImBfB10ZHzsir1/MuRlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1qM7d03cWE-00LZSk; Thu, 07
 Sep 2023 12:23:44 +0200
Date:   Thu, 7 Sep 2023 11:56:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/7] rebase -i: impove handling of failed commands
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
Message-ID: <6b927687-cf6e-d73e-78fb-bd4f46736928@gmx.de>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com> <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UDWsTg4rfL9/Igd3XgJWiqH/h1xUTLejgP/3BZwqujgs0wqx7Cw
 4H43njA/Vm2EqJIrjvHesjrNtU6zRl3j37rfU1mOT4CDcn9jj0aSTW+gdYQXazPHsHtSQsw
 8GeJOszXaUOgAmcZid1aguZHC0YVQqUGXxNVANduMVhg2r+IggIf8UYV4Kpc/rXnmxGRt2a
 UUZwnUKhG+iliO8fDIMCg==
UI-OutboundReport: notjunk:1;M01:P0:sHEFGG/kN30=;f3s50ceWydSgMy3y/aiqkUMAODD
 QI7ZT2Bj4fb1I75bUP61eTv5rf1xSdgOt8fpZvR8vka//GmBvx5pf0ej6pWJLgj0Xc8rSzQrm
 7ek/KpYp6ZI/Z8pQyK6xB0x8CMVRTE6+LV/rTmZ/WXNsrGwsEBqHfCd1IatB1XbQzK94UCsYh
 oVrAXT0SCzcbHZID9J+uqporrmL3hJhWb81qZcNS7WDwBbpg+H/9h+CJmziwFf4yGiv/ubVo8
 YyJuANCsMzKRDrfmEw5ne1FmBra1QdQEc5aWnkRkjkZW9eMMNPv3svXv38neHg38j5p0I+cfr
 wTyEbZhfMv97Txc3kalGnZuXYcWc48CodMyJYSF/CNR33iHml1R/pU7WiTIRO88DQmOmxLkwQ
 ttquzE5cKvTNKc/on5m64kl9hRYLfC9dyV981H6SUC3c10dK0nrTc4Plz3KveJ3QKt427fzNP
 vCNabHS2kuDWMpltREGlrn1ga0D8R/UB4+c10IgHGCFRMmfb5a9IfIXQ2H51yslILRhxC8Ew6
 KxOL47ONFby8xiG8QP0LEKTb2eu41omts29JAa+8KYdPCfhdypnJe3JJYZoRTLCQ7bsuKGIzz
 /o5lgzXkb+2kjbUNlrAMI3fBRqtaJgj8rZbR/ZOUCJF8jR4pLLq/Flqmt2rBhfYrrWaq7ivfg
 IkzmNo183baDm9YhOvwVpVEm4GcRW6JP8KnaEwezUQoa2v8ASYu+UkkW1ecUwQAUd6nyNrJTC
 J9IhFwULCmGLxA+WyTV9i4c2PShNt88YZYMNjiD3gNGLMK+Ka0x0adqIby8o7e8SSNptftXmy
 Kxb4a8T5uOw2kl10YVxexecOyVxuXIejbWt0FRHDW6nlJYnpzOaBs7eUfbBt+yZYshB3aMwXe
 I2fhiBF1jIHtmzDVda/BBJB7WeM3IxP3UbCppBbkvMZ8so+Cu7ddvYRLUA/6F8YURZrMm/JkO
 Z68QiQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 6 Sep 2023, Phillip Wood via GitGitGadget wrote:

> Range-diff vs v3:
>
>  1:  1ab1ad2ef07 ! 1:  ae4f873b3d0 rebase -i: move unlink() calls
>      @@ Metadata
>        ## Commit message ##
>           rebase -i: move unlink() calls
>
>      -    At the start of each iteration the loop that picks commits rem=
oves
>      -    state files from the previous pick. However some of these are =
only
>      -    written if there are conflicts and so we break out of the loop=
 after
>      -    writing them. Therefore they only need to be removed when the =
rebase
>      -    continues, not in each iteration.
>      +    At the start of each iteration the loop that picks commits rem=
oves the
>      +    state files from the previous pick. However some of these file=
s are only
>      +    written if there are conflicts in which case we exit the loop =
before the
>      +    end of the loop body. Therefore they only need to be removed w=
hen the
>      +    rebase continues, not at the start of each iteration.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>  2:  e2a758eb4a5 ! 2:  f540ed1d607 rebase -i: remove patch file after co=
nflict resolution
>      @@ Commit message
>           now used in two different places rebase_path_patch() is added =
and used
>           to obtain the path for the patch.
>
>      +    To construct the path write_patch() previously used get_dir() =
which
>      +    returns different paths depending on whether we're rebasing or
>      +    cherry-picking/reverting. As this function is only called when
>      +    rebasing it is safe to use a hard coded string for the directo=
ry
>      +    instead. An assertion is added to make sure we don't starting =
calling
>      +    this function when cherry-picking in the future.
>      +
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>        ## sequencer.c ##
>      @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_amend, "rebase-mer=
ge/amend")
>         * For the post-rewrite hook, we make a list of rewritten commits=
 and
>         * their new sha1s.  The rewritten-pending list keeps the sha1s o=
f
>       @@ sequencer.c: static int make_patch(struct repository *r,
>      + 	char hex[GIT_MAX_HEXSZ + 1];
>      + 	int res =3D 0;
>      +
>      ++	if (!is_rebase_i(opts))
>      ++		BUG("make_patch should only be called when rebasing");
>      ++
>      + 	oid_to_hex_r(hex, &commit->object.oid);
>      + 	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1=
) < 0)
>        		return -1;
>        	res |=3D write_rebase_head(&commit->object.oid);
>
>  3:  8f6c0e40567 ! 3:  818bdaf772d sequencer: use rebase_path_message()
>      @@ Commit message
>           made function to get the path name instead. This was the last
>           remaining use of the strbuf so remove it as well.
>
>      +    As with the previous patch we now use a hard coded string rath=
er than
>      +    git_dir() when constructing the path. This is safe for the sam=
e
>      +    reason (make_patch() is only called when rebasing) and is prot=
ected by
>      +    the assertion added in the previous patch.
>      +
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>        ## sequencer.c ##
>  4:  a1fad70f4b9 =3D 4:  bd67765a864 sequencer: factor out part of pick_=
commits()
>  5:  df401945866 ! 5:  f6f330f7063 rebase: fix rewritten list for failed=
 pick
>      @@ Commit message
>           disabled the user will see the messages from the merge machine=
ry
>           detailing the problem.
>
>      -    To simplify writing REBASE_HEAD in this case pick_one_commit()=
 is
>      -    modified to avoid duplicating the code that adds the failed co=
mmand
>      -    back into the todo list.
>      +    The code to add a failed command back into the todo list is du=
plicated
>      +    between pick_one_commit() and the loop in pick_commits(). Both=
 sites
>      +    print advice about the command being rescheduled, decrement th=
e current
>      +    item and save the todo list. To avoid duplicating this code
>      +    pick_one_commit() is modified to set a flag to indicate that t=
he command
>      +    should be rescheduled in the main loop. This simplifies things=
 as only
>      +    the remaining copy of the code needs to be modified to set REB=
ASE_HEAD
>      +    rather than calling error_with_patch().
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>  6:  2ed7cbe5fff =3D 6:  0ca5fccca17 rebase --continue: refuse to commit=
 after failed command
>  7:  bbe0afde512 =3D 7:  8d5f6d51e19 rebase -i: fix adding failed comman=
d to the todo list

Thank you for indulging me. This iteration looks good to me!

Ciao,
Johannes
