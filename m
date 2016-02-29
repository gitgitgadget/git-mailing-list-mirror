From: Christian Couder <christian.couder@gmail.com>
Subject: GIT_TRACE_PERFORMANCE and pager
Date: Mon, 29 Feb 2016 12:25:49 +0100
Message-ID: <CAP8UFD2zFBV7gRVvLB-gGEB=cfZJmYKrfiD2vdTdxgEgYU6jHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 29 12:25:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaLxb-00060k-R6
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbcB2LZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 06:25:51 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35199 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcB2LZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:25:50 -0500
Received: by mail-lb0-f169.google.com with SMTP id bc4so77922290lbc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=fmTuyBJ5w+du25YuG4kxFEGT+mJq591ovCmUQC4rUcw=;
        b=E7kClDA5UULfnp4dJ/eh8DMgoyg82/c5+LE0830gpCj+fkJ4bM3aQJMhNAQhdmQ1ig
         i6GrPyLmSH9N7hOOGZbQ8AOu8zZjC86ZKElgpc/yzxmYqOx2CkvVcLnHV95ExMObL6Ma
         iycH/kXUzE+CnVnymOBAL6IMQx15ESJmkTZstLNIKJ3MHT5henB036QOHmkl+ZLeQO/d
         u4uop9+UFGTlDes94mxHBKTZ79XshruODTdGJ8ie20demAu4KonLFIOOJBaVDFJuZhBP
         StiphOKU5r67FS9OCwCbMOLF+TkqvCGMU0zq7BYgzzcI6a8s3W9KK8nfFF6SCgmJMDeD
         C0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=fmTuyBJ5w+du25YuG4kxFEGT+mJq591ovCmUQC4rUcw=;
        b=fYQ08QB1G1fw0qrzw7rP9qljnkHR4p2mF1hlmhkJmSnWg12QMl/U28kI8RMKGEpq0V
         6gUa5mLUo+Nm/GUA4sRsyVWqhD4mhaJJ+EYEw0RNu4IlfL4IXHxeFMwgWM3PI92el10X
         eQ8fOMz7dyTJNq79e6UYkZrbI/suu44zZuirgBZWeSF54yX0/2M5vwXCkYAhjTSLt9xJ
         4JgeJk7sOA7FQp3dd6rbEf4nTwKxAFXunF64wSSbSgZEYs04ivc2hNqhfrfXr7UVCg+f
         7gds54qYLrsKrR9iw0xng68u+1HalESfYdY2Os7zpgynCwBMei5EudNrUcJwEhZisj5V
         VSPQ==
X-Gm-Message-State: AD7BkJIzb8QGhg31w6guGmC9BI4VVDetlYZQqxI3U7mGFq6Ckm1chJhhynVfn1G0lzI86YAdOjrHaCvqP4RjrQ==
X-Received: by 10.112.128.225 with SMTP id nr1mr5216077lbb.101.1456745149068;
 Mon, 29 Feb 2016 03:25:49 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Mon, 29 Feb 2016 03:25:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287826>

Hi,

It looks like setting GIT_TRACE_PERFORMANCE to 1 or 2 (for stdout or
stderr) does not always work well with commands that use a pager, for
example:

-------------
> GIT_TRACE_PERFORMANCE=2 git log -1
commit f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Feb 26 13:45:26 2016 -0800

    Git 2.8-rc0

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
-------------

In the above the GIT_TRACE_PERFORMANCE output is missing.

When I use "--no-pager", I get the GIT_TRACE_PERFORMANCE output:

-------------
> GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
commit f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Feb 26 13:45:26 2016 -0800

    Git 2.8-rc0

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
12:16:31.258462 trace.c:420             performance: 0.001415428 s:
git command: 'git' '--no-pager' 'log' '-1'
-------------

Setting GIT_TRACE to 1 or 2 seems to work, but maybe it is because it
outputs stuff at the beginning of the process and not at the end.

Cheers,
Christian.
