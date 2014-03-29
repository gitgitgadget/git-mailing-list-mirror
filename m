From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH 2/2] status: don't ignore submodules added to index
Date: Sun, 30 Mar 2014 00:40:27 +0100
Message-ID: <533759EB.20100@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374F82.3020800@gmail.com> <53375447.2050502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 00:41:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU2s3-00085z-ON
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 00:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaC2Xkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 19:40:31 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49539 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbaC2Xka (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 19:40:30 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so5353562eei.33
        for <git@vger.kernel.org>; Sat, 29 Mar 2014 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nV6vCQLX35iWQtxb9QcSAnvgKQAri2OgW4TrFS94Ma0=;
        b=ukEbm35f6sK7oEfE5MV64ijrO1J5u7BppNwhR9Tl4lEPMjLPL+cB3B/C1L4SSZZyYJ
         Na41y882+2npPLPgRcZnv3zfpu2EHm3HlrR9Wlitss/0nfwnqJUGkidELAy6aCw/KN9i
         yihzllJkLhVQo++Ft4w7EP+CoM7Y6TDfMiqlMFu86CnYQqtEiqsUn8kpWQVbOPpcdQ7z
         8HQUtx0Q28gJmXxjlduwvgxd9Af+Kvz8HT7S0ND8DYK4Zl5GQGTvqAhPy37TlsatDhGx
         tpDjcHF07vUdnjFMgiYOqerLTMR9aQzozCPxkWD0WeH6D/9u/ywZ255fuOuixQ8Ntib3
         oa+g==
X-Received: by 10.14.206.137 with SMTP id l9mr20223879eeo.40.1396136429284;
        Sat, 29 Mar 2014 16:40:29 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id l42sm21848831eew.19.2014.03.29.16.40.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 29 Mar 2014 16:40:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53375447.2050502@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245449>

On 30. 3. 2014 0:16, Jens Lehmann wrote:
> Thanks, but I think this patch falls a bit short (I assume you should see
> test failures with this patch). I'm currently working on fixing that, will
> post that as soon as I finished it.

You're right, 3 tests from t7508 failed with that, I'm sorry for not
verifying that :-(.

That change was really too aggresive, the one below seems better, all
tests pass with it, and it still works. But I'm not sending it as patch
anymore, knowing that You are already working on better solution.

diff --git a/wt-status.c b/wt-status.c
index a452407..520835e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -489,4 +489,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
        if (s->ignore_submodule_arg) {
                DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
                handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
+       } else {
+               DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+               DIFF_OPT_CLR(&rev.diffopt, IGNORE_SUBMODULES);
        }
