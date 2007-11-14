From: "shunichi fuji" <palglowr@gmail.com>
Subject: [PATCH] git-clean: consider core.excludesfile
Date: Wed, 14 Nov 2007 16:40:33 +0900
Message-ID: <30046e3b0711132340y2c503dd4laea24b9b1c79a160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 08:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsCrj-000541-ML
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 08:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbXKNHkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 02:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbXKNHkg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 02:40:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:49204 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbXKNHkf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 02:40:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so70317nfb
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 23:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=G+CpRPSXrguHQlBwUqP+6Nb8LL6YabmrZVH7elgwn5A=;
        b=IH0Md89Quz2HGMUcy1mV6KXhBujYULgNcx5eSzLRr2Ek+yyvFnMNlqTIXP/vRGRnfX1v7+Ypb0qvxiu71daEpLn88/FpgAHh9uboymP4IC9Kw2o+2/kg56/87pKAq5CqLLgFxQIwA1PYGS73/oL97M4cF/bMaxRZvkuX7Sp1JlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NpiV4V5uiK8tVUzPtjxuS2w6kXUbyjwlbbDD4noL4Sm9jVO73UqnCyeCtDobfWLjYzfNhU/7EMmZ5HTTs3wJJfYru+QgRrDRwgOo1C7dNLmXAd5StrU0HlzLBQULRTLSRUJ9LNc6ZrypYGgn4oOqztHYljroHdi/XDcTjT79OsM=
Received: by 10.86.90.2 with SMTP id n2mr6619794fgb.1195026033690;
        Tue, 13 Nov 2007 23:40:33 -0800 (PST)
Received: by 10.86.51.7 with HTTP; Tue, 13 Nov 2007 23:40:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64956>

git-clean used "git ls-files" and "git ls-files" don't consider
core.excludesfile.
i add few lines.

--- /usr/bin/git-clean  2007-11-14 08:26:20.000000000 +0900
+++ git-clean   2007-11-14 09:43:03.000000000 +0900
@@ -81,9 +81,14 @@
       if [ "$ignoredonly" ]; then
               excl="$excl --ignored"
       fi
+       core_excl="`git-config core.excludesfile`"
+       if [ -f "$core_excl" ]; then
+               core_excl_info="--exclude-from=$core_excl"
+       fi
 fi

-git ls-files --others --directory $excl ${excl_info:+"$excl_info"} -- "$@" |
+git ls-files --others --directory $excl ${excl_info:+"$excl_info"} \
+${core_excl_info:+"$core_excl_info"} -- "$@" |
 while read -r file; do
       if [ -d "$file" -a ! -L "$file" ]; then
               if [ -z "$cleandir" ]; then
