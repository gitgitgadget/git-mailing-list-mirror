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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B677C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE6F64DD6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 08:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhBDISz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 03:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbhBDISx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 03:18:53 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99925C061573
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 00:18:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z6so2351208wrq.10
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 00:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/RwMzoFf9LcG898idLRefQOxEzK4VIlZ6L82MtTUi7I=;
        b=ne6LgzGocSmXIukkQaDKdwzI1FES8yee5tsv3d4gdyTjyOGp/UekS1D87G3QrIIH0y
         pHFBKNVB6ACj/H2aZcDaj92NWy3wjopDhOimRhY8uqMZIn8MkOekMeh+d8iz878nWtDe
         st1Z64bM3Q4rvQAU3bdEs6BIS/gF42UNbhY/K5oLIQkJPP8cxOKiiXW05clgN/+cDNqo
         usLGI6U4aYz2H3i4+A81P9GkokmqQUi2PyjN1JoNzBwQu+yZzjF1Nj8lV4BLjVrgZ/si
         weddQpxsUiFLU2P6R+8+PiawdXwqu6prUEafoEfbFcdfL8TMi57iiJX6gd04zVRHEv/x
         uReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/RwMzoFf9LcG898idLRefQOxEzK4VIlZ6L82MtTUi7I=;
        b=Q20BrGKO3rZEddb8XKi15hfEONx61My4O5M25WBeDZDVl0zI14U3gcYT5stljjsKzB
         Whwj2JuFYTP5qeCN3oU3Il9u8qdOnpLnHFrgTLPDviAbe2fMtn/Qgbaoiy89ZEp2UJ8B
         FJWdqeZDzk6drYXzcxg/7VDhorPG89hDG9Xf70w/lZqdmaC4kVZzqVzGQ7Y3xV5KE2Gy
         p+lVe+xlbABijPop8ai+YSwd/vHujD7MapesALL6srmWalZXjLQomTV+pFYugzvPC/s4
         /d1GULVTsuMkwhlu+AkYJWhvaRoskYoN4BFK6QPMhMl6UsDQLNyod2w2xmyjzAjYHCD9
         aDqg==
X-Gm-Message-State: AOAM531206BF5DRzecAvbALZuXbyYL2xrkKl8873umoGXfG+yGRHr+VN
        +aFHr0ccz0iljdprh2S9Xh1/CCHtzyo=
X-Google-Smtp-Source: ABdhPJxsm8Hd3xSvcGUoshEB9lAubzrjYmX0GZjhSUcHgS7qu/kPO3zu7NbMopVXq5QenSqAjrItpw==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr7860925wrw.399.1612426691140;
        Thu, 04 Feb 2021 00:18:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm6984960wrr.56.2021.02.04.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:18:10 -0800 (PST)
Message-Id: <pull.866.git.1612426689172.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 08:18:08 +0000
Subject: [PATCH] [RFC] gitk: tag add right click options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
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

But now I may need a little help:
after we successfully deleted or modified the tag,the content
show on gitk has not changed, and I am stuck here.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [RFC] gitk: tag add right click options
    
    This patch want to fix: https://github.com/gitgitgadget/git/issues/855
    
    We can provide for right-clicking the tag icon in gitk Rename this tag",
    "Remove this tag", "Copy tag name" function.
    
    For convenience, only the tags on the branch with the number of tags <=3
    are processed temporarily.
    
    Now I may need a little help: after we successfully deleted or modified
    the tag name,the content show on gitk has not changed, and I am stuck
    here.
    
    In addition,I just learned part of the syntax of the tcl/tk language,
    and there may be some bad uses in my patch.
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-866%2Fadlternative%2Fgitk_tag_new_opt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-866/adlternative/gitk_tag_new_opt-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/866

 gitk-git/gitk | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d0..f69834d52785 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1874,6 +1874,28 @@ proc removehead {id name} {
     unset headids($name)
 }
 
+proc movetag {id name} {
+    global tagids idtags
+
+    removetag $tagids($name) $name
+    set tagids($name) $id
+    lappend idtags($id) $name
+}
+
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
@@ -2077,6 +2099,7 @@ proc makewindow {} {
     global filesepbgcolor filesepfgcolor
     global mergecolors foundbgcolor currentsearchhitbgcolor
     global headctxmenu progresscanv progressitem progresscoords statusw
+    global tagctxmenu
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
     global have_tk85 use_ttk NS
@@ -2685,6 +2708,14 @@ proc makewindow {} {
     }
     $headctxmenu configure -tearoff 0
 
+    set tagctxmenu .tagctxmenu
+    makemenu $tagctxmenu {
+        {mc "Rename this tag" command mvtag}
+        {mc "Remove this tag" command rmtag}
+        {mc "Copy tag name" command {clipboard clear; clipboard append $tagmenutag}}
+    }
+    $tagctxmenu configure -tearoff 0
+
     global flist_menu
     set flist_menu .flistctxmenu
     makemenu $flist_menu {
@@ -6581,6 +6612,7 @@ proc drawtags {id x xt y1} {
 
     set marks {}
     set ntags 0
+    set ntags_copy 0
     set nheads 0
     set singletag 0
     set maxtags 3
@@ -6592,6 +6624,7 @@ proc drawtags {id x xt y1} {
     if {[info exists idtags($id)]} {
         set marks $idtags($id)
         set ntags [llength $marks]
+        set ntags_copy $ntags
         if {$ntags > $maxtags ||
             [totalwidth $marks mainfont $extra] > $maxwidth} {
             # show just a single "n tags..." tag
@@ -6678,6 +6711,9 @@ proc drawtags {id x xt y1} {
                    -font $font -tags [list tag.$id text]]
         if {$ntags >= 0} {
             $canv bind $t <1> $tagclick
+            if {$ntags_copy < $maxtags} {
+              $canv bind $t $ctxbut [list tagmenu %X %Y $id $tag_quoted]
+            }
         } elseif {$nheads >= 0} {
             $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
         }
@@ -9531,6 +9567,57 @@ proc mkbranch {} {
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
+    set val(command) [list mvtago $top $tagmenutag]
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
@@ -9582,6 +9669,38 @@ proc branchdia {top valvar uivar} {
     focus $top.name
 }
 
+proc mvtago {top prevname} {
+    global tagids idheads mainhead mainheadid
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
+        eval exec "git tag $name $prevname"
+        eval exec "git tag -d $prevname"
+    } err]} {
+        notbusy renametag
+        error_popup $err
+    } else {
+        notbusy renametag
+        removetag $id $prevname
+        set tagids($name) $id
+        lappend idtags($id) $name
+        run refill_reflist
+    }
+
+}
+
 proc mkbrgo {top} {
     global headids idheads
 
@@ -9915,6 +10034,17 @@ proc headmenu {x y id head} {
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
@@ -10019,6 +10149,25 @@ proc rmbranch {} {
     run refill_reflist
 }
 
+proc rmtag {} {
+    global tagmenuid tagmenutag
+    global idtags
+
+    set tag $tagmenutag
+    set id $tagmenuid
+
+    nowbusy rmtag
+    update
+    if {[catch {exec git tag -d $tag} err]} {
+        notbusy rmtag
+        error_popup $err
+        return
+    }
+    removetag $id $tag
+    notbusy rmtag
+    run refill_reflist
+}
+
 # Display a list of tags and heads
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor NS

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
