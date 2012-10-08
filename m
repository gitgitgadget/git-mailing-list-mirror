From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC] rebase: Handle cases where format-patch fails
Date: Mon,  8 Oct 2012 15:36:27 -0400
Message-ID: <1349724988-14625-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vipaou0zw.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, alex.kostikov@gmail.com,
	Andrew Wong <andrew.kw.w@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 08 21:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLJ8E-0000lK-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 21:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2JHTgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 15:36:40 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53834 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab2JHTgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 15:36:39 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so501572iea.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Y/ABAlgoNlzHPwrzvRTG97zFL5zcGcTmdoLMuTWL7CM=;
        b=oTHqyzZ357ZOC0b9YsT045cOjoUd6lZdUydswkKxphAlU7eeIFXUUm82zf9rODmG2w
         /LYf3XPwKc6LBp/fq/tnN614fwOqQ/pm4VTPrjNwyqIH5B/eBSuTBCap5ERPe445tlM2
         G0UcK/RTfjCrBixfs05DtlmMXKoBOj2eRK1DBUiUsjYhFagjtU6g8MnFGfHvbjr4KHTO
         nxRfsUt8lpvRsucO7dbW4fUDlKKkFFwt2HgZ3irXGxKs5GwCqenO/cVxDEmk5RxH0LJ5
         LZCsyxqYnxEBmKLgZ91L4RhZJhdXdwnQqrXDwY2FQIjULFR73qpfQdz1TdaIl5QM6Gx/
         xEoQ==
Received: by 10.50.152.196 with SMTP id va4mr9438174igb.13.1349724998648;
        Mon, 08 Oct 2012 12:36:38 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id ff4sm8134062igc.5.2012.10.08.12.36.36
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 12:36:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.19.ga19ab82.dirty
In-Reply-To: <7vipaou0zw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207262>

Here's an alternate method for handling 'format-patch' failing.  We remove the
pipe between 'format-patch' and 'am' by storing the patch in an intermediate
file. This means we can gurantee that 'am' is always invokved with the complete
input.

I did some timing on rebasing 500 commits from the git repo.  The patch file
had a size of 6.9MB, but the overall timings between the pipe approach and
intermediate file approach are approximately the same.  I did the tests on a
Linux machine, so I don't know what the impact would be on other platforms, or
in repos with larger files and perhaps binary files.

Andrew Wong (1):
  rebase: Handle cases where format-patch fails

 git-rebase--am.sh | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

-- 
1.8.0.rc0.19.ga19ab82.dirty
