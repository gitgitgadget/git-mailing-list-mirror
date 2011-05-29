From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in
 notes
Date: Sat, 28 May 2011 23:37:45 -0700
Message-ID: <0DF6602C-9DF3-42B3-AFB1-CDAA71D9E2F0@apple.com>
References: <201105281154.25223.jnareb@gmail.com>
 <BANLkTinorqTQOBw46mYJYfEWTEXC+Myzpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 08:40:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQZfc-0003t9-E2
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 08:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab1E2GkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 02:40:00 -0400
Received: from crispin.apple.com ([17.151.62.50]:42482 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab1E2GkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 02:40:00 -0400
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LLY00AHA2ERJLJ0@mail-out.apple.com> for git@vger.kernel.org;
 Sat, 28 May 2011 23:37:46 -0700 (PDT)
X-AuditID: 11807130-b7c15ae000005aca-5d-4de1e9badfd1
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 36.E3.23242.AB9E1ED4; Sat, 28 May 2011 23:37:46 -0700 (PDT)
Received: from [10.0.1.254]
 (adsl-70-231-253-68.dsl.snfc21.sbcglobal.net [70.231.253.68])
 by cardamom.apple.com
 (Oracle Communications Messaging Exchange Server 7u4-20.01 64bit (built Nov 21
 2010)) with ESMTPSA id <0LLY00L4F2EXIG30@cardamom.apple.com> for
 git@vger.kernel.org; Sat, 28 May 2011 23:37:46 -0700 (PDT)
In-reply-to: <BANLkTinorqTQOBw46mYJYfEWTEXC+Myzpw@mail.gmail.com>
X-Mailer: Apple Mail (2.1233)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174684>

On May 28, 2011, at 8:55 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> One good thing about git-svn's current system is that you can easily
> share your repository with someone else, and they can bootstrap from
> the same commits.

I wish that was practical for some projects.

It would be a huge improvement if git-svn could fully incorporate *all*=
 of the metadata that it needs into native git objects (notes/tags/some=
thing). That way a git clone of a git-svn repository doesn't need to re=
-bootstrap anything. :-)

=46or example, a project that I follow has 26k branches (one per bug fi=
x due to organizational workflow/policy). The project took five days to=
 "git svn clone -s" and the re-bootstrap after blowing away the .git/sv=
n directory is similarly painful. Why? Well, let's consider how much da=
ta must be rebuilt:

$ git svn gc
$ find */.git/svn -type f -name unhandled.log.gz -print0 | xargs -0 rm
$ du -sh .git/svn
445M	.git/svn
$ find .git/svn | wc -l
   52467
$=20

Crazy, huh?

davez


P.S. -- To the credit of git, the space savings are incredible for this=
 project. The svn repository is 33.6 GiB vs 133.2 MiB for git (minus gi=
t-svn and git-reflog overhead). That's ~260x!