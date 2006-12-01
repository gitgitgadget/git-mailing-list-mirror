X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: pclouds@gmail.com
Subject: [PATCH 2/3] Prepare for grouped common command list generation
Date: Fri,  1 Dec 2006 22:08:30 +0700
Message-ID: <11649857203869-git-send-email-pclouds@gmail.com>
References: <1164985711791-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 1 Dec 2006 15:09:06 +0000 (UTC)
Cc: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:content-type:content-transfer-encoding:from;
        b=PDYjFebnqD+ojlOytzQyWLDQbXS+hEF51kzFC6/VgtrjX5bKP9Teo4fOjpt9gRnO3ZuoQuKNOiIdmjY0Xhm/4x15o42q1xWqrDA12ZnurfxkQFAZkkCjvKyFantan23HhouSdfL8wwkM2gSH+KXHeK3aoH2MTSqYhzjVEW2xV6k=
X-Mailer: git-send-email 1.4.3.3.g7854-dirty
In-Reply-To: <1164985711791-git-send-email-pclouds@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32933>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqA0c-0005qE-B6 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759190AbWLAPI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759285AbWLAPI6
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:08:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:23275 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1759190AbWLAPI5
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:08:57 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1550824nze for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 07:08:56 -0800 (PST)
Received: by 10.65.185.13 with SMTP id m13mr7805227qbp.1164985736243; Fri, 01
 Dec 2006 07:08:56 -0800 (PST)
Received: from localhost ( [125.234.253.165]) by mx.google.com with ESMTP id
 c5sm30172766qbc.2006.12.01.07.08.52; Fri, 01 Dec 2006 07:08:55 -0800 (PST)
Received: by localhost (sSMTP sendmail emulation); Fri,  1 Dec 2006 22:08:40
 +0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 generate-cmdlist.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 5450918..b45495d 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,7 +9,7 @@ struct cmdname_help
=20
 struct cmdname_help common_cmds[] =3D {"
=20
-sort <<\EOF |
+cat <<\EOF |
 add
 apply
 archive
@@ -41,6 +41,11 @@ verify-tag
 EOF
 while read cmd
 do
+     [ -z "$cmd" ] && continue
+     if echo $cmd|grep -q '^G:'; then
+       echo '  {"'$(echo -n $cmd|sed 's/^G://')'",""},'
+       continue
+     fi
      sed -n '
      /NAME/,/git-'"$cmd"'/H
      ${
--=20
1.4.4.rc1.g9124
