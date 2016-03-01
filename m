From: Vladimir Dosen <vladimir.doshen@gmail.com>
Subject: git-svn ignore-paths and huge files
Date: Tue, 1 Mar 2016 23:41:14 +0100
Message-ID: <CAHS3bFRB_PNx0ssno+5Yz3mKt9K7pUzvnqqyucm3CuGuc5P4ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 23:41:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aasym-0008Nw-7o
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 23:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbcCAWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 17:41:16 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34171 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcCAWlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 17:41:16 -0500
Received: by mail-wm0-f41.google.com with SMTP id p65so56091311wmp.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 14:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=6agHqc6qVO8aCF7E9nzVPeW3yU2Jt3W4SLVZ6lSia18=;
        b=VXxUVHF4wyzsNw63Vu4smJRch7t7MY19PheRRe6+tFpV9isPc00mVR96qkx3oFTbc0
         m91nM2Zk+x5Db0OXhO07YnjpZRdJZWqIaz4R0JRmVt/WjaUWOdvxHehbshDwa8Nu7KWr
         zZvmgdmS03m9xGOuzBF0myRZVLUkXdtw8Vjhw96YaTDXqPnsgtgNxCCPxOaULW/JULEQ
         8oPComA1WmiJMDDrLCrCf1sQbspc3uOlY8dEuZdb+KqaPav4YARbgIEwS+GS4AaLS2kr
         0YqOeUYXj9MA35y9qBPBX+44kxqHR0oATCCmjONbJoLhORpoytQln3M1Ipqn4xX99x64
         L/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=6agHqc6qVO8aCF7E9nzVPeW3yU2Jt3W4SLVZ6lSia18=;
        b=F9PQtQBerMaStMQJwlJZAp/WFVKCp6Li+gHKAncaNhr37oLanGopSK1nFAcCWaRlpf
         1F3eGXg0wF3Um9MvduAWbPBcR88KeI6XYFaSMCe1gL0Qlrv3h9iJ1ISdIgUJ/i9xATmb
         zHXABreV6DILUIZ2ihcx2iZdO8yUmVSbpS8TOp0oKkNySHjqDqyfOOgQPNqtppyC+vgP
         LFE+kYkPQ54JvLGFB/5DN40T2T7f3B26BVw/8YQ4DKVWP4fDHBhJPxBZ410nYXZ3UtOR
         TRFc1WkzZUz3O72JD4gW7fL26RcAb9mksAAx4AL9pd2m1R4jyJaPoONGpvFVNwPwQ20C
         rTng==
X-Gm-Message-State: AD7BkJK3m/grx2UYQzcwVKQ3xIVFc/HFzBfu6FGKAH1S4PuAHJNqqcDOu0MkdW9/aKEBE+QnKd2onsz9k6qwvg==
X-Received: by 10.194.184.112 with SMTP id et16mr23158121wjc.75.1456872074659;
 Tue, 01 Mar 2016 14:41:14 -0800 (PST)
Received: by 10.27.188.212 with HTTP; Tue, 1 Mar 2016 14:41:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288073>

Hi.

Recently I sent Eric (who is CC-ed and these days sporadic available
for deeper analyses) email titled as "git-svn cloning get stuck during
processing huge file".
It was about "git svn clone ..." against repository which had big
third-party files (1,3 GB, 1,1 GB, 80 MB, 55 MB ), temporary stored in
that repository by mistake (deleted in next revisions).
So, because I don' t want them, naturally, neither in WC, nor in
.git/object files as a part of history,
I used "--ignore-paths" to avoid them.

Until today I though that process git-svn hangs, because I did not see
any progress indicator for a  long time, more than couple of hours.
(Thankful to "--ignore-paths", there were no temporary file(s) under
./git which rapidly increase on second level, but still there were
files such as (MAC's git-svn):
-rw-------   1 vladimirdosen  staff     0 Feb 26 17:51
Git_git_blob_1101_0_gyOjAm
-rw-------   1 vladimirdosen  staff     0 Feb 26 17:51
Git_svn_delta_1101_0_kG6AtD
-rw-------   1 vladimirdosen  staff     0 Feb 26 17:51 Git_svn_hash_OkjgGH
, as well as
-rw-r--r--  1 vladimirdosen  staff     0 Feb 26 17:51 index.lock
under /.git/svn/refs/remotes/git-svn.
... and I could note that process "get stuck" somewhere between
Ra.gs_do_update's call for "$reporter->finish_report($pool);"
and
return from Fetcher.apply_textdelta. )

Fortunately, today, probably thankful to much better network
condition, I succeed with "latency" 60-80 minutes,
where handling of mentioned files has taken 98% of total cloning.

So now, my question(s) could be rephrased:
Is there any way that ignoring with "ignore-paths" can be complete
ignoring of marked files,
or why beside many "return undef if $self->is_path_ignored" in git-svn
this  cloning(fetching) takes significant time anyhow?

It is not only about waiting, but I was misled that process is not
possible at all if I want to migrate SVN with full history :)

Thanks,
Vladimir
