From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [ANNOUNCE] Gitolite v2.1 and mirroring features
Date: Fri, 30 Sep 2011 12:14:33 +0530
Message-ID: <CAMK1S_j3dK1m5j2B3yzW_ofyL5WSwE4+96wusS4FkwbTgkTZTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 08:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Wpr-0000ye-8p
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 08:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab1I3Gof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 02:44:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59048 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1I3Goe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 02:44:34 -0400
Received: by qadb15 with SMTP id b15so109745qad.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/okYYGi83L426qJ55rxGfC1KPeASmspL9DHjZbf9ncE=;
        b=fbVd2CeHFpkYlQchRyb/RZam8a9WEBViwkDWEO7GoaA2VzJk58IwGddaqHCyW6pF7G
         CJNjwKtVeOrhx1lqibcYO63nPIJvPLangpJxXhns1mm+BQ7O/jHrk/v8NZLUmmdEJDCy
         EOMsUrRvKQioq+WRSaHZYZz0PX6Ms8xfm7rE0=
Received: by 10.224.203.69 with SMTP id fh5mr8009103qab.271.1317365073695;
 Thu, 29 Sep 2011 23:44:33 -0700 (PDT)
Received: by 10.224.54.71 with HTTP; Thu, 29 Sep 2011 23:44:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182466>

Hello all,

I've kinda stopped sending "announce" emails for all the little
features and enhancements that happen to gitolite, but this one seemed
big enough and important enough to send one out to this list.

Gitolite v2.1 now does mirroring much more flexibly and powerfully
than the old, rather naive, setup.

Most of the impetus for these changes came from a rather large product
development group within TCS, the company I work for -- many cities,
offices, servers, repos, and developers.

Here are the highlights:

(1) the "NUMA" thing: Different repos can now be mastered on different
servers, depending on which city/office has the most developers for
*that* project.

This was the single biggest motivator for the new mirroring code; the
rest of the cool stuff just happened along.

(2) almost as good as "active-active" mirroring: If the "master"
server trusts the authentication performed by the "slave" server, you
can have the slave internally redirect a "git push" to the correct
master.

With this, developers don't have to remember which repo is mastered
where, use different 'pushurl's, etc.  They just do *everything* with
their local mirror and let the system deal with it.  (You can even
change which server is "master" and people don't even need to know it
has changed!)

(3) partial mirrors and local repos: A server doesn't have to carry
*all* the repos in the system -- it can choose to carry only some.

In our case it was often because there were no developers for that
project in that office, but there could be other reasons.  Server
load/resource constraints, legal/jurisdictional issues, server in a
non-free country and repo has crypto code ;-) etc.

Similarly, a server can have repos that it wants to keep purely local
-- not to be mirrored at all.

(4) laggy mirrors: If daytime bandwidth is an issue, and you're ok
with the lag, you can postpone mirroring to night times instead of
with every push.  The actual mirroring is triggered with a simple
command -- you can write your cron jobs around that quite easily.

(5) autonomous mirrors: Your mirrors don't all have to be under your
control.  They can be owned by someone else and you negotiate what
repos you'll mirror for each other.  For example, an open source
project may find a "donor" that is willing to mirror a few
highly-trafficked repos and make them available via git:// or http://

----

We use all these features (except the last one; it's not pertinent to
our setup), and things have been humming along for a few weeks now.

If you have any questions not answered by the documentation[1], feel
free to email me.

[1]: http://sitaramc.github.com/gitolite/doc/mirroring.html

-- 
Sitaram
