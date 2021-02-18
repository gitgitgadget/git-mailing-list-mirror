Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7400C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA0964DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhBRQ4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhBRPzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 10:55:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C43C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 07:55:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n10so4421351wmq.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZEU8TrT9NCB+EOfmj5myeG95EzmRQbDutl9egTpaLMU=;
        b=EM2K2FW94YRAtzAcRi8M/vv72q1ejxMYrcRbti813QYmvq0dkItZNHG4c+qxaYSjaQ
         fOkYgOV3YibJFteYrkU37ddwsJCMQFrU6eQFH7LD0KE+dVYx8CP6sTCuKkafgBd6AdwG
         8RZ19DUhuFZNhjV+HB+xaYlZL0O1jLvm+VFaenCt0MjDnwax1hG75df6hZ/5/wOq8/sr
         jHHNoJZX2tXXwMssePboheu3Y9c1IvA26FKiM5WaiCp+FHYs4S+X/K0YPgDAHdZDL3A1
         9r6rvvTrkCe+d1e8D4mLisK1ljAh7RQ/33bL42MdJjUWTVRcIbfkG9z6yKB5EsxoeCha
         L0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZEU8TrT9NCB+EOfmj5myeG95EzmRQbDutl9egTpaLMU=;
        b=AMHG2CE1y+bahLgWzvwIMhAFMrAhJbcCgXozd+ISQSqT8QRduGo++WkipE29xogXe5
         xaEM28Hu9cvZ37zbdf6NADiJImBTnjyYElLphwR6bFTCvNvmP/mFCwPEmnAFGDu/Jb6n
         nZCXNKHvd8u3pomS6L7HOnJvTZWPKdfnFug/vGF/O8tnJ85GMsYmEu1OH01sNnCpm0za
         ekI4judNiJXO/tRXKzI2qgLaV5tdofY6ROkFYxvKOqYGogrOOapijWV0iRvPI8KoPG2n
         vYwRsNNxPw3Dl5KrMIBCo0znccSa0udORvRGvFiVExR9Pj/R57+f5+tVUWGYA3DcJenu
         cTlg==
X-Gm-Message-State: AOAM533gDKY/0sCiGt59IIEBOG/3xZJAckwJwopl1ubG3YvWwWXKDTeW
        uAEcTs6Skec9TsYes+N4Y990xStTWRw=
X-Google-Smtp-Source: ABdhPJzi34JimnHn+fyOV2GOFb42767GJPvVxenB7PVotEx3aG5cGslMXff4BQbap5nDC5/saPGlmw==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr3320699wmb.19.1613663706579;
        Thu, 18 Feb 2021 07:55:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm7941953wmq.36.2021.02.18.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:55:05 -0800 (PST)
Message-Id: <pull.866.v3.git.1613663704128.gitgitgadget@gmail.com>
In-Reply-To: <pull.866.v2.git.1613483622881.gitgitgadget@gmail.com>
References: <pull.866.v2.git.1613483622881.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 15:55:03 +0000
Subject: [PATCH v3] gitk: tag add right click options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Anders Kaseorg <andersk@MIT.EDU>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In gitk, we can right-click on the icon of the branch,
and a directory will pop up to provide us with functions
such as "Checkout this branch", "Rename this branch"...,
but we found that the right-click tag icon does not have such
a function , So I learned how to write the branch icon, and
added the following functions "Rename this tag","Remove this tag",
"Copy tag name" to right-click the tag icon. This function is
temporarily supported work on the branch with <=3 tags.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    gitk: tag add right click options
    
    This patch want to fix: https://github.com/gitgitgadget/git/issues/855
    
    We can provide for right-clicking the tag icon in gitk Rename this tag",
    "Remove this tag", "Copy tag name" function.
    
    For convenience, only the tags on the branch with the number of tags <=3
    are processed temporarily.
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-866%2Fadlternative%2Fgitk_tag_new_opt-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-866/adlternative/gitk_tag_new_opt-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/866

