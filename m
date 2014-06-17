From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 0/3] add strnncmp() function
Date: Tue, 17 Jun 2014 00:34:36 -0700
Message-ID: <cover.1402990051.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:35:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwnvH-0003q8-FK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 09:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbaFQHfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 03:35:09 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53283 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaFQHfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 03:35:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so2283045pbb.8
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Nz4umcJ6qOo7d9qambEolUzWn1Q09TQSbBfESGT5a+A=;
        b=xz6rEYp12aVZbnVSrx5walVLhRxbW+0IWTfr2lgpe84skVqfy0lOijhzuE2lbcbcb0
         BCf2c2Im9VfEbvPAGx0DW6/INJHu9l+ca9fH0z+6JmccxQ/A4LszQ6ZYIgypBzzyIdL0
         XcR+KNruiuLM2S+CP+wYqBiHPH8QRuCT2DCa4V0mpd3TpnOqEuy00pyoBFQx0EQANqpa
         76Fip5Y1MrTcnU2UCC5q7wBqAuWPzh9JlCOfWOQsFBmgjERd9M5l6VVbePkXNC2Mv1uE
         DEAQmhD4kLFB+VQJHo1fkWPTYbOSvKgmvI96O/7zb6EYKIfysixJdIHw+u0IxRgjJTn9
         Q05Q==
X-Received: by 10.66.180.141 with SMTP id do13mr29938918pac.93.1402990507802;
        Tue, 17 Jun 2014 00:35:07 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fn2sm80908230pab.22.2014.06.17.00.35.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 00:35:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.695.g38ee9a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251847>

Add a strnncmp() function which behaves like strncmp() except it takes
the length of both strings instead of just one.

Then simplify tree-walk.c and unpack-trees.c using this new function.
Replace all occurrences of name_compare() with strnncmp().  Remove
name_compare(), which they both had identical copies of.

Version 2 includes suggestions from Jonathan Neider [1]:

  - Fix the logic which caused the new strnncmp() to behave differently
	from the old version.  Now it is identical to strncmp().

  - Improve description of strnncmp().

Also, strnncmp() was switched from using memcmp() to strncmp()
internally to make it clear that this is meant for strings, not
general buffers.

[1]: http://marc.info/?l=git&m=140294981320743&w=2

Jeremiah Mahler (3):
  add strnncmp() function
  tree-walk: simplify via strnncmp()
  unpack-trees: simplify via strnncmp()

 strbuf.c       |  9 +++++++++
 strbuf.h       |  2 ++
 tree-walk.c    | 16 +++-------------
 unpack-trees.c | 13 +------------
 4 files changed, 15 insertions(+), 25 deletions(-)

-- 
2.0.0.695.g38ee9a9
