From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/3] remote HEAD improvements
Date: Wed, 11 Feb 2009 01:01:20 -0500
Message-ID: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8BU-0008EH-97
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZBKGB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbZBKGB2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:01:28 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:18162 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZBKGB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:01:27 -0500
Received: by an-out-0708.google.com with SMTP id c2so32219anc.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MbfroT+PCr+KOpVF4mxHC1im51PmOO4fl0h5yHWMHbg=;
        b=HNONXdi+4gGdBSdt1umchHcxcMNo7ceykdeT684KcZ2tz0KRQO9M/U2250oROcfXad
         Znplx5Hp4YHKHfsuiiyc78zcPSIYEUkd0kcjVL5vQyyrztMHl2U41N4yf4lYlpDbfn6V
         w7NwVygE9T7bOdh22iyYKcCLCxcuUA/5ZJBLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=stuh6FQD8AbZ7cZtjD96JR0W2AzH72Ish0/HG5IA+PWAbTTmHplj6byPY4iDYYjbN/
         mGMf9xsEza0xDV4+8AhtxBl3X3qmEjt74QvXFBlvZN5iK8H+1hnKSu13SUS8d7sy75F2
         W21NRDGvT7TCojxTZc6BtRPHkWEdBK7Li3a0w=
Received: by 10.100.95.15 with SMTP id s15mr3175659anb.20.1234332085895;
        Tue, 10 Feb 2009 22:01:25 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b29sm4116299ana.51.2009.02.10.22.01.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:01:25 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.187.g9fcfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109374>

There is currently no porcelain for dealing with remote HEADs (i.e.
$GIT_DIR/remotes/<remote>/HEAD). This series:

1) Teaches git remote a new "sethead" verb:

  To set a remote HEAD explicitly:
  $ git remote sethead <name> <branch>

  To set a remote HEAD to match the upstream repo:
  $ git remote sethead <name> -a

  To delete a remote HEAD:
  $ git remote sethead <name> -d

2) Teaches git remote show to display the remote HEAD:

  $ git remote show origin

* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  HEAD: master

3) Documents the new sethead verb. I also correct the git remote man page
w/respect to the "-m <master>" option. The man page implied that the remote
HEAD was set automatically when adding a remote (a la git clone), but this is
not true. And, since I couldn't find anywhere else that the point of having a
remote HEAD is documented, I documented it here.

Jay Soffian (3):
  builtin-remote: move duplicated cleanup code its own function
  builtin-remote: teach show to display remote HEAD
  builtin-remote: add sethead verb

 Documentation/git-remote.txt |   20 +++++++-
 builtin-remote.c             |  108 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 118 insertions(+), 10 deletions(-)
