From: Jacob Keller <jacob.keller@gmail.com>
Subject: failed submodule update re-run results in no checked out files?
Date: Wed, 17 Feb 2016 15:54:28 -0800
Message-ID: <CA+P7+xoF1Rz_43-v3NzGk1Hxp=yhF3toh1nFNQFMRVWr5q8STg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:54:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWBvu-0002DT-H6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 00:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161911AbcBQXyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 18:54:54 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:36132 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161909AbcBQXys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 18:54:48 -0500
Received: by mail-io0-f175.google.com with SMTP id l127so55242047iof.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+LzxOGePXDBYPkrVNuUqQV2gwqrX0yTf0UWDhPCmEoU=;
        b=uUcFoibJEgVrOJzIJUayEaiJAG7qomkqeQ0/Q7mhR56NdIQ6Xqyd8V6RPG/mrkSSwo
         lg2KViz2E6Yxo6eZQxmVLf285yMxPw2WZ0+vBCQv5is+mfPtlCAntfh7wLh9UNWxowZU
         IOB0mquikRj+2/1e45pcWxE+bRys2r3Fd9M0zOvRCpIZDMEsFTvSsU9hmTi79YdZ9M3X
         AMymh81PxYJGq1WsBFBfPvNj9q+jblcTrrUOGmW6Wa0CVmONs2gDK+KxG5agRDei3C4J
         DHitTqxcIq8e4eW7GssjcLjt3xpdSuQW8OPdpN+Zk6tJ4YFAeJodrC+3UyOqnjXrgAux
         VPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=+LzxOGePXDBYPkrVNuUqQV2gwqrX0yTf0UWDhPCmEoU=;
        b=PtRExF41FsrboijXDP1QiilnLNOqIZB7LHVdL797QNTLFqydL2+jgHOIzTz9j7naXI
         IUOkZOZmEAwAW80u19coc0rGkYKhLPtsqHA4Uq/gQwY9SNyGZT0creyIte9/Q7ux4jKk
         q8t7FeJMz6En2Rlsh2HlJVOXFJERjze3nd6sjCAslb0irtQAnZQ6WaDB5K1+4QpUefe2
         hEfADdH/skc8JnZxEyVCajeNMUke9rVK3ETK8pjuCCvS/R7ZDctG4pPgbnJjYha2Ur/H
         CYq7HEBJEhZtsPbc8AMoPVdfnhYUBHH1BPp+tL3cr43x6vsHMVv8bE4a7kMmQd/iCjL/
         Z0JA==
X-Gm-Message-State: AG10YOTdi+oC5d/OS7JrcSmeI3gi7utNc33Z4In5eCAWdDuhHV+sojxowkdVWEzRHINwZSv0SF/mQv81WdEqYQ==
X-Received: by 10.107.170.79 with SMTP id t76mr7549990ioe.71.1455753288037;
 Wed, 17 Feb 2016 15:54:48 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 17 Feb 2016 15:54:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286566>

Hi,

I am having an issue currently when using Git with a remote server
which has a limited number of ssh connections.

The ssh server sometimes closes connections due to too many concurrent
connections. I will get the following output from git in this case
when performing a submodule update of a submodule which is not yet
currently cloned/checked out.

stdout: Cloning into 'src/SHARED'...

stderr: Total 10288 (delta 7577), reused 10190 (delta 7577)
Received disconnect from 10.96.8.71: 7: Too many concurrent connections
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
Unable to fetch in submodule path 'src/SHARED'

The submodule is not cloned successfully, and this occurs somewhere in
the middle of the process.

If I run the command a 2nd time,

git submodule update --remote src/SHARED,

I get a successful run, but the files are not actually checked out. I
believe this is because the clone that failed did succeed in getting
the repository into a state where all the files are "removed" so a
further submodule update will do nothing since it's "already" checked
out at the correct commit.

Am I right in my understanding? Is this a bug? I believe I can fix
this using --force.

Note that i don't yet currently have a reliable reproduction of this
for various reasons, not least of which is that simulating network
error is difficult.

Any thoughts on this? Should I just have my script that runs my
continuous integration builds add a check to ensure files are checked
out? Is "--force" enough to get the submodule to be re-checked out
even if it's already checked out at the location?

Thanks,
Jake
