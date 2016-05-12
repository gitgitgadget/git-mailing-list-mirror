From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v6 0/3] bisect--helper: check_term_format() & write_terms()
Date: Thu, 12 May 2016 11:02:04 +0530
Message-ID: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	Johannes.Schindelin@gmx.de, sunshine@sunshineco.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:33:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0jFI-0005S3-S9
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbcELFdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:33:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36770 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcELFdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:33:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id g132so5423650pfb.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m52S2z8ps9VU8hQVSAHjBvlZ8vbSvGkqnETo7up9n1M=;
        b=bwtXQ+J6svQstVfjBX0bPiDUSdZqr7Ok8P3cJGsB65wim/Wyij8Xb1/8kxMeggPCiR
         4WOYQUzkpGsiIYkziaLC0Ler11SJ+Iz+EObm0qZ//LCygoc1lxSRbkvmSz3JYqateJK5
         kYQlF+4gkAnNsdKDT1mlqDzFSEcANEEAC6idi32sZ42FzBmZM+8WbzczA5wJOzouEPBN
         tEmhbiQUbUL3hFqyKi+LGFZsaofxv+Bb5qIgXUn5keGLA+KRpdJLGbgweJiYWemHnG5p
         bHPdayzxG2uGYL/OXqUannB9rPw5lYj2+OF/jwx/aLxNGYDeXhXKXASB37jgytfBB7+l
         F+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m52S2z8ps9VU8hQVSAHjBvlZ8vbSvGkqnETo7up9n1M=;
        b=E6P55rwGx/t9z7TEu0jJkhKJHjvP0oFfCGK8ERoJF/TwhCX2OoWVNnc6KD9GFI0YM2
         ouI1JTnnjWAC3qJvwLFfU0i5ZUlrxweNxvQSWAN8atiWXvLlj0AZ4zoUs30/q/fmXLjw
         TsSIVXnoHZtdgvycmr1FIKPGkFm95fWT3/ZJmW0LJGRV2pCIv5vvaUSJLfiHOnoHJceM
         yHMjALyqCtvzVD4UNLClO5nSh/NwdLTbCYfDBXp/2/TPrlJHNJC5RhhoH5A3dZ6Fnb6T
         YwEd0+sKs3AEKWhqujpfxYWNyvdGsSXLVtiisCLpF4Y2RTCCaGLPScqOSDZcbUJs4Yc1
         LPag==
X-Gm-Message-State: AOPr4FUmaHLgNer7hrk6nvmcS52RfaM4Xxf0RIOL+Jmz+fonKOzpkoXJ7jSufVXuA69EwQ==
X-Received: by 10.98.81.195 with SMTP id f186mr10995591pfb.30.1463031185153;
        Wed, 11 May 2016 22:33:05 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id m86sm8585820pfj.77.2016.05.11.22.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 22:33:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294388>

To show how I am going to approach conversion of shell function to its C
implementation by using the subcommand/cmdmode approach, I have first converted
check_terms_format() to a subcommand then I have converted write_terms() to
a subcommand and then remove the subcommand for check_terms_format() and
instead call that function from write_terms().

Also I investigated about the test coverage which I mentioned in my previous
version and there is nothing that could be done to improve it.

Minor changes wrt v5:
 * Use the term cmdmode instead of subcommand as pointed out by Junio. (I
   didn't understand his response in v4 then Christian and Johannes pointed
   it out to me what he meant).
 * Move the enum cmdmode (for subcommand) to function scope as suggested by
   Johannes Schindelin.
 * A few minor nits by Eric Sunshine.

Link for v5: http://thread.gmane.org/gmane.comp.version-control.git/293785

Pranit Bauva (3):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C
  bisect--helper: `write_terms` shell function in C

 builtin/bisect--helper.c | 97 +++++++++++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            | 49 ++++--------------------
 2 files changed, 98 insertions(+), 48 deletions(-)

-- 
2.8.2
