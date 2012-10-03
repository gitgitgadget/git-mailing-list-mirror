From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Rebase doesn't restore branch pointer back on out of memory
Date: Wed, 3 Oct 2012 12:47:47 -0700
Message-ID: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:52:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIo-0001DP-3f
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab2JCTrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 15:47:49 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41481 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab2JCTrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 15:47:48 -0400
Received: by qaas11 with SMTP id s11so1848767qaa.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=a4LciyNMCDP9FiaiA0SOCBIOXnQEINFIuJKLBGE1cjU=;
        b=GFjnW2HdZolS3A8n6Tcc1/eYFrNwF0SLRyQkFKKgpt06djA3gs7Bsor4/PIeCqVQlh
         81NmltyYOzKdBdrT6N1oeHMOioT4tsBD49buxxlVFmy6Vc+HyAz2BDpszyrjG8rl0I+N
         6uckpGRRvc+M0hxTL+bqUGJ+plYh9OAqDFJ0Jpnvs7z3vIqZ8zk2UxP6Y9i2ob7qKW+y
         BBJ8KRmAFOrQ/KI9dspQ/2zfGQlj5GK5q3i8VgCJ+3PK824hKuffwIOG7/DPGwyGhqrr
         OY9ZIW+9KpfuR75U0mjPZxC/z0hFbuH115uAnUhvi1yB8qtybvFLHtfQ3vOHo4U0Utyt
         WrZQ==
Received: by 10.224.192.66 with SMTP id dp2mr8979515qab.95.1349293667728; Wed,
 03 Oct 2012 12:47:47 -0700 (PDT)
Received: by 10.49.108.161 with HTTP; Wed, 3 Oct 2012 12:47:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206935>

Hi,

I'd like to report a bug in git (observed on git version 1.7.11.msysgit=
=2E1).
When you do a rebase and it fails due to out of memory exception,
rebased branch pointer is changed but commits are not rebased. That
makes commits that you are rebasing unreachable (except via reflog):

=BB git lg
* 4c60761 - (origin/master, origin/HEAD, master) ...

=BB git rebase master sql_script
=46irst, rewinding head to replay your work on top of it...
fatal: Out of memory? mmap failed: No error

=BB git lg
* 4c60761 - (HEAD, origin/master, origin/HEAD, sql_script, master) ...

=BB git reflog sql_script
4c60761 sql_script@{0}: rebase finished: refs/heads/sql_script onto
4c60761303fccbb0860b28e8094ad17ae8b01d07
13555ed sql_script@{1}: branch: Reset to sql_script@{1}

Expected behaviour:
- restore branch to pre-rebase location on out of memory exception
- not to fall with out of memory in the first place. But for our
repository that could be fixed only after either:
--- a) msysgit would have x64 binary (currently it's not available)
--- b) rebase -m option could be used by default somehow (currently
it's not possible so specify default -m)

--
Alexander Kostikov
