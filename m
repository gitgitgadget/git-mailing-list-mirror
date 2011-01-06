From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Thu, 6 Jan 2011 13:29:57 +1100
Message-ID: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 03:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pafca-0006Xm-OM
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 03:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab1AFCaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 21:30:30 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58103 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1AFCa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 21:30:29 -0500
Received: by bwz15 with SMTP id 15so16060275bwz.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 18:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=7GFzdY6LC4dkp3iS/8fYk98QkC6VBZ7uQ/Cjl2Iwy9U=;
        b=XDuV7+AIBnbW9vlUkO5L0rLbrx/1LcGMXdKARA5W/8Ash95klLHXf1MCX4hIuiYgOQ
         3AdP4wCJP4Hs60i/g2rzWlums4fBDr85B4+YgofO4WD6b0YiIFcp83+jRKGFSv57EnH2
         WdHZoSeUBLCWzoSEq2n5F6ZLmEGN9TIHCtfYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=A9miRtkx9jmq6mqr/GItgq2CdnsgFDajxQJkXCY4viGLy2wM9dMHGQ83w0HtqCEeIi
         hpVPg2CNfmBaNf36CwcgEP21jQ5BxW0j2adT/PHzDhB+YE/mU3SH+I705VLwT38uUEL8
         S8f+/uYaCgug5owDlu9kzYWacdSWDQdfu/gNs=
Received: by 10.204.112.196 with SMTP id x4mr677398bkp.133.1294281027246; Wed,
 05 Jan 2011 18:30:27 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Wed, 5 Jan 2011 18:29:57 -0800 (PST)
X-Google-Sender-Auth: A3Vafy7PAXaJjFj_YkXbFZQhJUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164620>

Bittorrent requires some stability around torrent files.

Can packs be generated deterministically?
If not by two separate repos, what about by one particular repo?

For Linus' linux-2.6.git, that repo is considered 'canonical' by many.

Pack-torrents could be ~1MiB, ~10MiB, ~100Mib, ~1GiB, or as configured
in a particular repo, which repo is the canonical location for
pack-torrents for all who consider that particular repo as canonical.

Perhaps a heuristic/ algorithm: once ten 10MiB (sequentially
generated) pack-torrents are floating around,
they could be simply concatenated to create a 100MiB pack-torrent,
with a deterministic name and SHA etc,
so that all those 10MiB pack-torrent files that torrent clients have,
can be re-used and locally combined into the 100MiB torrent as needed,
on demand.

Same for 100MiB -> 1GiB pack-torrents.

Individual extra commits:
While "small" number of additional commits go into a repo, clients
fall back to git-fetch, _after .

If Linus linus-2.6.git (currently configured "canonical" repo) goes
offline, simply configure a new remote canonical repo.

Branches:
Other "branches" repos of linux-2.6.git could create their own
consistent 50MiB (or as configured) pack-torrents which are
commits-only-missing-from-linux-2.6 pack-torrents (ie, those missing
from that repo's "canonical" upstream).

This would require clients have a recursive torrent locator (I start
at linux-net.git, which requires linux-2.6.git, so I go get those
packs as well as the linux-net.git packs).

Perhaps have a system-wide or user-wide git repo/ torrent config, or
check with user running git-clone linux-net.git "Do you have an
existing git.vger.kernel.org/linux-2.6.git archive?".

Zen
