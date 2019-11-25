Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC9C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2E620718
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOFFh22S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKYDKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:10:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36415 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfKYDKL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 22:10:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id n188so12194047wme.1
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 19:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z9N45rS78TlaUgRdR3NveUI7Qci+bagSZ8CyY/W0+b0=;
        b=hOFFh22SmMTVuihXYHXIo2rUr2QQ3wzTbbVtOMFh6uzHDmJvxgTllYh5nbuJGQcuQ3
         XEOZH9rV5zCbYGxuq30w6bZNGiiyDIPWBk2oybCqrgmcAhNvJFpGC/7o6pq40/p6fkhL
         oQj7+sFRXvqc5j3uCAUHMp/yX8lY+8yqGpiwmjZMEE48nx6ond1D7geKdAk+fWK0eAQs
         u8ZxLNlHuQYiQZILqP5mjdsDbhIjofGJNkV1o38NBkILnDEDoUtG8YcyKAD3l7YV9qKB
         p39xhAB7UsxoVWNompr5PkiTNSOD+jx9Q++6LjMTAhSxO+u3N3gPdhkRuHub1Btn4DOS
         SjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z9N45rS78TlaUgRdR3NveUI7Qci+bagSZ8CyY/W0+b0=;
        b=AcXn2s8DP/7DXZCgd6UzTuEW6MvEfmVreuFTDJZhbldOSE4mJM8qC/jMZfavjIvVVv
         rc84D8VMv7xoRAVYBk2DhyhMpTNbLfuMY/kjDuq7LxxC2llpEhpzCMNpFG05Y71kdBkR
         8sJLmZ3TxB9joYwKnbyaBnxo/dXNwKlepRyJtbuu6G+p1E/rZaH3sw+oLV0dChNf1dh9
         yf7OId94nu+16p/QgXZ+4+y4+/10Z3necLfWRuOtTMeTO0eOR+7RfX73RsW4naprwFX1
         Gm1EBBM74YwvJcKM+PmUnXYu119rHY95MXB8bh7tYrHun/RXJZz+N6xoQvWPc8LUkwQM
         s+9Q==
X-Gm-Message-State: APjAAAXgNkpsqSWHInSjOCJOqAdi972pTKIdTGKzDybznSa0A1dxy6yt
        6glyt3eqfRwAu0hduC0/JyRd93G3IRY=
X-Google-Smtp-Source: APXvYqw1LHRF0YymmmD3VS6ePuhqhWmKtDQL1JeMd3H5DmKyKZPOiHV+4aUU96S0uWARouQZvkxB3w==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr26511913wml.100.1574651407944;
        Sun, 24 Nov 2019 19:10:07 -0800 (PST)
Received: from szeder.dev (x4d0c37f4.dyn.telefonica.de. [77.12.55.244])
        by smtp.gmail.com with ESMTPSA id m16sm6912845wml.47.2019.11.24.19.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 19:10:07 -0800 (PST)
Date:   Mon, 25 Nov 2019 04:10:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3429: try to protect against a potential racy todo file
 problem
Message-ID: <20191125031005.GC23183@szeder.dev>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
 <20191124211021.GB23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191124211021.GB23183@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 10:10:21PM +0100, SZEDER Gábor wrote:
> To notice a changed todo file the sequencer stores the file's stat
> data in its 'struct todo_list' instance, and compares it with the
> file's current stat data after 'reword', 'squash' and 'exec'
> instructions.  If the two stat data doesn't match, it re-reads the
> todo file.
> 
> Sounds simple, but there are some subtleties going on here:
> 
>   - The 'struct todo_list' holds the stat data from the time when the
>     todo file was last read.
> 
>   - This stat data in 'struct todo_list' is not updated when the
>     sequencer itself writes the todo file.
> 
>   - Before executing each instruction during an interactive rebase,
>     the sequencer always updates the todo file by removing the
>     just-about-to-be-executed instruction.  This changes the file's
>     size and inode [1].
> 
> Consequently, when the sequencer looks at the stat data after a
> 'reword', 'squash' or 'exec' instruction, it most likely finds that
> they differ, even when the user didn't modify the todo list at all!
> This is not an issue in practice, it just wastes a few cycles on
> re-reading the todo list that matches what the sequencer already has
> in memory anyway.
> 
> However, an unsuspecting Git developer might try to "fix" it by simply
> updating the stat data each time the sequencer writes the todo list
> for an interactive rebase.  On first sight it looks quite sensible and
> straightforward, but we have to be very careful when doing that,
> because potential racy problems lie that way.
> 
> It is possible to overwrite the todo list file without modifying
> either its inode or size, and if such an overwrite were to happen in
> the same second when the file was last read (our stat data has one
> second granularity by default), then the actual stat data on the file
> system would match the stat data that the sequencer has in memory.
> Consequently, such a modification to the todo list file would go
> unnoticed.

