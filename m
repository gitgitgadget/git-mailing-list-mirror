From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 0/7] atomic pushes
Date: Fri, 19 Dec 2014 11:38:54 -0800
Message-ID: <1419017941-7090-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:39:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23OQ-0005Zt-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaLSTjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:39:13 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43620 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbaLSTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:39:12 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so1321353iec.22
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cDNUj91IuZyJiJSsKTwHbnM5J1aHE43OJk2Kig4YZE4=;
        b=THb7Xdie2luzAtNWaFw2XAhDPuXPQg92Mr+btcABnQq6ZCvyy/o7sFJekguv0sOd18
         gxXQZlDGYPKooz33Ye5vN8uzvxtTsnbYSOdgc4Lr61iymZ1m+Jt6uZu/xsXoRMNM7a0o
         E8xIrCYyhgw+A3u/06NXiYwNOqgnCvnuCgvq5QrdCad5wAahfNpDEzRpNZ5NCehXKpGp
         x7IT/L4afpXc7HYOq95eoN0uSqb4MNFSZ+ezNvfuERsYcvWCY9erhyaWqXmAVtE+3OKA
         6MxWCZYZi3gNBM1TBj0D93sWpzAm2NaamwqwwfYHg6TI4/iYYrc43NBlfyyXxxI41ONr
         cIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cDNUj91IuZyJiJSsKTwHbnM5J1aHE43OJk2Kig4YZE4=;
        b=VG5aSUq0nbbqWWIcvDDajjlJq0QxtscfK7N5uo5LQsMyepujCQSFEAeWC6Fws5etUd
         U5P0gzlo0QL9oHAuzCpHMDdxiMRjfdL9JBuit8AuHm945N+XIk93RemJHRnurA26bUfr
         OMhpGCH92+H7kyK3AQjq2O9rwYD3ZLIq6FiYDhbvdqjr/HaIIDkdW8fZtHKK+girtwg3
         MaENNL5zsvh2u6RFRK+55FM3omFMRIZXKp4kMG6ORtiWwoRdi2Tek+wVgafpA5dLzNpH
         H1m9ZkGQbstLU8Vs2W4QYKktchMI8qJLav1IzRHWGx9J5g+Ygr8YM3lsAxhqxbE4eWs4
         yJ6g==
X-Gm-Message-State: ALoCoQl9AIxciKsdxJuGzdDGcPVqfMwtdqqhuKydr+zYa5S/Mqjaw2V5BiECS4jb/lWdOexCzy+8
X-Received: by 10.50.127.146 with SMTP id ng18mr4781803igb.17.1419017951609;
        Fri, 19 Dec 2014 11:39:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5827:d4a2:8bd5:ac5d])
        by mx.google.com with ESMTPSA id l14sm4936822ioi.31.2014.12.19.11.39.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 11:39:11 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261586>

This patch series adds a flag to git push to update the remote refs atomically.

This series applies on top of origin/mh/reflog-expire
It can also be found at github[1].

This series incorporates all suggestions by Eric. Most changes appear in
patch 4/7 as it is a complete rewrite compared to v5 of this patch series.
5/7 is new to the series and cleans up the rewrite by moving the function
execute_command around.

Any comments are welcome!

Thanks,
Stefan

[1] https://github.com/stefanbeller/git/tree/atomic-push-v6

Ronnie Sahlberg (3):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add --atomic command line argument
  push.c: add an --atomic argument

Stefan Beller (4):
  send-pack: Rename ref_update_to_be_sent to check_to_send_update
  receive-pack.c: receive-pack.c: use a single ref_transaction for
    atomic pushes
  receive-pack: move execute_commands_non_atomic before execute_commands
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   2 +
 builtin/receive-pack.c                            | 165 +++++++++++++++-----
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  66 +++++++-
 send-pack.h                                       |   3 +-
 t/t5543-atomic-push.sh                            | 178 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 405 insertions(+), 51 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.1.62.g3f15098
