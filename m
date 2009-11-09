From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/24] Show usage string for 'git check-ref-format -h'
Date: Mon,  9 Nov 2009 09:04:48 -0600
Message-ID: <1257779104-23884-8-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vfm-000393-P7
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbZKIOzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZKIOzU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:20 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbZKIOzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:18 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=D9XsFr5oyru0qSUtW6jIcpb9JocM4WaNlryfFj1eQUM=;
        b=std9cxFHPN7cdY0rLkaYEuKoxTmFNCilO8oqE6rOfCsdNjEt3vT2V1q3SfnGTqUbdn
         tFflg97KNBTJp1U8kvzB8XdF77o413TkOJIXkUfandx41ngwWYwErP274IwfLAbKHsXC
         RGmMp3thxDCZtprjbtSliob16DkVYgxIDW/WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MIlZStlj5/NKefz+Ds1CN284H+iVFzws7yY2TPbRvNaQvev0a5OXIdWTC2qW0xE4pE
         kKnRX1IppEGnmPZmaiJfg/iPhgvKhU/W9ApsqxkEQMKTfCx7fNVcCbpHIaYjh6IModT1
         8XCa+q8X1VZ+1wfyezcDe6bku13KeZJp/u23w=
Received: by 10.216.90.198 with SMTP id e48mr280666wef.188.1257778523452;
        Mon, 09 Nov 2009 06:55:23 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:22 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132484>

This only changes the behavior of "git check-ref-format -h"
without any other options and arguments.

This change cannot be breaking backward compatibility, since any
valid refname must contain a /.   Most existing scripts use
arguments such as "heads/$foo".  If some script checks the
refname "-h" alone, git check-ref-format will still exit with
nonzero status, and the only detrimental side-effect will be a
usage string sent to stderr.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-check-ref-format.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 513f134..b106c65 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -35,6 +35,9 @@ static void collapse_slashes(char *dst, const char *src)
 
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(builtin_check_ref_format_usage);
+
 	if (argc == 3 && !strcmp(argv[1], "--branch")) {
 		struct strbuf sb = STRBUF_INIT;
 
-- 
1.6.5.2
