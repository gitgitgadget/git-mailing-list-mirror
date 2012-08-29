From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 0/3] revision (no-)walking in order
Date: Tue, 28 Aug 2012 23:15:53 -0700
Message-ID: <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 08:17:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bai-0006nI-Au
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab2H2GQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:16:40 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:40070 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab2H2GQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:16:40 -0400
Received: by yhl10 with SMTP id 10so20121yhl.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 23:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=kHBJqcRayvL6r2pWLXgOV0XYRgBA6XvQFsdCtFI2WU4=;
        b=dxdENQHl59ReO25Fg5jaUb0JnitXCbiDsHgYLQ4TQlXveMmI1znnpmDDhDo57SjtZ2
         8BrNlsXvu708dCqzn16swBvmGenhiuBqp9doIG0MZG5tu3hSUL6OmjPUU12OplfgOKLZ
         AQpoRtFh6Crq39hQAbeVoGFPRZwDdXZFFbDj7uBEIkp8DK4XtGbFeMeCFLZ0BJrWBZ7G
         lWNXcwHjsBwfpil3W3VpHmgxtVFJqIH9BqlT4x5IoYAOExSXZU8jrNZzDstF2wzKCy8Q
         nNP/OC7+RyjcREHYOOb0ACmm9vfFy64chzeLsYdHt7iOQ+8vqKFm79tpK5fc0yZlFz2V
         0CMg==
Received: by 10.236.173.202 with SMTP id v50mr396608yhl.8.1346220999426;
        Tue, 28 Aug 2012 23:16:39 -0700 (PDT)
Received: by 10.236.173.202 with SMTP id v50mr396593yhl.8.1346220999328;
        Tue, 28 Aug 2012 23:16:39 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id u67si6743490yhi.7.2012.08.28.23.16.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 28 Aug 2012 23:16:39 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 3B4201E0043;
	Tue, 28 Aug 2012 23:16:39 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id CCFC5C2AB1; Tue, 28 Aug 2012 23:16:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
X-Gm-Message-State: ALoCoQkTrmFxxlKFm2PAd/nt2R6ZeopeIO2jIOzwcqK5DOkkKDBHbR/rOExsD8T5FQ2RPlyCkTcZYcb6ATuR69t5zYNpN6tlFFugx0d6H61eXmbu1f8WAdujl4n1EWzukeWirwH4II+SPEElPbeH7z+hAT4tq+dcEIgfHa/ful8+TB/IpqmSdhpQxOJpLyDA/jtI9j24xlwm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204464>

I'm still working on a re-roll of my rebase-range series, but I think
these three are quite unrelated and shouldn't be held up by that other
series.

Junio, thanks for all the help with explaining revision walking. It
was a little blurry for a long time, but at least I feel more
comfortable with these few patches now.

Btw, the rebase-range series seems to need (or be greatly simplified),
although I'm not 100% sure yet, by teaching patch-id --keep-empty,
which would be its first command line option. Let me know if you
(plural) sees a problem with that.

Btw2, I'm migrating my email to martinvonz@gmail.com (not y@google.com
;-) which saves a few keystrokes and matches some of my other
accounts, so these patches will be the first ones from the new
address.

Martin von Zweigbergk (3):
  teach log --no-walk=unsorted, which avoids sorting
  demonstrate broken 'git cherry-pick three one two'
  cherry-pick/revert: respect order of revisions to pick

 Documentation/rev-list-options.txt  | 12 ++++++++----
 builtin/log.c                       |  2 +-
 builtin/revert.c                    |  2 +-
 revision.c                          | 18 +++++++++++++++---
 revision.h                          |  6 +++++-
 sequencer.c                         |  4 +++-
 t/t3508-cherry-pick-many-commits.sh | 15 +++++++++++++++
 t/t4202-log.sh                      | 10 ++++++++++
 8 files changed, 58 insertions(+), 11 deletions(-)

-- 
1.7.11.1.104.ge7b44f1
