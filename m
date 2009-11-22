From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Fix truncated usage messages
Date: Sun, 22 Nov 2009 22:19:53 +0100
Message-ID: <4B09AAF9.5000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 22:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCJqj-0006NQ-Uf
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 22:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbZKVVTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 16:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbZKVVTu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 16:19:50 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39935 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbZKVVTt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 16:19:49 -0500
Received: by ewy19 with SMTP id 19so1265961ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=F/koeU0sPGb2hem5wpfyhF1bjzjEZej+RjDnxJpalrs=;
        b=iUDge23JsiE8mhtHuTvEHCl54AMkMxhRolemkQI5m/Yo268TMdOFudlUiCLWC4yvbt
         5fqG9c1+3/pGHv9mTx07PDwM5S4TWQRvrqsqrdsUjrg6gu4KSDzTJ1eHgbYhCeHyhEia
         zzF6Q334TLL909LxZ7MohLVyvcy8zUzz8amdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=bHRTeEOxa8glJ/AyEpZInfIKRgYwQWGe20FgTQYJq40mMI7ZFgC4Y2nya2IXH6TZab
         ywG5nkV463f1yhbeqhSRooyj/jJwdgoKZM8AVjvT9IovnjSzWW99KxCEhKGB4GsknhBZ
         NPVTxvt2MCRS29Z9v5GxrWJS1+w1Y9MsxI3cE=
Received: by 10.213.0.142 with SMTP id 14mr3939339ebb.49.1258924795109;
        Sun, 22 Nov 2009 13:19:55 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm889197eyg.4.2009.11.22.13.19.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 13:19:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133456>

The usage messages for some commands (such as 'git diff-tree')
are truncated because they don't fit in a fixed buffer of
1024 bytes.

It would be tempting to eliminate the buffer and the problem once
and for all by doing the output in three steps, but doing so could
(according to commit d048a96e) increase the likelyhood of messing
up the display.

So we just increase the size of the buffer.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 usage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/usage.c b/usage.c
index e307e01..79856a2 100644
--- a/usage.c
+++ b/usage.c
@@ -7,7 +7,7 @@
=20
 static void report(const char *prefix, const char *err, va_list params=
)
 {
-	char msg[1024];
+	char msg[4096];
 	vsnprintf(msg, sizeof(msg), err, params);
 	fprintf(stderr, "%s%s\n", prefix, msg);
 }
--=20
1.6.5.3.298.g39add
