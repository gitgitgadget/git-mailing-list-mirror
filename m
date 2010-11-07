From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git diff-tree against the root commit
Date: Sun, 7 Nov 2010 09:23:25 -0800
Message-ID: <AANLkTimiyFhggBvK-AGqRnMXta65rEJvJSeQ+QGOnZWp@mail.gmail.com>
References: <4CCA6623.8090705@workspacewhiz.com> <4CD68662.4060709@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christoph Mallon <christoph.mallon@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 07 18:24:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF8yc-00088d-G0
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 18:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab0KGRYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 12:24:17 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44159 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121Ab0KGRYQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 12:24:16 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id oA7HNj9r028639
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 7 Nov 2010 09:23:46 -0800
Received: by iwn41 with SMTP id 41so3066183iwn.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 09:23:45 -0800 (PST)
Received: by 10.42.97.67 with SMTP id m3mr907721icn.343.1289150625349; Sun, 07
 Nov 2010 09:23:45 -0800 (PST)
Received: by 10.231.13.203 with HTTP; Sun, 7 Nov 2010 09:23:25 -0800 (PST)
In-Reply-To: <4CD68662.4060709@gmx.de>
X-Spam-Status: No, hits=-2.916 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160890>

On Sun, Nov 7, 2010 at 2:58 AM, Christoph Mallon
<christoph.mallon@gmx.de> wrote:
> On 29.10.2010 08:13, Joshua Jensen wrote:
>> I am mirroring a Git repository into another SCM. =A0I am using 'git=
 diff-tree' to tell me what changes I need to make to the other SCM.
>>
>> Today, I attempted to mirror a new submodule. =A0'git diff-tree' rep=
orted two SHAs... 0000000000000000000000000000000000000000 and the revi=
sion the submodule currently resides at. =A0I attempted to run a 'git d=
iff-tree' within the submodule for the all zero SHA and the revision sp=
ecified, but apparently, 0000000000000000000000000000000000000000 does =
not really represent the root commit and does not work. =A0I then disco=
vered the --root option, but that doesn't seem to give me the complete =
file list either.
>>
>> 'git diff-tree' has been working great for everything else, but I re=
ally need a root commit diff-tree listing for proper automation.
>>
>> What are my options?
>
> Diff against the empty tree.

That works, but it's a bit too technical.

The traditional way to do it is to just

   git diff-tree --root <commit>

where the magic "--root" option is just the flag to say "I want to see
the root as a diff too". The reason it isn't the default is
historical: since git started out for the kernel, and since the root
is an import from another tree, showing the root as a patch was
annoying.

You have to realize that back in the original coding days (when git
read-tree was introduced), it was meant for very basic scripting. What
is now "git log -p" used to be basically

  git-rev-list $(cat .git/HEAD) | git-diff-tree --stdin

and with the target being the kernel, the default of not showing that
first commit was a sane one (and going back even further,
git-diff-tree really only worked on trees, so you had to give explicit
beginning and end points).

Of course, by the time we actually had a "git log" command, I think
that default had already changed. But it still explains why there is a
separate option to show the root commit with a patch.

                                 Linus
