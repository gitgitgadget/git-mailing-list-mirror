From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/4] Teach fetch --prune and --dry run options
Date: Mon,  9 Nov 2009 23:58:29 -0500
Message-ID: <1257829113-52168-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 05:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ioh-0004jV-Pj
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 05:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbZKJE6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 23:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZKJE6p
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 23:58:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:29818 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbZKJE6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 23:58:44 -0500
Received: by qw-out-2122.google.com with SMTP id 3so726576qwe.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 20:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZhyS/eUVYTTR5g1/Rw0cfmloIz7SSis00JSmo4AqyuA=;
        b=nBKcYmwTbPtlftO3lYXAodU2EDSMynfAA0aQE8g1Fqk+tzqpxqdjv0YjdmGX+M2OZG
         Fc+eno12afPAEjZv/4jkVcz9pPtlmb6o8UmRw3h1h3HgXujfD78i2jCghAHUZ1fAe4aG
         tdfN36Lfnvhp1u0fmiVbK/9Q1VIKWG+/jW/Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sSDUWuPHlZ1uS9+k7TqFUsKd30T7Czzyb5Qu0WaA0+2+W++tkXkMykO5TeEcaCt685
         goaFXbaWK2oYNwsGvjUQYEooFJQ1EDCANRpgUp2oiCF/itMt9AlAjOunRlKJrQZ1Xkoh
         IL9AMTxAm5b/jlseDKFaQUqEedH5TM2O2cd9U=
Received: by 10.224.121.80 with SMTP id g16mr4564179qar.316.1257829129742;
        Mon, 09 Nov 2009 20:58:49 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 23sm260409qyk.7.2009.11.09.20.58.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 20:58:48 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132527>

This series builds on bg/fetch-multi, by teaching fetch --prune, re-enabling
"remote update --prune" and ensuring its corresponding test now passes.

As a convenience to users used to "remote prune" supporting the "--dry-run"
option, we also teach this option to fetch since it's trivial to do so.

I've left out re-implementing "remote prune" as a synonym for "update --prune"
since it's not a 1:1 match. And as per Junio's comments, teaching fetch a 
"--prune-only" option would be a UI wart.

Jay Soffian (4):
  remote: refactor some logic into get_stale_heads()
  teach warn_dangling_symref to take a FILE argument
  builtin-fetch: add --prune option
  builtin-fetch: add --dry-run option

 Documentation/fetch-options.txt |    9 ++++++++
 builtin-fetch.c                 |   42 +++++++++++++++++++++++++++++++++++---
 builtin-remote.c                |   38 +++++++++++------------------------
 refs.c                          |    7 +++--
 refs.h                          |    2 +-
 remote.c                        |   40 +++++++++++++++++++++++++++++++++++++
 remote.h                        |    3 ++
 t/t5505-remote.sh               |    2 +-
 8 files changed, 108 insertions(+), 35 deletions(-)
