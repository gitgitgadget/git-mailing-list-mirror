From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc2
Date: Sat, 25 Jul 2009 22:16:58 +0200
Message-ID: <1248553018.4593.15.camel@kea>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org>
	 <20090724093847.GA20338@dcvr.yhbt.net>
	 <7vk51ykm42.fsf@alter.siamese.dyndns.org>
	 <20090725103821.GA13534@dcvr.yhbt.net> <1248529164.4593.8.camel@kea>
	 <20090725192230.GA11510@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUnhO-0005qm-HL
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZGYURC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 16:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZGYURC
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:17:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:40233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752564AbZGYURA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 16:17:00 -0400
Received: (qmail invoked by alias); 25 Jul 2009 20:16:59 -0000
Received: from d187074.adsl.hansenet.de (EHLO [192.168.1.50]) [80.171.187.74]
  by mail.gmx.net (mp009) with SMTP; 25 Jul 2009 22:16:59 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX19Pzvchli1PiuSXjfqkm9OXyBVHVzqc4/SK4KuLlV
	xITNguTh7A7Sew
In-Reply-To: <20090725192230.GA11510@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124064>

On Sat, 2009-07-25 at 12:22 -0700, Eric Wong wrote:
> Mattias Nissler <mattias.nissler@gmx.de> wrote:
> > Maybe we should rather try to detect whether we have read access to the
> > repository root and adjust behaviour accordingly? Or at least print a
> > warning when cloning restricted multi-branch repos, since this just
> > fails silently (doesn't pick up any branches) when you have minimize_url
> > enabled.
> 
> We actually try that in Git::SVN::Ra::minimize_url:
> 
> sub minimize_url {
> 	my ($self) = @_;
> 	return $self->{url} if ($self->{url} eq $self->{repos_root});
> 	my $url = $self->{repos_root};
> 	my @components = split(m!/!, $self->{svn_path});
> 	my $c = '';
> 	do {
> 		$url .= "/$c" if length $c;
> 		eval { (ref $self)->new($url)->get_latest_revnum };
> 	} while ($@ && ($c = shift @components));
> 	$url;
> }
> 
> Maybe get_latest_revnum() isn't strong enough of a check for
> certain setups and get_log() needs to be used instead?

Well, I simply wasn't aware of this. I've just retried and it turns out
latest git.git works perfectly for me in both restricted and
non-restricted setups. Great work!

Mattias
