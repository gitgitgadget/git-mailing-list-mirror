From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 00/10] teach --progress to transport-related builtins
Date: Wed, 24 Feb 2010 20:50:19 +0800
Message-ID: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:50:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGhZ-00058b-KV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766Ab0BXMuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:50:46 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64550 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756456Ab0BXMup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:50:45 -0500
Received: by qyk9 with SMTP id 9so338835qyk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=76PNcHH42PqQNzclp6BA1ThfmlMfzC9uFedtNyTCdko=;
        b=HQrnPVu9whEzeOjlehQSVEld3PT/d9nWVmEc6tMstK8ly4QR/j15nMkoB+/mZ5PaVv
         8DOiRyV7sBajnmKgNfm+vYxGveOKG3obwLGouNGgkWjZ3cFkP6b4qlS20TO09xTLt0XP
         Y88AweJMKKPdqWRlXBBsdxiFh0rLI/QIBhpFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RAGUk27bNV7jdjMoQUto4dpverY+czA1EufntAd+OY3RBxU8QuTNB2AVSwFebn6jz6
         Zct1xNivVkq/ckUk4hKflNPbZVw7K+p7aTIj6Rq0f0V0ajAqQ6r+76iMbZJn+jOLSaP4
         m+gF7dGPzaF0GaupXmPDorWn7gFaTdiUFGOy0=
Received: by 10.224.55.8 with SMTP id s8mr7654934qag.10.1267015843812;
        Wed, 24 Feb 2010 04:50:43 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.50.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:50:43 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140931>

This patch series adds --progress to:

  - git-fetch
  - git-pull
  - git-push

Changes from v1:
  - rebased on git/next and resolved a conflict with the recent
    refactoring of print_push_status() in transports.

  - add a new patch for git-clone's documentation that mentions
    the effect of the -v/--verbose option on progress reporting.

    This should have been done with 5a518ad (clone: use --progress to
    force progress reporting), as per Miklos's suggestion
    (<20091227012032.GE25474@genesis.frugalware.org>).

  - put verbosity options (-v and -q) in a common area for the
    documentation for git-pull, as per Junio's suggestion
    (<7vhbpe5jvo.fsf@alter.siamese.dyndns.org>).

  - teach --progress to git-fetch and git-pull in one patch instead of
    two previously; after all, git-pull is a wrapper of git-fetch.

Contents:

[PATCH v2 01/10] Documentation/git-clone: mention progress in -v
[PATCH v2 02/10] Documentation/git-pull: put verbosity options before merge/fetch ones
[PATCH v2 03/10] Documentation/git-push: put --quiet before --verbose
[PATCH v2 04/10] fetch: refactor verbosity option handling into transport.[ch]
[PATCH v2 05/10] push: support multiple levels of verbosity
[PATCH v2 06/10] clone: support multiple levels of verbosity
[PATCH v2 07/10] transport->progress: use flag authoritatively
[PATCH v2 08/10] push: learn --progress
[PATCH v2 09/10] fetch and pull: learn --progress
[PATCH v2 10/10] transport: update flags to be in running order

 Documentation/fetch-options.txt |    9 ++++++++-
 Documentation/git-clone.txt     |    3 ++-
 Documentation/git-pull.txt      |   10 ++++++++++
 Documentation/git-push.txt      |   15 +++++++++++----
 Documentation/merge-options.txt |    2 ++
 builtin-clone.c                 |   19 ++++++-------------
 builtin-fetch.c                 |    7 +++----
 builtin-push.c                  |   11 ++++++++---
 git-pull.sh                     |    6 ++++--
 transport-helper.c              |    4 +---
 transport.c                     |   31 ++++++++++++++++++++++++++-----
 transport.h                     |   15 ++++++++++-----
 12 files changed, 91 insertions(+), 41 deletions(-)
