From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] add warning for depth=0 in git clone.
Date: Tue,  8 Jan 2013 09:07:02 +0100
Message-ID: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 09:07:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsUDg-0004tM-W8
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab3AHIHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:07:15 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:38924 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3AHIHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:07:13 -0500
Received: by mail-ee0-f48.google.com with SMTP id b57so58222eek.7
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=gunqxYQXzX4LpV83lTJn93g+Zuqvf+cUqsFca/WRNDo=;
        b=Tzc4gIcTReDxmuOAEBB4DfygrBc1hBqh3V1590HBkJ68ZrUKuwvGbaZVzlNOs76z1A
         aKm85Imp8FFiJWdv4rlXMc+K9eKTG1JpVEHRmzQSiVB3IEgkgife+IW1gk9lPODvGg+H
         wJvbRNGDqRavJZRZGAfAbiowE9B7KQxuMAuj3WsJETX2IcQNhAr4X9D1aWsv/0rqejsC
         ckTxZAdRTVjhjYEfFm0gg+SsavgMk0SftKckNXjuPy//3Bbw8A9tdmVLyHYdspUyZJZw
         4a0J8GgukGb+5LJ4v8GdkjgQ7HJMMJHA9v5GZDOxVvU25kYqKh1dHtaAHFzU7sVbxbYT
         X+cg==
X-Received: by 10.14.225.194 with SMTP id z42mr172773799eep.22.1357632432621;
        Tue, 08 Jan 2013 00:07:12 -0800 (PST)
Received: from localhost (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id q44sm134151642eep.5.2013.01.08.00.07.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 00:07:11 -0800 (PST)
X-Mailer: git-send-email 1.8.1.166.g27cbb96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212946>

---
 builtin/clone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index ec2f75b..5e91c1e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -818,6 +818,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
 
+	if (option_depth && transport->smart_options->depth < 1)
+		die(_("--depth less or equal 0 makes no sense; read manpage."));
+
 	if (!is_local) {
 		if (!transport->get_refs_list || !transport->fetch)
 			die(_("Don't know how to clone %s"), transport->url);
-- 
1.8.1.166.g27cbb96
