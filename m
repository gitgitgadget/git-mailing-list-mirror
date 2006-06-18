From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 10:02:35 +0200
Organization: At home
Message-ID: <e731ai$su1$1@sea.gmane.org>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz> <e72j53$1m1$1@sea.gmane.org> <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 18 10:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsFH-00046J-Ar
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWFRICp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWFRICp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:02:45 -0400
Received: from main.gmane.org ([80.91.229.2]:43743 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932135AbWFRICo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 04:02:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrsEv-00045R-88
	for git@vger.kernel.org; Sun, 18 Jun 2006 10:02:37 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 10:02:37 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 10:02:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22054>

Martin Langhoff wrote:

> On 6/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> So GIT_CONFIG would be ~/.gitconfig, and GIT_CONFIG_LOCAL would be
>> $GIT_DIR/config or what?
> 
> I don't quite follow why gitweb needs a GIT_CONFIG_LOCAL defined.
> Given that it works in a CGI environment, it should read
> $GIT_DIR/config by default, and $GIT_CONFIG if set (from httpd.conf).

When talking about gitweb [installation] configuration, including where to
find GIT projects to display, one needs to remember that gitweb might (and
probably is) installed from binary package and not git.git, and
git/.git/config might not exist.

So we have the following options to separate gitweb-wide options:

- use ~/.gitconfig, /etc/gitconfig or some other global git configuration 
  file, reading values using '$gitexecdir/git-repo-config'.
  Problem: bootstraping, namely value of $gitexecdir ($gitbin now)
  needs to be set in gitweb.cgi, perhaps during the build process.

- use gitweb.conf for configuration, reading values via equivalent of
  'GIT_CONFIG=gitweb.conf $gitexecdir/git-repo-config'. 
  Problem: bootstraping, namely value of $gitexecdir ($gitbin now)
  needs to be set in gitweb.cgi, perhaps during the build process.

- use gitweb.conf for configuration, following the .git/config format,
  writing parsing of ini file (reading only) in Perl from scratch 
  (or use one of many CPAN modules).

- use Perl for configuration file, a la Jon Loeliger <jdl@jdl.com> patch:
   http://marc.theaimsgroup.com/?l=git&m=114308224922372&w=2

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
