From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 0/4] submodule: improve support for relative superproject origin URLs
Date: Sun,  3 Jun 2012 19:46:46 +1000
Message-ID: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 11:47:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sb7Oy-0005th-Vn
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 11:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab2FCJrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 05:47:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60718 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2FCJrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 05:47:06 -0400
Received: by dady13 with SMTP id y13so4601633dad.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=x2Mwg6syW9BnQa+1j0h7DZ773cSqCllgUcP5o4Pl6UA=;
        b=NwaoIe4yETyHL0B70U/dTr6VGzYs0HdQF+NNKrrmfcQ5sXzeRoPNuaKckRaS4NPCGu
         xmktZNt64W4qDXXro5BiaoDGnJAPX6WoBWzEkWg89UYFWBjvnP+lzJIAuDMFTW+i3ua+
         dF/s3FOBdlXXjg2eLJBWDxB3TBJ82pxDiCD+4GDRqw8YTKKHbmcGoNPtHwf4MIA+L4vQ
         exfSuF8NdhylOD9MYUfr9OgZZvkxKlDiuhdETkWBqJlfbph5gPSOObKd/JOmATjizSQ9
         5cOKrEva+gTBtxRsfV1ZjBfQfbU23REcGJppUp/4DFUn70EoZ/IF+XgCTgIAiNj+omws
         Xs8g==
Received: by 10.68.136.106 with SMTP id pz10mr19870963pbb.143.1338716824781;
        Sun, 03 Jun 2012 02:47:04 -0700 (PDT)
Received: from ubuntu.au.ibm.com (202-159-159-155.dyn.iinet.net.au. [202.159.159.155])
        by mx.google.com with ESMTPS id pb10sm8385550pbc.68.2012.06.03.02.47.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 02:47:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.651.g2c84487
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199074>

This series improves handling by 'git submodule' of relative superproject origin URLs. 

Currently, 'git submodule':

* incorrectly configures origin URL for submodules with a path that is relative to
the work tree of the superproject when the configured path needs to be relative 
to the work tree of the submodule

* unnecessarily fails with an error if the superproject origin URL is of the form: foo

This series corrects these problems for paths like the following:
  foo
  foo/bar
  ./foo
  ./foo/bar
  ../foo
  ../foo/bar

It does not change current behaviour for URLs that begin with a leading / or contain
a : as such URLs are deemed to be absolute URLs for which no correction is required.

In addition, this series ensures that relative URLs configured by git submodule do
not include a superfluous leading or embedded './'.

This series differs from v7 by removing the patches dealing incorrect handling 
of greedy submodule URLs (those with too many leading ../'s) and those that deal
with improperly normalized superproject origin URLs. These patches may resubmitted
at a later date.

Jon Seymour (4):
  submodule: additional regression tests for relative URLs
  submodule: document failure to handle relative superproject origin
    URLs
  submodule: fix sync handling of some relative superproject origin
    URLs
  submodule: fix handling of superproject origin URLs like foo, ./foo
    and ./foo/bar

 git-submodule.sh           |  65 +++++++++++++++++---
 t/t7400-submodule-basic.sh | 144 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7403-submodule-sync.sh  |  90 +++++++++++++++++++++++++++-
 3 files changed, 287 insertions(+), 12 deletions(-)

-- 
1.7.10.2.652.gdffd412
