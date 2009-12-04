From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH resend 0/3] transport: catch non-fast-forwards
Date: Fri, 4 Dec 2009 14:54:37 +0800
Message-ID: <20091204145437.1a9910db.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 07:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGS43-0000tr-Lw
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 07:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbZLDGyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 01:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZLDGyj
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 01:54:39 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:43054 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZLDGyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 01:54:39 -0500
Received: by gxk26 with SMTP id 26so1973881gxk.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 22:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=1qHTN6nGXlkatnNq0n6jAte09eJ9/aBOQQndArcVDSU=;
        b=hNtepd/IH7iJuuH1ad0nRXiSIXLiDgP6tX4vmQpi45MOONRwisqGyda0nDSzzEdwRn
         WQmFUB2yld0tjJE7N6zKdhlQIyFA2eTbPfGcAQqMlILyUAJ2IqByIx5A1ICw0SrDI03F
         AoGf30fS5qov2hBtQ5DXZLCNvX3MOj/SNIfSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ZHztPkjpDnhI+0Rt7ijxoPAbLj4HXGbZ11x5IxUCySh9UBreWuHCyraNMZZEkqtfk5
         fgsNugO02Z/QEkx9QBtl25jziL7CfzCwHPIu0z9kGrGbZ1jkqOlj4Zz/gky31U9f2gJR
         SqoZWQpuehZZZ8Cjz/qh6+4p5cbYROfrFatjg=
Received: by 10.90.242.9 with SMTP id p9mr1305282agh.30.1259909685510;
        Thu, 03 Dec 2009 22:54:45 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 36sm1425284yxh.67.2009.12.03.22.54.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 22:54:44 -0800 (PST)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134494>

This patch series applies on top of 'next', and deals with alerting
the user to non-fast-forward pushes when using helpers (smart).

Previously, git silently exited. This situation involves the curl
helper and the smart protocol. The fast-forward push is only detected
when curl executes the rpc client (git-send-pack). Now, we detect it
before telling the helper to push.

The first patch refactors ref status logic out of builtin-send-pack.c.

The second patch lets git know of non-fast-forwards before actually
telling the helper to push anything.

The third patch changes the return code when ref status indicate an
error (determined by push_had_errors()), so that the caller of
transport_push() is alerted.

PS. There are at least 2 bug fixes related to this series. If you
usually do so from repo.or.cz, please fetch from git.kernel.org; the
former is 2 days old.

 builtin-send-pack.c |   39 +++------------------------------------
 remote.c            |   42 ++++++++++++++++++++++++++++++++++++++++++
 remote.h            |    1 +
 transport-helper.c  |   10 +++-------
 transport.c         |   11 +++++++----
 5 files changed, 56 insertions(+), 47 deletions(-)

--
Cheers,
Ray Chuan
