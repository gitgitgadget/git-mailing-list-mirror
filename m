Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E2C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 21:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B99420748
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 21:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KddOVWCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKXVK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:10:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55266 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKXVK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 16:10:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so3596212wmj.4
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/t9B1It99xQTQZimw4ljJLwCcZduZ4jwjjaNHG7+W/Q=;
        b=KddOVWCwkQRT/o6fNENTSX7d5i+xsz3J1uqkQzEFo6h42x2ZbEGXFK6bRaJcppRgxh
         LrexkpZi2LcT4XJ3Quxj4zQCLSeslYIFJQjKymSmvvJiC3ANMcMZjILnmns5mMyE/Hxd
         yUf8zg/lJmw81x7CGd+bKWrHGQozRgsCQogFlhxpPad2DA9Ey7B5CquDsfqmzo7Jjv6m
         73c8WBCXa5rDPxAgoIKLXG/BtNi6pMzE1l+XhDP40iIR7s6WUecl7f29xog6Ve502b9e
         mNePsUgZvxO0OngBDOBIreayKtzFSdHGn2qOherfaWSx3ImSNNhwS3rKuV0n8VoZLzul
         oeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/t9B1It99xQTQZimw4ljJLwCcZduZ4jwjjaNHG7+W/Q=;
        b=M4WA+sheScSMNGZeeouCL0bL0fviEv5ahPuLy3H3Ho/uk8wn6H20dirrW8sQDIk7Um
         p2AMlJ7XrOC8s4NGEiHVuS3m0Z+ywYGcoWRFVE09RaGwVjzReFk1ojrz+BgTZkpbYyD6
         HLsEgNegovV3REe27Mz85GldMRBQm/4tZ/E3NJohfgnTzWy+gWYvbvfW9zlIu5Q+v7pP
         F4WTL7TV10gd7AJnUlCY7kuBaJYDxKQkZ55OJIclHvLlpesIAwoKq4baX0DYMrwkQ0qi
         bq245AMpIkmmpuQdwRK8SImZobxqLCLSj8Y60sCqnMoEdEfWddwL0wYG54VsacwDZGmU
         iVBw==
X-Gm-Message-State: APjAAAWn+tjwboX2VStbKxv7SVOx0J6mystYDnYd/vWwT+WtlWlHSh3K
        usTs5yUo0oRVHZdsi4J6Dps=
X-Google-Smtp-Source: APXvYqzXShmPzcCFIs++niuUABBnTpM2RbskiTjrzqVVxBnrnzsPC+aBwsrABo5SgOxwvnIahfCxbw==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr11737702wmj.152.1574629824559;
        Sun, 24 Nov 2019 13:10:24 -0800 (PST)
Received: from szeder.dev (x4dbd62c1.dyn.telefonica.de. [77.189.98.193])
        by smtp.gmail.com with ESMTPSA id c12sm7617917wro.96.2019.11.24.13.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 13:10:23 -0800 (PST)
Date:   Sun, 24 Nov 2019 22:10:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t3429: try to protect against a potential racy todo file
 problem
Message-ID: <20191124211021.GB23183@szeder.dev>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
 <20191123172046.16359-1-szeder.dev@gmail.com>
 <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
 <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 10:44:10AM +0000, Phillip Wood wrote:
