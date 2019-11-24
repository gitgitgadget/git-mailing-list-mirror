Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64522C43215
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C14120823
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYRpw2iO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfKXUiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:38:02 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50682 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKXUiC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:38:02 -0500
Received: by mail-wm1-f46.google.com with SMTP id l17so13009514wmh.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KsOJ9AJ0xYB1S06lbRibas+/R9fXjOeH9TFA+5sgExA=;
        b=vYRpw2iOMIY+/4UtMHC3S9BE8j09AbQ3R3d+TOX0r4K8+z5Y6OD9Pc69S5NRlfwmAI
         CIz8pp6Np5UIiP+8TLmLZxSiyR79c9tFvpV52K5UFnsEKNtCzb2wFSFca5tHvr2AZypv
         Xr0HoWWJtl6bIlwpUlgTJKNqUiElsb89f7cZFdUOyhoI6a9ewiLQitOF/MlxZOhkHrpF
         83HD5WZDArQfqfGzdwUMkTLONJVpZ9WavutVDoG7j2FXCIFW1Of5bQRZwniV2MqTbuFr
         RM6EeLu9g7202gWhGNduTUK6O6lZUBDZoXR5VQoB0bh7WDvPktkw+ToGeQ4MrB+qnWua
         WZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KsOJ9AJ0xYB1S06lbRibas+/R9fXjOeH9TFA+5sgExA=;
        b=iGuhboOPBwqZs+sQNf5Ywlq6ayMXO6CnmWMzGDuSRrZFwdXaRQPlzpVbFz5NUP5Jq0
         iEPME4DpKcfDAgg5j5tknhnxwIJXkdZZuWIccyuEHedjsPfw46mSnTMkg5IwsSHVgD1q
         ll3Jk48AhijdZC7ZPuzFUXivSe/ZLfYslhY+ZeUrYSD0kyk5yWgWsm3TyrZlchGH75pk
         CI0KWk+AAhVfkqCUlSNrizMePbj4w93ksvHVnLkCb8+2jC2rc0RW1rFqYk1RPKZHqoNx
         YhY6jKgqb7rMNjOAItjKRdroJl2gmG/xl5eRfuDRwqdTF70YN3jYCMg7MpNGLDDpxQuL
         lZvw==
X-Gm-Message-State: APjAAAWO37lnQPsWNT9GfCiTYB0y5UKHN2Na37oLKT5q40eygIBEjTS8
        6XD0USCtlSiLYhEoVlVi7jxpYpVz
X-Google-Smtp-Source: APXvYqwIF2czKj0bAnS/PKLP24+kQUkuNW79yahTNb0kBmhZCuWF0puV2TQaCGehpyoSpdCozk9TNg==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr25234551wmc.54.1574627877291;
        Sun, 24 Nov 2019 12:37:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm7614102wrv.35.2019.11.24.12.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 12:37:56 -0800 (PST)
Message-Id: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 20:37:52 +0000
Subject: [PATCH v5 0/3] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My development environment sometimes makes automatic changes that I don't
want to keep. In some cases, this involves new files being added that I
don't want to commit or keep (but I also don't want to outright .gitignore 
forever). I have typically had to explicitly delete those files externally
to Git Gui, which is a context switch to a manual operation, and I want to
be able to just select those newly-created untracked files in the UI and
"revert" them into oblivion.

This change updates the revert_helper proc to check for untracked files as
well as changes, and then changes to be reverted and untracked files are
handled by independent blocks of code. The user is prompted independently
for untracked files, since the underlying action is fundamentally different
(rm -f). If after deleting untracked files, the directory containing them
becomes empty, then the directory is removed as well. A new proc 
delete_files takes care of actually deleting the files, using the Tcler's
Wiki recommended approach for keeping the UI responsive.

Since the checkout_index and delete_files calls are both asynchronous and
could potentially complete in any order, a "chord" is used to coordinate
unlocking the index and returning the UI to a usable state only after both
operations are complete.

