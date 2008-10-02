From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: PATH_INFO support improvements
Date: Thu,  2 Oct 2008 02:10:28 +0200
Message-ID: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:11:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBnG-00017h-UG
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbYJBAKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYJBAKB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:10:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48915 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYJBAJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:09:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so341125nfc.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fa3U2JX5nG6nZ4vjcIHsRHyHV5eraLUpCBkjoQv8rYM=;
        b=iDKknWr2z79P6y0RVXlvoXjJVUMF17InacupXyjC+SPzTbUrGb5D14e19+53S1yCn1
         JSeX+4NGLHvVdzv3xhoeXhfdC/xxE60dSIgBGE2jN6yN/qGOwQPRMgh+GLUMXtTXQ2uG
         VTfVunA0jqGs9tL/J/IFlHLHo8+J6NkDoKjeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mo/IeCetQoMeiwi/i4Bl6s0u6cXUjGWfBdvrn0a6w0yuoP4P1qdi2BRJpPkZgE/T2R
         MCX9Aal5OuPWi174w46ruUbFzK/konJxZFxHdhSYwAX3D8fne1b1ezkLdaGeHBy0z+68
         WeZ3+YLJb4jJU/xdnJrxpCDse8vsKSUKSeMiU=
Received: by 10.210.123.2 with SMTP id v2mr10530282ebc.21.1222906197854;
        Wed, 01 Oct 2008 17:09:57 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 7sm1104179eyg.0.2008.10.01.17.09.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 17:09:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97283>

Fourth version of my gitweb PATH_INFO patchset, whose purpose is to
reduce the use of CGI parameters by embedding as many parameters as
possible in the URL path itself, provided the pathinfo feature is
enabled.

The new typical gitweb URL is therefore in the form

$project/$action/$parent:$file..$hash:$file

(with useless parts stripped). Backwards compatibility for old-style
$project/$hash URLs is kept, as long as $hash is not a refname whose
name happens to match a git action.

The main implementation is provided by paired patches (#1#3, #5#6)
that implement parsing and generation of the new style URLs.

Patch #2 deals with a refactoring of the input parameters parsing and
validation, so that the rest of gitweb can be agnostic wrt to the
parameters' origin (CGI vs PATH_INFO vs possible other future inputs
such as CLI).

Patch #4 is a minor improvement to the URL syntax that allows web
documents to be properly browsable in raw mode.

Giuseppe Bilotta (6):
  gitweb: parse project/action/hash_base:filename PATH_INFO
  gitweb: refactor input parameters parse/validation
  gitweb: generate project/action/hash URLs
  gitweb: use_pathinfo filenames start with /
  gitweb: parse parent..current syntax from pathinfo
  gitweb: generate parent..current URLs

 gitweb/gitweb.perl |  392 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 254 insertions(+), 138 deletions(-)
