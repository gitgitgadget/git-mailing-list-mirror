From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix file locking with retry and timeout on Windows
Date: Fri, 05 Jun 2015 12:57:13 -0700
Message-ID: <xmqq4mmmrkrq.fsf@gitster.dls.corp.google.com>
References: <55700F10.8030806@kdbg.org> <cover.1433532967.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:57:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xk2-0008AZ-8b
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbbFET5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:57:17 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36074 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbbFET5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:57:16 -0400
Received: by igbpi8 with SMTP id pi8so23850315igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZNsGjX/8FOluV5yRg02vU9klLPEN5ePMkosksF05uG8=;
        b=KThJcqHe2eivEsoulez6/Q4uSr3889bOkrB8klhUP+dL8/BfxullzoRwUegixM3OAk
         Gfe2nlLNQDtOfrjWLjRJUmRyqw4DuxS0+l3SA7sOVU0biMvS25vjEnYHB9Uavi8v+DJR
         VitXmGA75USzH7aqlnvFCES2HjJasp6AZAyx1T9AK5sS3MC0k5mfBBSBr+ZEvY+S/cP3
         xuWe2eM0d7VqihdDT04PlJcw6S+f8ueYXkHBQgOSPivnrGDrUkVXdavU7a5/5/TQ8Fs+
         Nzw60m6669c/bVPA7LYIq3QJtrfZfk96Nbsp46jHvm8ohqkdYYk/xnpRxm0o0sf3OS6I
         53PQ==
X-Received: by 10.107.13.130 with SMTP id 124mr6743597ion.70.1433534235350;
        Fri, 05 Jun 2015 12:57:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d0d:eed3:5800:fefa])
        by mx.google.com with ESMTPSA id k16sm1997523igf.19.2015.06.05.12.57.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 12:57:14 -0700 (PDT)
In-Reply-To: <cover.1433532967.git.j6t@kdbg.org> (Johannes Sixt's message of
	"Fri, 5 Jun 2015 21:45:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270884>

Johannes Sixt <j6t@kdbg.org> writes:

> The remaining 3 patches replace the select() invocation that waits
> for a short time period by the version with poll() that we already
> use in help.c. This is necessary because a select() call where all
> three sets of file descriptors are empty is not supported on Windows.

Thanks.

The use of both select() and poll() in our code has been bugging me
for a long time (but wasn't irritating enough to make me do anything
about it).

>
> Johannes Sixt (4):
>   lockfile: replace random() by rand()
>   help.c: wrap wait-only poll() invocation in sleep_millisec()
>   lockfile: convert retry timeout computations to millisecond
>   lockfile: wait using sleep_millisec() instead of select()
>
>  cache.h    |  1 +
>  help.c     |  2 +-
>  lockfile.c | 31 +++++++++----------------------
>  wrapper.c  |  5 +++++
>  4 files changed, 16 insertions(+), 23 deletions(-)
