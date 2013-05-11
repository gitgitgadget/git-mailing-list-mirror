From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] git-prompt.sh: colorize ZSH prompt
Date: Sat, 11 May 2013 18:06:48 -0500
Message-ID: <CAMP44s0QKGVzWohsbyN_7EdW1WxHvqDrjpuCykxNFkUKi=XKbA@mail.gmail.com>
References: <CAMP44s1pO+ytNWEV6ykRn671yf50+oMZQMnrcTN+s5ykPRpumg@mail.gmail.com>
	<1368310739-24099-1-git-send-email-artagnon@gmail.com>
	<CAMP44s1B+FfdKebpTq+AwHP3YCiiVc++rtc8wqOn8EOy1dyLwA@mail.gmail.com>
	<CALkWK0mySjW_QGObkXWvhzMa0gbwKDire4Dx9=PV+9OnEgZjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 01:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbIsR-0003KB-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 01:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab3EKXGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 19:06:50 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:53622 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab3EKXGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 19:06:49 -0400
Received: by mail-la0-f50.google.com with SMTP id dz20so1166159lab.23
        for <git@vger.kernel.org>; Sat, 11 May 2013 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=yK70mEhqaE7SOu6mQLBZyp/kvX6n+0BBZvzUa3CeEdM=;
        b=K6s6evAkscNQ4clLGsvFyoUG3FY/B7y69bL41j5NuTLJCKWJgcGV3nfESm1l1xSShN
         CQ00++u4If+h50IPHSpeCWjrLFl/GzP8RHiI02K+LfB33Afr6D7dTnoKrbOZRtPyBryR
         g1W+xtn7DPqzjGLH1uThx7puKay50BKD8KtbX+fuihuefxuPrgW16IA24v1OF6Z3qQAa
         NXfw8o0rMHV4/NmDszIdJ/MaJ692WYXal/GWstzFQcr+OCNXXTWHDp9ExwA/wsqi84Hw
         XW1kgZVUkhvogZrLZjiCTzY3Do9Pm6felYOpNK2u2y6pwbRScAybqeKyza9oCbdKyHbd
         aA2w==
X-Received: by 10.112.145.72 with SMTP id ss8mr10309714lbb.12.1368313608215;
 Sat, 11 May 2013 16:06:48 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 11 May 2013 16:06:48 -0700 (PDT)
In-Reply-To: <CALkWK0mySjW_QGObkXWvhzMa0gbwKDire4Dx9=PV+9OnEgZjsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224019>

On Sat, May 11, 2013 at 5:40 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Not really. If we need to avoid the \[\], it makes sense to have a
>> separate function, but what I meant is that this function should be
>> initially on the same file, and created in a separate patch.
>
> What are you saying?
>
> 1. It makes sense to have a separate function specifically for ZSH,
> but it should be located in the same physical file (why?)

This is what I mean:

commit 4726a5f76ec7d96c34863d6640488e2183cc8f00
Author: Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Sat May 11 21:55:13 2013 +0530

    prompt: split code into __git_ps1_colorize_gitstring()

    Will be useful for reorganizations.

    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..1187292 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -222,6 +222,45 @@ __git_ps1_show_upstream ()

 }

+__git_ps1_colorize_gitstring ()
+{
+	local c_red='\e[31m'
+	local c_green='\e[32m'
+	local c_lblue='\e[1;34m'
+	local c_clear='\e[0m'
+	local bad_color=$c_red
+	local ok_color=$c_green
+	local branch_color="$c_clear"
+	local flags_color="$c_lblue"
+	local branchstring="$c${b##refs/heads/}"
+
+	if [ $detached = no ]; then
+		branch_color="$ok_color"
+	else
+		branch_color="$bad_color"
+	fi
+
+	# Setting gitstring directly with \[ and \] around colors
+	# is necessary to prevent wrapping issues!
+	gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
+
+	if [ -n "$w$i$s$u$r$p" ]; then
+		gitstring="$gitstring "
+	fi
+	if [ "$w" = "*" ]; then
+		gitstring="$gitstring\[$bad_color\]$w"
+	fi
+	if [ -n "$i" ]; then
+		gitstring="$gitstring\[$ok_color\]$i"
+	fi
+	if [ -n "$s" ]; then
+		gitstring="$gitstring\[$flags_color\]$s"
+	fi
+	if [ -n "$u" ]; then
+		gitstring="$gitstring\[$bad_color\]$u"
+	fi
+	gitstring="$gitstring\[$c_clear\]$r$p"
+}

 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
