From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 00/13] New output style for git remote show
Date: Mon, 23 Feb 2009 01:28:48 -0500
Message-ID: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULI-00072Y-VM
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbZBWG3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZBWG3I
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:65030 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZBWG3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:07 -0500
Received: by gxk22 with SMTP id 22so4839738gxk.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/56L9nH1jlnGO7wHz0TS9ZK2lyh49E5bMOK0CsaD7gY=;
        b=mhmJG59eQTEO23Orzk4IzztshVWZcqvJuQlvoEhl6G2pNEyyFqqqDuflfxtKijDPMA
         xjDaOetwngLIqZCfc6J22XrnuY2vAPGz+QMUs2jCakfFnaEwDP0AdgNx/nPx1W84gDEE
         AbyBIArqDx6aidSk/5On4GShforVg0T4afWQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NQvYzjw3sDjqJQtT5h31eCjvC1iNOnmFW1vNjZOXvQDOPDuWIbX/zlqoytNCNxdERI
         oHeCjYKYtWmpcAxrohYPzRno0LKJf6kaltvjcCIXa8H5IpClOZOOALCUqJ/Kie2p8GUr
         Aj0Jzj5B7eAy0mc/DtbJDF4klLgMQK3WdcaTE=
Received: by 10.100.123.11 with SMTP id v11mr3563123anc.71.1235370545475;
        Sun, 22 Feb 2009 22:29:05 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c29sm4867599anc.3.2009.02.22.22.29.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:04 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111090>

Junio, this is based on pu, as it builds on my and Jeff's git remote
changes. Patches 1-7 are about new output style for "git remote show"
for everything but the push refspecs. Patches 8-13 then culiminate in
teaching it a new output style for push refspecs as well.

1-4 were previously a single patch which I broke up per your feedback
(gmane 110806).

Jay Soffian (13):
  remote: rename variable and eliminate redundant function call
  remote: remove unused code in get_ref_states
  remote: fix two inconsistencies in the output of "show <remote>"
  remote: make get_remote_ref_states() always populate states.tracked
  remote: name remote_refs consistently
  string-list: new for_each_string_list() function
  remote: new show output style
  refactor duplicated get_local_heads() to remote.c
  refactor duplicated ref_newer() to remote.c
  remote.c: make match_refs() copy src ref before assigning to peer_ref
  remote.c: don't short-circuit match_refs() when error in
    match_explicit_refs()
  remote.c: refactor get_remote_ref_states()
  remote: new show output style for push refspecs

 builtin-remote.c    |  469 ++++++++++++++++++++++++++++++++++++++++-----------
 builtin-send-pack.c |   78 +---------
 http-push.c         |   72 +--------
 remote.c            |   88 +++++++++-
 remote.h            |    2 +
 string-list.c       |   10 +
 string-list.h       |    5 +
 t/t5505-remote.sh   |   66 +++++---
 8 files changed, 516 insertions(+), 274 deletions(-)