> On 24/11/2019 04:49, Junio C Hamano wrote:
> 
> Thanks for working on this Gábor
> 
> >SZEDER Gábor <szeder.dev@gmail.com> writes:
> >
> >>When 'git revert' or 'git cherry-pick --edit' is invoked with multiple
> >>commits, then after editing the first commit message is finished both
> >
> >"commits, then after editing the first commit message, both of" I
> >would say.
> >
> >>these commands should continue with processing the second commit and
> >>launch another editor for its commit message, assuming there are
> >>no conflicts, of course.
> >>
> >>Alas, this inadvertently changed with commit a47ba3c777 (rebase -i:
> >>check for updated todo after squash and reword, 2019-08-19): after
> >>editing the first commit message is finished, both 'git revert' and
> >>'git cherry-pick --edit' exit with error, claiming that "nothing to
> >>commit, working tree clean".
> >>...
> >>   - When invoking 'git revert' or 'git cherry-pick --edit' with
> >>     multiple commits they don't read a todo list file but assemble the
> >>     todo list in memory, thus the associated stat data used to check
> >>     whether the file has been updated is all zeroed out initially.
> >>
> >>     Then the sequencer writes all instructions (including the very
> >>     first) to the todo file, executes the first 'revert/pick'
> >>     instruction, and after the user finished editing the commit
> >>     message the changes of a47ba3c777 kick in, and it checks whether
> >>     the todo file has been modified.  The initial all-zero stat data
> >>     obviously differs from the todo file's current stat data, so the
> >>     sequencer concludes that the file has been modified.  Technically
> >>     it is not wrong, of course, because the file just has been written
> >>     indeed by the sequencer itself, though the file's contents still
> >>     match what the sequencer was invoked with in the beginning.
> >>     Consequently, after re-reading the todo file the sequencer
> >>     executes the same first instruction _again_, thus ending up in
> >>     that "nothing to commit" situation.
> >
> >Hmph, that makes it sound as if the right fix is to re-read after
> >writing the first version of the todo file out, so that the stat
> >data matches reality and tells us that it has never been modified?
> 
> I think we should update the stat data after we write the todo list.

Well, yes and no.

No, because we are dealing with regression in v2.24.0 here, so the
simpler the fix the better it is for maint.  I don't think a fix can
get any simpler than my patch, with or without the suggestions from
Phillip.

Yes, we should definitely consider updating the stat data after the
sequencer writes the todo list, or any other options with which the
sequencer could notice a modified todo list file with less subtlety.
Alas, there is a big can of worms in that direction, see the patch
below, and we have to be very careful going that way, so I think it's
only viable in the long term, but less suitable as a regression fix
for maint.

(Hrm, perhaps I spent too many words on the all zeroed out stat data,
and managed to sidetrack you a bit...)

  ---  >8  ---

Subject: [PATCH] t3429: try to protect against a potential racy todo file
 problem

During an interactive rebase session the user can run basically any
commands with an 'exec' instruction, including commands that modify
the todo list of the ongoing rebase.  Similarly, the user might choose
to modify the todo list while editing a commit message for a 'reword'
or a 'squash' instruction.  The ongoing interactive rebase process
should be able to notice the modified todo file and re-read it to
follow the updated instructions.  This has been working well for the
'exec' instruction for some time, but for 'reword' and 'squash' it has
been fixed only recently in a47ba3c777 (rebase -i: check for updated
todo after squash and reword, 2019-08-19).

To notice a changed todo file the sequencer stores the file's stat
data in its 'struct todo_list' instance, and compares it with the
file's current stat data after 'reword', 'squash' and 'exec'
instructions.  If the two stat data doesn't match, it re-reads the
todo file.

Sounds simple, but there are some subtleties going on here:

  - The 'struct todo_list' holds the stat data from the time when the
    todo file was last read.

  - This stat data in 'struct todo_list' is not updated when the
    sequencer itself writes the todo file.

  - Before executing each instruction during an interactive rebase,
    the sequencer always updates the todo file by removing the
    just-about-to-be-executed instruction.  This changes the file's
    size and inode [1].

Consequently, when the sequencer looks at the stat data after a
'reword', 'squash' or 'exec' instruction, it most likely finds that
they differ, even when the user didn't modify the todo list at all!
This is not an issue in practice, it just wastes a few cycles on
re-reading the todo list that matches what the sequencer already has
in memory anyway.

However, an unsuspecting Git developer might try to "fix" it by simply
updating the stat data each time the sequencer writes the todo list
for an interactive rebase.  On first sight it looks quite sensible and
straightforward, but we have to be very careful when doing that,
because potential racy problems lie that way.

It is possible to overwrite the todo list file without modifying
either its inode or size, and if such an overwrite were to happen in
the same second when the file was last read (our stat data has one
second granularity by default), then the actual stat data on the file
system would match the stat data that the sequencer has in memory.
Consequently, such a modification to the todo list file would go
unnoticed.

