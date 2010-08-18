From: Knittl <knittl89@googlemail.com>
Subject: [PATCH] Do not display 'Switched to a new branch' when the branch existed
Date: Wed, 18 Aug 2010 10:28:26 +0200
Message-ID: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 10:28:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ole11-0003BO-GO
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 10:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab0HRI2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 04:28:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64062 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0HRI2r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 04:28:47 -0400
Received: by vws3 with SMTP id 3so343316vws.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=bwPnESghNUiNuCIJqgWahE5ExhaRuGhYbFebE9GO+Gw=;
        b=gDRzqFztRpKNR8Da2KpfWzgn7s7OSxQ95Fn8B+uqcPfY6FVbFKE8ffrmx9hsmcsd5+
         pmrw53YhT3Y6AfqwBhorcq5ByFAlNY04RDozVJgKOdpBmPZjwmopgaJ4q3Av+3BawnRJ
         vHs2yJX0UBIl4QML2GrFXq9gTBsZL7Ke0Rhks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=bfVYc9eqI6My+T91H7QUPKVpaFb/HqcBAsGS4ITSk9Ac3gVMbEUdjG6kBNb7+SXti5
         32pVryBdqJmZhiipo1aBXP8anweC6nmmbSU0pvY4TBCaDXx0NapJSGhndQR9VQTGwnNS
         l+y/20MNYYfTDT3l9kDCdABzBoHpJNuOm53R4=
Received: by 10.220.46.17 with SMTP id h17mr4793861vcf.174.1282120126347; Wed,
 18 Aug 2010 01:28:46 -0700 (PDT)
Received: by 10.220.179.8 with HTTP; Wed, 18 Aug 2010 01:28:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153815>

=46rom cc6410b89b85822aadc5a7843b7398209957e549 Mon Sep 17 00:00:00 200=
1
=46rom: Tay Ray Chuan <rctay89@gmail.com>
Date: Thu, 24 Jun 2010 03:29:00 +0800
Subject: [PATCH] builtin/checkout: fix info message for `git checkout <=
branch>`

Since 02ac98374eefbe4a46d4b53a8a78057ad8ad39b7 `git checkout` would
always display 'Switched to a new branch <branch>` even if the branch
had already existed.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---

git checkout should only display 'Switched to a new branch <branch>'
when it creates a new branch, not when it simply switches branches.

ps. I'm not sure about the style used in git for nested ternary
statements (if they should even be used =85)

 builtin/checkout.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4ad7427..ed7cde1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -536,7 +536,9 @@ static void update_refs_for_switch(struct
checkout_opts *opts,
 					new->name);
 			else
 				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->branch_exists ? " and reset" : " a new",
+					opts->branch_exists
+						? " and reset"
+						: opts->new_branch ? " a new" : "",
 					new->name);
 		}
 		if (old->path && old->name) {
--=20
1.7.1.574.g421e3
