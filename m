From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] completion: use specified file (if any) when completing config vars
Date: Wed,  6 May 2009 23:18:13 -0700
Message-ID: <1241677093-29937-2-git-send-email-bebarino@gmail.com>
References: <1241676906-29783-1-git-send-email-bebarino@gmail.com>
 <1241677093-29937-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 07 08:19:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wwt-0007GG-CE
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 08:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbZEGGSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 02:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbZEGGSs
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 02:18:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:12999 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZEGGSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 02:18:46 -0400
Received: by rv-out-0506.google.com with SMTP id f9so453669rvb.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=az8/qKwAZFHvybklL+oBWF8fFoTDgLsc1KqkIOtyE58=;
        b=v0Pbfzzp2yDzvm8jR8A3Hi9lm+yXo4pFUqwi0wk5oABs08TX2VA1zao4mPhRhhl/bA
         cK634jBk8wUaAt3nSg8jp+RrQ43q/Sy+zlFbIriOFcp6af5Q37B6ln0tUwc8JoO8Jchi
         3cB2lyGGa9mFIySnnb+yOxIFiiHRDTrU3Vj98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l+IHylxISZlBDVuQyr8jVslk+yQoGxp2cED6fAYNAFGtrCEZD9+aK/nZtfsXv77p/w
         PTNjZE49LQdok+yDYorMx7+dzTHScdr1nhoBv0zmWo64CjvdvMAvv4Hg/At5jQejjHTz
         Om240uMjrIFshwdLngPzgsEgngFMgDN0NtZHA=
Received: by 10.114.125.15 with SMTP id x15mr2028283wac.217.1241677126061;
        Wed, 06 May 2009 23:18:46 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id j26sm14352165waf.11.2009.05.06.23.18.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 23:18:44 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 06 May 2009 23:18:41 -0700
X-Mailer: git-send-email 1.6.3.rc4.29.g8146
In-Reply-To: <1241677093-29937-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118431>

Only list the variables that can actually be affected by the command by
searching the arguments for a config file setting.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f179cc8..8a9863b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1349,7 +1349,10 @@ _git_send_email ()
 
 __git_config_get_set_variables ()
 {
-	for i in $(git --git-dir="$(__gitdir)" config --list); do
+	local args="--global --system --file= -f"
+	local config_file="$(__git_find_argument_and_value "$args")"
+	for i in $(git --git-dir="$(__gitdir)" config $config_file --list \
+			2>/dev/null); do
 		case "$i" in
 		*.*)
 			echo "${i/=*/}"
-- 
1.6.3.rc4.29.g8146
