From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv1 2/2 (version A)] gitweb: Mention read_config_file in gitweb/README
Date: Wed, 25 May 2011 18:35:27 +0200
Message-ID: <1306341328-11108-3-git-send-email-jnareb@gmail.com>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 18:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPH3o-0002q9-T5
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569Ab1EYQfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 12:35:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590Ab1EYQfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:35:48 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so5498279fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=wHEdGUnLJP1CWEvjvRUws705ud0p6HUtOx+gvbwuqHM=;
        b=vrFJPu35urHtR6pA9RRHVAcNIToliYAZeOOXw2dZxuqYw0+B6Gp60shEkygdVjPEmC
         oiWDTvjfaZL00pr/7kBF118wifhTi3PL7xLmk0m5kGLE4YJckNCcNH9naJfkLryyQBvE
         Y+AW69RCzJhJ2MvoUXveep1G77ReXiF0fQT+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tyVuRpxg9dY7UMlhcLP/XFy2RX+65+zydDMBaZhPURJDkQ8Cvl7cqVexj7qq8txEoe
         Iogcx63BRyXoLTa122X7SmX79pUC76QJGvXBpBkg8r7KjpXqeVI1JRRJfWwQrLXWNbgS
         OppIDrBeMR1lYQ125q4utdLyV2eb2MRbkLK2k=
Received: by 10.223.83.3 with SMTP id d3mr5168260fal.89.1306341347057;
        Wed, 25 May 2011 09:35:47 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id i6sm295066faa.10.2011.05.25.09.35.45
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 09:35:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
In-Reply-To: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174423>

Using

  read_config_file($GITWEB_CONFIG_SYSTEM);

at the very beginning of per-instance GITWEB_CONFIG file is quite
similar to e.g. using

  if [ -f /etc/bashrc ]; then
    . /etc/bashrc
  fi

in ~/.bashrc to read system-wide defaults.

This solution is backwards compatibile, but it requires to explicitly
request system-wide defaults... which otherwise are _not used at all_
when per-instance config file exists.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is alternate solution to "system-wide policy" problem, the other
way to make things convenient.  It was (soft of) suggested by Junio
in

  Re: [PATCHv2] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG does exist
  http://thread.gmane.org/gmane.comp.version-control.git/173603/focus=173815

While usually user's (here per-instance) configuration file overrides
system-wide configuration file settings (or in other words first
obtained value from user's and system-wide configuration file, in that
order, is used), like e.g. the case for ssh_config,... it is not
universal, as described in commit message.


This commit should be thought as exclusive to

  [PATCH 2/2 (version B)] gitweb: Use /etc/gitweb.conf even if gitweb_conf.perl exist

We have to choose one or the other.  Note that this other version
includes also change to gitweb/INSTALL...

 gitweb/README |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index a92bde7..ea10c91 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -127,6 +127,16 @@ Runtime gitweb configuration
 You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
 (defaults to 'gitweb_config.perl' in the same directory as the CGI), and
 as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
+You can read defaults in system-wide GITWEB_CONFIG_SYSTEM from GITWEB_CONFIG
+by adding
+
+  read_config_file($GITWEB_CONFIG_SYSTEM);
+
+at very beginning of per-instance GITWEB_CONFIG file.  In this case
+settings in said per-instance file will override settings from
+system-wide configuration file.  Note that read_config_file checks
+itself that the $GITWEB_CONFIG_SYSTEM file exists.
+
 The most notable thing that is not configurable at compile time are the
 optional features, stored in the '%features' variable.
 
-- 
1.7.5
