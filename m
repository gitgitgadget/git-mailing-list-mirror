From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 4/4] format-patch: Add "--no-stat" as a synonym for "-p"
Date: Sat, 07 Nov 2009 10:58:55 +0100
Message-ID: <4AF544DF.6070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 10:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6i4W-0005It-Bt
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 10:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbZKGJ6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 04:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbZKGJ6x
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 04:58:53 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:51179 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZKGJ6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 04:58:52 -0500
Received: by ewy3 with SMTP id 3so1775074ewy.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=W3D20I8m+16y0/CUNE120s5GFKBkQd8pQyhEShUbfDA=;
        b=jG8mnkFjfjBLjfhQ0k1IrpzklB1YScQpC82g4tNNqZ7TRCohyw66WSr5Q1W+dq8V3q
         Vs+6+HDnV3MWhuk8MFWZ5j1IonOsXkFcOkgYEzseR5JRJazoPnDlk1P1VYOLDqcjlBoP
         CiQbSz2LWbwmQ9I5p6mXhBKeqBwQ1T/jnylmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=pKooeFEqSL09o3adhDLJ/LQTrh8INs7XRrmOzpf39vY5V/4hHyFGpT3lhCKYG9SABF
         wCpRSaN4mbfsyN9o4l4ep9heknTQtdzwplsQkBoIz25xyndvUMNqfHqnKTlOrfHU8fyM
         Xca5EznB/kaSl0Z47ADBMa7IGG++zdQApiEuE=
Received: by 10.213.110.4 with SMTP id l4mr518142ebp.81.1257587936978;
        Sat, 07 Nov 2009 01:58:56 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm840411eyz.11.2009.11.07.01.58.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 01:58:56 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132358>

"-p" means "generate patch" in 'git log' and 'git diff', so it's
quite surprising that it means "suppress diffstat" in
'git format-patch'.

Keep the "-p" option for backward compatibility, but add
"--no-stat" as a more intuitive synonym. For backward compatibility
with scripts, we must allow combinations of --stat and --no-stat.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
This patch is new.

Unfortunately, we must allow --no-stat and --stat (or alternatively
complicate the implementation to allow -p and --stat, but not
--no-stat and --stat). If that seems too strange, perhaps we are
better off without this patch.

 Documentation/diff-options.txt |    1 +
 builtin-log.c                  |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 9398329..c4d65ba 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -14,6 +14,7 @@ endif::git-format-patch[]
=20
 ifdef::git-format-patch[]
 -p::
+--no-stat
 	Generate plain patches without any diffstats.
 endif::git-format-patch[]
=20
diff --git a/builtin-log.c b/builtin-log.c
index 9df8dac..968a038 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -925,7 +925,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			"show patch format instead of default (patch + stat)"),
 		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
 			    "don't include a patch matching a commit upstream"),
-		OPT_BOOLEAN('p', NULL, &use_patch_format,
+		OPT_BOOLEAN('p', "no-stat", &use_patch_format,
 			"show patch format instead of default (patch + stat)"),
 		OPT_GROUP("Messaging"),
 		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
--=20
1.6.5.1.69.g36942
