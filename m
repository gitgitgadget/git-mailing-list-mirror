From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 00/10] Adding RFC3161 time-stamps to tags
Date: Thu, 17 Mar 2016 19:46:51 +0100
Message-ID: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:48:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxr-0007lV-R1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935806AbcCQSrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:47:35 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43301 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932508AbcCQSre (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:34 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id A57E258C4C6;
	Thu, 17 Mar 2016 19:47:30 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:30 +0100
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289150>

Hi all,

this patch series adds RFC3161 time-stamping functionality to git tags.
This enables users to create and verify cryptographic time stamp signatures to
prove that a commit existed at a certain point in time.

The new RFC3161 time-stamping functionality is independent from GPG signatures.
However, GPG signatures include time-stamp signatures and therefore make them
robust against removal or replacement.

The time stamp signature is stored in the git tag object header under the
`timesig` key, which is equivalent to the format for GPG signatures in signed
commits. This facilitates a possible implementation of time-stamped commits in
the future.

We added two new helper commands, because of their dependencies on libcurl and
libcrypto respectively. If one of the libraries is missing, a warning message is
given when one of the new functionalities is used.

We tried to add as much documentation as possible. Especially timestamp-util.c,
which depends on libcrypto, is a bit tough to read.

Some configuration variables have been added, where `ts.tsaurl` is the most
important, which specifies the Time Stamping Autority to use.

For testing the implemented functionality, the Time Stamping Authority
SafeCreative can be used, which is free for non-commercial use:
https://tsa.safecreative.org.
Simply set the config variable ts.tsaurl to this TSA.

Your feedback is welcome.
Kind regards,
Anton Wuerfel
Phillip Raffeck

Anton Wuerfel (10):
Phillip Raffeck (10):
  Add Testcases for time-stamping functionality
  Documentation for time-stamping functionality
  Documentation: Whitespace fix
  Extending internal CURL wrapper for POST upload
  Make PGP macros global
  Add basic RFC3161 functionality
  Add git-http-timestamp helper tool
  Adding time-stamping helper tool
  Add time-stamping functionality to git verify-tag
  Add time-stamping functionality to git tag

 .gitignore                           |   2 +
 Documentation/config.txt             |  20 ++
 Documentation/git-http-timestamp.txt |  32 ++
 Documentation/git-tag.txt            |  32 +-
 Documentation/git-timestamp-util.txt |  52 +++
 Documentation/git-tsa-store.txt      |  68 ++++
 Documentation/git-verify-tag.txt     |  28 +-
 Makefile                             |  15 +
 builtin/tag.c                        |  55 +++-
 builtin/verify-tag.c                 |  61 +++-
 command-list.txt                     |   2 +
 gpg-interface.c                      |   3 -
 gpg-interface.h                      |   3 +
 http-timestamp.c                     |  76 +++++
 http.c                               |  30 +-
 http.h                               |  17 +-
 remote-curl.c                        |   2 +-
 rfc3161.c                            | 219 +++++++++++++
 rfc3161.h                            |  12 +
 t/t7031-verify-tag.sh                |  69 ++++
 timestamp-util.c                     | 615 +++++++++++++++++++++++++++++++++++
 21 files changed, 1380 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/git-http-timestamp.txt
 create mode 100644 Documentation/git-timestamp-util.txt
 create mode 100644 Documentation/git-tsa-store.txt
 create mode 100644 http-timestamp.c
 create mode 100644 rfc3161.c
 create mode 100644 rfc3161.h
 create mode 100755 t/t7031-verify-tag.sh
 create mode 100644 timestamp-util.c

-- 
2.8.0.rc0.62.gfc8aefa.dirty
