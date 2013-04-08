From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: [PATCH 2/4] gitweb: Make feed title valid utf8
Date: Mon, 08 Apr 2013 22:09:14 +0200
Message-ID: <m2y5csbx91.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 22:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPINq-0002Ca-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 22:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935924Ab3DHUJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 16:09:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50695 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935850Ab3DHUJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 16:09:32 -0400
Received: by mail-bk0-f46.google.com with SMTP id je9so3270223bkc.5
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=uFqj5qBwqgDdgNZ84Nvi9EPQg14rxuXgGTemC54bs7w=;
        b=jOWX2hXm441H8vZ788wtq4XbNx7lwmlUxZnJQQ9RHL+KWUY5dLbi73y0UGwJKc6VyS
         uTpjAHIK/dP8rbFAloBI+ei8lrICzrug+IxfWkp6plSeIQ/rdKuStHxqKXBQadYSBrba
         pLaKsKsvwK6HcOkWNCAYnKu9WKZXAnKzGaRKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=uFqj5qBwqgDdgNZ84Nvi9EPQg14rxuXgGTemC54bs7w=;
        b=HCWx2/0mW5T4tzcIyftBw9aUCwUEDlFRZzJOI9IEr7KuufrK16OjrnnyqxwRlrs8pD
         mBoC3TOdCHlW/ZuDnNA1FClGVV/cImX3tCy0Qq7cZlXUfPR5rtFlnEERT/CiNbJfXjX5
         zfna5CZqj9nRwHD0MxdVMS9UfVEHQ3HUGVjZlaWcIUpEqEn0U1lJmELGTM1/PKNwW+F1
         +I0qzZEXTa6fwHwMlN/dCRMkzm27zHbTrX280TaiTIKaqYyQQrSdOk9yHoMALv2KjvyN
         +LsVSxj1Q554MTGSLavm/f1+5pwKV0lnc+O9GpLGgk3go8GtS3cNXiz7NQRcnI8FRD25
         8PBA==
X-Received: by 10.205.114.195 with SMTP id fb3mr1294387bkc.117.1365451771103;
        Mon, 08 Apr 2013 13:09:31 -0700 (PDT)
Received: from zahir.local (p5083D2BC.dip.t-dialin.net. [80.131.210.188])
        by mx.google.com with ESMTPS id gm14sm13102601bkc.7.2013.04.08.13.09.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 13:09:30 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQnQq+i8Mdf41qEegwU5h+FdlXZpg//7XUG3gRaWm9B5RLEHpHjc/fKZyJhUxSItrZseQDEK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220508>

Properly encode site and project names for RSS and Atom feeds.

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cfe5b5..09294eb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8056,7 +8056,7 @@ sub git_feed {
 	return if ($cgi->request_method() eq 'HEAD');
=20
 	# header variables
-	my $title =3D "$site_name - $project/$action";
+	my $title =3D to_utf8($site_name) . " - " . to_utf8($project) . "/$ac=
tion";
 	my $feed_type =3D 'log';
 	if (defined $hash) {
 		$title .=3D " - '$hash'";
--=20
1.7.10.4
