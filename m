From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/3] MSVC: fix compile errors due to macro redefinitions
Date: Wed, 11 Sep 2013 01:22:34 +0200
Message-ID: <522FA9BA.6020303@gmail.com>
References: <522FA959.80108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXGZ-0000OH-4o
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab3IJXWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:22:35 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:63546 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3IJXWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:22:35 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so4198825eek.22
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=B0yyhjJfKPlqLf8adQYfktUs02mXmQpZ5JKa11dwPOw=;
        b=sxtoSghWgw1T/sx8BQb65R7CYxktiBCuBjnoPageA7IFFEMhWhmezSQCx2lBNEFDis
         oxp9ANjB+PV8qRfVPT9Y2eCQfFcB432FYzZ6LlzOwknAYopGU41lJCOfhwAIsh4TNRUM
         aYyQ9SwjdK08H9upIUGQM2Tb8Q8dAbhUrfDZIX6uyG3g89z+39orEY37zCm2ygJWMlp4
         AMnYz777RNAc2/VPMPstpWQaeVLylxtIcx1/rEx+pLOZ153J1wa3H2YrAwTv+f7IXF9R
         0chEi+BKgGmWDtDTDsyO23mCDnO4D9O7QpH3dyXFgzhafXOuCSMw5ht47bPUQh2JgGar
         7vtw==
X-Received: by 10.14.107.68 with SMTP id n44mr42904213eeg.26.1378855354040;
        Tue, 10 Sep 2013 16:22:34 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id y47sm35251371eew.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:22:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FA959.80108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234506>

Skip errno.h definitions if they are already defined.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index bd0a88b..6b531e4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -32,7 +32,9 @@ typedef int socklen_t;
 #define WEXITSTATUS(x) ((x) & 0xff)
 #define WTERMSIG(x) SIGTERM
 
+#ifndef EWOULDBLOCK
 #define EWOULDBLOCK EAGAIN
+#endif
 #define SHUT_WR SD_SEND
 
 #define SIGHUP 1
@@ -46,8 +48,12 @@ typedef int socklen_t;
 #define F_SETFD 2
 #define FD_CLOEXEC 0x1
 
+#ifndef EAFNOSUPPORT
 #define EAFNOSUPPORT WSAEAFNOSUPPORT
+#endif
+#ifndef ECONNABORTED
 #define ECONNABORTED WSAECONNABORTED
+#endif
 
 struct passwd {
 	char *pw_name;
-- 
1.8.4.8243.gbcbdefd
