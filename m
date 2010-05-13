From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 0/4] End-of-line normalization, getting close?
Date: Thu, 13 May 2010 23:44:38 +0200
Message-ID: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 23:45:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCgDI-0005HK-NR
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 23:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758894Ab0EMVov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 17:44:51 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:49373 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab0EMVot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 17:44:49 -0400
Received: by ewy8 with SMTP id 8so702712ewy.28
        for <git@vger.kernel.org>; Thu, 13 May 2010 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ICEwEN2xc0fpfsa4ztIIxjkkphBVg+/+JailS9Eph8g=;
        b=DgpWfOPVykMBnGwYCyklNl2JVqEb3uSPqhzt+x+Ll0XW7l/kNfW9AXmORNtUgEIwiU
         vwAChuG1C9HVk6x0EiIqx+Dwj2UYksaYMJTInu7QTz+Jnz41yeUahl4sLxGpS11Mm8ZW
         NvxSsTx1b85UaOu2PtUwBDPyhvLfHK4O8mlxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IWwVP0F9UspxVHdx0fvSskbh528yVIxveFnKbsK06QUblX1B8VQ8802jJzUoAYcRD8
         rdbiIRie+Hibb8xI0vxLyE8oRZVCa0NPil5FmRdiOgPPu7RFvFEMFSOWntXjb8xXsfgC
         oHzla8Yl7SCKMLYj9Hyt8wPrUSDptQnAu/hvw=
Received: by 10.213.48.13 with SMTP id p13mr262596ebf.18.1273787087360;
        Thu, 13 May 2010 14:44:47 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm906408ewy.4.2010.05.13.14.44.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 14:44:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147029>

Here's the latest series.  Linus's suggested attribute names were a
lot saner than mine, so I've now split the "crlf" attribute into
"crlf" and "eol", and the "crlf" attribute gets renamed to "text" in
the final commit.  I dropped the patch that renamed autocrlf.

git-cvsserver gets a bit more love in this round (particularly the
documentation), so I think it should work as well as it did before.
Not too happy with the logic duplication, though.

Patch 1/4 is still "safe autocrlf" from Finn Arne, just for
convenience.

All in all, I think this looks pretty good now.
-- 
Eyvind


Eyvind Bernhardsen (3):
  Add tests for per-repository eol normalization
  Add per-repository eol normalization
  Rename the "crlf" attribute "text"

Finn Arne Gangstad (1):
  autocrlf: Make it work also for un-normalized repositories

 Documentation/config.txt        |   20 +++--
 Documentation/git-cvsserver.txt |   13 +--
 Documentation/gitattributes.txt |  164 +++++++++++++++++++++++++++++++--------
 attr.c                          |    2 +-
 cache.h                         |    9 ++-
 config.c                        |    2 +-
 convert.c                       |  155 +++++++++++++++++++++++++++++++------
 environment.c                   |    2 +-
 git-cvsserver.perl              |   13 ++-
 t/t0020-crlf.sh                 |   52 ++++++++++++
 t/t0025-crlf-auto.sh            |  156 +++++++++++++++++++++++++++++++++++++
 11 files changed, 507 insertions(+), 81 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh
