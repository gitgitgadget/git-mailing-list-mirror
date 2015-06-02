From: Zenaan Harkness <zen@freedbms.net>
Subject: git torrent - sane deterministic pack files
Date: Tue, 2 Jun 2015 15:07:03 +1000
Message-ID: <CAOsGNSSK6WwVvftc1Wx14gRyZ7Mx2qnXsDxducCCA0VBvqyK8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 07:07:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzePu-0008Er-MI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 07:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbbFBFHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 01:07:05 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36333 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbbFBFHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 01:07:04 -0400
Received: by obbea2 with SMTP id ea2so119727261obb.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 22:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=YM4rtWxKZVoWoC1bNg4MNhg4cz0ZJ5iNTnlUHBk4e+w=;
        b=E+JqWW1+7JWcS6dtvaH6WzUgKboQQ0jFTWQ0lQx+TolDa/4I6bzIUk8vYXa2gJ6xGf
         e8ZkH1eMSGCItaLCCAFO04kncdDgjoXjT9FVcVTelvAloz6UmXCsDL621d31/YmPqOwV
         n/0Uigp/fa4a+kMelB94ifePmptz76tZzcHBU5tHOzA5+cQoDMn+Noc3ZSxFsoaBk3Dz
         L+m/JMVy+uE9ChOuhlXlhBE5dEetULmrcsNdSmz1Ejf95Uf6Irm58zJbueQuWtiSmfZI
         dffs6Tod2quRGT1twcy2MWko5GJV9PSv8jP4McHqn+8DzPytkGnpxSO35ekoEUVayrlf
         dOBQ==
X-Received: by 10.60.50.168 with SMTP id d8mr21374153oeo.41.1433221623649;
 Mon, 01 Jun 2015 22:07:03 -0700 (PDT)
Received: by 10.182.121.198 with HTTP; Mon, 1 Jun 2015 22:07:03 -0700 (PDT)
X-Google-Sender-Auth: MelJh7aTQ4ENoj81kc8UCUYgpIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270502>

Please CC me when replying, if you think of it. Thanks.

LWN discussion, this particular thread starts here:
https://lwn.net/Articles/646758/

Some extracts:
Deterministic packfile creation is required for parallel git downloads.

Example git pack file parameter/ configuration variations:
- compression on X number of CPUs
- maximum packfile size
- more trees/ branches in this repo than on that repo

A way is needed to capture these packfile config variations and
distribute them to other git servers (perhaps on a standardized branch
name or ??).
---
Related mail from 4 years ago:
http://article.gmane.org/gmane.comp.version-control.git/164643

Conceptually it may not be hard, but implementation is hard. By
forcing certain object layout rules, you may have lower compression
ratio, or slower pack access, and may consume more power. Git tries to
reuse deltas from existing packs to produce a new pack. This makes it
quick to assemble a pack, but also underterministic. There's also
threads stealing jobs from one another in the above link. Resumable
clone is a frequent request, and we still don't have it now.
---
Deterministic pack file parameter sets and compression can always be
tuned over time even though they change the format - that's just local
policy for the authoritative git torrent server.

Also for scenarios which benefit from pack file torrents, the marginal
reduction in compression (increase in pack file size) due to the need
for determinism may very well be valuable (marginal increase in local
storage in order to distribute downloads) - local policy strikes
again.
...
It's up to the "authoritative git server" admin to make the policy
decision of how long to keep with a current deterministic torrentable
pack file parameter set, and when to update to a new/tuned set. This
is always a local policy matter! "We can't do that because it's not
the best policy for maximum compression" is not the right answer
here...
...
If I am a torrent repo mirror, the "authoritative torrent upstream" is
merely a local config.

This not only sounds easy, it is easy - even in the face of
compression technology changes and "tuning" over time - that's merely
a "version" increase or new parameter set provided by the
"authoritative" repo server, and is local policy to that server.

Regards
Zenaan
