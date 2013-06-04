From: elliottcable <me@ell.io>
Subject: [PATCH/RFC] add --authorship-order flag to git log / rev-list
Date: Tue,  4 Jun 2013 14:08:17 -0400
Message-ID: <1370369299-20744-1-git-send-email-me@ell.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: elliottcable <me@ell.io>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 20:10:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjvgZ-0007wm-OE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 20:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab3FDSKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 14:10:16 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:53117 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3FDSKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 14:10:14 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz10so498603veb.3
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wRRkZzTCZIXb6PnTcolFZBrBcRYTQ/NDczeiNPpDtfo=;
        b=gVePWQX7Qp8zk5sev8k6iuPNPZ5gRzmFWfgkTc8wFWh0alPWRvf0K4xtMnunK5uIth
         Seu3dQp29XHltP5O5rwh/92vgjxaQPzfc1CbKTsSKgkxRBW86vbsRTD5jn17ci/5SYK4
         9aEswtjabAOAv2QvmKNv2P90l9EgarIU/b33c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=wRRkZzTCZIXb6PnTcolFZBrBcRYTQ/NDczeiNPpDtfo=;
        b=bQxJ+bu4/Su9TIkp2EQS16Kcha7RTeY/nngCgvKB7ztYLP1c8bJvmu32gG6sPZTOKe
         IzwhOKGcTb3aFM5Dx0kB3esuUauKU54RSizHwMO0i3RMD8cyP4XMNlBY2DNDwMRyndzk
         vhuhl5l5Xi66Zp09nWCBhvRqA/nxlLxw8QefKfZz3wsd1e66Ra1MgD19POL4mqQbqQ2x
         q2cCOZEuLSNKdsv2FSBdJkZ9s7COfW8vAJsxoFudb1SI8BMGXrsQ32IIS8aRz+WTsYTc
         haQxgIgVpn8HT55GNJHOSwCGIme+Le4Vcn8v4qSCc54d6gQmeh5TOKn6q6d/3hivtxRW
         1coQ==
X-Received: by 10.58.238.167 with SMTP id vl7mr11352959vec.19.1370369413266;
        Tue, 04 Jun 2013 11:10:13 -0700 (PDT)
Received: from Sanford.local.com (cpe-174-106-131-094.ec.res.rr.com. [174.106.131.94])
        by mx.google.com with ESMTPSA id u6sm45730121ven.3.2013.06.04.11.10.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 11:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
X-Gm-Message-State: ALoCoQmeuXIv0VKCHEUg761RkODWC6kgAwVv6BNa7i6d0XYSbwjZxcycVlB51cJ8WJJ59kyfxw2I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226387>

This is my first time submitting a patch to this list, so please, let me know if
I'm doing any of this the wrong way! I've striven to follow
`Documentation/SubmittingPatches`. I hope I've succeeded. For that matter, it's
my first time diving into git's sources, so I obviously would love some
commentary on the patch itself, as well. ;)

I've tried herein to add an `--authorship-order` flag to complement git-log's
`--topo-order` and `--date-order` flags; it should operate the same as
`--date-order`, but using the `AUTHOR_DATE` instead of the `COMMITTER_DATE`.

I've sent an e-mail to this list, previously, on this subject; I'd make this
patchset a reply to that, except I have no idea what the in-reply-to should be:
http://www.spinics.net/lists/git/msg208542.html

The original work is all on GitHub:
https://github.com/git/git/pull/40
https://github.com/ELLIOTTCABLE/git/compare/master...author-order+

elliottcable (1):
  rev-list: add --authorship-order alternative ordering

 builtin/log.c                          |  2 +-
 builtin/rev-list.c                     |  1 +
 builtin/rev-parse.c                    |  1 +
 builtin/show-branch.c                  | 12 ++++-
 commit.c                               | 83 ++++++++++++++++++++++++++++++----
 commit.h                               |  3 +-
 contrib/completion/git-completion.bash |  4 +-
 po/de.po                               |  4 +-
 po/git.pot                             |  2 +-
 po/sv.po                               |  4 +-
 po/vi.po                               |  4 +-
 po/zh_CN.po                            |  4 +-
 revision.c                             | 11 ++++-
 revision.h                             |  1 +
 14 files changed, 110 insertions(+), 26 deletions(-)

-- 
1.8.1.3
