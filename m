Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB7C432C3
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B96207FD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEHQ/I5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKXUiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:38:04 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38173 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXUiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:38:04 -0500
Received: by mail-wr1-f47.google.com with SMTP id i12so15053901wro.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+LFH3lVk9Ek4fzppXXlZ8x0CM6Xm+tzu0LROjPRlwmM=;
        b=QEHQ/I5Za+7MQYtHZ0uqdKeIRc9ZUm0XpEOAMTCPC1JY8fPzJnJ3Mq0Vjd4vTaAq+n
         Gtf/UQMuPToFxycPSChYaLPPIVfoXg+uNpMlUHHpl58A4Y/yEPpajLHB+j5LcUJWo0Hq
         KxLve0+S+e72YdfdZ/cdhCSoHQ8V9VVr/+bg5uFs8zkDO+G0iyrknrJBzdI6ntqY9y5n
         gM1frI5rmZ14ROpuHmp+hE9/twZ1SgaRwBFqAlxpSbLGqikx5ZyZYVGCvytiTyruw8yM
         yA4Sr2lHQTo8jNfjrq8plXosOOOwa7KFiy+wthuii8mITtC/bQpR3jslko5At6tgJK+k
         5LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+LFH3lVk9Ek4fzppXXlZ8x0CM6Xm+tzu0LROjPRlwmM=;
        b=lERQWrXGCmhKxAv+579XwbN8GcGfVWoFMoeT4xeq6NU//aDL++AVvyAr02dM4nXbde
         8fGpaXZp8IFkcilruHX78bslbQrf5eZvtU1OlS9Obs8ZfNOAxpEI5Q4jwq4h/DamdV1f
         zeDfQ696WlA6fWqqwoP9U2le/eqgZFaswbWKIqtSMri9hLJwWk3TfmK139vSwctIlZH8
         E9PW7vDppO04/R/AC2ThM3WcmFsWGaKIVex+2k4uLTWUK1Ac+YMvaGVUkAYYX/KnzQfU
         NEABFRR+Y/p/n/J1mJbv0OlWDOT1q8BEubPTeXW2wPSBWvJEkf3nspy8nuJZgGW1/O5V
         RA/A==
X-Gm-Message-State: APjAAAVZO7+vfnYvD4TPAp86mVuD26ibzsZ8Fuyxi44z6BiTB0uT3udw
        +2txD/ZfV7DN2rZdvTCxBTvh0sAr
X-Google-Smtp-Source: APXvYqxawlrYG7TOX9b3qiWwuH+/jVpk/joXd93Eku0qeEoLq48IRKJd5R1F4wWJhbzKTZuGwZXkeg==
X-Received: by 2002:adf:db06:: with SMTP id s6mr5708716wri.117.1574627880132;
        Sun, 24 Nov 2019 12:38:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm6092751wmk.23.2019.11.24.12.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 12:37:59 -0800 (PST)
Message-Id: <d0d6593b421609445e8f2c794e1d3ca46ebed068.1574627876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
        <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 20:37:55 +0000
Subject: [PATCH v5 3/3] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

Update the revert_helper proc to check for untracked files as well as
changes, and then handle changes to be reverted and untracked files with
independent blocks of code. Prompt the user independently for untracked
files, since the underlying action is fundamentally different (rm -f).
If after deleting untracked files, the directory containing them becomes
empty, then remove the directory as well. Migrate unlocking of the index
out of _close_updateindex to a responsibility of the caller, to permit
paths that don't directly unlock the index, and refactor the error
handling added in d4e890e5 so that callers can make flow control
decisions in the event of errors. Update Tcl/Tk dependency from 8.4 to
8.6 in git-gui.sh.

A new proc delete_files takes care of actually deleting the files in
batches, using the Tcler's Wiki recommended approach for keeping the UI
responsive.

Since the checkout_index and delete_files calls are both asynchronous
and could potentially complete in any order, a "chord" is used to
coordinate unlocking the index and returning the UI to a usable state
only after both operations are complete. The `SimpleChord` class,
based on TclOO (Tcl/Tk 8.6), is added in this commit.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 git-gui.sh    |   4 +-
 lib/chord.tcl | 160 +++++++++++++++++++
 lib/index.tcl | 422 ++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 502 insertions(+), 84 deletions(-)
 create mode 100644 lib/chord.tcl

