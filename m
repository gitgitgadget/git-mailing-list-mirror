From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 14/26] refs.c: move is_branch to the common code
Date: Tue, 27 Oct 2015 22:14:15 -0400
Message-ID: <1445998467-11511-15-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGj-0001Ee-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbbJ1CPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:13 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33206 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbbJ1CPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:05 -0400
Received: by iodd200 with SMTP id d200so78975922iod.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whVTTgObT5kfhJ49i1kvia1Qp2THr6WUZ78oGQLTQHU=;
        b=oui84fZOBgDvee0E/v3N8HVFSCashjeI0nsiWBUFZcuqhsATMGIe5kWm2pqMm1FPgE
         BhWnm2wgkBOjcKG2nvjJ8k0A0Y5Oy180IJzim2YN8MPmvL1EtiszACVxGdpaz66O1EhJ
         Lm6Yy/Ih436yo1ndAp3/TKxalx5rq9CsI0E59WztDMLkdsREeaZyIDJJ1toCnDbIPJvC
         XeZLqOswmSJvwlm6W52l+HFlllkFUKy+ua+KWqn5FBtOMgoVJI9R0fi4b8bbcYN34EkL
         5/3KegIVeIdf9B2VCjhZFYTXQqplf12OHZHWuGuT7AZE4RXftCvSdXitGgC/65MDxEvn
         eRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whVTTgObT5kfhJ49i1kvia1Qp2THr6WUZ78oGQLTQHU=;
        b=aoex4gBuGbKnPlo7VDOdTFiUp2BBfTEoLHROr3BIR2n0l1EBSdaiHiXN2DxIDUjU3S
         V7usohonD2HWP/lQrZulOeOpJAhspXCicDRFB3DpNMQrmJGGRtoyRoTynnd7Hbne3gV4
         PxiOjbHEO2q5eTUWTBlU2QWxtO1+qw+nn6qY+DXwhfpj2taibiaYaRuK7jR590UPx9vY
         i4+bBZaYxFQbgYc8aho6bMM9yARtOd7k2/9xdr18a+JSyg3PhZD6PR1+COsQpDXpKKHl
         G9TRrv05V6R/KejT6TFrF883ph2TBSQJytRbhta39UW30gc91WDstRoghf74Ca2XIoo1
         ZKqw==
X-Gm-Message-State: ALoCoQnN73tC3JO0zcp9nglfJgtTkNcJxdqsRHUCq5IwVfJQ6GbXIim3aWzNyQhlc2x/f8oDKCMK
X-Received: by 10.107.136.216 with SMTP id s85mr25175172ioi.142.1445998504593;
        Tue, 27 Oct 2015 19:15:04 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280334>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 5 -----
 refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index ec6efd7..8eb4b93 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3002,11 +3002,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return ret;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
diff --git a/refs.c b/refs.c
index 58991a0..2aae268 100644
--- a/refs.c
+++ b/refs.c
@@ -731,3 +731,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.4.2.658.g6d8523e-twtrsrc
