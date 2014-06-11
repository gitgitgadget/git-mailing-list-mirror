From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Wed, 11 Jun 2014 18:30:37 -0400
Message-ID: <1402525838-31975-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 00:31:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wur2r-0006tW-9h
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 00:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbaFKWa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 18:30:56 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:61205 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbaFKWa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 18:30:56 -0400
Received: by mail-qc0-f182.google.com with SMTP id m20so715986qcx.13
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 15:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mI+7c9abUa+8IegE0qsf7Udc6CubVf0bFyAona5up20=;
        b=U2fgyfo6XgJ5S6h+IZp4rzsPLmbmULLPh1+tukzpxHba9QrHdOp7lVijgPYXV7SLOJ
         T0f2DLhn/RpqphJG9vN3xdcTo6BzUkY9Q2YVKGSNkmE8X83du6TEewUGfTFiMwougkc+
         oZiOCI1s8djG1T2CU1l876Elo3sTwqcI+fByHvgG8tblOmA/l14GWHn8NTJBzHhqW968
         gNaBlMmPR3NDQFdtG2B8XqXT7UNmzVMQUOeTSVv1Oo9hFT7IePYSZVwpXgAy7itckNhI
         gkXnTDU65QDNvsvEyJGcEXbk3Q1QAk3ReFUOGWcXZRi7B/ONQZ703jyRabll+PXWFRg3
         KlWA==
X-Gm-Message-State: ALoCoQlu1kd7Kr4iS3MLtbjQvyyPbhgQfgRR9A/tYY/6BnEGMnbbcfD0OmxyPW+dGVgDGjD25hFY
X-Received: by 10.224.72.13 with SMTP id k13mr30687597qaj.54.1402525855440;
        Wed, 11 Jun 2014 15:30:55 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id l33sm3676899qgd.6.2014.06.11.15.30.54
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jun 2014 15:30:54 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.24.g0588c94.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251388>

This issue bit us again recently.

In talking with some colleagues, I realized that the previous version
of this patch, in addition to being potentially slow, was incomplete.
Specifically, it didn't handle the case of refs/heads/case/one vs
refs/heads/CASE/two; these are case clones even though they strcasecmp
different.

This new version contains code to prevent this, as well as tests for
this case.

Also it uses a hashmap to make lookups constant-time.
