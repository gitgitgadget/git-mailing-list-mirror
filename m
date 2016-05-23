From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v7 0/3] bisect--helper: check_term_format() & write_terms()
Date: Mon, 23 May 2016 20:18:45 +0530
Message-ID: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
References: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 16:50:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4rBW-0007vT-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 16:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbcEWOuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 10:50:17 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35454 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcEWOuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 10:50:16 -0400
Received: by mail-pa0-f66.google.com with SMTP id rw9so18265125pab.2
        for <git@vger.kernel.org>; Mon, 23 May 2016 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qMXZ6Ug3G0RkKmu2BFUfQUFFakgcKX+t+bj47dGEUYI=;
        b=lXCrkt8jc518aMHx+b7pkCw6HnDLYlCFfejLw7m512oqDU3qZORXjc4qSE1tu8DhT5
         KYbzIJQ7wJQXMAjOCYtdTTyvWxCfy0NSOHs/+SmOgQ+ujA6MDwYP8z23jUofGBclfH0a
         YkAklt99ualTF123/WkbEaOMJR/LIb/ObLF1eYMz2yRckf5AoNKmFEpXX+UMCNm1Nqni
         02QgfyWsbFlM8f7ynitCe/QwaVZGw0lECadtJ+qRmCTBQQNEMRq1S9xUCxIzxTptbC2M
         i3BKGINYjL8Z0/cov/RIi3cN+c00uRmjjQ7fsdWHMHCLk3pLYIwxBmh0nSToLio2n34b
         JbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qMXZ6Ug3G0RkKmu2BFUfQUFFakgcKX+t+bj47dGEUYI=;
        b=AQKdHtXXDSrJ0WDEQY50YbzbB+muuKCFELwHOK64yKc42OB2nkgpVk2zH/6K2Ysf//
         vGJekxYTmCX0wwNeaoKQomm67SXQ1wmPZbw1UeLwozXjQp/td/9MGAACbl/mvRHITHy+
         TWLzRUH70+Wv6nmsKHHU7Ps32XjLOZDeHgAKTtWuizn5sXNnsIw+ypTFd1HsRvV/lOuL
         4SpxLebZzJWuHHD6mwUzzS8Jg3tCDcyPYQiA7tEYQencdrqxHELQ1Sn+myb6xKZd7L9W
         DIhQ5IyMfb2hUo8mHpBM3msEsCygabnPBfeQWHg+uXO70xdBEkeaHz6plQN3D8IWEuw5
         2PZg==
X-Gm-Message-State: AOPr4FVRf+9/Q3huVuILf9WEsZWt2b6LByxzPLpIjbBRK2EhCiHEIVMvt7aZHRtAeC52cw==
X-Received: by 10.66.80.72 with SMTP id p8mr28221859pax.38.1464015015855;
        Mon, 23 May 2016 07:50:15 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id x89sm47301031pfa.87.2016.05.23.07.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 07:50:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295327>

Here is the link to v6[1]. I have kept bisect_log() and bisect_voc() on hold
right now. It would be sent to the list whenever it is required which would
probably be during the end.

Important Changes wrt v6:

 * make the method write_terms() static

 * Use fprintf() instead of strbuf functions

 * Previously ".git/" was hardcoded. Now it uses GIT_PATH_FUNC

 * Use error() instead of die.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/294388
Pranit Bauva (3):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C
  bisect--helper: `write_terms` shell function in C

 builtin/bisect--helper.c | 96 +++++++++++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            | 49 ++++--------------------
 2 files changed, 97 insertions(+), 48 deletions(-)

-- 
2.8.2