Since the checkout_index and delete_files calls are both asynchronous and
overlap, they clash in wanting to update the status bar. To address this,
the status bar is reworked so that when an operation wants to display
ongoing updates/progress, it explicitly starts an "operation", which is
tracked by its own object, and the status bar handles multiple concurrent
operations by merging their progress and concatenating their text. This is
captured in a separate commit, since it touches a variety of files.

The _close_updateindex proc contains error handling (added in d4e890e5) that
has the potential to interact badly with unlock_index running at the
completion of an async operation. I have refactored the procedure into
separate procs _close_updateindex and rescan_on_error. Call sites that
exercised the combined functionality also unlocked the index, so a combined
proc close_and_unlock_index calls _close_updateindex and then either 
rescan_on_error or unlock_index as appropriate. Call sites have been updated
appropriately.

The revert_helper proc, with its overlapping operations, is an example of a
call site that does not combine the close and unlock/rescan operations. The 
checkout_index proc has been reworked to only call _close_updateindex, and
to call a functor supplied by the caller to captures any errors that occur. 
revert_helper uses this to supply a lambda function that stashes the error
within the chord's body namespace, so that it can then separately call 
rescan_on_error when the chord is completed (or unlock_index, if no error
was captured), which might be substantially after checkout_index encounters
its error. If it turns out that a rescan is called for, it is done once the
deletion is complete.

This is the sixth revision of this change, which differs from the fifth
version in the following ways:

 * The status_bar.tcl changes have been isolated into a separate commit.
   
   
 * A method in status_bar.tcl that apparently had never been hit had some
   simple bugs in it that have been corrected.
   
   
 * The show methods on the classes in status_bar.tcl no longer have a test 
   parameter, as nothing was using that feature that I could see.
   
   
 * The refresh method in status_bar.tcl now only tries to update the
   progress bar widget if it actually exists.
   
   
 * blame.tcl had been missed when searching for code using the status bar,
   this has been addressed.
   
   
 * rescan_on_error takes $after as well, in case 
   close_and_unlock_updateindex_rescan_on_error needs to call it.
   
   
 * close_and_unlock_updateindex_rescan_on_error has been renamed to simply 
   close_and_unlock_index.
   
   

On Sun, Nov 24, 2019 at 7:09 AM Pratyush Yadav wrote:

> Unfortunately, this change breaks things. The users of 'status_bar' that
aren't updated don't work. As an example, if I run 'git gui blame
git-gui.sh' with your patch applied, I get the following error:

 invalid command name "::status_bar::update"


I thought I'd found all places that used the status bar, but apparently
overlooked blame.tcl. This has been addressed. My apologies!

choose_repository.tcl was addressed already in the previous commit.

> Either way, please split the status bar refactor in a separate commit such
that the entire system still works properly (so this means the commit would
include updating the existing callsites).


Done. In doing so and testing it independently, I actually found paths that
weren't being hit with the full set of changes and fixed a few bugs. In
particular, stop_all was completely broken :-P I thought I had exercised it
before and I hadn't.

> > +# Clear "Initializing..." status +after idle {after 500 {$main_status show
""}}


Why put this in an 'after idle'? What's wrong with just 'after 500'? This is
not an expensive operation so we shouldn't really require the application to
be idle to run it.


My thinking was to make it clear the status bar 500 milliseconds after the
queue empties. It's quite possible that my understanding of what it means
for the queue to have emptied means that this isn't a terribly meaningful
thing to do. I was wanting it to continue saying "Initializing..." until,
heuristically, it is done initializing, including any queued up operations.
I guess if anything waits on I/O, then the queue may to go idle even though
it's still busy doing things. So, a straight-up after 500 { } would make
more sense? I've changed it to this, can make further changes if they are
called for.

