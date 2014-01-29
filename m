From: =?UTF-8?B?QWxleCBWYWxsw6ll?= <avallee@google.com>
Subject: Bug: Branch rename breaks local downstream branches
Date: Wed, 29 Jan 2014 16:42:00 -0500
Message-ID: <CAJwg7ssT-BQe+tmRNvhmPgZUsAnA8+jkuU6P-vuMdJPAOwgLMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 22:42:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8ctu-0004qt-Je
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 22:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbaA2VmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 16:42:22 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:50794 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaA2VmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 16:42:21 -0500
Received: by mail-oa0-f49.google.com with SMTP id i7so2704093oag.8
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=MR2lDJ6CizoOrBCDTln4+2lIIwhDb0oh95ZARm1dg1U=;
        b=fejOPMErY8V+80wkirq+MKLLR3Jd3qReljryzto3mF79kfuh38Ix7z0Fyy7s0sUDZw
         naotBkDrRwZPEu8SAPCVcsn8QoT4w3O//yYDJXD2LQ8S8q4bbDc225JW+NIoxFAjnQcb
         S0apnaOAbu5e3naQ5X2QKnzzfunbCi5ewAcsPNJqGVHQxGZptlsG736sichJp5ypbgpF
         riJHk0ZD9FKnGrR15XatwkVt9OILAeO+ZD9knAKiP+Fzi6BWTQLE8ItUgEDUdvLYqCp5
         Vzt5lsr8Y1pYkaIMJmAkonD4l8QtJLSEurmmU0BsHtC6slf6pWWPS4RUcplXKnYNlUUY
         qq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=MR2lDJ6CizoOrBCDTln4+2lIIwhDb0oh95ZARm1dg1U=;
        b=mKJDcTUJuxWHMtD77RJq76r64Us18f05c5PXQI2NqC4kOdD5juMqwRvE67CVBr2qKF
         jERP/rtx/IvnFqZDKubhG8I82OIKcE6/QCfVWeqvpsyza0wLzIqjVn6ovjotgnrRceG/
         QHZi9bVRqogmv9g/clKCjUOPHX76HaejklNMTkwnGJoV0UmraggsCpOf+s0wrs7bXu2H
         8MPV2EXIJrYx+HE9V7jNUqsYFT3F7fuBlSh8wqDFwhjieOwORvNm/EezumJ/2ojNXYQo
         sjnCX7Qev2UG2DcjCx0etYc75SiHU0YM2QcBy/ftwxq/1dz/7LHAhejIdAUlbF27Mnfs
         AEhA==
X-Gm-Message-State: ALoCoQn7i0OcnCuBiHdrTOMazmnof1JGaGMjFaLpuRqkwcyXxl6MFXQvOVbyy75q4vYJR+sel0cZjd5K1hjQJss20xJRFKgzLKrsT8Ztx9Ew5D0rdaqQoW6TRWjArcEl1x7ur3C8CTpzD1ywte54b7JQy9a6bfi5ue2DPifRoFDz0/L76XllcT+cYgfb7+qzIHbidG02Ib3T
X-Received: by 10.60.103.134 with SMTP id fw6mr8339990oeb.34.1391031740842;
 Wed, 29 Jan 2014 13:42:20 -0800 (PST)
Received: by 10.182.18.103 with HTTP; Wed, 29 Jan 2014 13:42:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241228>

When tracking a local branch, renaming the tracked branch will not
update the downstream branch.

See transcript:

    avallee@gust:/tmp/repo (master)$ git co -b foo
    Switched to branch 'foo'
    avallee@gust:/tmp/repo (foo)$ git co -b bar --track
    Branch bar set up to track local branch foo.
    Switched to a new branch 'bar'
    avallee@gust:/tmp/repo (bar)$ git branch foo -m baz
    avallee@gust:/tmp/repo (bar)$ git co bar
    Already on 'bar'
    Your branch is based on 'foo', but the upstream is gone.
      (use "git branch --unset-upstream" to fixup)
    avallee@gust:/tmp/repo (bar)$