@@ -363,42 +402,7 @@ __git_ps1 ()
 		if [ $pcmode = yes ]; then
 			local gitstring=
 			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-				local c_red='\e[31m'
-				local c_green='\e[32m'
-				local c_lblue='\e[1;34m'
-				local c_clear='\e[0m'
-				local bad_color=$c_red
-				local ok_color=$c_green
-				local branch_color="$c_clear"
-				local flags_color="$c_lblue"
-				local branchstring="$c${b##refs/heads/}"
-
-				if [ $detached = no ]; then
-					branch_color="$ok_color"
-				else
-					branch_color="$bad_color"
-				fi
-
-				# Setting gitstring directly with \[ and \] around colors
-				# is necessary to prevent wrapping issues!
-				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
-
-				if [ -n "$w$i$s$u$r$p" ]; then
-					gitstring="$gitstring "
-				fi
-				if [ "$w" = "*" ]; then
-					gitstring="$gitstring\[$bad_color\]$w"
-				fi
-				if [ -n "$i" ]; then
-					gitstring="$gitstring\[$ok_color\]$i"
-				fi
-				if [ -n "$s" ]; then
-					gitstring="$gitstring\[$flags_color\]$s"
-				fi
-				if [ -n "$u" ]; then
-					gitstring="$gitstring\[$bad_color\]$u"
-				fi
-				gitstring="$gitstring\[$c_clear\]$r$p"
+				__git_ps1_colorize_gitstring
 			else
 				gitstring="$c${b##refs/heads/}${f:+ $f}$r$p"
 			fi

commit 23d89b370ac36401da1d9a98754e222a7a4c93e5
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat May 11 18:03:39 2013 -0500

    prompt: add colorization for zsh

    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1187292..8946a29 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -224,6 +224,8 @@ __git_ps1_show_upstream ()

 __git_ps1_colorize_gitstring ()
 {
+	if [[ -z ${ZSH_VERSION-} ]]
+	then
 		local c_red='\e[31m'
 		local c_green='\e[32m'
 		local c_lblue='\e[1;34m'
@@ -260,6 +262,39 @@ __git_ps1_colorize_gitstring ()
 			gitstring="$gitstring\[$bad_color\]$u"
 		fi
 		gitstring="$gitstring\[$c_clear\]$r$p"
+	else
+		local c_red='%F{red}'
+		local c_green='%F{green}'
+		local c_lblue='%F{blue}'
+		local c_clear='%f'
+		local bad_color=$c_red
+		local ok_color=$c_green
+		local branch_color="$c_clear"
+		local flags_color="$c_lblue"
+		local branchstring="$c${b##refs/heads/}"
+
+		if [ $detached = no ]; then
+			branch_color="$ok_color"
+		else
+			branch_color="$bad_color"
+		fi
+
+		gitstring="$branch_color$branchstring$c_clear"
+
+		if [ "$w" = "*" ]; then
+			gitstring="$gitstring$bad_color$w"
+		fi
+		if [ -n "$i" ]; then
+			gitstring="$gitstring$ok_color$i"
+		fi
+		if [ -n "$s" ]; then
+			gitstring="$gitstring$flags_color$s"
+		fi
+		if [ -n "$u" ]; then
+			gitstring="$gitstring$bad_color$u"
+		fi
+		gitstring="$gitstring$c_clear$r$p"
+	fi
 }

 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)

-- 
Felipe Contreras
