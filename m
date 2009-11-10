From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/4] Teach fetch --prune and --dry run options
Date: Tue, 10 Nov 2009 00:03:30 -0500
Message-ID: <1257829414-52316-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 06:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7itR-0006Cg-TH
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbZKJFDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbZKJFDi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:03:38 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:6023 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZKJFDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:03:38 -0500
Received: by qw-out-2122.google.com with SMTP id 3so727058qwe.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9AsbZ3/FeME+AzmnnjYe0X9Vf1er2VJE53ree2A9CZc=;
        b=DxHoOCRNYfVxoLQJWUHXTVXKZ54l7dcbFQk5RjWKtfxHUXfxgYl3SJlEmbJuFJiTaZ
         KmVRY43N0VLnqR4knVir9Akwx39asysNiBImU/9naVQBcHOxHrEdUA9k+G5qdK1FpV6o
         S5Anb09/fy7yFxnQ2ookDVWzAwYH5LmhVjIyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=J51WfaDQYelsVNzvTTkLvlZSiDcOrwUwasBS+pis5VDLYG0Qp7UoDc/CJivI//dmcE
         tQsXuCOtJ2a1eXVuHQKkddxMkBVRWLJRMmcScaYdYZSOVfglUnETuhOasOj2UDAG8lbE
         5Mrp5cCkAYJaqcWkXtEuUkuZi9/SYwz2bv4uQ=
Received: by 10.224.58.163 with SMTP id g35mr4595642qah.330.1257829423576;
        Mon, 09 Nov 2009 21:03:43 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 21sm262982qyk.0.2009.11.09.21.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 21:03:42 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132532>

(Darn it, I left the SOB off. This is a resend of the series with SOB. Sorry
for the noise...)

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
