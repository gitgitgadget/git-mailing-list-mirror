From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Tue,  5 Jan 2016 13:32:59 +0530
Message-ID: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:02:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMZs-0007he-M6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbcAEICp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:02:45 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36448 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbcAEICo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:44 -0500
Received: by mail-pf0-f182.google.com with SMTP id 65so171294863pff.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rMFlXcN4YPBKYa9ylou8P7ileJqyKX0/n9ceh1ytOvA=;
        b=AaaYFwojWlSCf4VjoOBY/XbVvbwE7foTL2A115pmeF7OrkCtoYRKAu+WEdDwWznStB
         awg0rd5UfPKQ3LuZycjbtjqbN7F+n0jT/pFWGmwlsRxh2NIdxKARxwDc8h8EcF93a8NP
         jlxWjA7vPb+CgZRbJ2iGc6QC4/TtxDRgzL1aMUmT6b8EqE4Yi7FHdN5RC6J8SLqPzNri
         ILvmp1ewaDx3kmgCVmacDPYXv53xpci13L0XfpRLhxInFPrZ8ghaCrW0yBDbrFmeTQOy
         8x9Ihvi9q5QFCDDNnFP04Ko5kDortN3cFBN82JExeoauW7jbrSqL4Z9WXPezEA/mtHo3
         XovA==
X-Received: by 10.98.64.142 with SMTP id f14mr101186450pfd.159.1451980963969;
        Tue, 05 Jan 2016 00:02:43 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:43 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283350>

This series cleans up populate_value() in ref-filter, by moving out
the parsing part of atoms to separate parsing functions. This ensures
that parsing is only done once and also improves the modularity of the
code.

v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
v2: http://thread.gmane.org/gmane.comp.version-control.git/282563

Changes in this version:
* Change variable name in 'used_atom' from 'str' to 'name'.
* Split introduction of 'used_atom' into [3/15], [4/15] and [5/15].
* In [8/15] parse the color in color_atom_parser() itself and pass the
value to 'v->s' in populate_value().
* Introduce [11/15] which changes 'width' in align_atom_parser() from
int to unsigned int.
* Fix error in code in align_atom_parser(). and split it into [9/15],
[10/15], [11/15] and [12/15].
* Change 'align' atom tests to a table form.
* Change 'no_lines' to 'nlines' in used_atom.
* Switch to starts_with()/strcmp() instead of match_atom_name() as required.
* Changes in commit message and comments.
* Improve readability of code.

Eric suggested that I make match_atom_name() not return a value [0]. I
haven't done that as we use match_atom_name() in [14/15] for matching
'subject' and 'body' in contents_atom_parser() and although Eric
suggested I use strcmp() instead, this would not work as we need to
check for derefernced 'subject' and 'body' atoms.

[0]: http://article.gmane.org/gmane.comp.version-control.git/282701

Karthik Nayak (15):
  strbuf: introduce strbuf_split_str_omit_term()
  ref-filter: use strbuf_split_str_omit_term()
  ref-filter: bump 'used_atom' and related code to the top
  ref-filter: introduce struct used_atom
  ref-filter: introduce parsing functions for each valid atom
  ref-fitler: bump match_atom() name to the top
  ref-filter: skip deref specifier in match_atom_name()
  ref-filter: introduce color_atom_parser()
  ref-filter: introduce align_atom_parser()
  ref-filter: introduce parse_align_position()
  ref-filter: convert variable 'width' to an unsigned int
  ref-filter: align: introduce long-form syntax
  ref-filter: introduce remote_ref_atom_parser()
  ref-filter: introduce contents_atom_parser()
  ref-filter: introduce objectname_atom_parser()

 Documentation/git-for-each-ref.txt |  20 +-
 ref-filter.c                       | 455 ++++++++++++++++++++++---------------
 strbuf.c                           |   7 +-
 strbuf.h                           |  25 +-
 t/t6302-for-each-ref-filter.sh     |  41 ++++
 5 files changed, 349 insertions(+), 199 deletions(-)

-- 
2.6.4
