From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 6/7] t5540-http-push: when deleting remote refs, don't need
 to branch -d -r
Date: Sun, 25 Oct 2009 23:23:10 +0800
Message-ID: <20091025232310.2c512a1b.rctay89@gmail.com>
References: <20091025232227.96769e50.rctay89@gmail.com>
 <20091025232142.6558d9e4.rctay89@gmail.com>
 <20091025232044.06d7ce5c.rctay89@gmail.com>
 <20091025231932.be9a6dfa.rctay89@gmail.com>
 <20091025231809.15b470fa.rctay89@gmail.com>
 <20091025231651.18c75559.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24wE-0002IT-F7
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbZJYPXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbZJYPXL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:23:11 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:57800 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbZJYPXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:23:11 -0400
Received: by yxe17 with SMTP id 17so9153373yxe.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SV3BxEh+68iPTHb5ZxGCEcZpdroaxWHd32eMZfOMZ0A=;
        b=ASb2cQ55sS3rMrSpH/2aYTE9Wh3HQwWB32VlQQawEyC3o76ee85bgz8EpWxEYMLSm+
         EP/AGf9AyRpJb1TBd3zH6/SSb49c/5JWN94fsCPTUhDNYgBovrVtw/k2lgoWanUzp25p
         f2cKG/SbNsQndszrWohDZNdL45s3PA/5SUnEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=CUTzmaaU2MPk5CLWOWE1aXv/P898gvbK9KCKJDXNU7dilSGTcLVebyoLo+g0Mh661i
         rGLktEo6PiRItbOzC6crbVu6ytuo+CQJ4+a8YqjHKGwen5KhBdqiTkDkYbcgeCEZsgHc
         rwNzqBkYXTX/fCkx8qiDV8u94wCMT+E3Xqv7o=
Received: by 10.101.29.8 with SMTP id g8mr3153968anj.198.1256484195844;
        Sun, 25 Oct 2009 08:23:15 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 9sm892657yxf.41.2009.10.25.08.23.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:23:15 -0700 (PDT)
In-Reply-To: <20091025232227.96769e50.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131213>

In c6aa27e (Move WebDAV HTTP push under remote-curl, Wed Oct 14),
transport->push_refs became defined for http pushing. This enabled the
code to update local tracking refs (transport.c::update_tracking_ref()
via transport.c::transport_push()), allowing these refs to be deleted
together with the remote ref, thus doing away with a manual branch -d
-r.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index ee7f84a..6bb5afa 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -116,7 +116,6 @@ test_expect_success 'create and delete remote branch' '
 	git push origin dev &&
 	git fetch &&
 	git push origin :dev &&
-	git branch -d -r origin/dev &&
 	git fetch &&
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
--
1.6.4.4
