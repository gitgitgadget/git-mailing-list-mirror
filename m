From: Jim Ramsay <i.am@jimramsay.com>
Subject: [PATCH] gitk: Decode the "-n" argument properly for Edit View
Date: Tue,  4 May 2010 11:05:39 -0400
Message-ID: <1272985539-24586-1-git-send-email-i.am@jimramsay.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 17:05:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Jh2-00040R-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861Ab0EDPFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 11:05:45 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:47992 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624Ab0EDPFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 11:05:44 -0400
Received: by qyk27 with SMTP id 27so8275753qyk.23
        for <git@vger.kernel.org>; Tue, 04 May 2010 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :message-id:x-mailer;
        bh=4f71ihlartnBPsHFSMUTIf+vPHktTfDWIH85voAh9PI=;
        b=SRQR7AxgK90HJaE9PqK3FrEYtBJaEAJFd0cy7IYxXcvngzH/UUUVKM/7MzMHCvvPiK
         jaWO+BM1wEGGyfTtSzwT0h48vGgkvh3OTu5eu/9z/nf9RWX32Dw0KGBNu7kyG8vywfgy
         uW4XwL2jfNQxIHUqzBg76bD46f5kSbSMfyJbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:message-id:x-mailer;
        b=HyxjzTm9tOg8HLFlfN53lCYHH8XbXWLdSv//44SbozbKqwLU8+6mNV7iqY99xZPlPk
         a+tZ5K8Y3F5wo7TwvykCANeDEDhkw8nxCjGMWfsBwUAKYQ253DNJs6yWUN92IPXhXcUd
         GT5huwQln3AoYuwkuDRpxsjBVsgwmw5Gotwcg=
Received: by 10.224.71.214 with SMTP id i22mr4367910qaj.248.1272985542371;
        Tue, 04 May 2010 08:05:42 -0700 (PDT)
Received: from vrm378-02 ([144.190.95.61])
        by mx.google.com with ESMTPS id 21sm3828413qyk.13.2010.05.04.08.05.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 08:05:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146314>

Running 'gitk -n 42' and selecting View > Edit View... would previously put the
'-n' half of the argument-pair in the box labeled "Additional arguments to git
log" and the '42' in "Branches & Tags".  Parse this pair properly and use the
numerical portion for the 'limit' value.

Signed-off-by: Jim Ramsay <i.am@jimramsay.com>
---
 gitk-git/gitk |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..f93e7e5 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3907,6 +3907,17 @@ proc decode_view_opts {n view_args} {
     set oargs [list]
     set refargs [list]
     foreach arg $view_args {
+	# Decode 2-argument '-n 42' as 'limit'
+	if {[info exists haslimitarg]} {
+	    set newviewopts($n,limit) $arg
+	    set found(limit) 1
+	    unset haslimitarg
+	    continue
+	}
+	if {$arg eq "-n"} {
+	    set haslimitarg 1
+	    continue
+	}
 	if {[regexp -- {^-([0-9]+)$} $arg arg cnt]
 	    && ![info exists found(limit)]} {
 	    set newviewopts($n,limit) $cnt
-- 
1.7.0.2
