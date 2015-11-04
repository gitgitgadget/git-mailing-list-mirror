From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Missing O_NONBLOCK under Windows (was: git.git as of tonight)
Date: Wed,  4 Nov 2015 14:43:47 -0800
Message-ID: <1446677029-10745-1-git-send-email-sbeller@google.com>
References: <563A63BA.9020407@web.de>
Cc: tboegi@web.de, j6t@kdbg.org, gitster@pobox.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: sbeller@google.com
X-From: git-owner@vger.kernel.org Wed Nov 04 23:43:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu6mc-000711-Ri
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 23:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031002AbbKDWnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 17:43:53 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35272 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030412AbbKDWnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 17:43:52 -0500
Received: by pasz6 with SMTP id z6so67683286pas.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1Ri+ghwtriABTMVSL24iojyflPqdcK+qIGMCWaVJbU=;
        b=bs0fT5wMrtb5BqVkqmp4CB+RsCEY5AgQcnsi8mQx372ta8k4U5UQi1vZbYdXz5Xepz
         L+nV8oE8TkhrvAzqMcjpI0hv+UDzUdOXMdIHtUuLEclfDHQdVIh42uad1hk2LzjOyVpm
         xDaI+Ql4l4QwyWpFdu0z/iqulc7Sk7f0vm0+JZ1buuVCkf+LI1MTI8uiYPJqLPqlpJc0
         b9JRtA9mEh8r8DPd6XC4ak5pIArBjuONdJ8AgWxUZlJ/5eUU51vPPFKzyXjNCnXCsDy+
         pMuyfOmX8TdI2MNJwMDmS0dPV0Ub3IHVwu0gNIoMAphhmiVAWrfGIy7rro06gdINWLUE
         XWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i1Ri+ghwtriABTMVSL24iojyflPqdcK+qIGMCWaVJbU=;
        b=ZJyZnhkow9tj4g4GVo57eY55e8UryJpuTinZyyBNf7ntzRuh7FiZRgcYODseMZnYrr
         EMjN+tDIpE3CQSxwFNpBbjYGrNY645dhiB5dzGaT5KR/FY/NGY3kaYlrBSQzUYET9W+S
         CL7k9Bn0WVm9rJJiVT6iuQqCRHjmF/gtIoGESpx2Ewt4eErE1S66Sm/tiwXBJOETc97N
         Tdl+x10JXlkaeV+6uS5RCUkL/j2wxC7b0sQ35J1xCk220XU0fvfsate4NcDA2rJVFca9
         1qJbubDRJsmRJRDsCt6tzpGAvMSxcAZ1OL+MZVzky3iVenVjxzrxNVaMuV+ljEKnTx7t
         h3iw==
X-Gm-Message-State: ALoCoQnBAriqifBi1hxdF9k5JepyJjv1zpefnh2ZuD0njPfOJcEjikiLX6iZsK8naTOwJvE8frPx
X-Received: by 10.68.114.36 with SMTP id jd4mr5043765pbb.135.1446677032223;
        Wed, 04 Nov 2015 14:43:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e456:40e8:5942:d41e])
        by smtp.gmail.com with ESMTPSA id xe9sm4028367pbc.4.2015.11.04.14.43.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Nov 2015 14:43:51 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <563A63BA.9020407@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280889>

The first patch is a general fixup as per discussion,
the second patch will make Git compile in Windows again (hopefully, not tested)

The number of #ifdefs seems acceptable to me, opinions on that?

This has been developed on top of d075d2604c0f9 (Merge branch 'rs/daemon-plug-child-leak'
into sb/submodule-parallel-update), but should also apply on top of origin/sb/submodule-parallel-fetch

Thanks,
Stefan

Stefan Beller (2):
  run-parallel: rename set_nonblocking to set_nonblocking_or_die
  run-parallel: Run sequential if nonblocking I/O is unavailable

 run-command.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.6.1.247.ge8f2a41.dirty