> > +# Returns true if the operation succeeded, false if a rescan has been
initiated. +proc close_and_unlock_updateindex_rescan_on_error {fd after} {


Nitpick: That name is a bit too unwieldy. Maybe something a bit more concise
like 'close_and_unlock_index' (I'm not great at naming things. Maybe you can
figure out something better)? Let the readers figure out what happens on
error.


Good point. The thinking that had been going on in my head is that 
close_and_unlock_updateindex_rescan_on_error was combining two operations
that most but not all paths would do together, and then the paths that
needed them separated would call close_and_unlock in one place and 
rescan_on_error in another. The previous "cover letter" actually explicitly
described this, referring to proc names that actually weren't current any
more by the time the code was submitted. Upon closer review, at this point,
the place that calls rescan_on_error independently is not making a separate
call to something like close_and_unlock, it's just calling 
_close_updateindex directly, and the unlock is occurring in the chord body.

> >  * if {![catch {_close_updateindex $fd} err]} {    unlock_index
   
   
 * rescan $after 0
 * return
 * uplevel #0 $after
 * return 1
 * } else {
 * rescan_on_error $err $after
 * return 0


Neither of the two callers use the return value. Are these really needed?


I'm pretty sure there was an iteration of the code where at least one path
checked, but since nothing checks it now, I've removed the return value.

> > +proc write_checkout_index {fd path_list total_cnt batch
status_bar_operation \

 * after capture_error} { global update_index_cp global file_states
   current_diff_path
   
   if {$update_index_cp >= $total_cnt} {
   
   
 * _close_updateindex $fd $after
   
   
 * $status_bar_operation stop
   
   
 * 
 * if {[catch {_close_updateindex $fd} err]} {
   
   


Nitpick: Please mention exactly why we don't use
'close_and_unlock_updateindex_rescan_on_error' (or whatever its new name
would be) here. This function is very similar to 'write_update_index' and
'write_checkout_index', so this subtle difference is not very easily
apparent.


Done.

> > -field status {}; # single line of text we show


The field 'status' is removed, but the procedure 'show' still uses it. The
if condition needs to be refactored.


As far as I can tell, this feature of show to only change the status if the
test matches isn't actually used by any call sites. I've removed it. If this
was in error, then I'll reintroduce it correctly. I think, generally
speaking, supporting overlapping operations resolves the problem that this
would have originally resolved, which is that something else has updated the
status since it was previously set and the caller doesn't want to clear
somebody else's more up-to-date status text.

> >  * if {!$allow_multiple && [llength $operations]} {


This silently ignores multiple 'start's on a status bar that doesn't allow
it, correct?


It does, yes. The only status bar that doesn't allow multiple operations is
the two-line one created by choose_repository.

A caller that did this erroneously would get the same operation reference
both times, which would mean that (presumably) it got stopped multiple times
--- but stop on a status bar operation is idempotent, so this shouldn't
actually result in any errors.

> One quick question: the consumers of status_bar who don't run multiple
operations in parallel would still continue working exactly the same (after
refactoring them to use 'status_bar_operation'), right?


This is the expectation, yes, and is what I have observed in my testing. :-)

git remote add logiclrd https://github.com/logiclrd/git.git
git fetch logiclrd git-gui-revert-untracked revision5
git diff 23d4f5d..d0d6593b42

Jonathan Gilbert (3):
  git-gui: consolidate naming conventions
  git-gui: update status bar to track operations
  git-gui: revert untracked files by deleting them

 git-gui.sh          |  11 +-
 lib/blame.tcl       |  22 +-
 lib/checkout_op.tcl |  15 +-
 lib/chord.tcl       | 160 ++++++++++++++
 lib/index.tcl       | 523 +++++++++++++++++++++++++++++++++-----------
 lib/merge.tcl       |  14 +-
 lib/status_bar.tcl  | 228 ++++++++++++++++---
 7 files changed, 797 insertions(+), 176 deletions(-)
 create mode 100644 lib/chord.tcl


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/436

Range-diff vs v4:

 1:  da1704c56e = 1:  da1704c56e git-gui: consolidate naming conventions
 -:  ---------- > 2:  aa05a78d28 git-gui: update status bar to track operations
 2:  23d4f5d829 ! 3:  d0d6593b42 git-gui: revert untracked files by deleting them
     @@ -11,8 +11,8 @@
          out of _close_updateindex to a responsibility of the caller, to permit
          paths that don't directly unlock the index, and refactor the error
          handling added in d4e890e5 so that callers can make flow control
     -    decisions in the event of errors. Rework status_bar to explicitly handle
     -    multiple overlapping operations, and update all call sites.
     +    decisions in the event of errors. Update Tcl/Tk dependency from 8.4 to
     +    8.6 in git-gui.sh.
      
          A new proc delete_files takes care of actually deleting the files in
          batches, using the Tcler's Wiki recommended approach for keeping the UI
     @@ -24,14 +24,6 @@
          only after both operations are complete. The `SimpleChord` class,
          based on TclOO (Tcl/Tk 8.6), is added in this commit.
      
     -    Since the checkout_index and delete_files calls are both asynchronous
     -    and overlap, they clash in wanting to update the status bar. This commit
     -    reworks the status bar so that when an operation wants to display
     -    ongoing updates/progress, it explicitly starts an "operation", which is
     -    tracked by its own object, and the status bar handles multiple
     -    concurrent operations by merging their progress and concatenating their
     -    text.
     -
          Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
      
       diff --git a/git-gui.sh b/git-gui.sh
     @@ -48,73 +40,6 @@
       } {
       	catch {wm withdraw .}
       	tk_messageBox \
     -@@
     - 	do_explore
     - }
     - 
     -+# Clear "Initializing..." status
     -+after idle {after 500 {$main_status show ""}}
     -+
     - # Local variables:
     - # mode: tcl
     - # indent-tabs-mode: t
     -
     - diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
     - --- a/lib/checkout_op.tcl
     - +++ b/lib/checkout_op.tcl
     -@@
     - 	global HEAD
     - 
     - 	set readtree_d {}
     --	$::main_status start \
     -+	set status_bar_operation [$::main_status start \
     - 		[mc "Updating working directory to '%s'..." [_name $this]] \
     --		[mc "files checked out"]
     -+		[mc "files checked out"]]
     - 
     - 	set fd [git_read --stderr read-tree \
     - 		-m \
     -@@
     - 		$new_hash \
     - 		]
     - 	fconfigure $fd -blocking 0 -translation binary
     --	fileevent $fd readable [cb _readtree_wait $fd]
     -+	fileevent $fd readable [cb _readtree_wait $fd $status_bar_operation]
     - }
     - 
     --method _readtree_wait {fd} {
     -+method _readtree_wait {fd status_bar_operation} {
     - 	global current_branch
     - 
     - 	set buf [read $fd]
     --	$::main_status update_meter $buf
     -+	$status_bar_operation update_meter $buf
     - 	append readtree_d $buf
     - 
     - 	fconfigure $fd -blocking 1
     - 	if {![eof $fd]} {
     - 		fconfigure $fd -blocking 0
     -+		$status_bar_operation stop
     - 		return
     - 	}
     - 
     - 	if {[catch {close $fd}]} {
     - 		set err $readtree_d
     - 		regsub {^fatal: } $err {} err
     --		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
     -+		$status_bar_operation stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
     - 		warn_popup [strcat [mc "File level merge required."] "
     - 
     - $err
     -@@
     - 		return
     - 	}
     - 
     --	$::main_status stop
     -+	$status_bar_operation stop
     - 	_after_readtree $this
     - }
     - 
      
       diff --git a/lib/chord.tcl b/lib/chord.tcl
       new file mode 100644
     @@ -327,22 +252,18 @@
      -		wm deiconify $w
      -		tkwait window $w
      -
     --		$::main_status stop
     -+# Returns true if the operation succeeded, false if a rescan has been initiated.
     -+proc close_and_unlock_updateindex_rescan_on_error {fd after} {
     +-		$::main_status stop_all
     ++proc close_and_unlock_index {fd after} {
      +	if {![catch {_close_updateindex $fd} err]} {
       		unlock_index
      -		rescan $after 0
      -		return
      +		uplevel #0 $after
     -+		return 1
      +	} else {
      +		rescan_on_error $err $after
     -+		return 0
       	}
      +}
     - 
     --	$::main_status stop
     ++
      +proc _close_updateindex {fd} {
      +	fconfigure $fd -blocking 1
      +	close $fd
     @@ -384,8 +305,8 @@
      +	"
      +	wm deiconify $w
      +	tkwait window $w
     -+
     -+	$::main_status stop_all
     + 
     + 	$::main_status stop_all
       	unlock_index
      -	uplevel #0 $after
      +	rescan [concat $after [list ui_ready]] 0
     @@ -393,82 +314,25 @@
       
       proc update_indexinfo {msg path_list after} {
      @@
     - 	set batch [expr {int($total_cnt * .01) + 1}]
     - 	if {$batch > 25} {set batch 25}
     - 
     --	$::main_status start $msg [mc "files"]
     -+	set status_bar_operation [$::main_status start $msg [mc "files"]]
     - 	set fd [git_write update-index -z --index-info]
     - 	fconfigure $fd \
     - 		-blocking 0 \
     -@@
     - 		$path_list \
     - 		$total_cnt \
     - 		$batch \
     -+		$status_bar_operation \
     - 		$after \
     - 		]
     - }
     - 
     --proc write_update_indexinfo {fd path_list total_cnt batch after} {
     -+proc write_update_indexinfo {fd path_list total_cnt batch status_bar_operation \
     -+	after} {
     - 	global update_index_cp
     - 	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
     + 		$status_bar_operation stop
      -		_close_updateindex $fd $after
     -+		$status_bar_operation stop
     -+		close_and_unlock_updateindex_rescan_on_error $fd $after
     ++		close_and_unlock_index $fd $after
       		return
       	}
       
      @@
     - 		display_file $path $new
     - 	}
     - 
     --	$::main_status update $update_index_cp $total_cnt
     -+	$status_bar_operation update $update_index_cp $total_cnt
     - }
     - 
     - proc update_index {msg path_list after} {
     -@@
     - 	set batch [expr {int($total_cnt * .01) + 1}]
     - 	if {$batch > 25} {set batch 25}
     - 
     --	$::main_status start $msg [mc "files"]
     -+	set status_bar_operation [$::main_status start $msg [mc "files"]]
     - 	set fd [git_write update-index --add --remove -z --stdin]
     - 	fconfigure $fd \
     - 		-blocking 0 \
     -@@
     - 		$path_list \
     - 		$total_cnt \
     - 		$batch \
     -+		$status_bar_operation \
     - 		$after \
     - 		]
     - }
     - 
     --proc write_update_index {fd path_list total_cnt batch after} {
     -+proc write_update_index {fd path_list total_cnt batch status_bar_operation \
     -+	after} {
     - 	global update_index_cp
     - 	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
     + 		$status_bar_operation stop
      -		_close_updateindex $fd $after
     -+		$status_bar_operation stop
     -+		close_and_unlock_updateindex_rescan_on_error $fd $after
     ++		close_and_unlock_index $fd $after
       		return
       	}
       
      @@
     - 		display_file $path $new
     - 	}
     - 
     --	$::main_status update $update_index_cp $total_cnt
     -+	$status_bar_operation update $update_index_cp $total_cnt
     + 	$status_bar_operation update $update_index_cp $total_cnt
       }
       
      -proc checkout_index {msg path_list after} {
     @@ -477,33 +341,31 @@
       
       	if {![lock_index update]} return
      @@
     - 	set batch [expr {int($total_cnt * .01) + 1}]
     - 	if {$batch > 25} {set batch 25}
     - 
     --	$::main_status start $msg [mc "files"]
     -+	set status_bar_operation [$::main_status start $msg [mc "files"]]
     - 	set fd [git_write checkout-index \
     - 		--index \
     - 		--quiet \
     -@@
     - 		$path_list \
     - 		$total_cnt \
       		$batch \
     -+		$status_bar_operation \
     + 		$status_bar_operation \
       		$after \
      +		$capture_error \
       		]
       }
       
     --proc write_checkout_index {fd path_list total_cnt batch after} {
     -+proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
     + proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
     +-	after} {
      +	after capture_error} {
       	global update_index_cp
       	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
     + 		$status_bar_operation stop
      -		_close_updateindex $fd $after
     -+		$status_bar_operation stop
     ++
     ++		# We do not unlock the index directly here because this
     ++		# operation expects to potentially run in parallel with file
     ++		# deletions scheduled by revert_helper. We're done with the
     ++		# update index, so we close it, but actually unlocking the index
     ++		# and dealing with potential errors is deferred to the chord
     ++		# body that runs when all async operations are completed.
     ++		#
     ++		# (See after_chord in revert_helper.)
      +
      +		if {[catch {_close_updateindex $fd} err]} {
      +			uplevel #0 $capture_error [list $err]
     @@ -514,15 +376,6 @@
       		return
       	}
       
     -@@
     - 		}
     - 	}
     - 
     --	$::main_status update $update_index_cp $total_cnt
     -+	$status_bar_operation update $update_index_cp $total_cnt
     - }
     - 
     - proc unstage_helper {txt paths} {
      @@
       	add_helper [mc "Adding all changed files"] $paths
       }
     @@ -860,348 +713,3 @@
       	}
       }
       
     -
     - diff --git a/lib/merge.tcl b/lib/merge.tcl
     - --- a/lib/merge.tcl
     - +++ b/lib/merge.tcl
     -@@
     - 	if {[ask_popup $op_question] eq {yes}} {
     - 		set fd [git_read --stderr read-tree --reset -u -v HEAD]
     - 		fconfigure $fd -blocking 0 -translation binary
     --		fileevent $fd readable [namespace code [list _reset_wait $fd]]
     --		$::main_status start [mc "Aborting"] [mc "files reset"]
     -+		set status_bar_operation [$::main_status \
     -+			start \
     -+			[mc "Aborting"] \
     -+			[mc "files reset"]
     -+		fileevent $fd readable [namespace code [list \
     -+			_reset_wait $fd $status_bar_operation]]
     - 	} else {
     - 		unlock_index
     - 	}
     - }
     - 
     --proc _reset_wait {fd} {
     -+proc _reset_wait {fd status_bar_operation} {
     - 	global ui_comm
     - 
     --	$::main_status update_meter [read $fd]
     -+	$status_bar_operation update_meter [read $fd]
     - 
     - 	fconfigure $fd -blocking 1
     - 	if {[eof $fd]} {
     - 		set fail [catch {close $fd} err]
     --		$::main_status stop
     - 		unlock_index
     -+		$status_bar_operation stop
     - 
     - 		$ui_comm delete 0.0 end
     - 		$ui_comm edit modified false
     -
     - diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
     - --- a/lib/status_bar.tcl
     - +++ b/lib/status_bar.tcl
     -@@
     - # git-gui status bar mega-widget
     - # Copyright (C) 2007 Shawn Pearce
     - 
     -+# The status_bar class manages the entire status bar. It is possible for
     -+# multiple overlapping asynchronous operations to want to display status
     -+# simultaneously. Each one receives a status_bar_operation when it calls the
     -+# start method, and the status bar combines all active operations into the
     -+# line of text it displays. Most of the time, there will be at most one
     -+# ongoing operation.
     -+#
     -+# Note that the entire status bar can be either in single-line or two-line
     -+# mode, depending on the constructor. Multiple active operations are only
     -+# supported for single-line status bars.
     -+
     - class status_bar {
     - 
     -+field allow_multiple ; # configured at construction
     -+
     - field w         ; # our own window path
     - field w_l       ; # text widget we draw messages into
     - field w_c       ; # canvas we draw a progress bar into
     - field c_pack    ; # script to pack the canvas with
     --field status  {}; # single line of text we show
     --field prefix  {}; # text we format into status
     --field units   {}; # unit of progress
     --field meter   {}; # current core git progress meter (if active)
     -+
     -+field baseline_text   ; # text to show if there are no operations
     -+field status_bar_text ; # combined text for all operations
     -+
     -+field operations ; # list of current ongoing operations
     -+
     -+# The status bar can display a progress bar, updated when consumers call the
     -+# update method on their status_bar_operation. When there are multiple
     -+# operations, the status bar shows the combined status of all operations.
     -+#
     -+# When an overlapping operation completes, the progress bar is going to
     -+# abruptly have one fewer operation in the calculation, causing a discontinuity.
     -+# Therefore, whenever an operation completes, if it is not the last operation,
     -+# this counter is increased, and the progress bar is calculated as though there
     -+# were still another operation at 100%. When the last operation completes, this
     -+# is reset to 0.
     -+field completed_operation_count
     - 
     - constructor new {path} {
     - 	global use_ttk NS
     -@@
     - 	set w_l $w.l
     - 	set w_c $w.c
     - 
     -+	# Standard single-line status bar: Permit overlapping operations
     -+	set allow_multiple 1
     -+
     -+	set baseline_text ""
     -+	set operations [list]
     -+	set completed_operation_count 0
     -+
     - 	${NS}::frame $w
     - 	if {!$use_ttk} {
     - 		$w configure -borderwidth 1 -relief sunken
     - 	}
     - 	${NS}::label $w_l \
     --		-textvariable @status \
     -+		-textvariable @status_bar_text \
     - 		-anchor w \
     - 		-justify left
     - 	pack $w_l -side left
     -@@
     - 	set w_l $w.l
     - 	set w_c $w.c
     - 
     -+	# Two-line status bar: Only one ongoing operation permitted.
     -+	set allow_multiple 0
     -+
     -+	set baseline_text ""
     -+	set operations [list]
     -+
     - 	${NS}::frame $w
     - 	${NS}::label $w_l \
     --		-textvariable @status \
     -+		-textvariable @status_bar_text \
     - 		-anchor w \
     - 		-justify left
     - 	pack $w_l -anchor w -fill x
     -@@
     - 	return $this
     - }
     - 
     --method start {msg uds} {
     -+method ensure_canvas {} {
     - 	if {[winfo exists $w_c]} {
     - 		$w_c coords bar 0 0 0 20
     - 	} else {
     -@@
     - 		$w_c create rectangle 0 0 0 20 -tags bar -fill navy
     - 		eval $c_pack
     - 	}
     -+}
     -+
     -+method show {msg {test {}}} {
     -+	if {$test eq {} || $status eq $test} {
     -+		$this ensure_canvas
     -+		set baseline_text $msg
     -+		$this refresh
     -+	}
     -+}
     -+
     -+method start {msg uds} {
     -+	set baseline_text ""
     -+
     -+	if {!$allow_multiple && [llength $operations]} {
     -+		return [lindex $operations 0]
     -+	}
     -+
     -+	$this ensure_canvas
     -+
     -+	set operation [status_bar_operation::new $this $msg $uds]
     -+
     -+	lappend operations $operation
     -+
     -+	$this refresh
     -+
     -+	return $operation
     -+}
     -+
     -+method refresh {} {
     -+	set new_text ""
     -+
     -+	set total [expr $completed_operation_count * 100]
     -+	set have $total
     -+
     -+	foreach operation $operations {
     -+		if {$new_text != ""} {
     -+			append new_text " / "
     -+		}
     -+
     -+		append new_text [$operation get_status]
     -+
     -+		set total [expr $total + 100]
     -+		set have [expr $have + [$operation get_progress]]
     -+	}
     -+
     -+	if {$new_text == ""} {
     -+		set new_text $baseline_text
     -+	}
     -+
     -+	set status_bar_text $new_text
     -+
     -+	set pixel_width 0
     -+	if {$have > 0} {
     -+		set pixel_width [expr {[winfo width $w_c] * $have / $total}]
     -+	}
     -+
     -+	$w_c coords bar 0 0 $pixel_width 20
     -+}
     -+
     -+method stop {operation stop_msg} {
     -+	set idx [lsearch $operations $operation]
     -+
     -+	if {$idx >= 0} {
     -+		set operations [lreplace $operations $idx $idx]
     -+		set completed_operation_count [expr \
     -+			$completed_operation_count + 1]
     -+
     -+		if {[llength operations] == 0} {
     -+			set completed_operation_count 0
     -+
     -+			destroy $w_c
     -+			if {$stop_msg ne {}} {
     -+				set baseline_text $stop_msg
     -+			}
     -+		}
     -+
     -+		$this refresh
     -+	}
     -+}
     -+
     -+method stop_all {{stop_msg {}}} {
     -+	set operations_copy $operations
     -+	set operations [list] # This makes the operation's call to stop a no-op.
     -+
     -+	foreach $operation operations_copy {
     -+		$operation stop
     -+	}
     -+
     -+	if {$stop_msg ne {}} {
     -+		set baseline_text $stop_msg
     -+	}
     -+
     -+	$this refresh
     -+}
     -+
     -+method _delete {current} {
     -+	if {$current eq $w} {
     -+		delete_this
     -+	}
     -+}
     -+
     -+}
     -+
     -+# The status_bar_operation class tracks a single consumer's ongoing status bar
     -+# activity, with the context that there are a few situations where multiple
     -+# overlapping asynchronous operations might want to display status information
     -+# simultaneously. Instances of status_bar_operation are created by calling
     -+# start on the status_bar, and when the caller is done with its stauts bar
     -+# operation, it calls stop on the operation.
     -+
     -+class status_bar_operation {
     -+
     -+field status_bar; # reference back to the status_bar that owns this object
     -+
     -+field is_active;
     -+
     -+field status   {}; # single line of text we show
     -+field progress {}; # current progress (0 to 100)
     -+field prefix   {}; # text we format into status
     -+field units    {}; # unit of progress
     -+field meter    {}; # current core git progress meter (if active)
     -+
     -+constructor new {owner msg uds} {
     -+	set status_bar $owner
     - 
     - 	set status $msg
     -+	set progress 0
     - 	set prefix $msg
     - 	set units  $uds
     - 	set meter  {}
     -+
     -+	set is_active 1
     -+
     -+	return $this
     - }
     - 
     -+method get_is_active {} { return $is_active }
     -+method get_status {} { return $status }
     -+method get_progress {} { return $progress }
     -+
     - method update {have total} {
     --	set pdone 0
     --	set cdone 0
     -+	if {!$is_active} { return }
     -+
     -+	set progress 0
     -+
     - 	if {$total > 0} {
     --		set pdone [expr {100 * $have / $total}]
     --		set cdone [expr {[winfo width $w_c] * $have / $total}]
     -+		set progress [expr {100 * $have / $total}]
     - 	}
     - 
     - 	set prec [string length [format %i $total]]
     -+
     - 	set status [mc "%s ... %*i of %*i %s (%3i%%)" \
     - 		$prefix \
     - 		$prec $have \
     - 		$prec $total \
     --		$units $pdone]
     --	$w_c coords bar 0 0 $cdone 20
     -+		$units $progress]
     -+
     -+	$status_bar refresh
     - }
     - 
     - method update_meter {buf} {
     -+	if {!$is_active} { return }
     -+
     - 	append meter $buf
     - 	set r [string last "\r" $meter]
     - 	if {$r == -1} {
     -@@
     - 	}
     - }
     - 
     --method stop {{msg {}}} {
     --	destroy $w_c
     --	if {$msg ne {}} {
     --		set status $msg
     -+method stop {{stop_msg {}}} {
     -+	if {$is_active} {
     -+		set is_active 0
     -+		$status_bar stop $this $stop_msg
     - 	}
     - }
     - 
     - method show {msg {test {}}} {
     -+	if {!$is_active} { return }
     -+
     - 	if {$test eq {} || $status eq $test} {
     - 		set status $msg
     -+		$status_bar refresh
     - 	}
     - }
     - 
     --method _delete {current} {
     --	if {$current eq $w} {
     --		delete_this
     --	}
     -+method _delete {} {
     -+	stop
     -+	delete_this
     - }
     - 
     - }

-- 
gitgitgadget
