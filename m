From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 0/2] Check for lock failures early
Date: Wed, 16 Apr 2014 11:56:51 -0700
Message-ID: <1397674613-4922-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 20:57:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaV1F-00031g-8g
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbaDPS45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:56:57 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:51054 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbaDPS44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:56:56 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so1661571qac.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=B+6bXTtcfKZmpzSWXjKSBpfXHysgwlFiT40aHZ0BXQs=;
        b=cYdDILSEAXMOQQuNk/ppEDno6nkhxn+vZP93UNaHwMfz9LrkZWOSTyN1vhmcFfyuXU
         X1LtNg4t0ovknVLb9wi3m4jc8dNiEBouK/gnSpoCcE8S8S+5muR0R2JaEKMr8omh7wdq
         ywHFdBRSJKVNHn0nUGGkl/VF2mifVeFmgTXvO3ZxUuHm7dRPKTgEn9T1tOxne5kOXGlB
         4VxqfOazS6xz1Gcu49ox+i3DDAzbWOB0M8sxFvLFVJEecIwNwNzijS9jMaVzslenwpeB
         BmToesN8m7vL8PHMFD6bMdc6QR4IkUpYfhsV3Hmrad85IzqTPilZopvoQGUiu3yyieKb
         uJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B+6bXTtcfKZmpzSWXjKSBpfXHysgwlFiT40aHZ0BXQs=;
        b=gOOdmtUMBSEPPsEGdsCaFDHbyuNyXrhZBs/JRUCkk5hL2PNV5UVwlfXrq0xPGxTY3z
         m8ObKhxas3uezg1uF/BLwecagv182iLsRB1vx7JOsdHmQ6kW27I58cYuZ6c2kkd5RcKV
         S9OVaUDNSIHKGm1OWV6blmfNgDYF1qWFlnu+VHE2qVC1GIlEgkjKRMSn6EZ+iroTQU5m
         vYZVBrxEpMYVDl+S16H572S8BWN13BMX7o79nJjfIHP7aKOT56cWZabsbuHnS2MATJhL
         ccGAyeP/Ys+33gY6OxW4FN4OaMInEbJz4HYWNAYjEOlhf4TvLhkxuEQjtIS77uOAbOkU
         AYHg==
X-Gm-Message-State: ALoCoQnSdXdJF32hEQF3km0FKHP661uCG4ql1YiRT2FiZ6CDf2mT3ZMKZWhfJOC4Nu6iKQgd6tvemzWBYyv7s0DsrZ+LrhvE8Ft+FCthoemyUM41x0M3OFuGfuC/sye5817NvimdGymS0A/hA5rk3npWtyZ5Mll1YUT26fCHfC/ehXV6dv6dfydaK8f6p3fEuPBVFUZmnmF5
X-Received: by 10.58.155.3 with SMTP id vs3mr4977690veb.16.1397674615425;
        Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3214505yhe.3.2014.04.16.11.56.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 46F6731C1E3;
	Wed, 16 Apr 2014 11:56:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DC682E0B22; Wed, 16 Apr 2014 11:56:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.504.g5a62d94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246375>

Callers outside of refs.c use either lock_ref_sha1() or 
lock_any_ref_for_update() to lock a ref during an update.

Two of these places we do not immediately check the lock for failure
making reading the code harder.

One place we do some unrelated string manipulation fucntions before we
check for failure and the other place we rely on that write_ref_sha1()
will check the lock for failure and return an error.


These two patches updates these two places so that we immediately check the
lock for failure and act on it.
It does not change any functionality or logic but makes the code easier to
read by being more consistent.

Version 2:
* Simplify the return on error case in sequencer.c.


Ronnie Sahlberg (2):
  sequencer.c: check for lock failure and bail early in fast_forward_to
  commit.c: check for lock error and return early

 builtin/commit.c | 8 ++++----
 sequencer.c      | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.9.1.504.g5a62d94
