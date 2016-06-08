From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: (unknown)
Date: Wed,  8 Jun 2016 15:01:36 +0200
Message-ID: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	e@80x24.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAd95-00032Q-8i
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425490AbcFHNDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:03:36 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:44601 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425335AbcFHNDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:03:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 84C972591;
	Wed,  8 Jun 2016 15:03:30 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m2D3EM7kfY0I; Wed,  8 Jun 2016 15:03:30 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 751E22415;
	Wed,  8 Jun 2016 15:03:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 6EBE92066;
	Wed,  8 Jun 2016 15:03:30 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id My4opy-YmP_R; Wed,  8 Jun 2016 15:03:30 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id DB2442064;
	Wed,  8 Jun 2016 15:03:29 +0200 (CEST)
Subject: 
X-Mailer: git-send-email 2.8.2.667.gf43de12
In-Reply-To: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296788>


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


Changes since v3:
 - test_cmp_noorder shell function fixed             (patch 1/6)
 - use fgrep instead of grep                         (patch 2/6)
 - typo fixed                                        (patch 3/6)
 - email parser subroutine moved to Git.pm library   (patch 4/6)
 - test if $mail->{"cc"} is defined                  (patch 5/6)

  [PATCH v4 1/6] t9001: non order-sensitive file comparison
  [PATCH v4 2/6] t9001: check email address is in Cc: field
  [PATCH v4 3/6] send-email: shorten send-email's output
  [PATCH v4 4/6] send-email: create email parser subroutine
  [PATCH v4 5/6] send-email: --in-reply-to=<file> populate header
  [PATCH v4 6/6] send-email: add option --cite to quote the message

 Documentation/git-send-email.txt |  17 +++++-
 git-send-email.perl              | 150 ++++++++++++++++++++++++++++++++++++++++++++-----
 perl/Git.pm                      |  34 ++++++++++++
 t/t9001-send-email.sh            | 190 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 339 insertions(+), 52 deletions(-)
