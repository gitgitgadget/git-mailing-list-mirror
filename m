From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [RFC PATCH] gitweb: use CGI with -utf8
Date: Wed,  1 Feb 2012 23:50:53 +0100
Message-ID: <1328136653-20559-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsj1D-0006LY-36
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab2BAWvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 17:51:01 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab2BAWu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:50:58 -0500
Received: by eaah12 with SMTP id h12so809481eaa.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=W/8QUKWG8htLuPfeppHX4nWWFtPFTa/oF3iF8pspbbY=;
        b=QhMqOkKdnsawLuNIQ3l08d1I276J+cCMR7QDtog/DfUc+ceLEnSr/rIHvpEHn6OIzQ
         QosmvdDj5dCdosrSijbyrQZuL72vOdP1e382Zpn8pXMUfsAtCv1HKksT+JD7D5/h7B5d
         jJU+A8+YJuIuRla5T4pPAPZyXCkkBn44NCZjo=
Received: by 10.213.108.145 with SMTP id f17mr83409ebp.113.1328136657255;
        Wed, 01 Feb 2012 14:50:57 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e12sm1764223eea.5.2012.02.01.14.50.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 14:50:56 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189551>

I noticed that gitweb tries a lot to properly process UTF-8 data, for
example it prints my name correctly in log and commit information, but
it echos junk in the search field. It looks like:

	Micha=C3=85=C2=82 Kiedrowicz

I don't know CGI well and I never touched gitewb code, but I found this
on http://www.lemoda.net/cgi/perl-unicode/index.html:

	use CGI '-utf8';
	my $value =3D params ('input');

I tried it and that fixed my problem. I'm not sure about the
consequences, maybe someone more experienced in CGI might help?
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..74d45b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -10,7 +10,7 @@
 use 5.008;
 use strict;
 use warnings;
-use CGI qw(:standard :escapeHTML -nosticky);
+use CGI qw(:standard :escapeHTML -nosticky -utf8);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
 use Encode;
--=20
1.7.3.4
