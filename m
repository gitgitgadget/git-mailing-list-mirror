From: Christopher Tiwald <christiwald@gmail.com>
Subject: Filter-branch's "move tree to subdirectory" example fails with BSD
 sed?
Date: Sat, 14 Apr 2012 12:00:28 -0400
Message-ID: <20120414160028.GD1012@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 18:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ5Ox-00051M-Oq
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 18:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab2DNQAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 12:00:34 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:44978 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab2DNQAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 12:00:33 -0400
Received: by qafi31 with SMTP id i31so7678242qaf.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=/kXZiQC5Kc6TWWwN3gFP7zkyXzJIaKrmqUKqLMPX1DY=;
        b=alaL9BHLpJfO5zhH3MeefemAZiRN2M4u/ZWQbWufdYy4b2VufFAJJkTSluCzDncYsw
         5Pr9NHj5Ju2F36oOgBIQhP/wyJ69iIZTUqnNN2lhymirhztGF8Wpr8Rb+RvGdvMY8zqk
         HxrgYIOKVyG65aiyY14bPg+b7MSv6k/aVqz35mQydQo8PxfcwpIeCjkO5lEsEAMcLMAc
         fe/lJvdMco7IVusdLDGcwJc7Ex2+VhX+XByA6Tm2DVhDHdMeNanwh3P/2sqAyJSi+qTR
         sljKHdSqiz+bt/Fb0MkAIlA2hFucPnhGS7tnK09iFMl4XxkF81Hs+SttcB4gKpvKZtiL
         GZVg==
Received: by 10.224.41.200 with SMTP id p8mr8012163qae.13.1334419232859;
        Sat, 14 Apr 2012 09:00:32 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id dx8sm14906042qab.5.2012.04.14.09.00.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 09:00:31 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195492>

The "Move tree to subdirectory" example in the 'git filter-branch'
manpage fails on Mac OSX 10.7.3, but succeeds on Ubuntu 10.04. I'm
using git version 1.7.0.4, which happened to be the version installed
on the Ubuntu VM I had laying around. I think it's a difference between
'sed' on the two systems.

The example:
git filter-branch --index-filter \
        'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
                GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
         mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

Demonstrating the problem is with sed:
git init "test"
cd "test"
mkdir -p subdirA/subdirB
echo content > subdirA/subdirB/file
git add .
git commit -m "initial commit"
git ls-files -s | sed "s-\t\"*-&newsubdir/-"

On Mac 10.7.3 the final command outputs:
100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0	subdirA/subdirB/file

On Ubuntu 10.04:
100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0	newsubdir/subdirA/subdirB/file

I can solve my immediate problem using Ubuntu, but is there a way we
could rewrite the example to work on both systems? I'm afraid differences
between BSD and GNU 'sed' are a bit beyond me.

--
Christopher Tiwald
