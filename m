From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 12/23] transport.c::get_refs_via_curl(): do not leak
 refs_url
Date: Sat, 6 Jun 2009 16:43:40 +0800
Message-ID: <20090606164340.a49e63ad.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrb9-000433-0S
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbZFFItp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbZFFItp
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:49:45 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:33895 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbZFFItn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:49:43 -0400
Received: by mail-px0-f181.google.com with SMTP id 11so21643pxi.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=LNqja45ujwCRwGcCQQnGro/N9x/ZMdZ4zD6tKBEj+Kk=;
        b=QlgOgjKTlUO4BgbBqoltNaZZ6FmQuxBp6T3hS6BEZsHWGBr8sVkEmR2TObmM+orTB3
         XeG8RcCLWUx87RGyrfnDi9oZNhk9qxBlYGfwwfYmKcaoOY24DTFWob1ZGvEZ60G4gCtc
         9Wm9UPvDrux+WbzZEF6Q6wUXkH9LiQE8/RYUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=eSOrho1D9MRO4zKz++m5KyYFclh19h8x0KXo8t/lOliF4Z2chntOjLgWsNJoGcFZVZ
         gwwvMFYYZz8KR1lutxP4ho3gE6p6ih6c88V2QzKu99huay8ztXY6dgmQRVHRBbVRu+bq
         9cy34aVnHJodgQa/wFsc1YhLQzFftffzzuDec=
Received: by 10.142.171.3 with SMTP id t3mr1495650wfe.236.1244278186277;
        Sat, 06 Jun 2009 01:49:46 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 29sm2736755wfg.8.2009.06.06.01.49.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:49:45 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120893>

From:	Mike Hommey <mh@glandium.org>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is based on Mike's earlier patch:

Subject: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date:   Sun, 18 Jan 2009 09:04:27 +0100

I've removed the http_cleanup() invocation, after Johannes reported
that it breaks http clone. I've also renamed it, for clarity's sake.

 transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index efecb65..9edd5aa 100644
--- a/transport.c
+++ b/transport.c
@@ -519,6 +519,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 		free(ref);
 	}

+	free(refs_url);
 	return refs;
 }

--
1.6.3.1
