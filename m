From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 14:13:33 -0400
Message-ID: <20080830181333.GA14893@coredump.intra.peff.net>
References: <20080830173947.GF7185@schiele.dyndns.org> <20080830180022.GA14552@coredump.intra.peff.net> <7vwshygyy9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUy8-0003ht-VC
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbYH3SNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 14:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbYH3SNf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:13:35 -0400
Received: from peff.net ([208.65.91.99]:3174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbYH3SNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:13:35 -0400
Received: (qmail 24611 invoked by uid 111); 30 Aug 2008 18:13:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 30 Aug 2008 14:13:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Aug 2008 14:13:33 -0400
Content-Disposition: inline
In-Reply-To: <7vwshygyy9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94400>

On Sat, Aug 30, 2008 at 11:06:06AM -0700, Junio C Hamano wrote:

> > Won't this execute the command using the shell, which means that
> > metacharacters need to be escaped? I didn't try, but I'm pretty sur=
e
> > this would break
> >
> >   git add -i "file with space"
>=20
> I didn't try either but I think you are right.  And I agree we should=
 say
> we rely on 5.6 or newer.

I did just try, and it is indeed broken.

> I thought gitweb folks are targetting 5.6.1 as the minimum for unicod=
e
> support (Lea and Jakub Cc'ed)?

Has it been tested? I don't have perl 5.6 handy, but:

  $ man perl58delta | grep -A8 'list form of'
       =C2=B7   If your platform supports fork(), you can use the list =
form of
           "open" for pipes.  For example:

               open KID_PS, "-|", "ps", "aux" or die $!;

           forks the ps(1) command (without spawning a shell, as there =
are
           more than three arguments to open()), and reads its standard=
 output
           via the "KID_PS" filehandle.  See perlipc.

  $ grep -- '-|' gitweb/gitweb.perl | head
        if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEA=
D") {
        open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return=
;
        open my $fh, "-|", git_cmd(), "config", '-z', '-l',
        open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
        open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z', $bas=
e
        open($fd, "-|", git_cmd(), 'for-each-ref',
        open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
        open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
        open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or ret=
urn;
        open my $fd, "-|", git_cmd(), "rev-list",

So either I am misunderstanding something, or gitweb uses a construct
that needs perl 5.8.

-Peff
