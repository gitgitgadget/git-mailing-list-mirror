From: Brandon Turner <bt@brandonturner.net>
Subject: [PATCH v4] completion: ignore chpwd_functions when cding on zsh
Date: Thu,  9 Oct 2014 14:01:38 -0500
Message-ID: <1412881298-64117-1-git-send-email-bt@brandonturner.net>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Turner <bt@brandonturner.net>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:02:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcIyq-0008Fq-4B
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbaJITCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 15:02:23 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54915 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbaJITCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:02:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so267161pad.25
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wF0r1IOn2b3zTNTsPkPeiQ5SBQhXr5jXyqFmSDlNJUc=;
        b=VsZTIEQgHsBv6rRRzL46Q9NkIGmh4bmFOslvF9HsBZW9sQRcntL9im+8hgSdG8V7Jq
         5lIlwVgeKoSDYC2YXdvOzIs/QwMzJsJjXn66ed6EiSUv2Hmy65qw48FvHjKeLwsCfsdz
         OHitaBxIvHasaxpenuO4LBLvRJGaoidy0v8uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=wF0r1IOn2b3zTNTsPkPeiQ5SBQhXr5jXyqFmSDlNJUc=;
        b=ft9gyODHh8t3ZnImX5JxCUXc5ViFtQ5+F6FgzhX7/xMxAq6NDVU4Th8WUilsgex/5Z
         BblhttQT79sUJLF0jj9idZKdHgllgEnMm89nWV6TuxnCmlAhhTCgvqpsoCE2oq9oaJEt
         NUdzYe0UC1fWCu6X8IFa8c0HtPWoq332nk6cw9so/m9o5dTryHMi1ICS8QweM5iyuaOr
         ZwdWxCAfeCI2LfZ2UpudNjR24s5xG4T9xS74dB/QMm++IphEmjn/dcPvEpGpw6E0eFhM
         q7R+mb09NxxXBKd5oirloUMI9RbljZTacxx2yFoKfAW/tpcFYNvu4NbZTe8QgpWNP702
         YVBw==
X-Gm-Message-State: ALoCoQmsC0/79muKlzEBCi6i/FwCcjOzdFwXAV+CuXDZl0xazjmoV6j0CwzQQ6LK+zMqJRAWaLEb
X-Received: by 10.66.157.73 with SMTP id wk9mr1435863pab.101.1412881341906;
        Thu, 09 Oct 2014 12:02:21 -0700 (PDT)
Received: from aus-mac-1035.aus.rapid7.com ([128.177.65.10])
        by mx.google.com with ESMTPSA id c8sm1340979pat.6.2014.10.09.12.02.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 12:02:21 -0700 (PDT)
X-Mailer: git-send-email 2.1.2
In-Reply-To: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Software, such as RVM (ruby version manager), may set chpwd functions
that result in an endless loop when cding.  chpwd functions should be
ignored.

As I've only seen this so far on ZSH, I'm applying this change only to
the git-completion.zsh overrides.

Signed-off-by: Brandon Turner <bt@brandonturner.net>
---
As =C3=98ystein pointed out, on zsh we can use "cd -q" to ignore
chpwd_functions.

Junio - from my testing, unsetting CDPATH is sufficient on zsh.

 contrib/completion/git-completion.zsh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion=
/git-completion.zsh
index 9f6f0fa..04ed348 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -93,6 +93,20 @@ __gitcomp_file ()
 	compadd -Q -p "${2-}" -f -- ${=3D1} && _ret=3D0
 }
=20
+__git_ls_files_helper ()
+{
+	(
+		test -n "${CDPATH+set}" && unset CDPATH
+		cd -q "$1"
+		if [ "$2" =3D=3D "--committable" ]; then
+			git diff-index --name-only --relative HEAD
+		else
+			# NOTE: $2 is not quoted in order to support multiple options
+			git ls-files --exclude-standard $2
+		fi
+	) 2>/dev/null
+}
+
 __git_zsh_bash_func ()
 {
 	emulate -L ksh
--=20
2.1.2
