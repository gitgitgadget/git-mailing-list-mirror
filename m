From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-repack keeps running out of memory
Date: Mon, 01 Jun 2015 11:43:01 -0700
Message-ID: <xmqqlhg35ky2.fsf@gitster.dls.corp.google.com>
References: <556CA6C8.6000804@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Phil Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:43:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUg2-0008Id-BW
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbbFASnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:43:06 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33459 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbFASnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:43:03 -0400
Received: by igbpi8 with SMTP id pi8so68365188igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xbKx3kR7BBxVQ1HhqS86A4ehQQP9RipfZRW3nuAYelc=;
        b=oMbOhHjvkcxB6uMrqX3tIoaYvNFqEaCK5VSj15BKuw0Ig1oSsWM/AzYYZ8iPaJG4rK
         4EF6bmiFLcGTSdmzPTUvUwhE7dCzk00E0uWZjleBrEgVnHSNtd05QHqjF3PX3XRtZXhp
         d0w2XR5dKcOlOnqTD5uw5Sf+qsHXmr6VVFm4cgq4B2SNl2+U/qwSuqd1jvsdF/fi778K
         xXZHcdthLo1O1Nz4NrasQFae6fFnI6hLLnh1T/jfNA96fUBFP2TfoNonojIYUabH1xS6
         8LqGtTweUgTfLCQkzjz0hXbXXDibK8T4Cyllmo55/TNuk+4rwL63HOi8As4P9v786UzY
         3pWA==
X-Received: by 10.42.176.8 with SMTP id bc8mr19783103icb.22.1433184182923;
        Mon, 01 Jun 2015 11:43:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id e10sm2499945igy.11.2015.06.01.11.43.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 11:43:02 -0700 (PDT)
In-Reply-To: <556CA6C8.6000804@ubuntu.com> (Phil Susi's message of "Mon, 01
	Jun 2015 14:39:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270457>

Phil Susi <psusi@ubuntu.com> writes:

> I keep having git-repack run out of virtual memory ( 32 bit system )
> when trying to repack my linux kernel repo.  It keeps making it right
> up to 99% then barfing saying mmap failed: Cannot allocate memory.
>
> I thought I could help this by limiting the pack size, and using
> --window-memory to limit the memory usage, but it still happens with
> this full command line:
>
> git repack -a -d --max-pack-size=500m -f -F --depth=20 --window=250
> --window-memory=500m
>
> The key factor seems to be the --window... with 50 it works fine, but
> with 100 or more, even with the very low --window-memory limit, it
> crashes.

Unfortunately, that is totally expected.  Window tells us to keep
enough information to compare with that many objects in-core.  I do
not think max-pack-size would affect much.
