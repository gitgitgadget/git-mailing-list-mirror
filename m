From: David Turner <dturner@twopensource.com>
Subject: [PATCH 00/24] Yet another pre-refs-backend series
Date: Thu,  7 Apr 2016 15:02:47 -0400
Message-ID: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDD-0006ye-DP
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbcDGTDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:22 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:32928 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730AbcDGTDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:21 -0400
Received: by mail-qg0-f48.google.com with SMTP id j35so71752900qge.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dGrNujfcu474vMSshqFLyfv5Mh07wLdm4ftgzW1kGsk=;
        b=pHaS6xKTnCq3hgSFjLiOA9c/ATrj2EpAyyLhCmMZXgNcooqbcrcle6EdHnb6wuqMRa
         ds3XWWKiobVbq5jwJzify5359HlWWA/juOr8gL4I0O/oNxUDiG9hcECJazmK0xzAvDss
         SpI/D5IRrNcM2IUXdgVFiuqA/vy0P/Ln0WyEH7xNdwE7jniXup8NnHHVu/hYY9mUYJfh
         +yddsEzml7GZBl9uz//FXzvvIHL503l4F1NiWXv5TtXOqg927G4T/OfZGmNGkWA6T7c4
         zx5laHcifKqAM2iPoLgweiI35DRr9aFlOCIh7ko4klgsocnQdBsWjeNRI2C/BggZy/sr
         5iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dGrNujfcu474vMSshqFLyfv5Mh07wLdm4ftgzW1kGsk=;
        b=mi2Mdu7AoqeP04Mvnv8eC5gHMSMeor3WU0qXgRWpWqlmA/aHUy4Me4Wszyd8MWA60p
         8HsOnbHODw3YFHqWcQ8EdgzGetBtiYUvDORUGAJqcXea9MnmR1yj7f7s4WexkIrvXEky
         /nGy5ISeZMIYXxANue2FBcy6EcPbxpxwjhYa5dyGn9iVFhsYAVhQQypuKzTBb/zmE3nX
         Wem/Y3Cmr05BT4hc4H9HKCctgUKUUUx8Jzh2N4AOpVb2XytjVc0t5TT/haM6jvcCt7y+
         eH+gqlKx4qMexAHC/3criaFEjInA53wnCw6W9bjMokCGH1ml6kWgHUBq24pGhKCKG6cj
         mLog==
X-Gm-Message-State: AD7BkJLOh3cl5OZHahW3wsp/Fc/Ahh+1BzimwVKVQBpS+kXy/tDernduRBLOauaTaDC1vQ==
X-Received: by 10.140.253.197 with SMTP id y188mr6104749qhc.67.1460055800038;
        Thu, 07 Apr 2016 12:03:20 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290953>

We now have quite a large number of patches before we even get into
the meat of the pluggable refs backend series.  So it's worth breaking
those out and getting them in before we get into the main series
(which Michael Haggerty swants to redesign a bit anyway).

This set of patches should be applied on top of
jk/check-repository-format.

Michael Haggerty has reviewed those of my patches which are in here
except maybe:
  refs: on symref reflog expire, lock symref not referrent
This was the one from later in the series that was straightforward to
move to before the vtable; the other two were going to be harder to
move and can wait until after the vtable.

I have reviewed all of Michael's patches.


David Turner (5):
  refs: move head_ref{,_submodule} to the common code
  refs: move for_each_*ref* functions into common code
  files-backend: break out ref reading
  refs: move resolve_ref_unsafe into common code
  refs: on symref reflog expire, lock symref not referrent

Michael Haggerty (19):
  t1430: test the output and error of some commands more carefully
  t1430: clean up broken refs/tags/shadow
  t1430: don't rely on symbolic-ref for creating broken symrefs
  t1430: test for-each-ref in the presence of badly-named refs
  t1430: improve test coverage of deletion of badly-named refs
  resolve_missing_loose_ref(): simplify semantics
  resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
  resolve_ref_unsafe(): ensure flags is always set
  resolve_ref_1(): eliminate local variable
  resolve_ref_1(): reorder code
  resolve_ref_1(): eliminate local variable "bad_name"
  read_raw_ref(): manage own scratch space
  Inline resolve_ref_1() into resolve_ref_unsafe()
  read_raw_ref(): change flags parameter to unsigned int
  fsck_head_link(): remove unneeded flag variable
  cmd_merge(): remove unneeded flag variable
  checkout_paths(): remove unneeded flag variable
  check_aliased_update(): check that dst_name is non-NULL
  show_head_ref(): check the result of resolve_ref_namespace()

 builtin/checkout.c      |   3 +-
 builtin/fsck.c          |   3 +-
 builtin/merge.c         |   4 +-
 builtin/receive-pack.c  |   2 +-
 http-backend.c          |   4 +-
 refs.c                  | 149 ++++++++++++++++++
 refs/files-backend.c    | 406 ++++++++++++++++--------------------------------
 refs/refs-internal.h    |  15 ++
 t/t1410-reflog.sh       |  10 ++
 t/t1430-bad-ref-name.sh | 132 ++++++++++++++--
 10 files changed, 440 insertions(+), 288 deletions(-)

-- 
2.4.2.767.g62658d5-twtrsrc
