From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 0/6 v3] Add execvp failure diagnostics
Date: Tue, 24 Jan 2012 23:32:21 +0100
Message-ID: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 23:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpovg-0005Xu-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab2AXWdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:33:05 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54821 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2AXWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:33:04 -0500
Received: by eaac13 with SMTP id c13so1306969eaa.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VaZvdQn7IcjOVfs3LL8kWlY5bZHwydfTsOAQ2DtZ5NM=;
        b=DqLwjZcvZ84DSRFJmz9CdHrk/veotCp4CMcNn/SfJxwJJz31QekUcoVsAMnPbIeOKn
         kEAtZcKAgmBl+EDesYMk4gkVaewdHVt2OhwoENQxfDlSytRRLIMvENJnggq+1nnI+shI
         SEipSKv0r2lbNOxTBZqdGEx9s7ZMibxe9NuVU=
Received: by 10.213.16.141 with SMTP id o13mr718347eba.61.1327444382023;
        Tue, 24 Jan 2012 14:33:02 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c37sm18739220eec.10.2012.01.24.14.33.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 14:33:01 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189077>

This patch series replaces $gmane/187026. It aims to improve the
information provided after execvp fails in run-command.

This series takes a rather different approach than the previous
one. In the former the focus was on determining what might cause
an EACCES failure. This series focuses on trying to provide hints
on what went wrong on any error.

The resulting checking produces behavior rather like bash, with the
notable exception that we consider "Not found and PATH access issues"
a failure, where bash doesn't.

[PATCH 1/5] t0061: Fix incorrect indentation
[PATCH 2/5] t0061: Add tests
[PATCH 3/5] run-command: Elaborate execvp error checking
[PATCH 4/5] run-command: Warn if PATH entry cannot be searched
[PATCH 5/5] run-command: Error out if interpreter not found

run-command.c          |  140 +++++++++++++++++++++++++++++++++++++++++++++---
t/t0061-run-command.sh |   57 ++++++++++++++++++-
2 files changed, 186 insertions(+), 11 deletions(-)
