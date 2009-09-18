From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git crashes on pull
Date: Fri, 18 Sep 2009 21:39:48 +0800
Message-ID: <20090918213948.4bb65f4e.rctay89@gmail.com>
References: <7vzl8v4y5g.fsf@alter.siamese.dyndns.org>
 <alpine.LSU.2.01.0909152044450.10936@bianca.dialin.t-online.de>
 <7vljkg57xs.fsf@alter.siamese.dyndns.org>
 <alpine.LSU.2.01.0909160022430.24554@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org,
	Michael Wookey <michaelwookey@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 15:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Modgc-0005uV-Nq
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 15:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbZIRNjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 09:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZIRNjc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 09:39:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:23987 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZIRNjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 09:39:32 -0400
Received: by fg-out-1718.google.com with SMTP id 22so496551fge.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=S9xA23oNbPQhQGhuI2NA6FxTpnE9YZQ6qwIDp8whocI=;
        b=BvjcCaCgHtsY9XCi0FjSF6eOS31Wf1nNZvVXvoKUfeqfXbRFqP0nbbU40RZ3PHZARC
         6K04CQBVIxLHgrMfsbg9YvjvED7g006WOMsqk6ZAf09yOpRDrRTRJ6cyYYyiIr+oL5v4
         QGFu50uO66pw9PevJNYmAi399Af6nWlU8fdRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Q6GoCZErFwMFEHGkZkvQyNanhYYdaS4pg5xQ9qgTlqvqJYG6OJaEPvgqylzi3Kle96
         I9T7Wpmwk2/tA2RlbrLeG+tuy0sO/xSY9IlgJhpooTN38MFJTyG28Rq7T6UBxk16NJOj
         LavHUQ7U1S/nTS6FNaCiPVHlGMy/XiaMw1wX8=
Received: by 10.86.192.34 with SMTP id p34mr1780770fgf.28.1253281174826;
        Fri, 18 Sep 2009 06:39:34 -0700 (PDT)
Received: from your-cukc5e3z5n (cm104.zeta152.maxonline.com.sg [116.87.152.104])
        by mx.google.com with ESMTPS id e11sm441674fga.24.2009.09.18.06.39.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 06:39:33 -0700 (PDT)
In-Reply-To: <7vzl8v4y5g.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128797>

Hi,

On Wed, Sep 16, 2009 at 6:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.
>
> The sad part of the story was that this regression was introduced by a
> change to work around recent breakage observed when fetching from the http
> server github runs, and it was the primary purpose of pushing 1.6.4.3 out.
>
> Now we need to cut a 1.6.4.4 with this fix-on-fix soon, like tomorrow.

sorry for all the trouble caused.

Junio, do you think moving out the free() would be a better option? Setting it to NULL just so we can free() is rather contrived, I feel.

-- >8 --

Subject: [PATCH] http.c: move free() out of cleanup block

Instead of initializing a variable (url) just so we can do a free() on
it, as in b202514 (http.c: avoid freeing an uninitialized pointer), we
move the free() out of cleanup block.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 23b2a19..a67f62e 100644
--- a/http.c
+++ b/http.c
@@ -866,7 +866,7 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	int ret = 0;
 	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
-	char *url = NULL;
+	char *url;
 	struct strbuf buf = STRBUF_INIT;

 	if (has_pack_index(sha1)) {
@@ -885,9 +885,9 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	if (http_get_file(url, filename, 0) != HTTP_OK)
 		ret = error("Unable to get pack index %s\n", url);

+	free(url);
 cleanup:
 	free(hex);
-	free(url);
 	return ret;
 }

--
1.6.4.2
