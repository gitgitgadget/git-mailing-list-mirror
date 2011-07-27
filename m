From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2] gitweb: Git config keys are case insensitive,
	make config search too
Date: Wed, 27 Jul 2011 22:53:33 +0200
Message-ID: <20110727205118.10439.58875.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 22:54:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmB7J-0004Jo-Iy
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 22:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab1G0UyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 16:54:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43089 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1G0UyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 16:54:02 -0400
Received: by fxh19 with SMTP id 19so578696fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=abMj2WB5LJume3ytYNhAxGXq3HdsHiYy3lGSdgI39Dg=;
        b=j7THRctASOwqbB+McWW2HyDZtXKyKNz7RaS62bSjWaHj7Z7lVRmDXtbEJ28TB1834T
         a3h1+3VoC8TZ74EkZ7XUVCG5ZOXF50ksFk53VivxzeLrHmafAV0H9UPsot79zmxqwZar
         ZHWFSHr7czs9QOzrqIlNLzmy0018Xh0lFAqt8=
Received: by 10.223.76.137 with SMTP id c9mr171789fak.62.1311800041391;
        Wed, 27 Jul 2011 13:54:01 -0700 (PDT)
Received: from localhost.localdomain (abwm39.neoplus.adsl.tpnet.pl [83.8.236.39])
        by mx.google.com with ESMTPS id q5sm69292fah.6.2011.07.27.13.53.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 13:53:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6RKrXx6010491;
	Wed, 27 Jul 2011 22:53:44 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177998>

"git config -z -l" that gitweb uses in git_parse_project_config() to
populate %config hash returns section and key names of config
variables in lowercase (they are case insensitive).  When checking
%config in git_get_project_config() we have to take it into account.

Gitweb does not (yet?) use git config variables with subsection, so we
can simply lowercase $key in git_get_project_config (only subsection
names are case sensitive).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I think it is a resend, but I haven't found first version.

The patch is unchanged, but commit message got improved.
It is not as much bugfix as hardening (against user e.g. adding
new overridable feature via gitweb config file).

 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1070805..90b5a73 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2526,6 +2526,7 @@ sub git_get_project_config {
 
 	# key sanity check
 	return unless ($key);
+	$key = lc($key); # assuming there is no subsection
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
