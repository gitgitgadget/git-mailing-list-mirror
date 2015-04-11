From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v2 0/3] Improving performance of git clean
Date: Sat, 11 Apr 2015 18:43:04 +0200
Message-ID: <1428770587-9674-2-git-send-email-erik.elfstrom@gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 18:43:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgyVM-0005ik-Ie
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 18:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbbDKQn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 12:43:28 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33912 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbbDKQn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 12:43:27 -0400
Received: by laat2 with SMTP id t2so32040931laa.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kDdYkyL3AaUTcH/aUUJV34QSo+fJCfh+O6xlM2o8SEw=;
        b=O5tiAoRT5/SvyKxUEecsSLZhO9VkUBQoNKATjM0g6Sa09/d7uggd9s69xuS1DWkMv4
         9mXco8UmsH7iagsWNYlw83Riz8Q6Siw8NM7hbqPNcvoxoUFdjZ/xjBEfsYwmQ1ws/KWJ
         3RtJYaVPyajdbQaxl473+KMGRJh7HkqgvakCxg1nTdzktUeraCxwOC44hXvnlomelkgs
         VL1djnAGZspKQrcqXQs2LLCFLtY6+hR2SKf7QCFHODPSNMGxOzuEabBC2/gRy86irv/V
         DLSf1xvhKZwRAVIUH4itbfkLXX7ASXWlykb5w6AssW9WM9BMcX4bu29amJ2g1VquRXmo
         6OwA==
X-Received: by 10.152.5.134 with SMTP id s6mr6082418las.6.1428770606085;
        Sat, 11 Apr 2015 09:43:26 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id kx8sm501395lbc.3.2015.04.11.09.43.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Apr 2015 09:43:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267024>

v1 of the patch can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=3D2=
66839

changes in v2:
* fixed commit message,
  "p7300: added performance tests for clean"
  change to:
  "p7300: add performance tests for clean"
* simplified test code
* removed non portable ls -A in test
* removed non portable $(seq ) in test
* fixed missing " || return $?" in test
* fixed missing sub shell for 'cd' command in test
* fixed broken && chains in test
* added assert new clean.c:is_git_repository to guard aginst
  negative array index
* use size_t instead of int for strbuf->len

fixes held back for cleanup patches:
* fixed existing broken && chains
* added assert in existing code to guard gainst
  negative array index

Thanks to Eric Sunshine and Torsten B=C3=B6gershausen for the very help=
ful
review!


Erik Elfstr=C3=B6m (3):
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       | 24 ++++++++++++++---
 t/perf/p7300-clean.sh | 37 ++++++++++++++++++++++++++
 t/t7300-clean.sh      | 72 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.rc0.37.ga3b75b3
