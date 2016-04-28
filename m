From: Michal Hocko <mhocko@kernel.org>
Subject: feature request for cc-cmd
Date: Thu, 28 Apr 2016 15:43:46 +0200
Message-ID: <20160428134346.GA31496@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 15:43:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmEV-00076g-3B
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbcD1Nnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:43:49 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35314 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcD1Nnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:43:49 -0400
Received: by mail-wm0-f46.google.com with SMTP id e201so77341731wme.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 06:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l7wx9lz/Pu0Iqnr/iWMV9JvGrlBKZOiWFHZW9ZYuUCY=;
        b=YEsOTgJrqUxxWwuvoYeYHj4t9HuzG2whGDxNcIlgHqiVfZCSvWYxKUFnDoKsNyIaiD
         7/tTKbW6uMV37P5W83onOtfYl0I9ORiiCjLUM2xKlYqlAjzkzHrv6H6X0HAyfHf6NU71
         b6o1VK384LDT1OeJrmTgIWWoVfQgANo5db+xx9tPz704dcNKH0GV7kSUB+DSNkT+e/R/
         r5Dfskta0kk6MFmgCkfy7JDnXMpKWzbZ6G4RqVuJG+pZdByuGC+vqE3I0Pu6aNJ4wcLU
         kWeHEVp9l7R1OPjol90/6m7vxexRQCGMXIB4EaLq3l2b8XH9qiuRTgk2g7hJdzn50+1+
         4VmA==
X-Gm-Message-State: AOPr4FW8qm8RzwcNlVf5yoCbRyfZDaZZYNjOQMTv4PlAErQiIPCkJIjpB41yBqHzG4nTRA==
X-Received: by 10.194.58.195 with SMTP id t3mr15010706wjq.97.1461851027289;
        Thu, 28 Apr 2016 06:43:47 -0700 (PDT)
Received: from localhost (nat1.scz.suse.com. [213.151.88.250])
        by smtp.gmail.com with ESMTPSA id u187sm23923783wmu.21.2016.04.28.06.43.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 06:43:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292882>

Hi,
currently I am using --cc-cmd for larger patch series which are of
interest of different parties (e.g. kernel tree wide stuff) and I do not
want to spam all of them by patches which are not of their interest but
I still want them to receive the cover letter because that is useful to
get a context of a change. In order to do that each particular commit
has
 Cc: email
 {Acked,Reported,Reviewed,...}-by: email
in the patch header and I use the following

$ cat cc-cmd.sh
!/bin/bash

if [[ $1 == *gitsendemail.msg* || $1 == *cover-letter* ]]; then
        grep '<.*@.*>' -h *.patch | sed 's/^.*: //' | sort | uniq
else
        grep '<.*@.*>' -h $1 | sed 's/^.*: //' | sort | uniq
fi

git send-email --cc-cmd ./cc-cmd.sh --to lkml patches...

which works reasonably well except I have to git format-patch the whole
series before posting. Quite often I do git send-email commit-range
though. This way is also little bit error prone because I have to make
sure no unrelated patch files are in the same directory. Would it be
possible that the cc script would get a list of all patch files for the
cover email? I have noticed that git send-email from the sha range will
use /tmp/$rand_dir/*.patch so this should be possible I guess. I would
update my script to

!/bin/bash
grep '<.*@.*>' -h $1 | sed 's/^.*: //' | sort | uniq
if [[ $1 == *gitsendemail.msg* || $1 == *cover-letter* ]]; then
	shift
        grep '<.*@.*>' -h $* | sed 's/^.*: //' | sort | uniq
fi

Would something like that make sense or there is an easier way
which I am just not aware of?

Thanks a lot!
-- 
Michal Hocko
SUSE Labs
