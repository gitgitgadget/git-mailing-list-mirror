From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 00/15] port branch.c to use ref-filter's printing options
Date: Sun,  6 Mar 2016 17:34:47 +0530
Message-ID: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXQx-0001q3-LB
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbcCFMFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:11 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33326 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcCFMFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:08 -0500
Received: by mail-pf0-f169.google.com with SMTP id 124so63517304pfg.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WkYA9nThZ/3XS0P3xgwPYrZfJD1YRA0vOOVuHL8KmRQ=;
        b=LtARKltnF0O03AVkl7cBilkWUVq/uJOGo12swutudgVuasn7VVKwbg7WPnJozuaeNW
         G32L0TtxyFGJqDENhSn6yvt23WIPXq97EMe5IcwYwmxG4AeUxvJmHPJ+b1iAiphbAQGo
         TNQ9/qfR6yWvl3XyN972D4sZci+eTNjsJw9FBBuB0NyJagH7UdYYiqygZKbmNxUcMuZ/
         ASR0rnt8NuBvWxgFUN/gauu3WY6vUv1JL+px+6PWLrX26RBAUV59MYQdbWv5PCCtxY00
         j9USWL64Etu6keNRm7smfY6X5G1GcilgsGEt+I/WAx6Qbnx4hB4b5SEGpKoLfM97qX3X
         XVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WkYA9nThZ/3XS0P3xgwPYrZfJD1YRA0vOOVuHL8KmRQ=;
        b=GybdzByirj5f37+OaJy77YlWq933pRvpnCst51C9c/jVheqbGMMCwDIPAVp6jqvo+8
         5Q+YtVnQ8kCJQ8wZzt8uZ0u7C3TWyoGPGlSPRdr6h9TpXdM1Re+yqpD2h8UPVdQC1PFK
         VsjCTgj+MoGT4B+KoQoM4mRyUFv15mS0c4L4JL+5cQyu/QPBoc5AsW+BCt2eer1PG4dC
         C/1UHdHp+wP9IrDhSmytXR7jpzTPpslyRYOwlYxQ6Y2ui//WucuX9XVWPjfwxXw5XvTN
         VB16hgR1nGPJ2JQd9RkRRPN2SWPv9h4AjBOn4Z601zVsDI1994Rb8sGC7P8tTe077rkY
         6CXA==
X-Gm-Message-State: AD7BkJKXmLrRIyjatvVzqwHTkDqpq6/9Ghvd6ExJW6ZAhpDb1Mo6ckFcNHB9/LZQpYjQ8A==
X-Received: by 10.98.8.196 with SMTP id 65mr25484437pfi.53.1457265908126;
        Sun, 06 Mar 2016 04:05:08 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:07 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288342>

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

Karthik Nayak (15):
  ref-filter: implement %(if), %(then), and %(else) atoms
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
 Documentation/git-for-each-ref.txt |  58 ++++-
 builtin/branch.c                   | 267 +++++++----------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 428 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  11 +
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  40 +++-
 t/t6302-for-each-ref-filter.sh     |  88 ++++++++
 10 files changed, 637 insertions(+), 273 deletions(-)

-- 
2.7.2