> [1] The todo file is written using the lockfile API, i.e. first to the
>     lockfile, which is then moved to place, so the new file can't
>     possibly have the same inode as the file it replaces.  Note,
>     however, that the file system might reuse inodes, so it is
>     possible that the new todo file ends up with the same inode as is
>     recorded in the 'struct todo_list' from the last time the file was
>     read.

Unfortunately, we already do have an issue here when the sequencer can
overlook a modified todo list, but triggering it needs the lucky
"alignment" of inodes as well.  I can trigger it fairly reliably with
the test below, but forcing the inode match makes it kind of gross and
Linux-only.

  https://travis-ci.org/szeder/git/jobs/616460522#L1470


  ---  >8  ---

diff --git a/t/t9999-rebase-racy-todo-reread.sh b/t/t9999-rebase-racy-todo-reread.sh
new file mode 100755
index 0000000000..437ebd55e0
--- /dev/null
+++ b/t/t9999-rebase-racy-todo-reread.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='racy edit todo reread problem'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first_ &&
+	test_commit second &&
+	test_commit third_ &&
+	test_commit fourth &&
+	test_commit fifth_ &&
+	test_commit sixth_ &&
+
+	write_script sequence-editor <<-\EOS &&
+		todo=.git/rebase-merge/git-rebase-todo &&
+		cat >"$todo" <<-EOF
+			reword $(git rev-parse second^0) second
+			reword $(git rev-parse third_^0) third_
+			reword $(git rev-parse fourth^0) fourth
+		EOF
+	EOS
+
+	write_script commit-editor <<-\EOS &&
+		read first_line <"$1" &&
+		echo "$first_line - edited" >"$1" &&
+
+		todo=.git/rebase-merge/git-rebase-todo &&
+
+		if test "$first_line" = second
+		then
+			stat --format=%i "$todo" >expected-ino
+		elif test "$first_line" = third_
+		then
+			ino=$(cat expected-ino) &&
+			file=$(find . -inum $ino) &&
+			if test -n "$file"
+			then
+				echo &&
+				echo "Trying to free inode $ino by moving \"$file\" out of the way" &&
+				cp -av "$file" "$file".tmp &&
+				rm -fv "$file"
+			fi &&
+
+			cat >"$todo".tmp <<-EOF &&
+			reword $(git rev-parse fifth_^0) fifth_
+			reword $(git rev-parse sixth_^0) sixth_
+			EOF
+			mv -v "$todo".tmp "$todo" &&
+
+			if test "$ino" -eq $(stat --format=%i "$todo")
+			then
+				echo "Yay! The todo list did get inode $ino, just what the sequencer is expecting!"
+			fi &&
+
+			if test -n "$file"
+			then
+				mv -v "$file".tmp "$file"
+			fi
+		fi
+	EOS
+
+	cat >expect <<-\EOF
+	sixth_ - edited
+	fifth_ - edited
+	third_ - edited
+	second - edited
+	first_
+	EOF
+'
+
+for trial in 0 1 2 3 4
+do
+	test_expect_success "demonstrate racy todo re-read problem #$trial" '
+		git reset --hard fourth &&
+		>expected-ino && # placeholder
+
+		GIT_SEQUENCE_EDITOR=./sequence-editor \
+		GIT_EDITOR=./commit-editor \
+		git rebase -i HEAD^^^ &&
+
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_done
