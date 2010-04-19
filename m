From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v4 00/11] Resend sp/maint-dumb-http-pack-reidx
Date: Mon, 19 Apr 2010 22:46:43 +0800
Message-ID: <20100419224643.00001ff1@unknown>
References: <20100418115744.0000238b@unknown>
	<1271686990-16363-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:47:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3sFl-0008WJ-2X
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab0DSOq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:46:59 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:49695 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab0DSOq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:46:57 -0400
Received: by ewy20 with SMTP id 20so1497863ewy.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=LDGBRUOX4ntd3p9S6IwdsrOkoXnPNzxEMuvaO8r/KV8=;
        b=vDsQ+crYA/IpyNukSSCG3J7W0KH2kZqjUn+X//HB5bHil50cK0wfYkqpY9xenKtrQY
         jO8TWRIK0z+tsuwWY8tIWxvYHWe7ayRRHkNBTFblUNcq4Fs/9W2slqMhqHyBXOLQde29
         2g28/gikLnnTKFT+DIaxHW65UDOcX/fzNeXGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=IlRo7zJvywsP67WEF/rdpLt/8hJoNI/RJfFgZNISfa50NC4phh0a1gn+A/3I5tGfnQ
         LHMizzMYwfNpyY+Vq+yR/nohNVHUUPc+GHz/yzLObdZDZKtAXeq/mZoitEGLlR+oR+mn
         HNEn5TerCNlqNmKFvmdV8UlszYhUY3KdE3EOo=
Received: by 10.87.66.15 with SMTP id t15mr4221722fgk.37.1271688416062;
        Mon, 19 Apr 2010 07:46:56 -0700 (PDT)
Received: from unknown (cm101.zeta153.maxonline.com.sg [116.87.153.101])
        by mx.google.com with ESMTPS id d4sm8000352fga.0.2010.04.19.07.46.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:46:55 -0700 (PDT)
In-Reply-To: <1271686990-16363-1-git-send-email-spearce@spearce.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145306>

Hi,

On Mon, 19 Apr 2010 07:23:04 -0700
"Shawn O. Pearce" <spearce@spearce.org> wrote:

> This is a resend of the last half of the series, from patch 6/11
> to the end, to address some minor review comments.
> 
> Junio, I think you need to reset my branch to 0da8b2e7c80a6d
> ("http.c: Don't store destination name in structures"), and
> then apply this group.

the small patch below could also be applied to the rebased topic branch.

-->8--
From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http.c::new_http_pack_request: do away with the temp variable filename

Now that the temporary variable char *filename is only used in one
place, do away with it and just call sha1_pack_name() directly.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

diff --git a/http.c b/http.c
index c75eb95..110cff9 100644
--- a/http.c
+++ b/http.c
@@ -1027,7 +1027,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 struct http_pack_request *new_http_pack_request(
       struct packed_git *target, const char *base_url)
 {
-       char *filename;
       long prev_posn = 0;
       char range[RANGE_HEADER_SIZE];
       struct strbuf buf = STRBUF_INIT;
@@ -1042,8 +1041,8 @@ struct http_pack_request *new_http_pack_request(
               sha1_to_hex(target->sha1));
       preq->url = strbuf_detach(&buf, NULL);

-       filename = sha1_pack_name(target->sha1);
-       snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp", filename);
+       snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp",
+               sha1_pack_name(target->sha1));
       preq->packfile = fopen(preq->tmpfile, "a");
       if (!preq->packfile) {
               error("Unable to open local file %s for pack",
--

-- 
Cheers,
Ray Chuan
