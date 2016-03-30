From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 00/16] port branch.c to use ref-filter's printing options
Date: Wed, 30 Mar 2016 15:09:44 +0530
Message-ID: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:41:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCd4-0002CB-O2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbcC3Jla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:41:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35728 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbcC3JkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:09 -0400
Received: by mail-pa0-f50.google.com with SMTP id td3so36010932pab.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GP2Cj/YtAaINwJktvt5AQffXzQyxK83+B5D9tMtn6HY=;
        b=aP3Ztlh3rNN2LuL7OXKT8wiWxGpEGOC99vKCc+HNc7k7sq6UrIlnY5qq5KeyGPEfgW
         9Ibje6zisCWQYireVIpqarB07WHWVN0hfAMDwyTC4pyZL9rkXyQDadBrGGguxR1zjJVL
         GG38CugOx8ug25G5vEt/RQc5biRjm9HXXHrMtU8jBidB70jaeGYG4IGCC//cplXetHb+
         aBa5JJbJjqpqTOSAvAWrd2BdYX/CcF7Rpm+sULmHsjOIEEL55oGg6vhkyMV/PUb5Ac1m
         xDGS0L74B81KuRhAx3KxmMfuCLf+xpdh6pW2vRoBqH2oEkp4jAm7JL73kL2cHTp3tA32
         sigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GP2Cj/YtAaINwJktvt5AQffXzQyxK83+B5D9tMtn6HY=;
        b=hXjvY6/1sUxuhte2Zc7eYRAbDHinrdZX2amQjIalA3wP0g50Mus1p2uJthOxKnPkjy
         jfNXb6Dy6kKwZLI7XCAqjYZJF3LhrhZRa41SEfNCcxezDtFRWVpW3knGTYsGunhSWWbG
         esSh0erZ8G6WneYt7laJAvZa59V6xZMXNFvIQDHtR1Za9p+n9QFcPDX1LQfOpkb2eXTL
         /IRf+wsYFfG7kQOxexYIaFx3+bQfjIX2ZedCOtMMf+VYvblq0yecwXQCqYNTxwdtEo7w
         cpxh/R85ksH7sMQJHzZYBJtuA24S8b6u/Pswd62Ep5HUWuYuyM0MLA3+z/SYSlkKc0vA
         moGA==
X-Gm-Message-State: AD7BkJIswoALNC7eToFOWBZGsvMwVwVG/q2LSbJAo+LNtJZG2Lx2gHrmghq70MXbVSsUtg==
X-Received: by 10.66.90.226 with SMTP id bz2mr11508663pab.31.1459330808622;
        Wed, 30 Mar 2016 02:40:08 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:07 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290299>

I kinda waited before sending this, since there was lot of discussions
happening regarding to GSOC16, didn't want to clutter the mailing list.

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)

Changes in this version:
1. Only Documentation and commit message changes as suggested by
Jacob in v2.

Thanks to Jacob for his suggestions on the previous iteration.

Karthik Nayak (16):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce symref_atom_parser()
  ref-filter: introduce refname_atom_parser()
  ref-filter: add support for %(refname:dir) and %(refname:base)
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  63 +++++-
 builtin/branch.c                   | 267 ++++++----------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 447 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  12 +
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  40 +++-
 t/t6302-for-each-ref-filter.sh     |  88 ++++++++
 10 files changed, 657 insertions(+), 278 deletions(-)

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0d7d80f..578bbd1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -109,10 +109,6 @@ objectsize::
 objectname::
        The object name (aka SHA-1).
        For a non-ambiguous abbreviation of the object name append `:short`.
-       For an abbreviation of the object name with desired length append
-       `:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
-       length may be exceeded to ensure unique object names.
-
 
 upstream::
        The name of a local ref which can be considered ``upstream''
@@ -120,11 +116,12 @@ upstream::
        `refname` above.  Additionally respects `:track` to show
        "[ahead N, behind M]" and `:trackshort` to show the terse
        version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-       or "=" (in sync). `:track` also prints "[gone]" whenever
-       unknown upstream ref is encountered. Append `:track,nobracket`
-       to show tracking information without brackets (i.e "ahead N,
-       behind M").  Has no effect if the ref does not have tracking
-       information associated with it.
+       or "=" (in sync).  Has no effect if the ref does not have
+       tracking information associated with it. `:track` also prints
+       "[gone]" whenever unknown upstream ref is encountered. Append
+       `:track,nobracket` to show tracking information without
+       brackets (i.e "ahead N, behind M").  Has no effect if the ref
+       does not have tracking information associated with it.
 
 push::
        The name of a local ref which represents the `@{push}` location

-- 
2.7.4
