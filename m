From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v9 0/3] bisect--helper: check_term_format() and write_terms()
Date: Wed, 25 May 2016 00:12:39 +0530
Message-ID: <20160524184242.7518-1-pranit.bauva@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, gitster@pobox.com,
	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@gmail.com, sunshine@sunshineco.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 20:46:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HLg-0004dl-5y
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbcEXSq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:46:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34123 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbcEXSq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:46:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so2971668pfz.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0ilSE5BkJqm1XA3LxQp8HBdOT5NZ0j0EihvmPWgcSI=;
        b=Ps11LBzJ/+x4PyLvTovcIE+XajDyRpzxcdkqEwPIzHPADF6Xf7VkhbMIzIgD2V52CT
         95uYCqGwv5ZCKzXWzNz+DIwqVhXppJT7xi8NTDES09MvKckOCDYktqB41DdnsGS098MV
         i3peufSPiS17/DpAT6Y0bUI0BsNUCqTGs8OIxS+665n0goJcElDYKzQax46b5jFEArGK
         VDmCKtagvzpFOlfOntwNPZO1pRVZUZvwX5iecvpbGOvM/DkqbPE1hv07f8XtgNgTpUZY
         5LNqwg9c0LKUQIFGVaNWyplB53CkdkkQcbh8G0fCfXeArl6KYEa3jkqRcX0fwoRfx3Bk
         9X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0ilSE5BkJqm1XA3LxQp8HBdOT5NZ0j0EihvmPWgcSI=;
        b=O5Flnkw58Hy41hdQAHFRl/R2l2DyNMhHr2uD0vKPGhSEUsYriBJkK9I12c7rraw4Su
         f5z8etSgTjP6Me720VdOEbwhXqvZgAmK2vQ7v8P6I5J2w/9Fc3lqjyYywoArDFtv52Sb
         nQxcfI7nK4xn+X0H6Nh4boBhPCPdXoJidh+BNKSfQZiz0oRrPR/rbfuGejJ11tuKYW0v
         xyyz38U12BZeo+wLykn5Nw2NQRJexFOkVliOaEwyM3lJybrrs+pERRsU4NQl0o6GEVd4
         wht9AS17VJTg11Y6kVX23nrK8tjRPA4vQJfmpvZa+oNQgFnOi3MzO+wtw3+y267eZZSV
         CEfQ==
X-Gm-Message-State: ALyK8tLZ5Gd2dye/QSVgy6VX49byjH/rXVz65ijHbZD2RQuWpSC3uA9Fi0OCeT8TX6Igjw==
X-Received: by 10.98.104.133 with SMTP id d127mr9181419pfc.112.1464115588131;
        Tue, 24 May 2016 11:46:28 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id u2sm6918859pan.45.2016.05.24.11.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 11:46:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160524072124.2945-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295518>

Here is the link to v8[1]. This has a few modifications.

Changes wrt v8 as suggested by Christian are:

 * Remove the redundant `|| exit`

Pranit Bauva (3):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C
  bisect--helper: `write_terms` shell function in C

 builtin/bisect--helper.c | 96 +++++++++++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            | 49 ++++--------------------
 2 files changed, 97 insertions(+), 48 deletions(-)

-- 
2.8.3
