Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB34C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9614423119
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMEnM+bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgHFRLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgHFRKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D37C008682
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:27:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so10101146wma.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rDLpynCOw0uTsaC5iumYy4EhRHQkQOjPr2gond9T0bE=;
        b=kMEnM+buDqtktbrpUwVp9mCLIDxbsIRLQWzlgHMhLQTkq/fVjGdR0LFTGhnqti9/WS
         o84vfI0ide+i7FJ7Z+E96qPuQ2CUR4hnBpYlqOzXm0NT64qb5JB/Q/q6Z1STD7VMNZu/
         kYPrjF6omlujS6Lrnt9Cx3xH2okC9N7IxDzNQY674/T3l8DcO8y8JJYGNMLipA/94A4v
         ivCcuCTOvOXKasRtSpyT2RbSXzwNXvYKKOEJpe7oYI6leVXBlzII0wP/V/f6SSI37NSM
         bOIfUkfvhfBw0OSN3BmLtP85aWNiMJdLPPg8tZ0DnxbYnnMIvJLdBm66iHxwUr27obDa
         nnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rDLpynCOw0uTsaC5iumYy4EhRHQkQOjPr2gond9T0bE=;
        b=SidzRGCb5MuoY8Sa/BsGABp/SAZB6r2rEaNviazPALusBRAbbQ96FTvB3Dmk5Ill1s
         nNv8ocFjlOVYN+7fDPbg7R3tBbhaLQ3NbVuSa4EA/oB6bkGw0kyuvd8nGnBlYf0xsK2i
         EFsVQPEpgr7EI8yqj+zR55eJ1H2UGmrVnWZ+2+lHyHEMpMLt47Y1vQ9TzNYotcBhW2oP
         VGIpc7kg7lS0aH6PywBkTYaYMqzyrgILxcnC0YNOlxcB0iZhAiREBlDadrfr8JneAZYN
         XpyRtyMFVE3+/Fc/R1PYeR7zhqNpCklWOWI0Whv1F+oZz+o+aY0aJVdRCPi+Mg9D09//
         7uIA==
X-Gm-Message-State: AOAM5306M6LVCu9w0rpsZQUebk7MfbPF2pLmUPBqtNTyzvI2eefblLp+
        StfYgLr0rDjRJhaMxD/Ttg0AaiYw
X-Google-Smtp-Source: ABdhPJwiy0QsvonfzBnr57lC/rQbpJoqp66a+56VeiNA6jFAvQuzam/MgcHE89Vteh0meZk9r5tBUg==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr8890736wmt.26.1596727674644;
        Thu, 06 Aug 2020 08:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm6707534wma.44.2020.08.06.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:27:54 -0700 (PDT)
Message-Id: <pull.693.v2.git.1596727673.gitgitgadget@gmail.com>
In-Reply-To: <pull.693.git.1596634463.gitgitgadget@gmail.com>
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
From:   "Marco Trevisan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:27:51 +0000
Subject: [PATCH v2 0/2] mergetool-lib: Don't use deprecated variable to detect GNOME
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To list merge tool candidates we used to use a private GNOME env variable (
GNOME_DESKTOP_SESSION_ID) that has been deprecated for long time ago and
removed as part of GNOME 3.30.0 release [1].

So replace this using XDG_CURRENT_DESKTOP instead, and cleanup the code to
avoid duplication and supporting KDE's kdiff3 better.

[1] https://gitlab.gnome.org/GNOME/gnome-session/-/commit/00e0e6226371d53f65

Marco Trevisan (Treviño) (2):
  mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
  mergetool-lib: give kdiff3 priority in KDE environments

 git-mergetool--lib.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)


base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-693%2F3v1n0%2Fdesktop-envs-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-693/3v1n0/desktop-envs-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/693

Range-diff vs v1:

 1:  66a026ae67 ! 1:  26b25b0d65 mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
     @@ Commit message
          variable (GNOME_DESKTOP_SESSION_ID) that has been deprecated for long time ago
          and removed as part of GNOME 3.30.0 release [1].
      
     -    So, git should instead check the XDG_CURRENT_DESKTOP env variable, that
     -    is supported by all the desktop environments.
     +    So, git should instead primarily check the XDG_CURRENT_DESKTOP env variable,
     +    that is now supported by all the desktop environments.
      
          Since the variable is actually a colon-separated list of names that the current
     -    desktop is known as, we need to go through all the values to ensure
     -    we're using GNOME.
     +    desktop is known as, we need to check if the value is set if we're using GNOME.
      
          [1] https://gitlab.gnome.org/GNOME/gnome-session/-/commit/00e0e6226371d53f65
      
     @@ git-mergetool--lib.sh: run_merge_cmd () {
       }
       
      +is_desktop () {
     -+	IFS=':'
     -+	for desktop in ${XDG_CURRENT_DESKTOP}
     -+	do
     -+		if test "$desktop" = "$1"
     -+		then
     -+			return 0
     -+		fi
     -+	done
     -+
     -+	return 1
     ++	case ":$XDG_CURRENT_DESKTOP:" in
     ++	*:$1:*)
     ++		return 0
     ++		;;
     ++	*)
     ++		return 1
     ++		;;
     ++	esac
      +}
      +
       list_merge_tool_candidates () {
     @@ git-mergetool--lib.sh: list_merge_tool_candidates () {
       	if test -n "$DISPLAY"
       	then
      -		if test -n "$GNOME_DESKTOP_SESSION_ID"
     -+		if is_desktop "GNOME"
     ++		if is_desktop "GNOME" || test -n "$GNOME_DESKTOP_SESSION_ID"
       		then
       			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
       		else
 2:  fc0d2b103e < -:  ---------- mergetool-lib: keep a list of cross desktop merge tools
 3:  37090d2322 ! 2:  c18a5edf50 mergetool-lib: give kdiff3 prioirty in KDE environments
     @@ Metadata
      Author: Marco Trevisan (Treviño) <mail@3v1n0.net>
      
       ## Commit message ##
     -    mergetool-lib: give kdiff3 prioirty in KDE environments
     +    mergetool-lib: give kdiff3 priority in KDE environments
      
          Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
      
       ## git-mergetool--lib.sh ##
      @@ git-mergetool--lib.sh: list_merge_tool_candidates () {
     - 	fi
     - 	if test -n "$DISPLAY"
     - 	then
     --		cross_desktop_tools="opendiff kdiff3 tkdiff xxdiff"
     -+		cross_desktop_tools="opendiff tkdiff xxdiff"
     - 		if is_desktop "GNOME"
     + 		if is_desktop "GNOME" || test -n "$GNOME_DESKTOP_SESSION_ID"
       		then
     --			tools="meld $cross_desktop_tools $tools"
     -+			tools="meld $cross_desktop_tools kdiff3 $tools"
     -+		elif is_desktop "KDE"
     + 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
     ++		elif is_desktop "KDE" || test x"$KDE_FULL_SESSION" = x"true"
      +		then
     -+			tools="kdiff3 $cross_desktop_tools meld $tools"
     ++			tools="kdiff3 opendiff tkdiff xxdiff meld $tools"
       		else
     --			tools="$cross_desktop_tools meld $tools"
     -+			tools="$cross_desktop_tools kdiff3 meld $tools"
     + 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
       		fi
     - 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
     - 		tools="$tools p4merge araxis bc codecompare"

-- 
gitgitgadget
