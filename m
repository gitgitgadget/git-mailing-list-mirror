From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 12/14] gitweb: add HEAD to list of shortlog refs if detached
Date: Fri, 31 Aug 2007 13:19:12 +0200
Message-ID: <11885591653402-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
 <11885591542097-git-send-email-giuseppe.bilotta@gmail.com>
 <11885591601143-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4ZF-0002oW-Ct
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbXHaLVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbXHaLVN
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:21:13 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:32010 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbXHaLVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:21:12 -0400
Received: by hu-out-0506.google.com with SMTP id 19so593548hue
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:21:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N9y+g6k53TfcsCE0wC/3ek8mPNQE1aAHhyfwloCmhuofaoMCkI1HRCxjoiftaS5GLk+jp1H82MlEsxt3VgFQqHodSiSqVqlZtCeH8xJNPSJaq/5PP6G2Pfh+J10jFgjcIoyHNR6pzASXZSld3VLswY7I6s87OjKwu+XmCtZeWO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IWZttSdS5Un9wwb3NS3OCfS8aTB7TdhYUMfs/l4b40xWDPTo7fF9xRXLjhZdviHZWDzFnJHDkFg9qR55YJHw75L6vCK7XMnskxr+etLylqCa2mCvLgls742cnvoMs0cTwMddDYSMxP55LPQlkLUzOvUs7p7Hyornis/nK+di1EM=
Received: by 10.78.149.15 with SMTP id w15mr1138697hud.1188559268513;
        Fri, 31 Aug 2007 04:21:08 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id d27sm1273536nfh.2007.08.31.04.21.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:21:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <11885591601143-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57162>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a745434..4f7b7da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1688,6 +1688,10 @@ sub git_get_last_activity {
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
+	if (git_is_head_detached()) {
+		my $hash = git_get_head_hash($project);
+		$refs{$hash} = [ 'HEAD' ];
+	}
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
 	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
-- 
1.5.2.5
