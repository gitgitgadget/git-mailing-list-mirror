From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Refactor checkout option handling
Date: Tue, 28 Aug 2012 20:49:05 +0700
Message-ID: <1346161748-25651-1-git-send-email-pclouds@gmail.com>
References: <7vr4qroel6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 15:56:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6MH3-0007fw-E2
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 15:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab2H1NzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Aug 2012 09:55:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51758 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2H1NzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 09:55:24 -0400
Received: by pbbrr13 with SMTP id rr13so9402403pbb.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P3IwkB/H2BCXrU1WBvtl5/DJSpAoVoAYak6caFkgUTM=;
        b=JiIOYGpYG9Yq3CePblYDe78bzNd7nehfpSQqb7iUwPOope5faydwtAJLK7GBnL3uZl
         kYSAHwJPqqqnGfWnsCBkZP/2H/pi4BCCo3nnV1p/gcMY5V4O9CbfkQmWMcuth9wR+rqZ
         BT7UiwXaOWsxMHEkU4IboVgYdH/dakMjlite+lLVaEaxYOMhaSLomKxPSlrM6qqTOd/a
         uMJYzFSfNlZ2B4gccW1qeDPcrUvpGCRsFfeUOoMrljwlnJaJXHOWk4bWN2zoOfKiyHgr
         lyzslzDnh/+Y7/b2uHQ1y5I6EU0JxQfGqMFLWVR9G/iNQhUFfkWQdOq4h8uo1phxJkEb
         WQDA==
Received: by 10.66.87.138 with SMTP id ay10mr37798468pab.38.1346162124218;
        Tue, 28 Aug 2012 06:55:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id ih5sm9804180pbc.53.2012.08.28.06.55.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 06:55:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Aug 2012 20:49:09 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <7vr4qroel6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204424>

On Tue, Aug 28, 2012 at 10:55 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> The surrounding code is somewhat tricky and the code structure is
> brittle; there are places that update the opts.new_branch so the new
> location of this check has to be after them, and there is one
> codepath that having a bad value in it does not matter.
>
> I had to check the code outside the context of this patch a few
> times to convince myself that this patch does not break them.  I'll
> queue the patch as-is for now, but we probably would want to see how
> we can structure it to be less brittle.

I'll give it a shot. On top of master, not the "checkout -b -t" patch.
The test suite passes, but we'll need more eyeballs for code moves
like this.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  checkout: pass "struct checkout_opts *" as const pointer
  checkout: reorder option handling
  checkout: move branch guessing code out as a separate function

 builtin/checkout.c | 290 ++++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 164 insertions(+), 126 deletions(-)

--=20
1.7.12.rc2.18.g61b472e
