From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http-push: add back underscore separator before lock token
Date: Tue, 03 Feb 2009 21:07:26 +0800
Message-ID: <4988418E.4000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 14:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUL1h-0002Vm-99
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 14:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbZBCNHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 08:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZBCNHv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 08:07:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:20720 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZBCNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 08:07:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1992548rvb.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=eschsvj0CSTflrWQ8m5mCs7j35Eatx9FKGa745JYf4s=;
        b=aGer9QA1icmbGucIzzHmcn6gHS13dSGhjLFUC16aA/hd8P12m+W5kzuSNkKPnR3dzs
         GzvHWf8a8W4RtyaTdvCAf5/B6S0KHEqz94/CKLEs+YrAyndS7Q7SDeNk6TppLZ7pN5SJ
         02MPNM40fS/euvHQLw2Dlg1MXPN0G9cZU/S60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=rZBLSelAXEPxHH67E+m+tmwP+mHnf4740DGzVTaC0YLe7q/nMAmFiERwc19Lfacgvx
         /fwobGTNLdleUsE45LX3T/+nR+u4lRP/7x/Dep1N95pMAd1ODFEA3Rn4UjhMmJYAxHgL
         St0FRyRQmNNc7larerjvx4i0WyzfzQDYfO6Mo=
Received: by 10.140.134.15 with SMTP id h15mr1596950rvd.156.1233666468504;
        Tue, 03 Feb 2009 05:07:48 -0800 (PST)
Received: from ?116.87.149.30? ([116.87.149.30])
        by mx.google.com with ESMTPS id f21sm11972642rvb.7.2009.02.03.05.07.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 05:07:48 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108184>

The patch dated Sat, 31 Jan, "[PATCH] http-push: refactor request url
creation" inadvertently removed the underscore separator between the
object path and the appended lock token.

This patch adds it back.

This would be keeping in line with the aforementioned patch's objective
of refactoring, without changing the behaviour and effect, of the code.

This would also be useful for testing if the lock token has been
indeed appended to the object url.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

 http-push.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 54c62d4..eefd64c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -557,6 +557,7 @@ static void start_put(struct transfer_request *request)
 	request->dest = strbuf_detach(&buf, NULL);

 	append_remote_object_url(&buf, remote->url, hex, 0);
+	strbuf_addstr(&buf, "_");
 	strbuf_addstr(&buf, request->lock->token);
 	request->url = strbuf_detach(&buf, NULL);

-- 
1.6.1.2.278.g9a9e.dirty
