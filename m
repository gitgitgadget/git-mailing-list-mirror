From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 0/4] replace: add option to edit a Git object
Date: Sat, 26 Apr 2014 22:00:53 +0200
Message-ID: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 26 22:02:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We8oM-0000ML-Ee
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaDZUCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 16:02:46 -0400
Received: from [194.158.98.15] ([194.158.98.15]:40324 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750904AbaDZUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 16:01:58 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id D815548;
	Sat, 26 Apr 2014 22:01:33 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247183>

This patch series comes from what Peff sent in the following thread:

http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528

I added the following fixes:

- add "strbuf_release(&result);" in import_object(); this was suggested
  by Eric Sunshine
- use MODE_LIST instead of MODE_DELETE if no arguments are passed; this
  makes the test suite pass
- add "--no-replace-objects" when calling "git cat-file" in export_object();
  so that we edit the original object if an object is already replaced

I am not happy with the fact that if the user doesn't modify the object when
editing it, then a replace ref can still be created that points to the
original object. I think something should be done to avoid that.

Once that is fixed, I plan to add some tests and documentation, but I wanted
first to let you know that I am looking at this.

Jeff King (4):
  replace: refactor command-mode determination
  replace: use OPT_CMDMODE to handle modes
  replace: factor object resolution out of replace_object
  replace: add --edit option

 builtin/replace.c | 189 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 154 insertions(+), 35 deletions(-)

-- 
1.9.1.636.g20d5f34
