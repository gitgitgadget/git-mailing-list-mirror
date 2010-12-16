From: Dun Peal <dunpealer@gmail.com>
Subject: Correctly detecting modified paths in merge commits?
Date: Thu, 16 Dec 2010 10:54:11 -0600
Message-ID: <AANLkTimsHZ543B7XWS6taa0w2Vc4huznx3UMs4Ejg3af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 16 17:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTH5v-0006G0-UL
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 17:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0LPQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 11:54:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58201 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab0LPQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 11:54:12 -0500
Received: by qwa26 with SMTP id 26so3430048qwa.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=IcAjctsfGaUA/v1/YByMKx3iZpVIjvSZJx601n2Yc3A=;
        b=Kr86P6bxrOvMkIpYLurlEM16ovPsEHs55ky9/Kg7Mw4vPUks0FK4vpewzmxbmkm0lp
         87UhzGQLobH+gsW+gEkXizWAr9F92JMS7dUGwGszFt+Fn1TZ+qOqK4MTRq6IjLlpouSP
         BGBJF+vpGV000SfKCI6zABqh3Vzwc3RNm7hFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XDteHXWNP8DLxk8APlhYiE1gbDPQKpANkaCQ4Rks26HmZQGR/Z04TOPcBUxPEIeb48
         Ti9+trF4DpGCXb7keMhDL4SzqulbKgSVIlEUTmYwioYfyZdmet4yAMLlWskS4HYuCfG7
         sEgXK210GqhyQ9cExMrhsL7aqSZIo7h7hbNow=
Received: by 10.224.74.13 with SMTP id s13mr7815007qaj.149.1292518451847; Thu,
 16 Dec 2010 08:54:11 -0800 (PST)
Received: by 10.220.191.66 with HTTP; Thu, 16 Dec 2010 08:54:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163809>

Hi.

We wrote a post-receive hook that alerts users (via email) when
specific paths are modified by their peers. The implementation is
pretty simple: whenever a new commit is made, we ask git for the full
list of files modified by that commit:

  git diff --name-only <COMMIT HASH>^!

This works well for regular commits, but breaks for merge commits.

For example, suppose we have the following basic merge scenario:

  B
 / \
A   D
 \ /
  C

Root A was branched to B and C, then merged into commit D.

Problem is, the diff for D^! will include all the changes introduced by C.

One obvious solution is to simply ignore merge commits, by parsing
`git cat-file commit D` and discarding all commits with parent count >
1. But merge commits may actually contain legitimate modified files if
there were any conflict resolutions.

So what's the best solution for this problem, oh wise Git wizards?

Thanks, D.
