From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Remove non-blocking fds from run-command.
Date: Thu,  5 Nov 2015 10:17:17 -0800
Message-ID: <1446747439-30349-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, tboegi@web.de,
	j6t@kdbg.org, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 19:17:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuP6K-0004qf-1L
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162123AbbKESRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:17:23 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32879 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964781AbbKESRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:17:23 -0500
Received: by pabfh17 with SMTP id fh17so94274472pab.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=W3UBjINeCs9awmPh3qZ2TRO5o1TKo7Nb97WqwweS3MQ=;
        b=S1rc4CNn7OTECl+Hrvok6Sj8YX0A2cQQytgrtxOi0lIqTQPi0S6KMokSLXpzt/rqmX
         yOFPXFrugAiNYp7l4nb/8dpvttmtz18Pjw9kRB2kG6leU5mQL8vV8ZW5+ZT3uO7eJTvW
         r6ycTaje+fpP0fr9FFqojwtOdkbSM+TzGZdyUyKPx9l1XGExGdeO8C7W9eDzzeXL0iA/
         zeOo+9rUPAhb23nmjLjNTGxJyG1SRII4owD6bUguMA7qIa7M5uPZrTNDrMlLpbKJSxAp
         bhbIl5x/dHKDWEl/NdY4esp/WbZXDfkb8TkpBtlNv4ETE1XvAgxTLI/VkbiUQrUo2IKZ
         JhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W3UBjINeCs9awmPh3qZ2TRO5o1TKo7Nb97WqwweS3MQ=;
        b=E2rLygOs8CuV6koRau355r7Sb4Pku4PVUumJxt04aevMDkgmMYWj8HWHxzi0tYpLov
         8fUqWv8kYdkXaS3WyT1kmxrGfatEqYmoG1+vM9GnsP8BHHEgbSc2vmkUt8+273sT1zm5
         ThrkvoOj4TcSCvAEqFuuvO6ZpVhiUtpX9Z4o4o6Q6xsojBMdFCpqcgi/htf/h4Wel99Q
         /WR1NVPf4r0TLI5fw1F1k/wTEfUf6cpeW8wH4jg4tpStHS7Q6ESmWmVHYSO/qoIGyv5M
         RaZIAy6GaJtvLYVCI8VoEM14UUFVp+HA4tM96VB47wXKmtBotd5kzfqqVawPlNX+i0JG
         rUOw==
X-Gm-Message-State: ALoCoQlKgnLyTzD76nvhLqv6k2ChRhbyVr+pwXDM9H6SmIvdKWcdD8U1N5KWRh/lkT0VgsYqjedi
X-Received: by 10.66.251.6 with SMTP id zg6mr10743815pac.79.1446747442184;
        Thu, 05 Nov 2015 10:17:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8805:9922:277f:8125])
        by smtp.gmail.com with ESMTPSA id ck9sm9157016pad.28.2015.11.05.10.17.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 05 Nov 2015 10:17:21 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280930>

So as far as I understand, all of the discussion participants (Torsten, Jeff,
Junio and me) are convinced we don't need the non-blocking feature. So remove it.

I developed it on top of d075d2604c0 (Merge branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update)
but AFAICT it also applies to sb/submodule-parallel-fetch.

This will fix compilation in Windows without any platform specific hacks.

Thanks,
Stefan

Stefan Beller (2):
  run-command: Remove set_nonblocking
  strbuf: Correct documentation for strbuf_read_once

 run-command.c | 13 -------------
 strbuf.h      |  3 +--
 2 files changed, 1 insertion(+), 15 deletions(-)

-- 
2.6.1.247.ge8f2a41.dirty
