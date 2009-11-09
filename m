From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 4/5] Add missing test for 'git remote update --prune'
Date: Mon, 09 Nov 2009 21:11:59 +0100
Message-ID: <4AF8778F.1090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 21:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ab4-0000fh-AZ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbZKIUL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 15:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbZKIUL6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:11:58 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38733 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbZKIUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:11:56 -0500
Received: by ewy3 with SMTP id 3so3513753ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=0TsQIIBSjgMeq9DH5vvaucLtD+W4qkdtzIFGsyDNES8=;
        b=M8l1ZgDrjEeziwseyZX8LHlQh38WvX0Eezm0y9vik0pPUg/kUFbiC/hdtM33gsZeoE
         2M4bBVG3DQqANizHaK/DaPL7rZm7bq3k6iWUilh42CZBtp0Z6hMOt8Pp0XyF5b3UpRwE
         UH/MnDuGjAkslBdr0zGFOdaDWXQUO2yNVnons=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=j8gTYBDolsCPEgLgiIqPbjuuEkdwrJeErJCEDS9TWi4KzLXGMYhjiFrxXIdsfElOMH
         0xHj1zccnGkrBWeG7FAnZFDXEqhX/lEQrNuhZDMtT+GaqTat9BkJ8jwgsWC84j/yqFfb
         /09KbFAMD78/BqaoQnmeAKW4Xx3aUztWXQ5Ks=
Received: by 10.213.110.17 with SMTP id l17mr3148322ebp.91.1257797521195;
        Mon, 09 Nov 2009 12:12:01 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm83220eya.4.2009.11.09.12.12.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 12:12:00 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132517>


Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t5505-remote.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 852ccb5..e931ce6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -365,6 +365,17 @@ test_expect_success 'update with arguments' '
=20
 '
=20
+test_expect_success 'update --prune' '
+
+	(cd one &&
+	 git branch -m side2 side3) &&
+	(cd test &&
+	 git remote update --prune &&
+	 (cd ../one && git branch -m side3 side2)
+	 git rev-parse refs/remotes/origin/side3 &&
+	 test_must_fail git rev-parse refs/remotes/origin/side2)
+'
+
 cat > one/expect << EOF
   apis/master
   apis/side
--=20
1.6.5.1.69.g36942