Add a test to 't3429-rebase-edit-todo.sh' that modifies the todo list
during an interactive rebase in a way that the file's stat data very
likely doesn't change.  Since we have no control over ctime repeat the
test a few times, just like we do in the racy git and racy split index
tests (t0010 and t1701).  This test succeeds right now because of all
the above, but it does fail most of the time if the stat data is
naively updated when writing the todo file [2].  Hopefully this test
will help prevent us from introducing such racy problems if we ever
change how the sequencer looks out for modified todo list files.

This new test only checks what it's supposed to when it doesn't change
the size of the todo file while modifying it, thus it critically
depends on the todo file format.  And the todo file format did change
in the past: early on it stored abbreviated commit object ids, but
since 75c6976655 (rebase -i: fix short SHA-1 collision, 2013-08-23) it
stores full object ids.  Perhaps it will change in the future as well,
so be extra defensive about this, and check that the file size before
and after the edit actually match, and complain with a "bug in the
test script" if they don't.

[1] The todo file is written using the lockfile API, i.e. first to the
    lockfile, which is then moved to place, so the new file can't
    possibly have the same inode as the file it replaces.  Note,
    however, that the file system might reuse inodes, so it is
    possible that the new todo file ends up with the same inode as is
    recorded in the 'struct todo_list' from the last time the file was
    read.

[2] To trigger failure in the new test updating the stat data when
    writing the todo file like the diff below does.  No other test in
    our test suite seems to fail with this change applied.

    diff --git a/sequencer.c b/sequencer.c
    index 3b05d0277d..b2acb7d536 100644
    --- a/sequencer.c
    +++ b/sequencer.c
    @@ -2730,6 +2730,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
     	struct lock_file todo_lock = LOCK_INIT;
     	const char *todo_path = get_todo_path(opts);
     	int next = todo_list->current, offset, fd;
    +	struct stat st;

     	/*
     	 * rebase -i writes "git-rebase-todo" without the currently executing
    @@ -2748,6 +2749,10 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
     	if (commit_lock_file(&todo_lock) < 0)
     		return error(_("failed to finalize '%s'"), todo_path);

    +	if (stat(todo_path, &st) < 0)
    +		return error(_("could not stat '%s'"), todo_path);
    +	fill_stat_data(&todo_list->stat, &st);
    +
     	if (is_rebase_i(opts) && next > 0) {
     		const char *done = rebase_path_done();
     		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3429-rebase-edit-todo.sh | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 8739cb60a7..c80c139b47 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -52,4 +52,63 @@ test_expect_success 'todo is re-read after reword and squash' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup for racy tests' '
+	write_script sequence-editor <<-EOS &&
+		cat >.git/rebase-merge/git-rebase-todo <<-\EOF
+			r $(git rev-parse second^0) second
+			r $(git rev-parse third^0) third
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
+			old_size=$(wc -c <"$todo") &&
+			# Replace the "reword <full-oid> third" line with
+			# a different instruction of the same line length.
+			# Overwrite the file in-place, so the inode stays
+			# the same as well.
+			cat >"$todo" <<-EOF &&
+				exec echo 0123456789012345678901234 >exec-cmd-was-run
+			EOF
+			new_size=$(wc -c <"$todo") &&
+
+			if test $old_size -ne $new_size
+			then
+				echo >&2 "error: bug in the test script: the size of the todo list must not change"
+				exit 1
+			fi
+		fi
+	EOS
+
+	cat >expect <<-\EOF
+	second - edited
+	first
+	EOF
+'
+
+# This test can give false success if your machine is sufficiently
+# slow or all trials happened to happen on second boundaries.
+
+for trial in 0 1 2 3 4
+do
+	test_expect_success "racy todo re-read #$trial" '
+		git reset --hard third &&
+		rm -rf exec-cmd-was-run &&
+
+		GIT_SEQUENCE_EDITOR=./sequence-editor \
+		GIT_EDITOR=./commit-editor \
+		git rebase -i HEAD^^ &&
+
+		test_path_is_file exec-cmd-was-run &&
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	'
+done
+
 test_done
-- 
2.24.0.532.ge18579ded8

