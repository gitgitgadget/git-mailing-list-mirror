From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 0/3] rev-parse: allow --flags to output rev-parse-like flags
Date: Sat, 25 Sep 2010 21:22:40 +1000
Message-ID: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 13:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzSnh-0002GO-5G
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 13:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756304Ab0IYLTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 07:19:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45526 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab0IYLTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 07:19:48 -0400
Received: by pzk34 with SMTP id 34so841133pzk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+Dgt/JbXMTx4AZuMrE3KjXsoDTKMNA9lPrbqo56w/6s=;
        b=VpsyXAfm61uMqNVRt72d17GHXCtmvtVSAenpT6xLgIk9TBCdg8elSczZ0EezUeEmKO
         wcy+cifN1l3vujAdK2HarofxXhL9aB6kYi2ERI12IwgW8peSPbMewHynKbtFCma9W1H3
         l2XR9emX5PDwAtfrVz1fnoDBKmggbxo3vUO80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mukYwZC8oGpJdNF235uoncaFKSE0d/0OGCSS02KIqXAejKy4N4gB9VU510aPdzLjU3
         3WhmqZC3EmH6I7OcT1YSraHa0yL8gXdR8aheVzAhj8wmU5beeqBlQEIbc/GPmqpTb3Ty
         p9iSVJVnADxJnceddTa4mH5ZcNq1w4BYHb0p8=
Received: by 10.142.110.18 with SMTP id i18mr3917947wfc.229.1285413588041;
        Sat, 25 Sep 2010 04:19:48 -0700 (PDT)
Received: from localhost.localdomain ([120.16.63.67])
        by mx.google.com with ESMTPS id o16sm3755003wfh.7.2010.09.25.04.19.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 04:19:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.g216ca.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157144>

This series allows git rev-parse --flags to output remaining flag-like arguments
even if such arguments are valid options to git rev-parse itself.

Previously:
  $ git rev-parse --flags -q -X --no-flags -- Y -Z
  -X
  $

Now:
  $ git rev-parse --flags -q -X --no-flags -- Y -Z
  -q -X --no-flags
  $

Note existing behaviour was:
  $ git rev-parse --flags HEAD
  HEAD
  $

This behaviour is unchanged by this series, but the documentation has
been updated to state that --flags:
  Do not output non-flag parameters which are not also revisions.

Reviewers are invited to comment on whether current behaviour
is reasonable or whether the implementation should be changed
to match the current documentation. That is, to make the behaviour:

  $ git rev-parse --flags HEAD
  $ 

This series differs from v2 in that 2/4 of the previous series
was actually unnecesssary since --no-flags --flags -X already
produced no output. The documentation has been reworded to
relect current behaviour more accurately.

Aevar's feedback has been incorporated.

Jon Seymour (3):
  rev-parse: stop interpreting flags as options to rev-parse once
    --flags is specified
  rev-parse: add tests for git rev-parse --flags.
  rev-parse: update documentation of --flags and --no-flags options

 Documentation/git-rev-parse.txt |   14 ++++-
 builtin/rev-parse.c             |    8 +++
 t/t1510-rev-parse-flags.sh      |  109 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

-- 
1.7.3.3.g262a8
