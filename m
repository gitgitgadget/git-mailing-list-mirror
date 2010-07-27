From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] examples/commit: use --abbrev for commit summary
Date: Tue, 27 Jul 2010 13:44:51 -0500
Message-ID: <20100727184450.GE5578@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino>
 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
 <20100727182942.GB5578@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:46:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdpAY-0000Q5-FH
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0G0SqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 14:46:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37173 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab0G0SqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:46:20 -0400
Received: by wwj40 with SMTP id 40so1566586wwj.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0AbrIDd9taTMfyvmvpVEF9TS6mNKcu2bGH7u3Vo88UY=;
        b=IhEiGBipm+/LVYCjRn0bXCDw1GEXYefocdNrPoTp1fDS4I4kdJrRM5UjlAkCtJuWUA
         v+nR2CQRcL3g4Qfnm0PbdymZ7wSCju9CK15wEIlzaFhJDuLZ+kDBi96P4WeveGj+QZXo
         rwWlcUnN4yzZD9DmhaFZfZsRey3vHlySnWBuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FxAKrZJyUL2AdaEcHpt/BSuaxtY3CsSTPFParKu6/El0wTU+9awQjJpoXUARWBiQR2
         PVSTmwpeBb/FpLjI7sn88jCjJhlh3xtnrQoHEKJzCOP4PhYmsEeGTtwiDJcGRFtlln+/
         IdVw2TU39bQ3IyWwDJ7B7e73YoYIAVhEB1YYo=
Received: by 10.227.144.18 with SMTP id x18mr9252029wbu.105.1280256360563;
        Tue, 27 Jul 2010 11:46:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e31sm4490461wbe.23.2010.07.27.11.45.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:45:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100727182942.GB5578@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151973>

After v1.7.1.1~17^2~3 (pretty: Respect --abbrev option, 2010-05-03),
plumbing users do not abbreviate %h hashes by default any more.

Noticed while investigating the bug fixed by v1.7.1.1~17^2
(commit::print_summary(): don't use format_commit_message(),
2010-06-12).

Cc: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Again, sorry for the trouble.

Maybe diff-tree should always abbreviate the format %h.  That would
make the Parents: line and %p format produce different result when
the --abbrev option is not supplied.

I could go either way.

 contrib/examples/git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 5c72f65..23ffb02 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -631,7 +631,7 @@ then
 	if test -z "$quiet"
 	then
 		commit=`git diff-tree --always --shortstat --pretty="format:%h: %s"\
-		       --summary --root HEAD --`
+		       --abbrev --summary --root HEAD --`
 		echo "Created${initial_commit:+ initial} commit $commit"
 	fi
 fi
-- 
1.7.2.21.g04ff
