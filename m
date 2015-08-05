From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Error pushing new branch: value too great for base (error token is...
Date: Wed, 5 Aug 2015 23:02:26 +0530
Message-ID: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:32:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2YJ-0003HG-CB
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbbHERc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:32:27 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36985 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbHERc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:32:26 -0400
Received: by igbpg9 with SMTP id pg9so37760365igb.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ATa7RymMXzCZgi9HaDfwOW6i3cW92yixp0x5WpAjLvY=;
        b=x/Lc/XfLJBd8qRuKvaGXV1e/b6BqASKTvo9u0h5qCkYxpavi4RN3NxPM7t315p6JrR
         R6zhNOqAvzRioxE6paeTqCvz+Tc726kxiPKnE15RraYwdklsJrX7WU+N0II7+b5FL64y
         pcb92wPUfDeG8yKDans1S44PZeLJkaXiVmSB/92CQbClsu8iJhKM3p4VDNPCOgaTKOoV
         YKJIpFYMliHMb1Gu0aMoaxL7GIAyZlag1HMRsvpjoDw7Oq1cZOUcmEsKWZ/xNrRqFYfD
         blu3S5zicGbwfGPfbsheWz6gnQUD0pY7iGN9+OyqVGIKD7iVSsrxjDKJJa+SpNLQqyPH
         Tv3Q==
X-Received: by 10.50.79.169 with SMTP id k9mr464010igx.44.1438795946083; Wed,
 05 Aug 2015 10:32:26 -0700 (PDT)
Received: by 10.79.105.2 with HTTP; Wed, 5 Aug 2015 10:32:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275379>

I had written the following code to check whether a push is for branch deletion:

#!/bin/bash

NULL="0000000000000000000000000000000000000000"

while read old_sha new_sha refname ; do
    echo "Stdin: [$old_sha] [$new_sha] [$refname]"

    if [[ "$new_sha" -eq "$NULL" ]]; then   # Line 17
        echo "Skipping checks..."
        continue
    fi
    ...
    ...
    ...
done


While it works fine for branch deletion, i noticed that if i create a
branch and push it to remote, i get the following error due to the
above-mentioned code:

$ git push origin rel-a
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 407 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: Stdin: [0000000000000000000000000000000000000000]
[9226289d2416af4cb7365d7aaa5e382bdb3d9a89] [refs/heads/rel-a]
remote:
remote: hooks/pre-receive: line 17: [[:
9226289d2416af4cb7365d7aaa5e382bdb3d9a89: value too great for base
(error token is "922628
9d2416af4cb7365d7aaa5e382bdb3d9a89")


Although the new branch gets pushed to remote but i'm not sure why i'm
getting this error and how can i fix it. I checked online and i get
few links where folks had similar issue but in each such case, the
error token was 08 or 09. I still tried the suggestion of using "10#"
in front of my $new_sha variable but to no avail.

Any suggestions?
