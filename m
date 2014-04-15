From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/2] Check for lock failures early
Date: Tue, 15 Apr 2014 16:46:46 -0700
Message-ID: <1397605608-12128-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 01:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaD45-000162-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 01:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbaDOXqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 19:46:52 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:56483 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaDOXqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 19:46:51 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so1504046qac.5
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qNbHRWAGdWjbl5JzbpekmoPcpl+YJLK61EiCLmlQvIo=;
        b=HYc27Zk8gmZPnuGy+jNufkGhpsVCZ6rQGwKLYf3aYLXeSC+e2AgmypQZP8792KPayH
         MbDf/FBIKhMhQ/LscPPRSjJnlPgmQ2UDVFNVrJVXNuyWOg6krsmT94E2A9mXZ3m3VVk/
         ZXF4Dk4HxsucxpW3hcnBKo5x+nuplZlYYwxlv2V+8JslaI+kb20BXpXiEEN5hrUiESuA
         zjrL7bTRiYJ2eSH/2F+OWhoAxHjLllCVXLBC8ma5xzgQ0Vqu+wVK/p1xJXjpNN/ztqaS
         36FtnU0Zvfb9GpZk8QviIVQHvBOe0Ur4iQ+C0NYRhJDBkv4PoeNeW4mZmVR9/2GmbRRd
         0pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qNbHRWAGdWjbl5JzbpekmoPcpl+YJLK61EiCLmlQvIo=;
        b=NBD1upXb+jGfsqFHkBpCCpK7zScmeziVO6czCHhqBdou8/mdh3E//KAGhH/PwNKAla
         E3VVytOcaGuoIkA1gnwTKhyJtU1GcEbPK7JtKot4zRuhodl/xCyh0+ZCnydLdQ7DGCjV
         u63cL26objWBVwcmCt0b7OnZVEEOlSJ5HoZ3FfIQl/16xxqmhcCumxzZgeszk0+PjnSB
         bkAaz0NcojE6pmo2dQHvBlVJfOOym3pGtgc3idQUs4yq0Rko1lpdY7BWUR1EXJPFhZGc
         DcEX0BJQOoLd6rJcu2UC+FZkd43dx6RszvzWNuMu3ppdEfvwJ2AkvL5t1ko0BhWjlRb9
         pmHA==
X-Gm-Message-State: ALoCoQkDL1Tg1Yx8AV8AIAU4Ilzt+dS1VC4A2rYXstjcL8DziIy2gurUlptO3EWbifDT+e/y671T3BBQQewkvEukjuhP5BcaNJkXHBEM8I6IdAOmLWYZfcHWIim09QgpeBNZReeEa3VXUW8EMrcdEdVit2HLDZ8tyUiYj0jL/HUyB8zkFFIFgFDUj8Rl89JGJvhwZ4r2/bLL
X-Received: by 10.236.128.112 with SMTP id e76mr2064514yhi.38.1397605610845;
        Tue, 15 Apr 2014 16:46:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id u45si2914869yhl.4.2014.04.15.16.46.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Apr 2014 16:46:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A795431C1D6;
	Tue, 15 Apr 2014 16:46:50 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 42429E099E; Tue, 15 Apr 2014 16:46:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.503.ge4c3920.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246309>

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


Ronnie Sahlberg (2):
  sequencer.c: check for lock failure and bail early in fast_forward_to
  commit.c: check for lock error and return early

 builtin/commit.c | 8 ++++----
 sequencer.c      | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
1.9.1.503.ge4c3920.dirty
