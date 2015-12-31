From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: A failed attempt to integrate diff-highlight to the core
Date: Thu, 31 Dec 2015 19:37:30 +0700
Message-ID: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUO-0001CE-9y
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbLaMhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:37:48 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32776 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbLaMhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:37:45 -0500
Received: by mail-pf0-f179.google.com with SMTP id q63so119896169pfb.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=CJnmJBCIX9RegcWzPctutWt8RqDDVe9zqX9c3fdo1WE=;
        b=U9i5iY03dQNdKczZpSou8MuNqtqxr0Jk8zwomV/Hhh8ndNIhutwK8dBn8sRaCPRH8R
         jH7fIcRpAVQTboGGMqpnkPPfasiaJfBUtioTTcq56ezBRTHsetGsfu3I5EJqlHFeZKvj
         0fDQWt4G9jz/J1Ymcn6bgsckXDwQy42YO0fo7trdRYzGksWai1bHu7jwh6pftR5yqEY3
         bIkSIEB8OrFhKAVI+Xm2/R31QrPaRNOk8f3xkMRiUo2JIv3bVTIwrH6gEo0cuBT6rq4A
         5fqRNwlTn9SeufERXYhEVXwsNPWHCD2qvhpSjOAprCiPlTzHk2duvPpgi1p/VKi7nv73
         fN7w==
X-Received: by 10.98.73.21 with SMTP id w21mr82912452pfa.136.1451565464831;
        Thu, 31 Dec 2015 04:37:44 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id n62sm33761894pfa.14.2015.12.31.04.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:37:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:37:41 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283237>

This is mostly for the record. The patches are not as important as the
result in this mail. But if you want to try out, you can.

If you don't know, the script diff-highlight in contrib can highlight
changes between two nearly identical lines, pointing out what
characters are different. It can improve readability a lot in certain
cases (e.g. when you wrap _() around strings).

I approached it differently. I took --color-words and reformatted its
output in unified diff format. So you'll see +/- lines like a normal
diff, but deleted and added words are also highlighted.

The idea seems to fit well into diff-words machinery. But the output
does not, especially in cases where there are many deleted/added words
in a chunk. It could look.. patchy, like somebody throwing colors on a
wall (especially when you do --highlight-words=3D.). You can try out an=
d
see.  git-log works so you can see lots of diff.

I don't know, maybe the idea can be improved to have something closer
to diff-highlight. I suppose we can select similar lines and diff
them, instead of diff the entire chunk in one go. I might revisit it
at some point in future, but for now, it's a failure.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  diff.c: keep all word diff structs together
  diff.c: refactor diff_words_append()
  diff --color-words: another special diff case
  diff.c: refactor fn_out_diff_words_write_helper()
  diff: unified diff with colored words, step 1, unified diff only
  diff.c: add new arguments to emit_line_0()
  diff --highlight-words: actually highlight words

 diff.c | 400 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+-------
 diff.h |   3 +-
 2 files changed, 363 insertions(+), 40 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
