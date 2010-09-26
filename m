From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 0/3] rev-parse: allow --flags to output rev-parse-like flags
Date: Mon, 27 Sep 2010 00:44:04 +1000
Message-ID: <1285512247-15600-1-git-send-email-jon.seymour@gmail.com>
References: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 26 16:41:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzsPe-0006wi-9j
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 16:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab0IZOlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 10:41:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58196 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0IZOlC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 10:41:02 -0400
Received: by pzk34 with SMTP id 34so998869pzk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OYAL4TLMSaWZOUBw/lIicKKUu9riUPqI8EWKtGGwEd0=;
        b=PbeZPwLryX7M2rjfbEX8x7kWRwj5NgfpQ2wtZB54ZyHVOrM4wR/U01zi4nnfGpAxJB
         aU0+AnOaQeqGnNtZoghIFO3lLL0KlUQiLv3z0OdQNKDYkXFnFQLqFm/5gw0UCQ8u5VxS
         N/wG4pJGKaoRWCf1p/rDv0wYE0zqA8+6pMyNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lGvPujI47IB9LqpO9EX39ykgxyumNLmd804MbCCa5LI1JqlxMQb7ImLw2E1+/al8qM
         X2ApkMPLKvLsXPjscv6OSJh5jmwcjAf3crOwbjdlQyWv2/If/nj+0E6RTPdh5Ti11U4d
         F3wRqvOmYyB/joIozHeh19dxYGmWC0TG9dXTg=
Received: by 10.142.249.2 with SMTP id w2mr5186575wfh.186.1285512062455;
        Sun, 26 Sep 2010 07:41:02 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id o9sm5877375wfd.4.2010.09.26.07.40.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 07:41:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.g9129b6
In-Reply-To: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157227>

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

Aevar's feedback on v2 and v4 of this series has been incorporated.

The first commit modifies the documentation so that it accurately
reflects the current implementation.

The second commit introduces tests that document existing behaviour.

The third commit changes the way git rev-parse interprets option-like
arguments after the first --flags option is processed.

The first and second commits should be non-controversial since they
merely document and test existing behaviour. The third commit
is offered for discussion.

v7 removes the patch that made --flags imply --no-revs.

Jon Seymour (3):
  rev-parse: update Documentation of --flags
  rev-parse: add tests for git rev-parse --flags.
  rev-parse: stop interpreting flags as options to rev-parse once
    --flags is specified

 Documentation/git-rev-parse.txt |   12 +++-
 builtin/rev-parse.c             |    8 ++
 t/t1510-rev-parse-flags.sh      |  172 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 1 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

-- 
1.7.3.3.g9129b6
