From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Support for large files on 32bit systems.
Date: Sat, 17 Feb 2007 11:46:32 +0100
Message-ID: <20070217104632.GF21842@admingilde.org>
References: <20070217091310.GD21842@admingilde.org> <20070217093953.GE21842@admingilde.org> <20070217094959.GH27864@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 11:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIN5R-0004Qd-BF
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 11:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946634AbXBQKqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 05:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946636AbXBQKqe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 05:46:34 -0500
Received: from mail.admingilde.org ([213.95.32.147]:55729 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946634AbXBQKqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 05:46:33 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HIN5M-0001gp-Mw; Sat, 17 Feb 2007 11:46:32 +0100
Content-Disposition: inline
In-Reply-To: <20070217094959.GH27864@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39985>

hoi :)

On Sat, Feb 17, 2007 at 04:49:59AM -0500, Shawn O. Pearce wrote:
> I think the only way to do with this is to have the Makefile detect
> if -D_FILE_OFFSET_BITS=64 is required to be added to CFLAGS based on
> some rule (e.g. uname output?), then add that to CFLAGS when needed.

something like this?

(I'm just testing it with a large data transfer, which will take some
time..., will report success later)

+++
Support for large files on 32bit systems.

Glibc uses the same size for int and off_t by default.
In order to support large pack sizes (>2GB) we force Glibc to a 64bit off_t.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ebecbbd..325c19f 100644
--- a/Makefile
+++ b/Makefile
@@ -334,9 +334,11 @@ EXTLIBS = -lz
 
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
+	BASIC_CFLAGS = -D_FILE_OFFSET_BITS=64
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
+	BASIC_CFLAGS = -D_FILE_OFFSET_BITS=64
 endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
-- 
1.5.0.80.g42d14


-- 
Martin Waitz