diff --git a/git-gui.sh b/git-gui.sh
index db02e399e7..ad87703b2d 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -30,8 +30,8 @@ along with this program; if not, see <http://www.gnu.org/licenses/>.}]
 ##
 ## Tcl/Tk sanity check
 
-if {[catch {package require Tcl 8.4} err]
- || [catch {package require Tk  8.4} err]
+if {[catch {package require Tcl 8.6} err]
+ || [catch {package require Tk  8.6} err]
 } {
 	catch {wm withdraw .}
 	tk_messageBox \
diff --git a/lib/chord.tcl b/lib/chord.tcl
new file mode 100644
index 0000000000..275a6cd4a1
--- /dev/null
+++ b/lib/chord.tcl
@@ -0,0 +1,160 @@
+# Simple Chord for Tcl
+#
+# A "chord" is a method with more than one entrypoint and only one body, such
+# that the body runs only once all the entrypoints have been called by
+# different asynchronous tasks. In this implementation, the chord is defined
+# dynamically for each invocation. A SimpleChord object is created, supplying
+# body script to be run when the chord is completed, and then one or more notes
+# are added to the chord. Each note can be called like a proc, and returns
+# immediately if the chord isn't yet complete. When the last remaining note is
+# called, the body runs before the note returns.
+#
+# The SimpleChord class has a constructor that takes the body script, and a
+# method add_note that returns a note object. Since the body script does not
+# run in the context of the procedure that defined it, a mechanism is provided
+# for injecting variables into the chord for use by the body script. The
+# activation of a note is idempotent; multiple calls have the same effect as
+# a simple call.
+#
+# If you are invoking asynchronous operations with chord notes as completion
+# callbacks, and there is a possibility that earlier operations could complete
+# before later ones are started, it is a good practice to create a "common"
+# note on the chord that prevents it from being complete until you're certain
+# you've added all the notes you need.
+#
+# Example:
+#
+#   # Turn off the UI while running a couple of async operations.
+#   lock_ui
+#
+#   set chord [SimpleChord new {
+#     unlock_ui
+#     # Note: $notice here is not referenced in the calling scope
+#     if {$notice} { info_popup $notice }
+#   }
+#
+#   # Configure a note to keep the chord from completing until
+#   # all operations have been initiated.
+#   set common_note [$chord add_note]
+#
+#   # Pass notes as 'after' callbacks to other operations
+#   async_operation $args [$chord add_note]
+#   other_async_operation $args [$chord add_note]
+#
+#   # Communicate with the chord body
+#   if {$condition} {
+#     # This sets $notice in the same context that the chord body runs in.
+#     $chord eval { set notice "Something interesting" }
+#   }
+#
+#   # Activate the common note, making the chord eligible to complete
+#   $common_note
+#
+# At this point, the chord will complete at some unknown point in the future.
+# The common note might have been the first note activated, or the async
+# operations might have completed synchronously and the common note is the
+# last one, completing the chord before this code finishes, or anything in
+# between. The purpose of the chord is to not have to worry about the order.
+
+# SimpleChord class:
+#   Represents a procedure that conceptually has multiple entrypoints that must
+#   all be called before the procedure executes. Each entrypoint is called a
+#   "note". The chord is only "completed" when all the notes are "activated".
+oo::class create SimpleChord {
+	variable notes body is_completed
+
+	# Constructor:
+	#   set chord [SimpleChord new {body}]
+	#     Creates a new chord object with the specified body script. The
+	#     body script is evaluated at most once, when a note is activated
+	#     and the chord has no other non-activated notes.
+	constructor {body} {
+		set notes [list]
+		my eval [list set body $body]
+		set is_completed 0
+	}
+
+	# Method:
+	#   $chord eval {script}
+	#     Runs the specified script in the same context (namespace) in which
+	#     the chord body will be evaluated. This can be used to set variable
+	#     values for the chord body to use.
+	method eval {script} {
+		namespace eval [self] $script
+	}
+
+	# Method:
+	#   set note [$chord add_note]
+	#     Adds a new note to the chord, an instance of ChordNote. Raises an
+	#     error if the chord is already completed, otherwise the chord is
+	#     updated so that the new note must also be activated before the
+	#     body is evaluated.
+	method add_note {} {
+		if {$is_completed} { error "Cannot add a note to a completed chord" }
+
+		set note [ChordNote new [self]]
+
+		lappend notes $note
+
+		return $note
+	}
+
+	# This method is for internal use only and is intentionally undocumented.
+	method notify_note_activation {} {
+		if {!$is_completed} {
+			foreach note $notes {
+				if {![$note is_activated]} { return }
+			}
+
+			set is_completed 1
+
+			namespace eval [self] $body
+			namespace delete [self]
+		}
+	}
+}
+
+# ChordNote class:
+#   Represents a note within a chord, providing a way to activate it. When the
+#   final note of the chord is activated (this can be any note in the chord,
+#   with all other notes already previously activated in any order), the chord's
+#   body is evaluated.
+oo::class create ChordNote {
+	variable chord is_activated
+
+	# Constructor:
+	#   Instances of ChordNote are created internally by calling add_note on
+	#   SimpleChord objects.
+	constructor {chord} {
+		my eval set chord $chord
+		set is_activated 0
+	}
+
+	# Method:
+	#   [$note is_activated]
+	#     Returns true if this note has already been activated.
+	method is_activated {} {
+		return $is_activated
+	}
+
+	# Method:
+	#   $note
+	#     Activates the note, if it has not already been activated, and
+	#     completes the chord if there are no other notes awaiting
+	#     activation. Subsequent calls will have no further effect.
+	#
+	# NB: In TclOO, if an object is invoked like a method without supplying
+	#     any method name, then this internal method `unknown` is what
+	#     actually runs (with no parameters). It is used in the ChordNote
+	#     class for the purpose of allowing the note object to be called as
+	#     a function (see example above). (The `unknown` method can also be
+	#     used to support dynamic dispatch, but must take parameters to
+	#     identify the "unknown" method to be invoked. In this form, this
+	#     proc serves only to make instances behave directly like methods.)
+	method unknown {} {
+		if {!$is_activated} {
+			set is_activated 1
+			$chord notify_note_activation
+		}
+	}
+}
diff --git a/lib/index.tcl b/lib/index.tcl
index 62f4773ef4..1254145634 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -7,53 +7,60 @@ proc _delete_indexlock {} {
 	}
 }
 
-proc _close_updateindex {fd after} {
-	global use_ttk NS
-	fconfigure $fd -blocking 1
-	if {[catch {close $fd} err]} {
-		set w .indexfried
-		Dialog $w
-		wm withdraw $w
-		wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
-		wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
-		set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
-		text $w.msg -yscrollcommand [list $w.vs set] \
-			-width [string length $s] -relief flat \
-			-borderwidth 0 -highlightthickness 0 \
-			-background [get_bg_color $w]
-		$w.msg tag configure bold -font font_uibold -justify center
-		${NS}::scrollbar $w.vs -command [list $w.msg yview]
-		$w.msg insert end $s bold \n\n$err {}
-		$w.msg configure -state disabled
-
-		${NS}::button $w.continue \
-			-text [mc "Continue"] \
-			-command [list destroy $w]
-		${NS}::button $w.unlock \
-			-text [mc "Unlock Index"] \
-			-command "destroy $w; _delete_indexlock"
-		grid $w.msg - $w.vs -sticky news
-		grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
-		grid columnconfigure $w 0 -weight 1
-		grid rowconfigure $w 0 -weight 1
-
-		wm protocol $w WM_DELETE_WINDOW update
-		bind $w.continue <Visibility> "
-			grab $w
-			focus %W
-		"
-		wm deiconify $w
-		tkwait window $w
-
-		$::main_status stop_all
+proc close_and_unlock_index {fd after} {
+	if {![catch {_close_updateindex $fd} err]} {
 		unlock_index
-		rescan $after 0
-		return
+		uplevel #0 $after
+	} else {
+		rescan_on_error $err $after
 	}
+}
+
+proc _close_updateindex {fd} {
+	fconfigure $fd -blocking 1
+	close $fd
+}
+
+proc rescan_on_error {err {after {}}} {
+	global use_ttk NS
+
+	set w .indexfried
+	Dialog $w
+	wm withdraw $w
+	wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
+	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
+	set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
+	text $w.msg -yscrollcommand [list $w.vs set] \
+		-width [string length $s] -relief flat \
+		-borderwidth 0 -highlightthickness 0 \
+		-background [get_bg_color $w]
+	$w.msg tag configure bold -font font_uibold -justify center
+	${NS}::scrollbar $w.vs -command [list $w.msg yview]
+	$w.msg insert end $s bold \n\n$err {}
+	$w.msg configure -state disabled
+
+	${NS}::button $w.continue \
+		-text [mc "Continue"] \
+		-command [list destroy $w]
+	${NS}::button $w.unlock \
+		-text [mc "Unlock Index"] \
+		-command "destroy $w; _delete_indexlock"
+	grid $w.msg - $w.vs -sticky news
+	grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
+	grid columnconfigure $w 0 -weight 1
+	grid rowconfigure $w 0 -weight 1
+
+	wm protocol $w WM_DELETE_WINDOW update
+	bind $w.continue <Visibility> "
+		grab $w
+		focus %W
+	"
+	wm deiconify $w
+	tkwait window $w
 
 	$::main_status stop_all
 	unlock_index
-	uplevel #0 $after
+	rescan [concat $after [list ui_ready]] 0
 }
 
 proc update_indexinfo {msg path_list after} {
@@ -93,7 +100,7 @@ proc write_update_indexinfo {fd path_list total_cnt batch status_bar_operation \
 
 	if {$update_index_cp >= $total_cnt} {
 		$status_bar_operation stop
-		_close_updateindex $fd $after
+		close_and_unlock_index $fd $after
 		return
 	}
 
@@ -162,7 +169,7 @@ proc write_update_index {fd path_list total_cnt batch status_bar_operation \
 
 	if {$update_index_cp >= $total_cnt} {
 		$status_bar_operation stop
-		_close_updateindex $fd $after
+		close_and_unlock_index $fd $after
 		return
 	}
 
@@ -199,7 +206,7 @@ proc write_update_index {fd path_list total_cnt batch status_bar_operation \
 	$status_bar_operation update $update_index_cp $total_cnt
 }
 
-proc checkout_index {msg path_list after} {
+proc checkout_index {msg path_list after capture_error} {
 	global update_index_cp
 
 	if {![lock_index update]} return
@@ -232,17 +239,33 @@ proc checkout_index {msg path_list after} {
 		$batch \
 		$status_bar_operation \
 		$after \
+		$capture_error \
 		]
 }
 
 proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
-	after} {
+	after capture_error} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
 		$status_bar_operation stop
-		_close_updateindex $fd $after
+
+		# We do not unlock the index directly here because this
+		# operation expects to potentially run in parallel with file
+		# deletions scheduled by revert_helper. We're done with the
+		# update index, so we close it, but actually unlocking the index
+		# and dealing with potential errors is deferred to the chord
+		# body that runs when all async operations are completed.
+		#
+		# (See after_chord in revert_helper.)
+
+		if {[catch {_close_updateindex $fd} err]} {
+			uplevel #0 $capture_error [list $err]
+		}
+
+		uplevel #0 $after
+
 		return
 	}
 
@@ -397,66 +420,301 @@ proc do_add_all {} {
 	add_helper [mc "Adding all changed files"] $paths
 }
 
+# Copied from TclLib package "lambda".
+proc lambda {arguments body args} {
+	return [list ::apply [list $arguments $body] {*}$args]
+}
+
 proc revert_helper {txt paths} {
 	global file_states current_diff_path
 
 	if {![lock_index begin-update]} return
 
+	# Common "after" functionality that waits until multiple asynchronous
+	# operations are complete (by waiting for them to activate their notes
+	# on the chord).
+	#
+	# The asynchronous operations are each indicated below by a comment
+	# before the code block that starts the async operation.
+	set after_chord [SimpleChord new {
+		if {[string trim $err] != ""} {
+			rescan_on_error $err
+		} else {
+			unlock_index
+			if {$should_reshow_diff} { reshow_diff }
+			ui_ready
+		}
+	}]
+
+	$after_chord eval { set should_reshow_diff 0 }
+
+	# This function captures an error for processing when after_chord is
+	# completed. (The chord is curried into the lambda function.)
+	set capture_error [lambda \
+		{chord error} \
+		{ $chord eval [list set err $error] } \
+		$after_chord]
+
+	# We don't know how many notes we're going to create (it's dynamic based
+	# on conditional paths below), so create a common note that will delay
+	# the chord's completion until we activate it, and then activate it
+	# after all the other notes have been created.
+	set after_common_note [$after_chord add_note]
+
 	set path_list [list]
-	set after {}
+	set untracked_list [list]
+
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
+		?O {
+			lappend untracked_list $path
+		}
 		?M -
 		?T -
 		?D {
 			lappend path_list $path
 			if {$path eq $current_diff_path} {
-				set after {reshow_diff;}
+				$after_chord eval { set should_reshow_diff 1 }
 			}
 		}
 		}
 	}
 
+	set path_cnt [llength $path_list]
+	set untracked_cnt [llength $untracked_list]
+
+	# Asynchronous operation: revert changes by checking them out afresh
+	# from the index.
+	if {$path_cnt > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages. Previously, the
+		# code used "Revert changes in" for both, but that can't work
+		# in languages where 'in' must be combined with word from
+		# rest of string (in different way for both cases of course).
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string
+		# translation.
+		#
+		if {$path_cnt == 1} {
+			set query [mc \
+				"Revert changes in file %s?" \
+				[short_path [lindex $path_list]] \
+				]
+		} else {
+			set query [mc \
+				"Revert changes in these %i files?" \
+				$path_cnt]
+		}
 
-	# Split question between singular and plural cases, because
-	# such distinction is needed in some languages. Previously, the
-	# code used "Revert changes in" for both, but that can't work
-	# in languages where 'in' must be combined with word from
-	# rest of string (in different way for both cases of course).
-	#
-	# FIXME: Unfortunately, even that isn't enough in some languages
-	# as they have quite complex plural-form rules. Unfortunately,
-	# msgcat doesn't seem to support that kind of string translation.
-	#
-	set n [llength $path_list]
-	if {$n == 0} {
-		unlock_index
-		return
-	} elseif {$n == 1} {
-		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
-	} else {
-		set query [mc "Revert changes in these %i files?" $n]
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
+
+[mc "Any unstaged changes will be permanently lost by the revert."]" \
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Revert Changes"] \
+			]
+
+		if {$reply == 1} {
+			checkout_index \
+				$txt \
+				$path_list \
+				[$after_chord add_note] \
+				$capture_error
+		}
 	}
 
-	set reply [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query
+	# Asynchronous operation: Deletion of untracked files.
+	if {$untracked_cnt > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages.
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string
+		# translation.
+		#
+		if {$untracked_cnt == 1} {
+			set query [mc \
+				"Delete untracked file %s?" \
+				[short_path [lindex $untracked_list]] \
+				]
+		} else {
+			set query [mc \
+				"Delete these %i untracked files?" \
+				$untracked_cnt \
+				]
+		}
 
-[mc "Any unstaged changes will be permanently lost by the revert."]" \
-		question \
-		1 \
-		[mc "Do Nothing"] \
-		[mc "Revert Changes"] \
-		]
-	if {$reply == 1} {
-		checkout_index \
-			$txt \
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
+
+[mc "Files will be permanently deleted."]" \
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Delete Files"] \
+			]
+
+		if {$reply == 1} {
+			$after_chord eval { set should_reshow_diff 1 }
+
+			delete_files $untracked_list [$after_chord add_note]
+		}
+	}
+
+	# Activate the common note. If no other notes were created, this
+	# completes the chord. If other notes were created, then this common
+	# note prevents a race condition where the chord might complete early.
+	$after_common_note
+}
+
+# Delete all of the specified files, performing deletion in batches to allow the
+# UI to remain responsive and updated.
+proc delete_files {path_list after} {
+	# Enable progress bar status updates
+	set status_bar_operation [$::main_status \
+		start \
+		[mc "Deleting"] \
+		[mc "files"]]
+
+	set path_index 0
+	set deletion_errors [list]
+	set batch_size 50
+
+	delete_helper \
+		$path_list \
+		$path_index \
+		$deletion_errors \
+		$batch_size \
+		$status_bar_operation \
+		$after
+}
+
+# Helper function to delete a list of files in batches. Each call deletes one
+# batch of files, and then schedules a call for the next batch after any UI
+# messages have been processed.
+proc delete_helper {path_list path_index deletion_errors batch_size \
+	status_bar_operation after} {
+	global file_states
+
+	set path_cnt [llength $path_list]
+
+	set batch_remaining $batch_size
+
+	while {$batch_remaining > 0} {
+		if {$path_index >= $path_cnt} { break }
+
+		set path [lindex $path_list $path_index]
+
+		set deletion_failed [catch {file delete -- $path} deletion_error]
+
+		if {$deletion_failed} {
+			lappend deletion_errors [list "$deletion_error"]
+		} else {
+			remove_empty_directories [file dirname $path]
+
+			# Don't assume the deletion worked. Remove the file from
+			# the UI, but only if it no longer exists.
+			if {![path_exists $path]} {
+				unset file_states($path)
+				display_file $path __
+			}
+		}
+
+		incr path_index 1
+		incr batch_remaining -1
+	}
+
+	# Update the progress bar to indicate that this batch has been
+	# completed. The update will be visible when this procedure returns
+	# and allows the UI thread to process messages.
+	$status_bar_operation update $path_index $path_cnt
+
+	if {$path_index < $path_cnt} {
+		# The Tcler's Wiki lists this as the best practice for keeping
+		# a UI active and processing messages during a long-running
+		# operation.
+
+		after idle [list after 0 [list \
+			delete_helper \
 			$path_list \
-			[concat $after [list ui_ready]]
+			$path_index \
+			$deletion_errors \
+			$batch_size \
+			$status_bar_operation \
+			$after
+			]]
 	} else {
-		unlock_index
+		# Finish the status bar operation.
+		$status_bar_operation stop
+
+		# Report error, if any, based on how many deletions failed.
+		set deletion_error_cnt [llength $deletion_errors]
+
+		if {($deletion_error_cnt > 0)
+		 && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
+			set error_text [mc "Encountered errors deleting files:\n"]
+
+			foreach deletion_error $deletion_errors {
+				append error_text "* [lindex $deletion_error 0]\n"
+			}
+
+			error_popup $error_text
+		} elseif {$deletion_error_cnt == $path_cnt} {
+			error_popup [mc \
+				"None of the %d selected files could be deleted." \
+				$path_cnt \
+				]
+		} elseif {$deletion_error_cnt > 1} {
+			error_popup [mc \
+				"%d of the %d selected files could not be deleted." \
+				$deletion_error_cnt \
+				$path_cnt \
+				]
+		}
+
+		uplevel #0 $after
+	}
+}
+
+proc MAX_VERBOSE_FILES_IN_DELETION_ERROR {} { return 10; }
+
+# This function is from the TCL documentation:
+#
+#   https://wiki.tcl-lang.org/page/file+exists
+#
+# [file exists] returns false if the path does exist but is a symlink to a path
+# that doesn't exist. This proc returns true if the path exists, regardless of
+# whether it is a symlink and whether it is broken.
+proc path_exists {name} {
+	expr {![catch {file lstat $name finfo}]}
+}
+
+# Remove as many empty directories as we can starting at the specified path,
+# walking up the directory tree. If we encounter a directory that is not
+# empty, or if a directory deletion fails, then we stop the operation and
+# return to the caller. Even if this procedure fails to delete any
+# directories at all, it does not report failure.
+proc remove_empty_directories {directory_path} {
+	set parent_path [file dirname $directory_path]
+
+	while {$parent_path != $directory_path} {
+		set contents [glob -nocomplain -dir $directory_path *]
+
+		if {[llength $contents] > 0} { break }
+		if {[catch {file delete -- $directory_path}]} { break }
+
+		set directory_path $parent_path
+		set parent_path [file dirname $directory_path]
 	}
 }
 
-- 
gitgitgadget
