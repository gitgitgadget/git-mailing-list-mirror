From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Fix hash slice syntax error
Date: Mon, 4 Aug 2008 10:32:47 +0530
Message-ID: <20080804050247.GA13539@toroid.org>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 07:26:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPsZy-00008s-3A
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 07:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYHDFY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 01:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbYHDFY4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 01:24:56 -0400
Received: from fugue.toroid.org ([85.10.196.113]:54194 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbYHDFYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 01:24:55 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id DB93B558383;
	Mon,  4 Aug 2008 07:02:49 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 1CF4CADC36D; Mon,  4 Aug 2008 10:32:48 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91316>


Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-08-04 12:49:27 +0800, rctay89@gmail.com wrote:
>
> $self->{@vars} evaluates to undef. i can't find any mention of using
> arrays to dereference objects in the manual and elsewhere; is this a
> mistake?

Yes, @vars would be interpreted in scalar context, which certainly isn't
the intended effect.

-- ams

 perl/Git.pm |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 087d3d0..2ef437f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -839,8 +839,8 @@ sub _close_hash_and_insert_object {
 
 	my @vars = map { 'hash_object_' . $_ } qw(pid in out ctx);
 
-	command_close_bidi_pipe($self->{@vars});
-	delete $self->{@vars};
+	command_close_bidi_pipe(@$self{@vars});
+	delete @$self{@vars};
 }
 
 =item cat_blob ( SHA1, FILEHANDLE )
@@ -928,8 +928,8 @@ sub _close_cat_blob {
 
 	my @vars = map { 'cat_blob_' . $_ } qw(pid in out ctx);
 
-	command_close_bidi_pipe($self->{@vars});
-	delete $self->{@vars};
+	command_close_bidi_pipe(@$self{@vars});
+	delete @$self{@vars};
 }
 
 =back
-- 
1.6.0.rc0.43.g2aa74
