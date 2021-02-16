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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC7FC433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C11664DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 13:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBPNyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 08:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBPNy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 08:54:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BDC06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 05:53:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a132so2766749wmc.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7KYqbIjvBJCT1Pz//m8lHU9nLfBSw3eCK8mhRowk3sQ=;
        b=Fxt/Kc3ja/XxmhL5o/ofzI3r5+cve73Tbu9ZHZtPfB5INqw5Lxm+FQQXPi6TW4BzVT
         dvFMor5Xd06agFjU0YVaACerYvMoqTUOFyHbBGLVP86OAO4Z0eVWppQrdzteo8kTzdt7
         AuW31K5X0RaQLjkLDihVdCf46DPOoyWuzxOxrSwEAAPR/6yvks7OINNF1BFUYwElOi22
         YrhE/a72oaNxZkOjbdCRjxMe9PsGEG9CMBCV94Eqc2bmqhHM+x02ldCbCB3pEsNrb8Se
         TA3YHwncMRM9Hg+ZGkjgdhKW5wwk88v1s0C5pdItL+IRQGuW3uWIIalGUlo2Wagi+JSk
         4f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7KYqbIjvBJCT1Pz//m8lHU9nLfBSw3eCK8mhRowk3sQ=;
        b=obghWLbpBlvY2DbAF8jx36bnsvhIo0oKIGJjiXVum6QUnU6yRKkBPapX16Qfz/ouPN
         99ycerF8o4DCDgW2ilmNnrZ1Tg0ewNVhJSWMnWeaHRW/c23sAvGGHMlWfwF4O7KG/c/a
         VbyqvW+jnpF7T1oiW7yQZ0/pqzNN+r9fLwWxzA6ZVfTDdcxituPADsM9wr/j8pAEHPar
         pXT07wSySsP7bW+DFC1W9jHz+YwiXEetZE7bq1rE2p3eOpXY76N/jdxWz5sW7Lm9BBe5
         MI47NyPqoPaEd41BaYcIgMHNEx/5NFovdy+C2anlE7IZUWa/vd70FkOFuJZI/uNaiYdX
         RXMg==
X-Gm-Message-State: AOAM530FvBm3gpMN09oNc/cfv8r502EEnB74cqagz+9L/bTZHeZA8G3H
        AoemaF3jNxi7oxUO5Xj22v6284HHHK8=
X-Google-Smtp-Source: ABdhPJxMGZvk6Ulf/cswpP8N68n4DsaSL8EZGvuGS2JAYVCOjaolM2q7QOlj1Ij/OLflsNeSgnfMeg==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr3472303wmb.21.1613483624219;
        Tue, 16 Feb 2021 05:53:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm27599239wrp.65.2021.02.16.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 05:53:43 -0800 (PST)
Message-Id: <pull.866.v2.git.1613483622881.gitgitgadget@gmail.com>
In-Reply-To: <pull.866.git.1612426689172.gitgitgadget@gmail.com>
References: <pull.866.git.1612426689172.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Feb 2021 13:53:42 +0000
Subject: [PATCH v2] gitk: tag add right click options
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-866%2Fadlternative%2Fgitk_tag_new_opt-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-866/adlternative/gitk_tag_new_opt-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/866

Range-diff vs v1:

 1:  b246cdf06d6e ! 1:  f3a5d7d3be9f [RFC] gitk: tag add right click options
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [RFC] gitk: tag add right click options
     +    gitk: tag add right click options
      
          In gitk, we can right-click on the icon of the branch,
          and a directory will pop up to provide us with functions
     @@ Commit message
          "Copy tag name" to right-click the tag icon. This function is
          temporarily supported work on the branch with <=3 tags.
      
     -    But now I may need a little help:
     -    after we successfully deleted or modified the tag,the content
     -    show on gitk has not changed, and I am stuck here.
     -
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## gitk-git/gitk ##
     @@ gitk-git/gitk: proc removehead {id name} {
           unset headids($name)
       }
       
     -+proc movetag {id name} {
     -+    global tagids idtags
     -+
     -+    removetag $tagids($name) $name
     -+    set tagids($name) $id
     -+    lappend idtags($id) $name
     -+}
     -+
      +proc removetag {id name} {
      +    global tagids idtags
      +
     @@ gitk-git/gitk: proc mkbranch {} {
      +
      +    set val(name) $tagmenutag
      +    set val(id) $tagmenuid
     -+    set val(command) [list mvtago $top $tagmenutag]
     ++    set val(command) [list mvtaggo $top $tagmenutag]
      +
      +    set ui(title) [mc "Rename tag %s" $tagmenutag]
      +    set ui(accept) [mc "Rename"]
     @@ gitk-git/gitk: proc branchdia {top valvar uivar} {
           focus $top.name
       }
       
     -+proc mvtago {top prevname} {
     -+    global tagids idheads mainhead mainheadid
     ++proc mvtaggo {top prevname} {
     ++    global tagids idtags idheads mainhead mainheadid
      +
      +    set name [$top.name get]
      +    set id [$top.sha1 get]
     @@ gitk-git/gitk: proc branchdia {top valvar uivar} {
      +    nowbusy renametag
      +    update
      +    if {[catch {
     ++        # NOTE: for an annotated tag, the new tag points to the old tag object
     ++        # where the old primary tag name is still recorded inside. Acceptable.
      +        eval exec "git tag $name $prevname"
      +        eval exec "git tag -d $prevname"
     -+    } err]} {
     ++        } err]} {
      +        notbusy renametag
      +        error_popup $err
      +    } else {
     @@ gitk-git/gitk: proc branchdia {top valvar uivar} {
      +        removetag $id $prevname
      +        set tagids($name) $id
      +        lappend idtags($id) $name
     ++        redrawtags $id
     ++        addedtag $id
     ++        dispneartags 0
      +        run refill_reflist
      +    }
      +
     @@ gitk-git/gitk: proc rmbranch {} {
      +        return
      +    }
      +    removetag $id $tag
     ++    redrawtags $id
      +    notbusy rmtag
      +    run refill_reflist
      +}


 gitk-git/gitk | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d0..7ff4b3603e98 100755
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
@@ -2685,6 +2700,14 @@ proc makewindow {} {
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
@@ -9582,6 +9661,43 @@ proc branchdia {top valvar uivar} {
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
+        set tagids($name) $id
+        lappend idtags($id) $name
+        redrawtags $id
+        addedtag $id
+        dispneartags 0
+        run refill_reflist
+    }
+
+}
+
 proc mkbrgo {top} {
     global headids idheads
 
@@ -9915,6 +10031,17 @@ proc headmenu {x y id head} {
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
@@ -10019,6 +10146,26 @@ proc rmbranch {} {
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
+    redrawtags $id
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
