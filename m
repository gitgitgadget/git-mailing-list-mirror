From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: is there a fast web-interface to git for huge repos?
Date: Thu, 6 Jun 2013 18:35:43 -0700
Message-ID: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 03:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uklan-0001bE-SM
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 03:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab3FGBfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 21:35:46 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:37387 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab3FGBfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 21:35:45 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so1723517lab.40
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZhboBU+60C7xkh7fEsuXPy7S8OPfyM4MHji0xWwHtIM=;
        b=oi+wfEYKIpOOdyyzt0//VB5oQX2smeJ7RqXHz351GRMpeD5O+59BR4APB2wUmwD0yo
         EiV1sLxIy+lt37AhvTKxAEQ+LpmpHgmOx/6NJ7+NJP6mz6eQLglX/f3w8GF1yw6APHKW
         eXPR+DmochJKaSeLZ1tBdIq3Ag8SPSE0VIDaLBLjfPo6o37119v9MhGsDkimIulwlgye
         GeoDUxy828hbL5i585QO0ZrKI4sPlf85rWDdgRAHA6zeCY6PAIUWXwDS6HQjCOvsJpk9
         9nmosd5VBSkaz2PAcW+xI+FvmBb++QM2TLdlpbVB/freMI9euEpiaCkxaU2FlaBu27xm
         QwKw==
X-Received: by 10.152.6.228 with SMTP id e4mr1403577laa.61.1370568943721; Thu,
 06 Jun 2013 18:35:43 -0700 (PDT)
Received: by 10.114.77.1 with HTTP; Thu, 6 Jun 2013 18:35:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226577>

Hi,

On a relatively-empty Intel Core i7 975 @ 3.33GHz (quad-core):

Cns# cd DragonFly/

Cns# time git log sys/sys/sockbuf.h >/dev/null
0.540u 0.140s 0:04.30 15.8%     0+0k 2754+55io 6484pf+0w
Cns# time git log sys/sys/sockbuf.h > /dev/null
0.000u 0.030s 0:00.52 5.7%      0+0k 0+0io 0pf+0w
Cns# time git log sys/sys/sockbuf.h > /dev/null
0.180u 0.020s 0:00.52 38.4%     0+0k 0+2io 0pf+0w
Cns# time git log sys/sys/sockbuf.h > /dev/null
0.420u 0.020s 0:00.52 84.6%     0+0k 0+0io 0pf+0w

And, right away, a semi-cold git-blame:

Cns# time git blame sys/sys/sockbuf.h >/dev/null
0.340u 0.040s 0:01.91 19.8%     0+0k 769+45io 2078pf+0w
Cns# time git blame sys/sys/sockbuf.h > /dev/null
0.340u 0.010s 0:00.36 97.2%     0+0k 0+2io 0pf+0w
Cns# time git blame sys/sys/sockbuf.h > /dev/null
0.310u 0.040s 0:00.36 97.2%     0+0k 0+0io 0pf+0w
Cns# time git blame sys/sys/sockbuf.h > /dev/null
0.310u 0.050s 0:00.36 100.0%    0+0k 0+0io 0pf+0w


I'm interested in running a web interface to this and other similar
git repositories (FreeBSD and NetBSD git repositories are even much,
much bigger).

Software-wise, is there no way to make cold access for git-log and
git-blame to be orders of magnitude less than ~5s, and warm access
less than ~0.5s?

C.
