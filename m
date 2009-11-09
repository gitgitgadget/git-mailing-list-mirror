From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/24] Show usage string for 'git grep -h'
Date: Mon,  9 Nov 2009 09:04:42 -0600
Message-ID: <1257779104-23884-2-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VeJ-0002K4-5q
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbZKIOzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZKIOzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:09 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbZKIOzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:06 -0500
Received: by ewy3 with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=g8kkskUSvgqPVA4Z6swNxfe/VDIrJVlfKoswzDMuQqI=;
        b=pwEqJl+lDyB4z/CWpUiJu+z/Y27K5UPd/9UAMvJjeDfe1Ujv63ud0Mb2MqT7MZ38Es
         fNa48OhJoZY6Hg2S4BBezrih9OTz5IYP9rC5V1m/VC4RLhXjXz8/Di4bBdfm7IjQMK9I
         0prQX7LZFxtVGK6gKzfy+sEDC8MG8Y/KImPok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dO2R7ss0TSR79EhhSNzpyRJLsCezsng/nMN6GU34bzvrbMWnV9GtBrf44niU+2lEKV
         TcfasyDngxQWgYUIUAw7FCPAfxBie2CdP9lkBuSm6NP3sCWX1FjqMGNmU/vOC7+etAcv
         hdTPdLXtOa8gRQ3vARDSJVWj3wsPTFGLIEqvQ=
Received: by 10.216.87.11 with SMTP id x11mr2547010wee.16.1257778510776;
        Mon, 09 Nov 2009 06:55:10 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:09 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132464>

Clarification: the following description only talks about "git
grep -h" without any other options and arguments.

Such a change cannot be breaking backward compatibility.  "grep
-h" cannot be asking for suppressing filenames, as there is no
match pattern specified.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-grep.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 1df25b0..01be9bf 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -788,6 +788,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	/*
+	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
+	 * to show usage information and exit.
+	 */
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(grep_usage, options);
+
 	memset(&opt, 0, sizeof(opt));
 	opt.prefix = prefix;
 	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
-- 
1.6.5.2
