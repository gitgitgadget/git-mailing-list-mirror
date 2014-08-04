From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 00/11] git_config callers rewritten with the new config-set API
Date: Mon,  4 Aug 2014 11:33:38 -0700
Message-ID: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN5j-0007R0-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbaHDSeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:36 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40143 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaHDSef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:35 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so10521493pac.31
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qo9Y5ZNe1pVbJtXdov4GaO6wpfm/+fyEBsZtBYsyERY=;
        b=iOPmZLZsK/okSyoTpEy5TS71tCSa2uo5GTmRcVjbYtClN8gy9i/Gw7mKndnHPwDazU
         i27MKgWht42BvQhOJ9U22Sn3bhc7Ucrday5Dveug6JdwV1MbiYgxZet4nf8fio+Hwupx
         59raepuSLc+PjLDaSuOaEDMS93uFjX0t6mimLoU6CBWk0woEgcIDGb2imMJo9bO0Tohm
         MkJ9WXhWOC3OU1DJcMzhZ+YxtaQeXZB+vEkm6dp963oeyDiIR2yMykZINxoNTGmVdcS1
         fxyc718YCRC+ZezpU1emkOQnkQ5IEfb7LEBLUJ9nxsge7FC6TLrVBVjnBw+mx6YPsxdr
         beTQ==
X-Received: by 10.70.61.194 with SMTP id s2mr25921902pdr.17.1407177275010;
        Mon, 04 Aug 2014 11:34:35 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254752>

The ta/config-set API is more or less solidified.

This series builds on the top of 4c715ebb in pu (ta/config-set). On top of it,
it also requires series [1] (Rewrite `git_config()` using config-set API) for
proper error checking.

This series is the first batch of patches which rewrites the existing callers
using a non-callback approach.
This series aims to,

* rewrite the existing callers, as you can see from the diff stat the bew API
  provides a much concise and clear control flow.

* stress test the new API, see if any corner cases or deficiencies arise or not.

The series passes all the tests, only thing to watch is that the config variables
that have been rewritten are single valued only. Though I have tried my best to
ascertain it, still mistakes may arise.

p.s: I haven't decided yet about whether to introduce a new helper set, for example
     git_config_get_value_fmt() which would behave like strbuf_addf(). It will probably
     come in a later series.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/254633/

Tanay Abhra (11):

 alias.c        | 25 ++++++------------------
 archive.c      | 12 +++---------
 branch.c       | 27 +++++++-------------------
 builtin/gc.c   | 51 +++++++++++++++++++-----------------------------
 daemon.c       | 27 +++++---------------------
 fetch-pack.c   | 35 ++++++++-------------------------
 http-backend.c | 31 ++++++++++++-----------------
 imap-send.c    | 61 ++++++++++++++++++++++++++--------------------------------
 pager.c        | 40 +++++++++++++-------------------------
 read-cache.c   | 14 +++-----------
 rerere.c       | 43 ++++++++++++-----------------------------
 11 files changed, 116 insertions(+), 250 deletions(-)

-- 
1.9.0.GIT
