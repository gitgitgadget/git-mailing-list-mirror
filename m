From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Fri,  6 May 2016 20:19:25 +0530
Message-ID: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 06 16:52:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayh7Q-0001dc-LE
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 16:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212AbcEFOwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 10:52:36 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36532 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbcEFOwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 10:52:36 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so10589612pag.3
        for <git@vger.kernel.org>; Fri, 06 May 2016 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8BcezJcJ7vAyJEMkm5+D4j4XRTrMJ2DSm+IP8uzWBAg=;
        b=orHMDiAeUNiHIuDIuNkAgKMeKJMbkmQQ5UmAHiNewG95eH7mCBRzQoX3wGSdveo6n0
         CPHBWL+6Q0tA2p7NpCCR63xXCKqsJFRGMrOYczcyK7fnVLvBuCzZTDRFko146YsZBF+h
         HeKuaEj65cy2jD4rlWFJ6BW4fd5/3eHc239x4tyOS463IvFy2yExtxAW6UQPqlWI52CM
         D9MI6misB0WQOqYZfOL3Q+WUm6F6wbOIoSB+Xy3ppXlEmKHWyu9GdasPMFh8rd4CdRqR
         wojRVsyKhGN5Q7K8A+HIRNYjwr1o6TA5YQYw2dWwXLOJ+XrRFfd1/28TZeQnuNNGgcHK
         xl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8BcezJcJ7vAyJEMkm5+D4j4XRTrMJ2DSm+IP8uzWBAg=;
        b=b2J/TmkC0ypEvLHb2kM4ITxsaBN75OBH6VKEe6mGA+3i/WdNcQIMRSfAnvw4Oa/HCC
         Kc4/4847W/nNbwmQJga2VR1oIImQmOJgtlWinI6lbWFnYzegeMypN8GGOiQf19EoGFU7
         hNKYv98HFtbaPiNvbCxsv0ATDxQpB933jkh+orO7JSsbW+YxLuuvJJwH9AZ9mF+RXp4T
         T0v1+tJkjegcWXfVDEtTgOEQa/DIGPrysWzoNjWBT5SgFNZRTDwZ7eaUkR+GgZra+DNL
         SlhoiI+rcE1v+xvHCbOrUPcFS60e1XcDh7XwIsfMRyI++h/hEwnkkfEgnHhixo3FyLE+
         kyLg==
X-Gm-Message-State: AOPr4FXw+zXsVj53ST+pW8kvdyTvdiOe5MzL2VhByPBKP4nFMZ0vRPqNxmHu3WcF8VG1/w==
X-Received: by 10.66.146.164 with SMTP id td4mr29410587pab.47.1462546355287;
        Fri, 06 May 2016 07:52:35 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id dh4sm21775410pad.37.2016.05.06.07.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 May 2016 07:52:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293785>

A very interesting fact to note:
I made a mistake by dropping of the first argument 'term' in the function
one_of() and compiled and the test suite passed fully (which was pointed
out by Christian). This shows that the test coverage is incomplete. I am
currently writing tests to improve on that coverage. It will be included
separately.

Link to v4: http://thread.gmane.org/gmane.comp.version-control.git/293488

Changes wrt v4:
 * Stick with 'subcommand' in the commit message.
 * Rename enum as 'subcommand' to make it singular.
 * s/bug/BUG/g
 * Drop _() in the default of switch case
 * Use some suggestions for commit message no. 2 and also include why I am
   using subcommand.
 * Drop of the latter part in the comment of one_of()
 * Remove flag from check_term_format()
 * Use return error() instead of die()
 * Drop '\n' from the localization strings
 * Include localization for a missed string
 * A comment in function check_term_format() is re-wrapped to fit in 80 columns
 * Use 'term' instead of 'ref'
 * Reword the string in the default of switch case
 * I have kept the commit message same as previous for commit no. 1 except for
   addressing the minor nits.

Pranit Bauva (2):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C

 builtin/bisect--helper.c | 76 ++++++++++++++++++++++++++++++++++++++++++++----
 git-bisect.sh            | 31 ++------------------
 2 files changed, 72 insertions(+), 35 deletions(-)

-- 
2.8.1
