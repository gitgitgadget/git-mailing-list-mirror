From: Stefan Beller <sbeller@google.com>
Subject: [RFD PATCH 0/3] Free all the memory!
Date: Mon, 16 May 2016 20:22:44 -0700
Message-ID: <20160517032247.25092-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:22:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Vaz-0002C1-4a
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbcEQDWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:22:53 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34694 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcEQDWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:22:52 -0400
Received: by mail-pf0-f175.google.com with SMTP id y69so1750011pfb.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iy5QvmmpQwBcqkMpvsK48VxIbYTOrxGdWZOTtX2n3tA=;
        b=bl8yK6q7rwp43somJzZiNMf1TUKgdm3SH134C6O5LIi0pExaXcbtd2a8XDxysikXKF
         /y1+/8QbXHlCf4C4+mXhvAP8J21tF75JBecuWRXpyE39Mbc8/Rwl2scF4eG7gWYNHDfJ
         HlCUMv8MhluelJQysIKfZ8+a3X0Iz5LuEkHqVPmCNAOC81CPyuoGHg1j/CmxtKB43gnq
         i/SHMYfl2YrUY4OPqLn2ZsWex6FXxJlJ1f+0I4j5YI1XzQW4hDhzeA4p6CRKpwTOBUR1
         Z/Q0xKzbuLAPMDIEHEUAHVhC2OgEiVfqOzlZo/EsjYRy9TasCO9pvT4YYCFB4N433tPj
         0Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iy5QvmmpQwBcqkMpvsK48VxIbYTOrxGdWZOTtX2n3tA=;
        b=KWl2WDiySSdtpLf+7dYybAS9l8cQTiC0maPPg0OsUynm0oW+DkDnMGmG44KLFMWmTO
         kh4X7qD3nNBytxUjC6wJNVyUE4DKObNXQDSPdNwJOxU6MGrMcCvHc9r6hq2Kq2+DeuBz
         cbvaKfsxyC8ohf7s47hjXZQKCXi0kbGQijuCn13dRiGrtFI3zZJf1r60LVjT/Slb5HmW
         XT/5wkXb/ivKXs0piNobE69D4PJICnAmXjQal3mqGG3NT86HvTz+umdaJEXsVRIwRHZk
         AFl31CBHY8rnCDtX5rBzu9TZ2EysUafcAh0/Cov7ee+ZooMJad+803N/YMazMiOp3BHI
         Oytw==
X-Gm-Message-State: AOPr4FWT5JZAUari648P8qyrBimYgrJeC4uR8C34EJ5JZ+eUlSHHk5ZAhLR94B4ryZpwUObe
X-Received: by 10.98.81.195 with SMTP id f186mr50882701pfb.30.1463455371684;
        Mon, 16 May 2016 20:22:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id o6sm519643pfo.64.2016.05.16.20.22.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:22:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294840>

When using automated tools to find memory leaks, it is hard to distinguish
between actual leaks and intentional non-cleanups at the end of the program,
such that the actual leaks hide in the noise.

The end goal of this (unfinished) series is to close all intentional memory
leaks when enabling the -DFREE_ALL_MEMORY switch. This is just
demonstrating how the beginning of such a series could look like.

Thanks,
Stefan


Stefan Beller (3):
  mv: free memory at the end if desired
  pack-redundant: free all memory
  rev-parse: free all memory

 Makefile                 |  7 ++++++-
 builtin/mv.c             |  7 +++++++
 builtin/pack-redundant.c | 17 +++++++++++++++++
 builtin/rev-parse.c      | 12 +++++++++++-
 4 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.8.2.401.g9c0faef
