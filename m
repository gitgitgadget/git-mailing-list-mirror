Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB89EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 16:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGDQk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjGDQkY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 12:40:24 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 09:40:20 PDT
Received: from spamfilter1.renyi.hu (spamfilter1.renyi.hu [193.224.79.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41E1A1
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 09:40:20 -0700 (PDT)
Received-SPF: pass (spamfilter1.renyi.hu: domain of gilyen.andras@renyi.hu designates 193.224.79.19 as permitted sender) receiver=spamfilter1.renyi.hu; client-ip=193.224.79.19; helo=smtp.renyi.hu; envelope-from=gilyen.andras@renyi.hu; x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with libspf2-1.2.10;
Received: from smtp.renyi.hu (smtp.renyi.hu [193.224.79.19])
        by spamfilter1.renyi.hu (8.15.2/8.15.2/Debian-8) with ESMTPS id 364GWBJr008153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 18:32:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=renyi.mta.hu; s=dkim; h=Content-Transfer-Encoding:Content-Type:Subject:From
        :Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FnrWGrAzcS96/HeI8zFMZLvptiixclXv0P5uByRyZRA=; b=lvfH4Qmgv0fxhafRygQG3edn8y
        eId0PzzyMVA2wjk0KNvC78qQfbGqDaXoKTqnymoi6ewyuR4XIOd4JEVN36eogmiRBa6Sh6AsxGEkj
        4TraKb7sN6OIpzqqZhbObcO8IqnsArdqdmWrL1hmvjhF6/n/7WqTngzUfLxzgobDYyCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=renyi.hu;
         s=dkim; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FnrWGrAzcS96/HeI8zFMZLvptiixclXv0P5uByRyZRA=; b=MdfX6DmZ/0b7gLjUQQmZGP/wXj
        CdeUzh1kUsCLKlyAKlhGG8/jJOAMnRxW5iB7XAgBY/pJoL5RZCvhHdcBMVV98xU6FqW/TCFWQ0S2j
        ZfajID9j4TgNOtjzQUQjoTowOMSF6Hr8CsHiHcM96iV4Yk/xiESfqs5svGu/y/mSZoFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mta.renyi.hu; s=dkim; h=Content-Transfer-Encoding:Content-Type:Subject:From
        :Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FnrWGrAzcS96/HeI8zFMZLvptiixclXv0P5uByRyZRA=; b=MrE+PAS/ofVBzpaN6ZOTXOOTn8
        J9tNbSZ+adTabZPCclT9K98Sr/H+clQrrk2J+f1HidTF/nfenxwDI9uBBD1JhFRIxe6NwL82cCVUv
        gf5ON4JHfNlcxIRMqNMQTFEOYfsQzvEDkVpBFGCwEG+5hMVWg/bCamaCsN+2uSEMP3B4=;
Received: (Authenticated sender: gilyen)
        by smtp.renyi.hu with esmtpsa(TLSv1.3:TLS_AES_128_GCM_SHA256:128) (Exim)
        from <gilyen.andras@renyi.hu>id 1qGiwl-0002tA-CF; Tue, 04 Jul 2023 18:32:11 +0200
Message-ID: <eadd1834-6798-ac45-0940-3a955149c826@renyi.hu>
Date:   Tue, 4 Jul 2023 18:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sergey Vlasov <vsu@altlinux.ru>
From:   =?UTF-8?B?QW5kcsOhcyBHaWx5w6lu?= <gilyen.andras@renyi.hu>
Subject: [PATCH] gitk: new config options for wrapping and diff modes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.2 at spamfilter1
X-Virus-Status: Clean
X-Scanned-By: MIMEDefang 2.79 on 10.0.2.87
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using gitk for tracking changes in large text files,
which often have very long lines consisting of, e.g.,
a paragarph of an article, it is highly desirable to
wrap the lines in the diff view and also to set the
default diff mode to "Markup words" or "Color lines".

There is a configurable option "wrapcomment" to make the
comments wrap in gitk, and now an additional "wraplines"
option is introduced for warpping lines in the source files.
Similarly, an option "worddiffdefault" is introduced which
sets the default diff view mode to "Markup words" or
"Color lines". These options can be set by editing gitk's
configuration file. The default behaviours are unchanged.

The new options are documented in Documentation/gitk,
where the formerly undocumented feature "wrapcomment"
also got explained, which was introduced by Commit f1b8629453
([PATCH] gitk: Display commit messages with word wrap, 2006-05-15).

Suggested-by: Ailin Nemui <ailin.nemui@xxxxxxxxx>
(https://www.spinics.net/lists/git/msg274761.html )
Signed-off-by: András Gilyén <gilyen@renyi.hu>
---
  Documentation/gitk.txt | 26 ++++++++++++++++++++++++--
  gitk-git/gitk          | 36 ++++++++++++++++++++++--------------
  2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index d50e9ed10e..e0650db6da 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -161,10 +161,32 @@ If neither of the above exist then 
`$XDG_CONFIG_HOME/git/gitk` is created and
  used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
  `$HOME/.config` in all cases.

+The following are some options that are configurable by updating the 
contents
+of the above configuration file. To set an option to a specific value add a
+line containing "set <option> <value>".
+
+wrapcomment::
+
+	Describes whether the comment section of a commit should be displayed
+	with (word) wrapded lines or without any wrapping of the lines.
+	Vaild options are none (default setting) and word.
+
+wraplines::
+
+	Describes whether the source section in the gitk viewer should be 
displayed
+	with (word) wrapded lines or should be scrollaple with unwrapped lines.
+	Vaild options are none (default setting) and word.
+
+worddiffdefault::
+
+	Sets the default diff view mode for gitk. Valid options are:
+	lines -- for "Line diff" (default setting)
+	markup -- for "Markup words"
+	color -- for "Color words"
+
  History
  -------
-Gitk was the first graphical repository browser. It's written in
-tcl/tk.
+Gitk was the first graphical repository browser. It's written in tcl/tk.

  'gitk' is actually maintained as an independent project, but stable
  versions are distributed as part of the Git suite for the convenience
diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99..91dea9df73 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2089,7 +2089,7 @@ proc makewindow {} {
      global diffcontextstring diffcontext
      global ignorespace
      global maincursor textcursor curtextcursor
-    global rowctxmenu fakerowmenu mergemax wrapcomment
+    global rowctxmenu fakerowmenu mergemax wrapcomment wraplines
      global highlight_files gdttype
      global searchstring sstring
      global bgcolor fgcolor bglist fglist diffcolors diffbgcolors 
selectbgcolor
@@ -2101,7 +2101,7 @@ proc makewindow {} {
      global rprogitem rprogcoord rownumsel numcommits
      global have_tk85 use_ttk NS
      global git_version
-    global worddiff
+    global worddiff worddiffdefault

      # The "mc" arguments here are purely so that xgettext
      # sees the following string as needing to be translated
@@ -2420,7 +2420,13 @@ proc makewindow {} {
          -command changeignorespace -variable ignorespace
      pack .bleft.mid.ignspace -side left -padx 5

-    set worddiff [mc "Line diff"]
+    if {$worddiffdefault == "color" && [package vcompare $git_version 
"1.7.2"] >= 0} {
+        set worddiff [mc "Color words"]
+    } elseif {$worddiffdefault == "markup" && [package vcompare 
$git_version "1.7.2"] >= 0} {
+        set worddiff [mc "Markup words"]
+    } else {
+        set worddiff [mc "Line diff"]
+    }
      if {[package vcompare $git_version "1.7.2"] >= 0} {
          makedroplist .bleft.mid.worddiff worddiff [mc "Line diff"] \
              [mc "Markup words"] [mc "Color words"]
@@ -2431,7 +2437,7 @@ proc makewindow {} {
      set ctext .bleft.bottom.ctext
      text $ctext -background $bgcolor -foreground $fgcolor \
          -state disabled -undo 0 -font textfont \
-        -yscrollcommand scrolltext -wrap none \
+        -yscrollcommand scrolltext -wrap $wraplines \
          -xscrollcommand ".bleft.bottom.sbhorizontal set"
      if {$have_tk85} {
          $ctext conf -tabstyle wordprocessor
@@ -12392,6 +12398,7 @@ set downarrowlen 5
  set mingaplen 100
  set cmitmode "patch"
  set wrapcomment "none"
+set wraplines "none"
  set showneartags 1
  set hideremotes 0
  set maxrefs 20
@@ -12438,6 +12445,7 @@ set diffbgcolors {"#fff3f3" "#f0fff0"}
  set diffcontext 3
  set mergecolors {red blue "#00ff00" purple brown "#009090" magenta 
"#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" 
"#f0b070" "#ff70b0"}
  set ignorespace 0
+set worddiffdefault "line"
  set worddiff ""
  set markbgcolor "#e0e0ff"

@@ -12497,16 +12505,16 @@ config_check_tmp_exists 50

  set config_variables {
      mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
-    cmitmode wrapcomment autoselect autosellen showneartags maxrefs 
visiblerefs
-    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
-    bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors 
mergecolors
-    markbgcolor diffcontext selectbgcolor foundbgcolor 
currentsearchhitbgcolor
-    extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor
-    remotebgcolor tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
-    filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
-    linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
-    indexcirclecolor circlecolors linkfgcolor circleoutlinecolor 
diffbgcolors
-    web_browser
+    cmitmode wrapcomment wraplines worddiffdefault autoselect autosellen
+    showneartags maxrefs visiblerefs hideremotes showlocalchanges 
datetimeformat
+    limitdiffs uicolor want_ttk bgcolor fgcolor uifgcolor uifgdisabledcolor
+    colors diffcolors mergecolors markbgcolor diffcontext selectbgcolor
+    foundbgcolor currentsearchhitbgcolor extdifftool perfile_attrs
+    headbgcolor headfgcolor headoutlinecolor remotebgcolor tagbgcolor
+    tagfgcolor tagoutlinecolor reflinecolor filesepbgcolor filesepfgcolor
+    linehoverbgcolor linehoverfgcolor linehoveroutlinecolor 
mainheadcirclecolor
+    workingfilescirclecolor indexcirclecolor circlecolors linkfgcolor
+    circleoutlinecolor diffbgcolors web_browser
  }
  foreach var $config_variables {
      config_init_trace $var
-- 
2.34.1
