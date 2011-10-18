From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] inet_ntop.c: Work around GCC 4.6's detection of uninitialized
 variables
Date: Tue, 18 Oct 2011 20:12:40 +0200
Message-ID: <4E9DC198.9040108@gmail.com>
References: <4E9DA88E.40500@gmail.com> <7vehyagq82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mschub@elegosoft.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 20:14:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGEBS-0005Qn-3r
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 20:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1JRSOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 14:14:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49324 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1JRSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 14:14:33 -0400
Received: by bkbzt19 with SMTP id zt19so1082885bkb.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CtgDHkoNY6N1tgY6hYTDd8HTuQKJ3WQky00R3qK97KQ=;
        b=tHctX0qFgxEVQr8ytk1OJdCrPwHCYxZNktIpYfEt03ubyZMPqYN7ap1jyeD3LWEeOe
         SCfxWMoh6vzqLLZEvEweNWi3mjGCKtbiCSaWbDYdTyr3ybTHRInMwlI4XS1cCVQj/s7w
         6x2ZHnZ+ZkHqSAE729Cmlk4gZkWXnVr5iivsM=
Received: by 10.204.139.8 with SMTP id c8mr2588505bku.97.1318961671843;
        Tue, 18 Oct 2011 11:14:31 -0700 (PDT)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id u10sm3102011bkv.3.2011.10.18.11.14.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 11:14:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vehyagq82.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183894>

GCC 4.6 claims that

    error: 'best.len' may be used uninitialized in this function

so silence that warning which is treated as an error by also initializing
the "len" members of the struct.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/inet_ntop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index ea249c6..9e9f6fb 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -98,7 +98,8 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
 	for (i = 0; i < NS_IN6ADDRSZ; i++)
 		words[i / 2] |= (src[i] << ((1 - (i % 2)) << 3));
 	best.base = -1;
-	cur.base = -1;
+	best.len = 0;
+	cur = best;
 	for (i = 0; i < (NS_IN6ADDRSZ / NS_INT16SZ); i++) {
 		if (words[i] == 0) {
 			if (cur.base == -1)
-- 
1.7.7.msysgit.1
