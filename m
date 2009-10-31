From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Gitolite update
Date: Sat, 31 Oct 2009 11:32:38 +0530
Message-ID: <2e24e5b90910302302n6e4e68ct43ea1bacc18d1266@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 07:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4796-0003Wm-0S
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 07:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbZJaGCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 02:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZJaGCe
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 02:02:34 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:35716 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbZJaGCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 02:02:34 -0400
Received: by iwn10 with SMTP id 10so2611400iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 23:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=IHp8MlsZkEC/UhnAEUzPLuSKyuCAGyeZIAdgTYokDEA=;
        b=Je99pCC54KwovnFwmpH9PLxEO5SYPUTlHiihhUVoBv2obZWu+USOr4GURbMtjZKiPt
         4ADgoaMLeEvw/HwmgcUEBsdcWzhTY8QG5XYYbFX4OZFX3oaDcest6GsuSOw82GJr/68f
         5wtJbwqR6A6aJqj+ydirV2haCkuXhfEE083Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=M8ejpbwNtPGkw2mAavXXlLIMtNuWiMAh65Tiz8zNzQVcKgKGZoHPFRYJK9m9KsvYdF
         9d+jpnS/ydJROdSctYrV28MPRUppv98yAVR5HoaNniuJDT/DRt2BwwMPwWCFzzvwjnnY
         x9EKlYQCqb4BqV4OId6LAliZs3JVrOkRWSy2c=
Received: by 10.231.83.75 with SMTP id e11mr3880305ibl.11.1256968958816; Fri, 
	30 Oct 2009 23:02:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131834>

This is an update on gitolite, an ssh-based access control tool for
using git in a typical corporate environment.  The latest version is
always at git://github.com/sitaramc/gitolite.git

While still remaining upward compatible with the "inspiration" project
(gitosis), the extra features now form the largest section in
http://github.com/sitaramc/gitolite/blob/pu/doc/3-faq-tips-etc.mkd.
This was mostly the result of users asking for features they wanted, so
please take a look to see if something there strikes your fancy.

    [However, the 2 programs that do the actual access control *still*
    total only about 90 lines; I firmly intend to keep those less than
    100 to make them easy to audit for security.]

Significant additions since the last update
-------------------------------------------

Installs/upgrades

  * The easy install script is also good for upgrades.  The new "-q"
    option is particularly useful, and makes an upgrade really quick and
    "one command".

    Remote admin mode (where you make config changes in a clone of the
    gitolite-admin repo, and push them to the server) is now the
    *default*.  I think I managed to put enough ssh intelligence into
    the ssh aspect to make this finally work without pain, and people on
    #git have said it does work (i.e., it's not just me claiming it ;-)

Config file maintenance

  * Large config files (when you have many, many, repos) can be split up
    and delegated to different people.  The main config file can give a
    specific user the authority to manage a specific group of repos, and
    that user can then maintain the access control for those repos
    independently.

  * Config files are also checked for mismatches in pubkeys and
    usernames, which is good for catching typos early.

Documentation etc

  * The documentation, help text, and messages that come out have had
    numerous changes based on user feedback on #git.  Like in the easy
    install script, a lot of effort has gone into the ssh aspect.

Other (minor) updates
---------------------

  * Supports git installed outside the normal $PATH (on the server).
    Without this, *all* your users would have to specify the upload-pack
    and receive-pack program paths, either by setting config variables
    or using "-u", "--exec" etc. in the clone/push commands.

  * Trying a plain ssh to your gitolite account now tells you what repos
    you have access to, instead of a (largely useless) error message
    about needing SSH_ORIGINAL_COMMAND.  This sounds like a gimmick...
    until you actually need it :)

  * I've finally started tagging releases, and now an install or an
    upgrade done from a clone will record the version number.  When you
    upgrade, it tells you you're upgrading from version foo to version
    bar.

  * When specifying repos in subdirectories (foo/bar/baz.git) you no
    longer have to manually create foo/bar on the server first.

Recap of older features (for completeness)
------------------------------------------

  * per-branch permissions, including fine-grained control over "rewind"
  * install without root access on any Unix
  * simpler but much more powerful config file syntax
  * more comprehensive logging
  * "personal" namespace prefix for each user
  * "deny" rights in the config file (in the "rebel" branch)

Questions and support
---------------------

I'm often on #git, subject to my living in UTC+0530 time, and email is
also welcome (sitaramc@gmail.com is preferred, but
sitaram.chamarty@tcs.com may get my attention quicker).  If you log an
issue on github, please also send an email; I am checking github more
often now (having missed two issues for many days) but it's not as
frequent as I would have liked.

-- 
Sitaram
sitaramc@gmail.com / sitaram.chamarty@tcs.com
