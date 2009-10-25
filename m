From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/6] http: push and test fixes
Date: Sun, 25 Oct 2009 23:16:51 +0800
Message-ID: <20091025231651.18c75559.rctay89@gmail.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:17:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24qe-00008l-9m
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbZJYPRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZJYPRA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:17:00 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47479 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbZJYPQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:16:59 -0400
Received: by yxe17 with SMTP id 17so9151038yxe.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=fz195idOQqoL+IzG1Ig4z0cKjvlFue2lMsfSYRi3v20=;
        b=jUnDMeh/lQBmdqwuvpWB0zxf2oDO7R3ZWIfTWThA9p/k/imwsQ3u1Z0zN+fGa+54Gb
         UzH3ACFjP+PG1Gsgo33MbhfIgH180nxbu+8Adm+7ew2/CLefB85AeatFwd9Xo5WjfcpL
         8LRbymkqsSgSegYTK0Qc336RfdjhUXVz2C4G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=xhT7RH6uOi9CHPZZO//3TkyMxSZOSBYcUJQ5QI6mAvaKRiE8Xxze3zLw+U1ov+0NZ6
         pKOdH1iSsQvjKGA695/3VKN+ALa4ye7QlRHU3bA9HAAQ5zdwMAnHJqTIKgtzlGvbrrc8
         VNwHQgkZN4w9EnNWGSBOGoPL1qRxAKpum5dWo=
Received: by 10.150.45.36 with SMTP id s36mr21889659ybs.334.1256483824342;
        Sun, 25 Oct 2009 08:17:04 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 9sm767981ywf.35.2009.10.25.08.17.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:17:03 -0700 (PDT)
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131207>

This series applies on top of pu, and should apply cleanly on top of
Shawn's v3-smart-http branch.

Patch 1: fixes a bug in http-push.c when fetching packs. This issue is
  minor and is unlikely to be triggered by normal users (for a possible
  trigger, see the "http-push fetches packed objects" test in
  t5540-http-push).

Patch 2: here, I collect my comments to Shawn's "Move WebDAV HTTP push
  under remote-curl" on the disabling of messages to stderr when
  --helper-status is used with http-push. I hope this will make it
  easier for Shawn to squash into his series, in the event he decides
  to.

Patch 3: also in response to Shawn's "Move WebDAV HTTP push under
  remote-curl", I collect here my mini-patch to add more reports for
  transport-helper. Again, I hope this will make it easier for Shawn to
  squash into his series.

Patch 4-7: update tests, as Shawn's patches changed the behaviour of
  the http push mechanism (dumb).

Tay Ray Chuan (7):
  http-push: fix check condition on http.c::finish_http_pack_request()
  http-push: allow stderr messages to appear alongside helper_status
    ones
  http-push: add more 'error <dst> <why>' status reports
  t5540-http-push: expect success when pushing without arguments
  t5540-http-push: check existence of fetched files
  t5540-http-push: when deleting remote refs, don't need to branch -d
    -r
  t5540-http-push: remove redundant fetches

 http-push.c          |   30 ++++++++++++++++--------------
 t/t5540-http-push.sh |   38 +++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 33 deletions(-)
