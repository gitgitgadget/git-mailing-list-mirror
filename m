From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Git push over git protocol for corporate environment
Date: Wed, 30 Sep 2009 19:54:09 -0400
Message-ID: <873a64gfa6.fsf@sanosuke.troilus.org>
References: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 02:00:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt95x-0003RJ-7F
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 02:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbZJAAAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754918AbZJAAAP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 20:00:15 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43054 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754898AbZJAAAO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 20:00:14 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2009 20:00:13 EDT
Received: from source ([209.85.220.209]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSsPxEd0dM13mqoHtaU0L8AYYzQMB8uYm@postini.com; Wed, 30 Sep 2009 17:00:18 PDT
Received: by fxm5 with SMTP id 5so5982572fxm.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 17:00:17 -0700 (PDT)
Received: by 10.86.227.1 with SMTP id z1mr536586fgg.56.1254354853867;
        Wed, 30 Sep 2009 16:54:13 -0700 (PDT)
Received: from sanosuke.troilus.org.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id e11sm343939fga.13.2009.09.30.16.54.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 16:54:13 -0700 (PDT)
In-Reply-To: <76c5b8580909301613m283c4bfdne8de449ca0fd0987@mail.gmail.com> (Eugene Sajine's message of "Wed\, 30 Sep 2009 19\:13\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129369>

Eugene Sajine writes:

[snip]
> My problem is that I need the simplest, easiest and fastest solution
> from setup and maintenance point of view in a situation when we have =
a
> huge CVS repo with hundreds of modules (projects) in it. My current
> understanding is that we are going to pull out project by project fro=
m
> CVS and create corresponding git repos.
> So, this brings us to hundreds of git repos and over 200 hundred
> committers. In this circumstances we don=E2=80=99t want to manage eac=
h repo
> separately as well as we don=E2=80=99t want to manage each person wri=
te access
> rights to each repo.
> As I understand the best solution here is git protocol (one port only
> on dedicated server and no security as we are in trusted network) wit=
h
> read and write access configured for all repos on a dedicated server.
> What do you think I should do? How to enable push over git protocol?

How do you manage permissions now?  How would you like to manage
rights under the new system?

I am a git amateur, but I would suggest using git+ssh (git over ssh)
and use group or ACL permissions based on the SSH user account.  The
standard git-daemon does not provide authentication or authorization,
so you would have to roll your own -- but git+ssh lets you leverage
the operating system's built-in access controls.

=46or example, some developers might belong to group A, and others
developers belong to group B.  With standard Unix permissions, you
could grant global read but only group-A commit rights to any number
of permissions (by appropriate use of git init --shared).

I have not tried using POSIX ACLs to grant more complicated access
rights for git repositories, but setting default ACL entries on the
directory before running "git init" *should* give good results.

(Others have mentioned Gerrit.  I use that at work, and my only major
wish is that it had per-branch rather than per-project access
controls.  It is a vast improvement over the Subversion system we had
before.)

Michael Poole
