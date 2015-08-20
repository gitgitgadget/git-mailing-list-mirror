From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Showing merges easier with "git log"
Date: Thu, 20 Aug 2015 15:43:08 -0700
Message-ID: <1440110591-12941-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 00:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSYYL-0002fX-0r
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 00:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbbHTWnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 18:43:14 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36694 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbHTWnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 18:43:13 -0400
Received: by pawq9 with SMTP id q9so37472937paw.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=8QBzSN9GuaNYzjJA9X01xiG8lVsAdf4+jIywnlt2Mek=;
        b=jgFmMOS62pRo4QqEdNTJvhiD8b0t5mZEhRaJrAqxtSCbIZfSzx254aNoq3LRScllY7
         +kcOVy3ns2wf2ve6dhJyp7+9xmYX25feAIlDlHO6wV4yeIzC5p+OA52IxY8tsgiXOf6m
         cC7FihWf8zh+WI7UUlMdLuhEwYt67I2MqYVfHt5F7PD9sLUerlHbGLHWip5XQCZVHHO/
         DKnWeTQglNhM8vuIQb2aAFFlh605wepW8ByUMOCKPMOAUjzg38v6JL9UKUjZdUhP/sUq
         IL3LVPzMZ+mcoqrfDsIQ20ndEG0naEB5tm2rgTuCVzpLXQDdO2WkgtFkkNQj5dTib+wk
         Qp6g==
X-Received: by 10.66.221.193 with SMTP id qg1mr417727pac.103.1440110592826;
        Thu, 20 Aug 2015 15:43:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id jr12sm5440589pbb.91.2015.08.20.15.43.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 15:43:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-546-gb1bbc0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276269>

This is a combination of two closely related topics.

 - The second patch is my long-time pet peeve (it is even on the
   leftover-bits list at git-blame blog).  When inspecting a branch,
   I often type "git log --first-parent --cc master..", and then
   realize that I need to give "-p" to actually view the condensed
   patch.  We do the same for "log -c" (combined but not desified
   form).

 - The third one is about "git log --cc master..", with which the
   user is clearly telling us that s/he wants to see interesting
   changes for both single-parent commits and for merges (otherwise
   s/he wouldn't be saying "--cc" in the first place).  Even with
   the second one that makes "--cc" imply "-p" unless another patch
   output format (e.g. "--raw") was asked, you'd need "-m", which
   was irritating.

The latter was inspired by a recent discussion, most notably

   http://thread.gmane.org/gmane.comp.version-control.git/273937/focus=273988

but implements it with a much less UI impact.  Tweaking "git log -p"
has a lot of fallout---interested parties can try it out and how two
tests in t4xxx series break.  Doing this for "log --cc" is
conceptually cleaner, as "-p" does not tell us what the user wants
to see for merges (nothing?  first-parent diff?  pairwise diff?
combined?), but "--cc" is a clear indication that dense combined
patch is desired.

Note that this conflicts with 'tr/remerge-diff' topic that has been
stalled on 'pu' for quite some time.  I'll tentatively drop that
other topic before pushing out today's integration result.  People
who are interested in that topic may want to help resurrect and
reroll it.  Hint, hint...

Junio C Hamano (3):
  log: rename "tweak" helpers
  log: when --cc is given, default to -p unless told otherwise
  log: show merge commit when --cc is given

 builtin/log.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

-- 
2.5.0-546-gb1bbc0d
