From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/4] git-am: use trailers to add extra signatures
Date: Thu, 7 Apr 2016 18:23:03 +0300
Message-ID: <1460042563-32741-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 17:23:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoBm5-0004t9-T5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157AbcDGPXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcDGPXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:23:07 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3349F85A00;
	Thu,  7 Apr 2016 15:23:07 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37FN4KK018497;
	Thu, 7 Apr 2016 11:23:04 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290916>

I'm using git am to apply patches, and I like the ability
to add arbitrary trailers instead of the standard Signed-off-by
one.

To this end, I have extended git am to call git interpret-trailers
internally. This way I can add arbitrary signatures.

For example, I have:
[trailer "t"]
        key = Tested-by
        command = "echo \"Michael S. Tsirkin <mst@redhat.com>\""
[trailer "r"]
        key = Reviewed-by
        command = "echo \"Michael S. Tsirkin <mst@redhat.com>\""
[trailer "a"]
        key = Acked-by
        command = "echo \"Michael S. Tsirkin <mst@redhat.com>\""
[trailer "s"]
        key = Signed-off-by
        command = "echo \"Michael S. Tsirkin <mst@redhat.com>\""

And now:
	git am -t t -t r -t s
adds all of:
	Tested-by: Michael S. Tsirkin <mst@redhat.com>
	Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
	Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This was originally suggested by Junio (a long time ago).

Documentation and tests are still TBD.

Michael S. Tsirkin (4):
  builtin/interpret-trailers.c: allow -t
  builtin/interpret-trailers: suppress blank line
  builtin/am: read mailinfo from file
  builtin/am: passthrough -t and --trailer flags

 trailer.h                    |  2 +-
 builtin/am.c                 | 57 +++++++++++++++++++++++++++++++++++++++++++-
 builtin/interpret-trailers.c | 11 ++++++---
 trailer.c                    | 10 +++++---
 4 files changed, 72 insertions(+), 8 deletions(-)

-- 
MST
