From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 0/6] send-email: cleaner tests and quote email
Date: Tue,  7 Jun 2016 16:01:42 +0200
Message-ID: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 16:02:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAHaI-0005MJ-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbcFGOCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:02:17 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:44124 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbcFGOCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:02:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 492552561;
	Tue,  7 Jun 2016 16:02:12 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EGzHmpbRJdJ3; Tue,  7 Jun 2016 16:02:12 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 390DD24F3;
	Tue,  7 Jun 2016 16:02:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 352AA2066;
	Tue,  7 Jun 2016 16:02:12 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHVXXnoJ-YMA; Tue,  7 Jun 2016 16:02:12 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033003.grenet.fr [130.190.33.3])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C698A2064;
	Tue,  7 Jun 2016 16:02:11 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc0.40.g1232aeb.dirty
In-Reply-To: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296680>

The purpose of this series of patches is to implement a new
"quote-email" feature integrated in the current `--in-reply-to` option.


 * The first 2 patches make the tests less dependent to
   `git send-email`'s exact output.

 * Third patch makes `git send-email` a bit less verbose.

 * Fourth patch introduces our email parser subroutine.

 * Fifth patch makes the `--in-reply-to` open a email file (if it
   exists) and populates From:, To:, Cc:, In-reply-to and
   References: fields.

 * Sixth patch quotes the message body in the cover letter if
   `--compose` is set. Else, imply `--annotate` and insert quoted
   message body below triple-dash in the first patch.


General changes since v2:
 - Modify tests to be less dependent on `git send-email`'s exact
   output.
 - New email parser subroutine.
 - `--quote-email` option is now merged with `--in-reply-to`.
 - Add `--cite` option to quote the message body.
 - `git send-email` is less verbose.

 Documentation/git-send-email.txt |  17 +++++--
 git-send-email.perl              | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 t/t9001-send-email.sh            | 238 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 3 files changed, 356 insertions(+), 77 deletions(-)
