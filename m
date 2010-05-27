From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/3] commit: fix abbrev-sha regression
Date: Thu, 27 May 2010 23:34:49 +0800
Message-ID: <1274974492-4692-1-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 27 17:35:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHf7H-0007kT-C6
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644Ab0E0PfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:35:22 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:45698 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab0E0PfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:35:19 -0400
Received: by pzk6 with SMTP id 6so93007pzk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=p/619VjuMTYG0XVGukIwlzmKvFKabhnyCXmNWnlRJJA=;
        b=Bj8dfLt9ZrMt4qc8bq7+xmyQgX0pcAU0KtIa8oQZKklTFtWbAxSzNMyUkUjoZI+L8K
         qxdAPe9u/bWLiEoo6IDqBqzwXYbuHUMW1V6VWcacmy1zlgY3L/WRh3Hb4m+FOkWgcnyu
         wn6dUVUgvZCp0U0ssz2SaLX7j3i0+MShAOGYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sVKtUFmQUDfqY+hXSAedRah+BQpPmuNQBh8lFEwbhIRhrqyrPDTGmrf/PihlpRRvL1
         w6j7vf61yMFVgj3JVgKdobJbIuEFZa8PgKS+EFhRbYmwb714u3mqh6RdQU7bhOQkn+Uh
         jpQuBGaN+23ElkYY7pmoaB2m5Ad9JWLX3NIuY=
Received: by 10.115.39.9 with SMTP id r9mr9161143waj.140.1274974518717;
        Thu, 27 May 2010 08:35:18 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id r20sm11007341wam.5.2010.05.27.08.35.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 08:35:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
In-Reply-To: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147876>

After c197702 (pretty: Respect --abbrev option), the summary output for
git-commit began to throw up non-abbreviated SHA-1s.

For example,

  $ git commit --allow-empty -m "empty"
  [master f869bf09c8eefee54094bb21387241aaf5f10324] empty

I also notice that this happens for merges after conflict resolutions.

This afflicts 'master', but not any release.

Changes from v1:

 - move cleanup commands into separate function in patch #1.
 - add a cleanup command to patch #1 to accomodate tests #20 and #22.
 - changed shell syntax in patch #2 (based on Junio's suggestion).
 - used a more "aggressive" fix in patch #3.

Contents:
[PATCH v2 1/3] t7502-commit: add tests for summary output
[PATCH v2 2/3] t7502-commit: add summary output tests for empty and merge commits
[PATCH v2 3/3] commit::print_summary(): set rev_info.always_show_header to 1
