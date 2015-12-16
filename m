From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/17] remote.c: read $GIT_DIR/remotes/* with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:11 -0800
Message-ID: <1450303398-25900-11-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KB7-0001kk-D5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967102AbbLPWED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:04:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967060AbbLPWDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14627325D3;
	Wed, 16 Dec 2015 17:03:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1gUh
	rkgYZDDKHJFKj5GR06CtfoY=; b=qik41iRPw9Ug1+kX6gIntiMuo12w0GJTmsj1
	8j9QtwXBXncLDBeJ9xh7UdYYfflLZGAQkRrPncpeIUBz4zX6a6tprPfvUghbL/7l
	ctRnhgFsInnI+VEqjKAHta7GMwjGAgqWa9+K/C8UZCdFIWNABUug1lEZnDf2HFIX
	4a9epCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=o+Lnwf
	Vv4WbGyo7BPVmcaUifJtQCGmqC4Zg8nSkUmIYw4b8ooOJsxqV+4ME26vDYCOR9JN
	lKCWaH/8724e2VRLaF0UmeCzyUWgmLJ7TB6lzkfduoDu+p9EwGPROJHZVUGuSDRc
	wI2zYMcET0h2tbiGBWHGhA11pJ1C6sWyiGk6Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CA33325D0;
	Wed, 16 Dec 2015 17:03:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F9DD325CF;
	Wed, 16 Dec 2015 17:03:35 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DA7FC514-A440-11E5-9332-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282611>

These files can be edited with a DOS editor, leaving CR at the end
of the line if read with strbuf_getline().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 1101f82..e88d936 100644
--- a/remote.c
+++ b/remote.c
@@ -256,7 +256,7 @@ static void read_remotes_file(struct remote *remote)
 	if (!f)
 		return;
 	remote->origin = REMOTE_REMOTES;
-	while (strbuf_getline(&buf, f, '\n') != EOF) {
+	while (strbuf_getline_crlf(&buf, f) != EOF) {
 		const char *v;
 
 		strbuf_rtrim(&buf);
-- 
2.7.0-rc1-83-ga8b6b9e
