Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EADC433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 00:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiC0AbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiC0AbN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 20:31:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64784393C0
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 17:29:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDE1D17E277;
        Sat, 26 Mar 2022 20:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+x+rDknJHQIY
        AQZ4CdUulMGI2ScZiAZDi7lJXnNEqTQ=; b=gA0ZmKzvuHiWrQC49RRnA/kFiTk1
        MQUSmWTZkLptZNhgFrf8x+7ShT/k6EUQZ1A6bocsV2ps8KYS0qgnfWZj+CcmrUz6
        CzQ5jdG4NvVhUpV6+Nx6P2hXzJbrnpGjogQauXmZhKSFICHVbNJFxnbJXsp1Vub5
        clKhTX2p7y38tl0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6FB017E276;
        Sat, 26 Mar 2022 20:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2BF0717E275;
        Sat, 26 Mar 2022 20:29:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: fr/vimdiff-layout
References: <xmqqwngkm4am.fsf@gitster.g>
        <220326.86k0cgk83t.gmgdl@evledraar.gmail.com>
        <Yj+Z0T2TShqH99a/@zacax395.localdomain>
Date:   Sat, 26 Mar 2022 17:29:32 -0700
In-Reply-To: <Yj+Z0T2TShqH99a/@zacax395.localdomain> (Fernando Ramos's message
        of "Sat, 26 Mar 2022 23:55:13 +0100")
Message-ID: <xmqq4k3k6xw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F94382F4-AD64-11EC-9AD2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

>> It looks like it's emitting a new warning from the "Makefile" in
>> check-docs:
>> =09
>> 	$ (make clean && make check-docs) >/dev/null 2>&1; make check-docs
>> 	make -C Documentation lint-docs
>> 	make[1]: Entering directory '/home/avar/g/git/Documentation'
>> 	make[1]: Nothing to be done for 'lint-docs'.
>> 	make[1]: Leaving directory '/home/avar/g/git/Documentation'
>> 	removed but documented: git-difftool--vimdiff
>> 	removed but documented: git-mergetool--vimdiff
>> 	removed but documented: git-version
>
> Looking at how the Makefile works it looks like this error is triggered
> because...
>
>   1. I have created these two new files:
>      - Documentation/git-difftool--vimdiff.txt
>      - Documentation/git-mergetool--vimdiff.txt
>
>   2. None of them are real programs (such as "git-clone") or scripts (s=
uch as
>      "git-mergetool--lib.sh")
>
> All the other "Documentation/*.txt" files are associated to "something"=
 that
> can be executed, but not these two (they are only meant to be accessed =
from "git
> help" / "man").

Thanks for noticing and reporting, =C3=86var.

I think the right place to describe how vimdiff or other
configuration should be configured should live next to configuration
documentation for other backends.

Documentation/git-mergetool.txt is the main entry point for those
who want to learn about "git mergetool", i.e. "git mergetool --help"
shows what's in there.

The documentation talks about the "mergetool" front-end, and then
includes config/mergetool.txt for the configuration files.

After all, the topic adds only one mergetool.<tool>.layout
configuration variable.  The file config/mergetool.txt would be the
place to describe that variable, after the entry for
mergetool.meld.useAutoMerge, which is already is about a variable
that is specific to a particular backend.  If we can successfully
can go this route, we do not need any new file added at all.

Alternatively, in the longer run, we may want backend specific
information in the "git mergetool --help" documentation.  Maybe
vimdiff is the first and currently only such backend that wants
documentation specific to it, but it does not has to stay that way
forever.

So adding a new section "BACKENDS SPECIFIC HINTS" after "TEMPORARY
FILES" section, and add "VIMDIFF" as its first (and currently only)
subsection, would be a reasonable thing to do.  Create a
Documentation/mergetools/ subdirectory, add vimdiff.txt file in
there, move the most of what is in git-mergetool--vimdiff.txt, and
include it from Documentation/git-mergetool.txt, perhaps like the
attached patch outlines?



diff --git c/Documentation/config/mergetool.txt w/Documentation/config/me=
rgetool.txt
index cafbbef46a..19ca39d43d 100644
--- c/Documentation/config/mergetool.txt
+++ w/Documentation/config/mergetool.txt
@@ -45,6 +45,11 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
=20
+mergetool.vimdiff.layout::
+	The vimdiff backend uses this variable to control how its split
+	windows look like.  See BACKEND SPECIFIC HINTS section of
+	linkgit:git-mergetool[1] for details.
+
 mergetool.hideResolved::
 	During a merge Git will automatically resolve as many conflicts as
 	possible and write the 'MERGED' file containing conflict markers around
diff --git c/Documentation/git-mergetool.txt w/Documentation/git-mergetoo=
l.txt
index e587c7763a..6cf3734544 100644
--- c/Documentation/git-mergetool.txt
+++ w/Documentation/git-mergetool.txt
@@ -113,6 +113,16 @@ Setting the `mergetool.keepBackup` configuration var=
iable to `false`
 causes `git mergetool` to automatically remove the backup as files
 are successfully merged.
=20
+BACKEND SPECIFIC HINTS
+----------------------
+
+Here we'll give backend specific hints.
+
+vimdiff
+~~~~~~~
+include::mergetools/vimdiff.txt[]
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git c/Documentation/mergetools/vimdiff.txt w/Documentation/mergeto=
ols/vimdiff.txt
new file mode 100644
index 0000000000..1cac121283
--- /dev/null
+++ w/Documentation/mergetools/vimdiff.txt
@@ -0,0 +1,11 @@
+vimdiff
+~~~~~~~
+
+Vimdiff backend allows `mergetools.vimdiff.layout` to specify how
+the split window is used ...
+
+Layout
+^^^^^^
+
+Text.
+
