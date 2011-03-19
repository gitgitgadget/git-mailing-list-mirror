From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sun, 20 Mar 2011 00:32:47 +0800
Message-ID: <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com> <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:33:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0z5V-00032N-Pz
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab1CSQdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 12:33:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56713 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab1CSQdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 12:33:07 -0400
Received: by gwaa18 with SMTP id a18so1934683gwa.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Sv0SJp2yFhkOFjBQAEcq5vljp++EWmmHgljnJEuFOj8=;
        b=fpMTe1n8mNYs+VXF6sQbmxC7/boGwQAQ4d0OT+pbljCJJx5NiQIC2I+mFhK0B28h9i
         GZWMgv2mt8g2nirnsuao1Zn8RoDiIG+tEhLtGLvgQv4esEsGzPzT6hKIm+GQQWD2ZNR0
         nVqvhfxEu8x5r9fgx7gpClFJdqi0FmO4jzqRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VE93FPNVRa7LNoFOD+lc+o3jjwrJSrRFPCeHqUO445iOB8Meyw39cIbmcArt0iYp0U
         rWSxSoGcFrVrhyCQ/sY2j6vS9Hbw71h1/9QWOBfcxQ5p1+XQH2AX0YodjEyCZhpBDsyN
         byOtu2h38ZgfByT6C0danMbFOGTNzR1RB1KHQ=
Received: by 10.100.193.12 with SMTP id q12mr1829511anf.7.1300552387196; Sat,
 19 Mar 2011 09:33:07 -0700 (PDT)
Received: by 10.100.121.3 with HTTP; Sat, 19 Mar 2011 09:32:47 -0700 (PDT)
In-Reply-To: <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169447>

Thank you, Duy, you're almost right, I just checked git-sh-setup.sh,
in the bottom, sort and find are defined as functions like what you
pointed out, but only for MinGW, therefore a better fix is to check
for cygwin as well:

---
 git-sh-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aa16b83..5c52ae4 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -227,7 +227,7 @@ fi

 # Fix some commands on Windows
 case $(uname -s) in
-*MINGW*)
+*MINGW*|*CYGWIN*)
        # Windows has its own (incompatible) sort and find
        sort () {
                /usr/bin/sort "$@"
--
1.7.4
