From: Troy Moure <troy.moure@gmail.com>
Subject: [BUG] Segfault with rev-list --bisect
Date: Tue, 3 Mar 2015 09:19:14 -0500
Message-ID: <CAMo-WNYNeShbbhNfG455o7krGfY7_9zVU3dMpJ7b4Smh_AiATg@mail.gmail.com>
Reply-To: troy.moure@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 15:19:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSnfM-0000Z1-RG
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 15:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbbCCOTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 09:19:16 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44849 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbCCOTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 09:19:16 -0500
Received: by lbiv13 with SMTP id v13so18568748lbi.11
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=cRzS5bKJ3fEnaZ5TPjfYm4/TIdOAQAYR0FHWDsqbvxE=;
        b=zBPiYcD4WXZvcsa9E/wnArJpO3g9t43/OWT/GrrfZABXIUDC1t8qWiPSVFlEiJxa+g
         YYXkkbLbmLkDYf39w36c7yKNGjSrEK5JJ9A5k5Lzg06SwslOs/ikfAbaNSodUPGUJHEa
         37SUNAwVShJhso3S7mEJvQNQZjntwtWkRG+Z3ECzRrW1Eun7083kHQLxE16rSPdHiNCE
         pS+D+aFRScZ80TUSEI89D/V4bZ5C9EXTjWsAxyo95Yi2Vg2Vc6fgKNw+kHcun9ljLvA8
         bi44wo7SJOkaYSp6Y3y5ljqpQqVkfRgsqOqiqhK9T1m2bAvUpSxDYrbdDDSbsrnodf3/
         4UEA==
X-Received: by 10.152.116.18 with SMTP id js18mr29291726lab.106.1425392354383;
 Tue, 03 Mar 2015 06:19:14 -0800 (PST)
Received: by 10.25.216.140 with HTTP; Tue, 3 Mar 2015 06:19:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264661>

Hi,

I've found a case where git rev-list --bisect segfaults reproducibly
(git version is 2.3.1). This is the commit topology (A2 is the first
parent of M):

I - A1 - A2
  \        \
    - B1 -- M  (HEAD)

And this is an example of a command that segfaults:

git rev-list --bisect --first-parent --parents HEAD --not HEAD~1

I tried a couple of variations quickly: It does not segfault if a
non-merge commit is made on top of M (so HEAD is no longer pointing
directly to M). It also does not segfault if 'HEAD~1' is changed to
'HEAD~2'.

Thanks,
Troy
