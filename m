From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 13/16] send-email: extract_valid_address use qr// regexes
Date: Thu, 30 Sep 2010 19:03:31 +0000
Message-ID: <1285873411-14045-1-git-send-email-avarab@gmail.com>
References: <1285854189-10240-14-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 21:03:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1OQ1-00066i-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 21:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab0I3TDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 15:03:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49800 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab0I3TDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 15:03:41 -0400
Received: by wwj40 with SMTP id 40so278198wwj.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CbZaHAY6W2isDkCa0e0sCZhXsoMViAHhP+cdB5ai50U=;
        b=HU6PAz05pJWF+jK6UgnZFRbxkAPvhtOReUEFZfitbsb0nfHtOohiAmMshzdFl56C2G
         DKgTfJFHBy3aGRTVzIEuDRNMd+T7heZV9BVd6OQj8CwOz86/0ct2hh65BH3YCditzdKo
         n+cHirikwtVOKsQwM02t+rzn4qNoUWzGN6d2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=srHNpsMl9A/BE28gBbV+MyQqL/tPs8WxWtRVUr4XOO7FQyJzsX8FCcWSpKPgaBzmo5
         7g1DG1lQfavv6Aj1kIh0ANrbvCH3JjPlhkxG+MmzqdsTZrvSikZmyrCrCGx++w/sco8e
         qT/4SC3RZhXEaBoW3HFzgLQt/eFf7ZPCHXAPg=
Received: by 10.227.146.149 with SMTP id h21mr3606972wbv.153.1285873420428;
        Thu, 30 Sep 2010 12:03:40 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id g9sm167114wbh.19.2010.09.30.12.03.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 12:03:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-14-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157703>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Here's v2 which omits the confusing /o addition and just uses the more
correct qr// syntax over qq//.

 git-send-email.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b87c3f2..30000b9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -777,8 +777,8 @@ our ($message_id, %mail, $subject, $reply_to, $refe=
rences, $message,
=20
 sub extract_valid_address {
 	my $address =3D shift;
-	my $local_part_regexp =3D '[^<>"\s@]+';
-	my $domain_regexp =3D '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';
+	my $local_part_regexp =3D qr/[^<>"\s@]+/;
+	my $domain_regexp =3D qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
=20
 	# check for a local address:
 	return $address if ($address =3D~ /^($local_part_regexp)$/);
--=20
1.7.3.159.g610493
