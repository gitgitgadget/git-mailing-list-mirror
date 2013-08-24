From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] fix interactive rebase short SHA-1 collision bug
Date: Fri, 23 Aug 2013 20:10:39 -0400
Message-ID: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 02:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1RS-0007JZ-Kd
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab3HXAKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:10:54 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45031 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3HXAKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:10:54 -0400
Received: by mail-ie0-f174.google.com with SMTP id k14so1861503iea.5
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 17:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tmUeDqn2GoUspn6hlsUbLUwwrcCYQ/FamYiNwndRno8=;
        b=q04R9xa5Mb21/f0yfyE9oEMOp6XIMvWBUCpwNfbtxA5jn7fcJFBeX4S5gs9T46woTV
         /TjkwWVJMtxqKOaGhD2QNQg6t1OgmeiZbljXoQzTPNhRJTMuisDMIHVdiAYvNBj2T5iq
         xQnDJpTt91aILHLAYT7LXKXQFGc8Bm2t0N35uAiDRNU3eJ1Bg5BbxrEG7i0+3R/37/1t
         YXTUGzvGQM59IbkQU3ZjRc8eerX7S0JnH1+D67lJJkn5DojRWiWmyMzPUSZIfxsmG/yr
         wnEGAegdSSxIpVVKvvPfGAEY0Q6eaXrKcPa6Tln0qjQGfsEvmH7896ZJjDR+gaK9sKoZ
         Blrg==
X-Received: by 10.50.13.104 with SMTP id g8mr3408016igc.30.1377303053547;
        Fri, 23 Aug 2013 17:10:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id k6sm1068749igx.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 17:10:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.557.g34b3a2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232850>

This is a re-roll of [1] which fixes a short SHA-1 collision bug during
rebase -i. v1 graduated to 'next' quickly, before I was able to post a
re-roll addressing Junio's review comments, so I instead posted fixes as
incremental patches atop 'next' [2]. Also, after already in 'next', I
discovered an issue in patch 3/3 where it ignored core.commentchar. This
was fixed by another incremental patch atop 'next' [3].

Junio suggested [4] that, when 'next' is ready to be rewound after 1.8.4
is released, a replacement to the original series should be sent with
all the incremental patches squashed in.  This re-roll does just that.
It incorporates all the incremental patches and presents the series
afresh. This series is meant to supersede all of the following commits
in 'next':

* v1 series

4ababc19e3b6 (t3404: restore specialized rebase-editor following
    commentchar test; 2013-08-12)
cda44c3b5098 (t3404: rebase: interactive: demonstrate short SHA-1
    collision; 2013-08-12)
9a46c25bdbf7 (rebase: interactive: fix short SHA-1 collision;
    2013-08-12)

* patches addressing review comments & general cleanup

4bd24da943d9 (t3404: preserve test_tick state across short SHA-1
    collision test; 2013-08-21)
d63f172cfd90 (t3404: make tests more self-contained; 2013-08-21)
7883ad2419a3 (t3404: simplify short SHA-1 collision test; 2013-08-21)

* core.commentchar bug fix

cd5ce1625074 (rebase -i: fix core.commentchar regression; 2013-08-18)

[This series does not include the similar core.commentchar bug fix
7bca7afeff6f (rebase -i: fix cases ignoring core.commentchar;
2013-08-16) currently in 'next' which is intended for 'maint' and
'master'.]

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232146
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232718
[3]: http://thread.gmane.org/gmane.comp.version-control.git/232482/focus=232483
[4]: http://thread.gmane.org/gmane.comp.version-control.git/232718/focus=232771

Eric Sunshine (2):
  t3404: make tests more self-contained
  t3404: rebase -i: demonstrate short SHA-1 collision

Junio C Hamano (1):
  rebase -i: fix short SHA-1 collision

 git-rebase--interactive.sh    | 30 +++++++++++++++
 t/t3404-rebase-interactive.sh | 89 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

-- 
1.8.4.557.g34b3a2e
