From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] Resumable clone revisited, proof of concept
Date: Fri,  5 Feb 2016 15:57:49 +0700
Message-ID: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcDW-0006z4-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbcBEI6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36704 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbcBEI6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:08 -0500
Received: by mail-pa0-f46.google.com with SMTP id yy13so30934464pab.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=+jwfF/Zcq57pyMrkKfW4a8dIOUkWqE+y6V7gR/SVHlM=;
        b=Vd441W+ilUxfL6OZhzI3lmRP8KVKDqzxdLeIT2yVGx5gtiAtsTFghv+MumyC+PQvnz
         Oc42Jt2LI2kt962CyDlkJ+PJ2QeCtwRtRJpFhhJSXXF5LQz96kEHP/kRPe/KS+uGoWOd
         QDmLXX9CtyEgrhNSBJpL9Ayw9vQFhXlvldR4wdBYveMIvTQsp5s9LKstIDMDS56PHLNa
         ARrSUB3935lqxn7mKVIV5rtylRrcTT/+Q/yRdk471Y3FP8Qfk54IPPjz00azxoM+JNWZ
         IeqxGjZZlHimfNNAK6gXDOutuX9wonuTH3Z2c3KjtPE6igEeWcg0dz9CJzmmmhToGIOA
         tYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=+jwfF/Zcq57pyMrkKfW4a8dIOUkWqE+y6V7gR/SVHlM=;
        b=TeAx/+ueFuSw8n327S9dFGOH5vTHBXLRyQmk+LQ/EuZBPTzLAQ8y4OsNE7LfQ0YGse
         0WrCzed2j6Rl9azdZ/qm2CTOKOV6OLKg9373LzG5mlFgrQEigQUhnu6n9yNX5EtQXdnM
         dVZF+RHCBrJbddbK+DDx135W7XvVxjKkQwzzblW4DYb0Ufnqv9YVwml/y7M5kXBF3857
         AydJVJInz1DDucNz7PUHsudasGT+FUFfnYob2Dq65Dfum/tmy/jMN7HucCK99lnitrrz
         eEpeiBkIK8YjVhU0Oy1sahnIemy9b4uDiqlg03/2xBhBe1OeDgoQE3YPCrZZHPS/j3FP
         KBPA==
X-Gm-Message-State: AG10YOSNxQKfdg1kEakQnEtZUpfEjShOJuAq6ab9xr2YNUwNi39cQb0UQYcjlFqfR9wsxA==
X-Received: by 10.66.218.225 with SMTP id pj1mr17810287pac.40.1454662688147;
        Fri, 05 Feb 2016 00:58:08 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id xm10sm22740643pab.12.2016.02.05.00.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:22 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285555>

I was reminded by LWN [1] about this. Annoyed in fact because it's
called a bug while it looks more like an elephant. So let's see if we
can agree this is a good way to go.

This is the stable pack approach. The client initiates "resumable
mode" and forces the server to generate a resumable, even though less
efficient, pack. Compared to the "download from a cached bundle first"
approach, this requires no extra setup for caching. But it wastes more
cpu.

The UI is not there yet, and you can only resume a fetch, not a clone.
What remains to do are:

 - Add UI to "git fetch" to retry
 - Make "git clone" use "git fetch --resume" to get the pack

[1] Quote from https://lwn.net/Articles/674392/ "she noted that Git
    still does not support interrupting and resuming download operation=
s,
    which is an important bug to fix."

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  pack-objects: add --skip and --skip-hash
  pack-objects: produce a stable pack when --skip is given
  index-pack: add --append-pack=3D<path>
  upload-pack: new capability to pass --skip* to pack-objects
  fetch-pack.c: send "skip" line to pack-objects
  fetch: add --resume-pack=3D<path>
  index-pack: --append-pack implies --strict
  one ugly test to verify basic functionality

 Documentation/technical/pack-protocol.txt         |  2 +
 Documentation/technical/protocol-capabilities.txt |  9 ++++
 builtin/fetch-pack.c                              |  4 ++
 builtin/fetch.c                                   |  5 +++
 builtin/index-pack.c                              | 52 +++++++++++++++=
+++++++-
 builtin/pack-objects.c                            | 26 ++++++++++++
 csum-file.c                                       | 52 +++++++++++++++=
++++++--
 csum-file.h                                       |  3 ++
 fetch-pack.c                                      | 40 +++++++++++++++=
++
 fetch-pack.h                                      |  3 ++
 remote-curl.c                                     |  8 +++-
 t/t5544-fetch-resume.sh (new +x)                  | 42 +++++++++++++++=
+++
 transport.c                                       |  4 ++
 transport.h                                       |  4 ++
 upload-pack.c                                     | 30 ++++++++++++-
 15 files changed, 275 insertions(+), 9 deletions(-)
 create mode 100755 t/t5544-fetch-resume.sh

--=20
2.7.0.377.g4cd97dd