Range-diff vs v2:

 1:  f3a5d7d3be9f ! 1:  52ca9bcfa52f gitk: tag add right click options
     @@ gitk-git/gitk: proc makewindow {} {
           global rprogitem rprogcoord rownumsel numcommits
           global have_tk85 use_ttk NS
      @@ gitk-git/gitk: proc makewindow {} {
     +     set headctxmenu .headctxmenu
     +     makemenu $headctxmenu {
     +         {mc "Check out this branch" command cobranch}
     +-        {mc "Rename this branch" command mvbranch}
     ++        {mc "Rename this branch..." command mvbranch}
     +         {mc "Remove this branch" command rmbranch}
     +         {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
           }
           $headctxmenu configure -tearoff 0
       
      +    set tagctxmenu .tagctxmenu
      +    makemenu $tagctxmenu {
     -+        {mc "Rename this tag" command mvtag}
     -+        {mc "Remove this tag" command rmtag}
     ++        {mc "Rename this tag..." command mvtag}
     ++        {mc "Remove this tag..." command rmtag}
      +        {mc "Copy tag name" command {clipboard clear; clipboard append $tagmenutag}}
      +    }
      +    $tagctxmenu configure -tearoff 0
     @@ gitk-git/gitk: proc branchdia {top valvar uivar} {
      +    } else {
      +        notbusy renametag
      +        removetag $id $prevname
     ++        removedtag $id $tag
      +        set tagids($name) $id
      +        lappend idtags($id) $name
     -+        redrawtags $id
      +        addedtag $id
     ++        redrawtags $id
      +        dispneartags 0
      +        run refill_reflist
      +    }
     @@ gitk-git/gitk: proc rmbranch {} {
      +
      +    set tag $tagmenutag
      +    set id $tagmenuid
     -+
     ++    if {![confirm_popup [mc "Really delete tag %s?" $tag]]} return
      +    nowbusy rmtag
      +    update
      +    if {[catch {exec git tag -d $tag} err]} {
     @@ gitk-git/gitk: proc rmbranch {} {
      +        return
      +    }
      +    removetag $id $tag
     ++    removedtag $id $tag
      +    redrawtags $id
      +    notbusy rmtag
     ++    dispneartags 0
      +    run refill_reflist
      +}
      +
       # Display a list of tags and heads
       proc showrefs {} {
           global showrefstop bgcolor fgcolor selectbgcolor NS
     +@@ gitk-git/gitk: proc addedtag {id} {
     +     unset -nocomplain cached_atags
     + }
     + 
     ++proc removedtag {id tag} {
     ++    global cached_dtags cached_atags cached_tagcontent
     ++
     ++    unset -nocomplain cached_tagcontent
     ++    unset -nocomplain cached_dtags
     ++    unset -nocomplain cached_atags
     ++}
     ++
     + proc addedhead {hid head} {
     +     global arcnos arcout cached_dheads
     + 


 gitk-git/gitk | 160 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d0..99b667d4db3e 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1874,6 +1874,20 @@ proc removehead {id name} {
     unset headids($name)
 }
 
+proc removetag {id name} {
+    global tagids idtags
+
+    if {$idtags($id) eq $name} {
+        unset idtags($id)
+    } else {
+        set i [lsearch -exact $idtags($id) $name]
+        if {$i >= 0} {
+            set idtags($id) [lreplace $idtags($id) $i $i]
+        }
+    }
+    unset tagids($name)
+}
+
 proc ttk_toplevel {w args} {
     global use_ttk
     eval [linsert $args 0 ::toplevel $w]
@@ -2077,6 +2091,7 @@ proc makewindow {} {
     global filesepbgcolor filesepfgcolor
     global mergecolors foundbgcolor currentsearchhitbgcolor
     global headctxmenu progresscanv progressitem progresscoords statusw
+    global tagctxmenu
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
     global have_tk85 use_ttk NS
@@ -2679,12 +2694,20 @@ proc makewindow {} {
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
         {mc "Check out this branch" command cobranch}
-        {mc "Rename this branch" command mvbranch}
+        {mc "Rename this branch..." command mvbranch}
         {mc "Remove this branch" command rmbranch}
         {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
     $headctxmenu configure -tearoff 0
 
+    set tagctxmenu .tagctxmenu
+    makemenu $tagctxmenu {
+        {mc "Rename this tag..." command mvtag}
+        {mc "Remove this tag..." command rmtag}
+        {mc "Copy tag name" command {clipboard clear; clipboard append $tagmenutag}}
+    }
+    $tagctxmenu configure -tearoff 0
+
     global flist_menu
     set flist_menu .flistctxmenu
     makemenu $flist_menu {
@@ -6581,6 +6604,7 @@ proc drawtags {id x xt y1} {
 
     set marks {}
     set ntags 0
+    set ntags_copy 0
     set nheads 0
     set singletag 0
     set maxtags 3
@@ -6592,6 +6616,7 @@ proc drawtags {id x xt y1} {
     if {[info exists idtags($id)]} {
         set marks $idtags($id)
         set ntags [llength $marks]
+        set ntags_copy $ntags
         if {$ntags > $maxtags ||
             [totalwidth $marks mainfont $extra] > $maxwidth} {
             # show just a single "n tags..." tag
@@ -6678,6 +6703,9 @@ proc drawtags {id x xt y1} {
                    -font $font -tags [list tag.$id text]]
         if {$ntags >= 0} {
             $canv bind $t <1> $tagclick
+            if {$ntags_copy < $maxtags} {
+              $canv bind $t $ctxbut [list tagmenu %X %Y $id $tag_quoted]
+            }
         } elseif {$nheads >= 0} {
             $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
         }
@@ -9531,6 +9559,57 @@ proc mkbranch {} {
     branchdia $top val ui
 }
 
+proc mvtag {} {
+    global NS
+    global tagmenuid tagmenutag
+
+    set top .tagdialog
+
+    set val(name) $tagmenutag
+    set val(id) $tagmenuid
+    set val(command) [list mvtaggo $top $tagmenutag]
+
+    set ui(title) [mc "Rename tag %s" $tagmenutag]
+    set ui(accept) [mc "Rename"]
+
+    tagdia $top val ui
+}
+
+proc tagdia {top valvar uivar} {
+    global NS commitinfo
+    upvar $valvar val $uivar ui
+
+    catch {destroy $top}
+    ttk_toplevel $top
+    make_transient $top .
+    ${NS}::label $top.title -text $ui(title)
+    grid $top.title - -pady 10
+    ${NS}::label $top.id -text [mc "ID:"]
+    ${NS}::entry $top.sha1 -width 40
+    $top.sha1 insert 0 $val(id)
+    $top.sha1 conf -state readonly
+    grid $top.id $top.sha1 -sticky w
+    ${NS}::entry $top.head -width 60
+    $top.head insert 0 [lindex $commitinfo($val(id)) 0]
+    $top.head conf -state readonly
+    grid x $top.head -sticky ew
+    grid columnconfigure $top 1 -weight 1
+    ${NS}::label $top.nlab -text [mc "Name:"]
+    ${NS}::entry $top.name -width 40
+    $top.name insert 0 $val(name)
+    grid $top.nlab $top.name -sticky w
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.go -text $ui(accept) -command $val(command)
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command "catch {destroy $top}"
+    bind $top <Key-Return> $val(command)
+    bind $top <Key-Escape> "catch {destroy $top}"
+    grid $top.buts.go $top.buts.can
+    grid columnconfigure $top.buts 0 -weight 1 -uniform a
+    grid columnconfigure $top.buts 1 -weight 1 -uniform a
+    grid $top.buts - -pady 10 -sticky ew
+    focus $top.name
+}
+
 proc mvbranch {} {
     global NS
     global headmenuid headmenuhead
@@ -9582,6 +9661,44 @@ proc branchdia {top valvar uivar} {
     focus $top.name
 }
 
+proc mvtaggo {top prevname} {
+    global tagids idtags idheads mainhead mainheadid
+
+    set name [$top.name get]
+    set id [$top.sha1 get]
+    if {$name eq $prevname} {
+          catch {destroy $top}
+          return
+    }
+    if {$name eq {}} {
+      error_popup [mc "Please specify a new name for the tag"] $top
+      return
+    }
+    catch {destroy $top}
+    nowbusy renametag
+    update
+    if {[catch {
+        # NOTE: for an annotated tag, the new tag points to the old tag object
+        # where the old primary tag name is still recorded inside. Acceptable.
+        eval exec "git tag $name $prevname"
+        eval exec "git tag -d $prevname"
+        } err]} {
+        notbusy renametag
+        error_popup $err
+    } else {
+        notbusy renametag
+        removetag $id $prevname
+        removedtag $id $tag
+        set tagids($name) $id
+        lappend idtags($id) $name
+        addedtag $id
+        redrawtags $id
+        dispneartags 0
+        run refill_reflist
+    }
+
+}
+
 proc mkbrgo {top} {
     global headids idheads
 
@@ -9915,6 +10032,17 @@ proc headmenu {x y id head} {
     tk_popup $headctxmenu $x $y
 }
 
+# context menu for a tag
+proc tagmenu {x y id tag} {
+    global tagmenuid tagmenutag tagctxmenu mainhead
+
+    stopfinding
+    set tagmenuid $id
+    set tagmenutag $tag
+
+    tk_popup $tagctxmenu $x $y
+}
+
 proc cobranch {} {
     global headmenuid headmenuhead headids
     global showlocalchanges
@@ -10019,6 +10147,28 @@ proc rmbranch {} {
     run refill_reflist
 }
 
+proc rmtag {} {
+    global tagmenuid tagmenutag
+    global idtags
+
+    set tag $tagmenutag
+    set id $tagmenuid
+    if {![confirm_popup [mc "Really delete tag %s?" $tag]]} return
+    nowbusy rmtag
+    update
+    if {[catch {exec git tag -d $tag} err]} {
+        notbusy rmtag
+        error_popup $err
+        return
+    }
+    removetag $id $tag
+    removedtag $id $tag
+    redrawtags $id
+    notbusy rmtag
+    dispneartags 0
+    run refill_reflist
+}
+
 # Display a list of tags and heads
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor NS
@@ -11228,6 +11378,14 @@ proc addedtag {id} {
     unset -nocomplain cached_atags
 }
 
+proc removedtag {id tag} {
+    global cached_dtags cached_atags cached_tagcontent
+
+    unset -nocomplain cached_tagcontent
+    unset -nocomplain cached_dtags
+    unset -nocomplain cached_atags
+}
+
 proc addedhead {hid head} {
     global arcnos arcout cached_dheads
 

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
