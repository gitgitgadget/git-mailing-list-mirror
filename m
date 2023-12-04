Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6hFZCT8"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371AAC4
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 05:18:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so13864505e9.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701695901; x=1702300701; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eJf7sbKO3QwR7a0J5Zvf7ax4ZBYsQ/5pTCWvLkM8nJI=;
        b=L6hFZCT8S+emfsfOWSc/SCbTIP3JYNpNthbXxqZEwTFsqc6fOcYFiQU14ZbinTwT/N
         wnwgFZU6iZkrDxYUxMTjo/s4H1NgC2YMHMNHz9q9zK3M902QAy3Zh+iF98mkfQ3bFgST
         ic9sfz9aE7KqsnphMe7mjwl1ijVBzQjj+AYLVGepIsmanr7JSFy99HtphA2XR3x+7XMJ
         yP31vdMhGFemO07sCk34d2W7BSSqJ/3QdtCt2VxzcPiwsFbPEawXzql/o17d5i+SCgGe
         6JM/ahzQFKpfHyAORlK+F67cHR0cvIbNgIwrd2ozmliQ8pqlcP0ypGaEiCalhgyVHrfj
         uE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695901; x=1702300701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJf7sbKO3QwR7a0J5Zvf7ax4ZBYsQ/5pTCWvLkM8nJI=;
        b=Z7iUZ0xelE3vS0PXKPoXLnDjsCbweZg9VDxFy/HOXlGdLiWiIItiD9CJGKXIft69Jo
         PTXglSq8vDd3onWrUMDyxHSkDIokPGLCNwcfeVw5OwpQJZ9rCO2BUlTE+tc9KSfiCEKS
         LmJGNxhUYiodGZslZiUNxvZnCiE8qgirveOx2OLyllf04bHY3U6Ymkr/qYzNX0FvihND
         3dzQ0kHX0jRXQP2QpV9vtjwOrSESuJEqLYcZNfbeeNqUhA5CZREw9uSW9NicrSCbhBes
         VPWkrQpJfV+ydXnDjQQyAOUDaEFZT1GOlisGSxAsI0sx1P4caVsb7UPllhFaUAk5Heid
         elIw==
X-Gm-Message-State: AOJu0YwVNVH98KWS2gw8HAdcZbFtF2aWdlDMnXEWPzJSyg4HmgnT4kJn
	Sgq6CI/4pJwFCIOAgImIlC+BMMTRGrs=
X-Google-Smtp-Source: AGHT+IGlfDpLNNj7FGic3izmHI/o/trREQ44/DKdQs08DC5gN3VyHiJOdf+nZDSvUpb8IsGThEftGA==
X-Received: by 2002:a05:600c:54ce:b0:40b:5e59:99a4 with SMTP id iw14-20020a05600c54ce00b0040b5e5999a4mr1625564wmb.196.1701695900781;
        Mon, 04 Dec 2023 05:18:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b004042dbb8925sm18821285wms.38.2023.12.04.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:18:20 -0800 (PST)
Message-ID: <pull.1619.git.1701695899635.gitgitgadget@gmail.com>
From: "Joachim B Haga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Dec 2023 13:18:19 +0000
Subject: [PATCH] gitk: add setting to hide unknown refs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Joachim B Haga <jobh@simula.no>,
    Joachim B Haga <jobh@simula.no>

From: Joachim B Haga <jobh@simula.no>

Tools such as branchless (https://github.com/arxanas/git-branchless)
add a lot of refs under the "refs/branchless" prefix. By default,
these are filtered out from `git log` using the `log.excludeDecoration`
config directive.

However, gitk applies decoration itself from the output of `git show-ref`,
so these refs clutter up the UI.

This patch adds a setting to gitk to exclude all unknown refs - which
is considerably simpler than trying to honour the `excludeDecoration`
pattern. Note that this also hides f.x. the `git bisect` refs, which I
think is fine given that this behaviour is opt-in (it defaults to not
hide anything).

Signed-off-by: Joachim B Haga <jobh@simula.no>
---
    gitk: add setting to hide unknown refs
    
    Tools such as branchless (https://github.com/arxanas/git-branchless) add
    a lot of refs under the "refs/branchless" prefix. By default, these are
    filtered out from git log using the log.excludeDecoration config
    directive.
    
    However, gitk applies decoration itself from the output of git show-ref,
    so these refs clutter up the UI.
    
    This patch adds a setting to gitk to exclude all unknown refs - which is
    considerably simpler than trying to honour the excludeDecoration
    pattern. Note that this also hides f.x. the git bisect refs, which I
    think is fine given that this behaviour is opt-in (defaults to not hide
    anything).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1619%2Fjobh%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1619/jobh/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1619

 gitk-git/gitk | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99b..e91856b33a0 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1798,7 +1798,7 @@ proc readrefs {} {
     global tagids idtags headids idheads tagobjid
     global otherrefids idotherrefs mainhead mainheadid
     global selecthead selectheadid
-    global hideremotes
+    global hideremotes hideunknown
     global tclencoding
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
@@ -1835,8 +1835,10 @@ proc readrefs {} {
             set tagids($name) $id
             lappend idtags($id) $name
         } else {
-            set otherrefids($name) $id
-            lappend idotherrefs($id) $name
+	    if {[string match "stash" $name] || !$hideunknown} {
+		set otherrefids($name) $id
+		lappend idotherrefs($id) $name
+	    }
         }
     }
     catch {close $refd}
@@ -11577,7 +11579,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs web_browser
+    global hideremotes hideunknown want_ttk have_ttk maxrefs web_browser
 
     set page [create_prefs_page $notebook.general]
 
@@ -11601,6 +11603,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
         -variable hideremotes
     grid x $page.hideremotes -sticky w
+    ${NS}::checkbutton $page.hideunknown -text [mc "Hide unknown refs"] \
+        -variable hideunknown
+    grid x $page.hideunknown -sticky w
 
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11725,7 +11730,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes hideunknown want_ttk have_ttk
 
     set top .gitkprefs
     set prefstop $top
@@ -11734,7 +11739,7 @@ proc doprefs {} {
         return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes hideunknown want_ttk} {
         set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11860,7 +11865,7 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes hideunknown want_ttk} {
         global $v
         set $v $oldprefs($v)
     }
@@ -11874,7 +11879,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes hideunknown
 
     catch {destroy $prefstop}
     unset prefstop
@@ -11920,7 +11925,7 @@ proc prefsok {} {
           $limitdiffs != $oldprefs(limitdiffs)} {
         reselectline
     }
-    if {$hideremotes != $oldprefs(hideremotes)} {
+    if {$hideremotes != $oldprefs(hideremotes) || $hideunknown != $oldprefs(hideunknown)} {
         rereadrefs
     }
 }
@@ -12394,6 +12399,7 @@ set cmitmode "patch"
 set wrapcomment "none"
 set showneartags 1
 set hideremotes 0
+set hideunknown 0
 set maxrefs 20
 set visiblerefs {"master"}
 set maxlinelen 200
@@ -12498,7 +12504,7 @@ config_check_tmp_exists 50
 set config_variables {
     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
     cmitmode wrapcomment autoselect autosellen showneartags maxrefs visiblerefs
-    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
+    hideremotes hideunknown showlocalchanges datetimeformat limitdiffs uicolor want_ttk
     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
     extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
