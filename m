From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 0/2] bisect--helper: rewrite of check_term_format()
Date: Wed,  4 May 2016 10:37:50 +0530
Message-ID: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, chriscool@tuxfamily.org,
	christain.couder@gmail.com, Johannes.Schindelin@gmx.de,
	larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 07:08:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axp3A-0004up-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbcEDFIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:08:35 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35263 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcEDFIe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:08:34 -0400
Received: by mail-pf0-f182.google.com with SMTP id 77so20411299pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 22:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Rv92JjT0aEKGhkfyhkQT2Q8KaRn0nh7IS760HBgXKfw=;
        b=WyJh4MGbiaBTGQaOoRFHf0U+nmp1KHkJnXAZtf0kEvRiU1AHythuwJ8y4gXZjylTPa
         PMwxR9tv2mq6CACap45T8GFnjVVI8+xOYb4Fbnvy/dlY/Yt9ROlN3LU2+yt/zaJiKgIv
         BSmEreEO89S1bLxJanB+2W+RhH+1dr1xw4HbAgIpuB48Y8WTCT+5I3u+ONSglAnx5F8i
         4guI8basTx92f4OQq0pA7f3YSKYMKxHdIgLXlJt9nt1ymlhYKgIdy2qqf7SMCIzOLFrM
         RyDgUPTOafuPjuC+qf1TMDvU9H/9bm7p/KuT2fVx/CxlcCDEVlcVeLHBNNjdvV2jJ+Vm
         Y0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Rv92JjT0aEKGhkfyhkQT2Q8KaRn0nh7IS760HBgXKfw=;
        b=TySI9aaE6K8smXnJUgVhPrz98ilT80FomAhFCHYaKyNJpzd/PMyRV+3qXXYndn0hCw
         rJROy9kA6F+9fhS1a2zEqCDqs4tCZ4g12kPPj7XoZOn8GxNX1yVatmRcU/6tq/1Zrjzz
         jzI+nBtdbYy1YgjuS8k7HztnocN8qQQhtFuTg8xYj6QLzfKhoTH6q6SkgVzI3GmajGPU
         9YYH6wasm9JVcRWNa2KBpMWMIwNaza2xTS531xMB9rlyC1T+bHBowXvTQ+WZgKBkrC23
         yhAKrW1+iIxxpo1tcWK46gRM8OnmYP1RXTxXy4NfEHygDwtm3j2TlDrGTGwdnI/3hRCV
         6Phg==
X-Gm-Message-State: AOPr4FVQ2eDEuut6v0KrqUEfvm6eR2FtaQmFx2U6lTIQ2MGHSauIAq3DV+CsXNxVqkTn2A==
X-Received: by 10.98.5.196 with SMTP id 187mr9405215pff.103.1462338513818;
        Tue, 03 May 2016 22:08:33 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.50])
        by smtp.gmail.com with ESMTPSA id p189sm2171709pfb.51.2016.05.03.22.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 May 2016 22:08:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293488>

Important Changes:

 * The previous patch is split into two patches for a better and logical
   commit history.

 * As previously absent, strbuf is used for string manipulation.

 * This passes the complete test suite unlike the previous patches.

 * Proper use of error handling (die() and error() are used at appropriate
   places).

 * Remove the shell code which is then redundant.

 * Improve according to the minor nits given by Johannes Schindelin.

Pranit Bauva (2):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C

 builtin/bisect--helper.c | 77 ++++++++++++++++++++++++++++++++++++++++++++----
 git-bisect.sh            | 31 ++-----------------
 2 files changed, 73 insertions(+), 35 deletions(-)

-- 
2.8.1
