From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/3] Use ref transactions for fetch
Date: Tue, 22 Apr 2014 11:45:24 -0700
Message-ID: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcfhM-0000CI-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbaDVSpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:45:36 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:61224 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbaDVSpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:45:32 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so994587yha.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aNUYRRqEca1W1728eWceMFQf1MR/+buD97r8f+FF2YA=;
        b=YhA9/CGe46s5VcfoNPLWk7wxUv/N9n3chCXVve1gZ+zQ6dunpbG6iqF3ThivmTUKl3
         JSvD/y213Nw8Or7F2a9KKKqU1FLb4RokJ1db6HOEP6afMOsgMghHvBX3qKxz1vJoOC9F
         1yNd9Yccb59C+AlzhQwhbckcX/ew6sq3WBkuXdTi9KkHbv8IiFCJH5y+E6x3ZExKrs9D
         juYiJDOcCFjSEXRmaQzaW11SdAkc2zcdrm7h7lEE4wpuo/YVgF8UIxXg2Gu/OZ/GgudC
         HcLLFq9geRIaZ3s5POOQbo1HPbR9rrk07GzAwaPMaUJaLH6nbGnnFcyWfI4TdHsDA2aI
         kldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aNUYRRqEca1W1728eWceMFQf1MR/+buD97r8f+FF2YA=;
        b=dqABY98dA7i2Vc4F8iW4LhjtqZSujJ3ZAiH8rZhJygjZ7ElgSkkqiFVP6aTWuaHvb0
         5QrbJ2sOypr5j0f8XxVIboWK69T99pj7eNrE1Gh7HVuDFa27a3+VH8xTIqH2ukWzfs0D
         EbfJjFLhgWkxMRGtY2YAgnrbiD39FQwwYFCIoOT0yc8Xe+IHVbYL/oDM3gzFPYl3dX9E
         oFP7e2rozV/6vuQF4TmTG/o8+AIveDvlVZH51lOfyD9+6LV5do4mHnhRM/tfydKempR1
         hitWHzP5qb+f/YSgN8ymmNQM3Uq0D1KVpigBcDUvlMPKKIn0ItO6mWARJbe3FNtVYcuZ
         Wr9w==
X-Gm-Message-State: ALoCoQlMV15fgSNcCw056ruarEC1+R9fcSD7DOexSoUjzbAL/hhfhycMvzgspysydCIWaiS6SKGLHC3+HmkaDWx8M/kJ4u0yuT4iAnUQdxgVrNDoL4LU31d3/64dg7o1G14LMylUHpshozzDqEhlIdznPd/kXRAdf9DvmGRKBaJOpZ4GwP6ZbnsuA+9b61AcjiiBmNy7hByp
X-Received: by 10.58.111.202 with SMTP id ik10mr22223460veb.4.1398192331628;
        Tue, 22 Apr 2014 11:45:31 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si5705804yhb.6.2014.04.22.11.45.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 11:45:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6EE3D31C15E;
	Tue, 22 Apr 2014 11:45:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E4D0BE0BD6; Tue, 22 Apr 2014 11:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.518.g16976cb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246763>

This change is based on the previous ref transaction patches.
This is sent as a separate patch series since it implements a lot more
non-trivial changes to the behaviour than the previous patches and thus can
use more detailed review.

Update fetch.c to use ref transactions when performing updates. Use a single
ref transaction for all updates and only commit the transaction if all other
checks and oeprations have been successful. This makes the ref updates during
a fetch (mostly) atomic.

Ronnie Sahlberg (3):
  fetch.c: clear errno before calling functions that might set it
  fetch.c: change s_update_ref to use a ref transaction
  fetch.c: use a single ref transaction for all ref updates

 builtin/fetch.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
1.9.1.518.g16976cb.dirty
