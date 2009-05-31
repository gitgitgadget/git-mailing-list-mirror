From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] http*: cleanup slot->local after fclose
Date: Sun, 31 May 2009 17:54:13 +0800
Message-ID: <20090531175413.962a55c3.rctay89@gmail.com>
References: <49F1EA6D.8080406@gmail.com>
	<20090530091755.GA13578@localhost>
	<be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	<20090530093717.GA22129@localhost>
	<be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	<20090530230153.527532b0.rctay89@gmail.com>
	<20090531000955.953725d9.rctay89@gmail.com>
	<7vy6sdssnk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 11:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAhkW-0006J6-BZ
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 11:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbZEaJyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 05:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbZEaJya
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 05:54:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:7589 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbZEaJy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 05:54:29 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2117786rvb.1
        for <git@vger.kernel.org>; Sun, 31 May 2009 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=EUVWzQBOGPm3zQbj6PvEC6S1qyyrND4V6ohGQKvz26U=;
        b=LTQ1lLVIz5B0++RbK1CQX0WC5EqSMtPOcL5SdBH4a8c2J0okWrjaIQVdqrRQlFVH0V
         lJZwzjVxyWxa0gELoEtbJHKfbaDH38syThD1+vS6eaPVviRMo9s73/Tt8spU7rMFzY89
         wRSyB6pZWDe8rOh3o8E1YsVHMnmP3EXdTdshI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=P72aei1220MTjNJrrtbFXDgUVNSOyUEtFPyTFcTCH4zzZMg95lf4+5TDGh5E0hy9g6
         wT/hpzbP5ScnyZ9ag46XPWcUm0y285+SZ2wUww2xucbJdA+ooypIz2SRSoP3iZd5xJt4
         b635s7BjJYNnmME802rEtTpwFUnw4D2YlJhlY=
Received: by 10.141.84.21 with SMTP id m21mr4228125rvl.284.1243763671631;
        Sun, 31 May 2009 02:54:31 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id n33sm4376938wag.34.2009.05.31.02.54.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 02:54:31 -0700 (PDT)
In-Reply-To: <7vy6sdssnk.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120394>

Set slot->local to NULL after doing a fclose on the FILE* pointer it
points to.

This fixes the issue raised by Clemens Buchacher on 30th May:

  http://www.spinics.net/lists/git/msg104623.html

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

On Sat, 30 May 2009 23:17:19 -0700
Junio C Hamano <gitster@pobox.com> wrote:
> Shouldn't a fix instead be queued for 'maint', without "refactoring"?

I tested this on top of the first 4 patches in 'rc/http-push' in 'pu',
applied on 'maint'. [1] I wonder if this should instead be queued for
'pu' [2], since the issue only occurs there, although, conceivably, it
*could* happen without those patches in 'pu'.

Footnotes:
[1] You can find this in the 'http-cleanup-slot-local_maint branch' at
    git://github.com/rctay/git.git. It's quite a minimal testcase, if
    you're looking for one.

[2] Found in 'http-cleanup-slot-local_pu'.

 http-push.c   |    6 ++++++
 http-walker.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index e16a0ad..0b12ffe 100644
--- a/http-push.c
+++ b/http-push.c
@@ -724,9 +724,11 @@ static void finish_request(struct transfer_request *request)
 	struct stat st;
 	struct packed_git *target;
 	struct packed_git **lst;
+	struct active_request_slot *slot;
 
 	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
+	slot = request->slot;
 	request->slot = NULL;
 
 	/* Keep locks active */
@@ -823,6 +825,7 @@ static void finish_request(struct transfer_request *request)
 
 			fclose(request->local_stream);
 			request->local_stream = NULL;
+			slot->local = NULL;
 			if (!move_temp_to_file(request->tmpfile,
 					       request->filename)) {
 				target = (struct packed_git *)request->userData;
@@ -1024,17 +1027,20 @@ static int fetch_index(unsigned char *sha1)
 		if (results.curl_result != CURLE_OK) {
 			free(url);
 			fclose(indexfile);
+			slot->local = NULL;
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
 		free(url);
 		fclose(indexfile);
+		slot->local = NULL;
 		return error("Unable to start request");
 	}
 
 	free(url);
 	fclose(indexfile);
+	slot->local = NULL;
 
 	return move_temp_to_file(tmpfile, filename);
 }
diff --git a/http-walker.c b/http-walker.c
index 7321ccc..9377851 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -418,15 +418,18 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
 			fclose(indexfile);
+			slot->local = NULL;
 			return error("Unable to get pack index %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
 		fclose(indexfile);
+		slot->local = NULL;
 		return error("Unable to start request");
 	}
 
 	fclose(indexfile);
+	slot->local = NULL;
 
 	return move_temp_to_file(tmpfile, filename);
 }
@@ -776,16 +779,19 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
 			fclose(packfile);
+			slot->local = NULL;
 			return error("Unable to get pack file %s\n%s", url,
 				     curl_errorstr);
 		}
 	} else {
 		fclose(packfile);
+		slot->local = NULL;
 		return error("Unable to start request");
 	}
 
 	target->pack_size = ftell(packfile);
 	fclose(packfile);
+	slot->local = NULL;
 
 	ret = move_temp_to_file(tmpfile, filename);
 	if (ret)
-- 
1.6.3.1
