From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 0/3] More fool-proof "git rebase --whitespace=fix"
Date: Wed, 17 Feb 2010 08:02:51 +0100
Message-ID: <4B7B949B.6020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 08:03:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhdw4-0006as-Ur
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 08:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab0BQHCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 02:02:55 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:60501 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0BQHCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 02:02:54 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1679282eyd.19
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 23:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=2HT8TS9piq/jHaQYS4jbDI0HShuBSY1bAjhU3Q/X07s=;
        b=GZtwhu4ZGEykbS+E/ngM1XsofKvRLYzpjCHQ26QZ57zCzVnpyVqesD4QRNiIYAcalW
         JCP6k+BOvHIa/mn49TCHWzZpd8cxxzHkoIZqyxWmFg8GCypFys+lPq6XTKfI1XJp1qOb
         xv5GUaud1NaCWgdK43sB5A/qgVrruSl00lY/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ZN4NdubN0iL8GCGmz9335d7bHUGJIyofyXORNqViL6+fs5268jlknoOEm4/tldrbPY
         BwDC3SLPtBQ0AegK6etfrIg4IqWBEF5SR/VEXub/HJ3Xc3Cg6ZHzYeBZYWQEK8yMrUna
         8G158+F4qveJlASRX9yf3XDTktCU3AlD2o3sY=
Received: by 10.213.59.145 with SMTP id l17mr4813437ebh.56.1266390172962;
        Tue, 16 Feb 2010 23:02:52 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm20132375eyg.36.2010.02.16.23.02.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 23:02:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140207>

This is the first step in making sure that "git rebase --whitespace=3Df=
ix HEAD~<number>"
will never fail.

As suggested by Junio, the first step consists in changing "git apply w=
hitespace=3Dfix"
to be smarter about previously deleted blank lines at the end of the fi=
le.

I would be grateful for any feedback on the design decisions and the im=
plementation.

Bj=C3=B6rn Gustavsson (3):
  apply: Allow blank context lines to match beyond EOF
  t4124: Add additional tests of --whitespace=3Dfix
  t3417: Add test cases for "rebase --whitespace=3Dfix"

 builtin-apply.c                  |  127 ++++++++++++++++++++++++++++++=
++------
 t/t3417-rebase-whitespace-fix.sh |  126 ++++++++++++++++++++++++++++++=
+++++++
 t/t4124-apply-ws-rule.sh         |   12 ++++
 3 files changed, 246 insertions(+), 19 deletions(-)
 create mode 100755 t/t3417-rebase-whitespace-fix.sh
