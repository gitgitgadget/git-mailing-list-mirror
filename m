From: Pierre Habouzit <madcoder@debian.org>
Subject: [parse-options] proposal for merge, take 1
Date: Tue, 16 Oct 2007 10:16:31 +0200
Message-ID: <1192522616-16274-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihhby-0003MG-M5
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbXJPIRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:17:00 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756583AbXJPIQ7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:16:59 -0400
Received: from pan.madism.org ([88.191.52.104]:39026 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbXJPIQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:16:57 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9B82C2538D;
	Tue, 16 Oct 2007 10:16:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 398D76FA2; Tue, 16 Oct 2007 10:16:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.1231.g62b9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61114>

  Hi, thanks to the tremendous help I received from Dscho to make its
API and internals even better, I believe that my parseopt branch is
ready for inclusion.

  There is only _one_ small backward incompatibility (if other ones,
then it's not done on purpose and should be fixed) in git-show-ref: it
had a -h short option, synonym of --head. I made this -H because -h is
automatically diverted to "show usage" now, and it's counter-intuitive
anyways. I rebased -i my series so that this patch comes last if people
think it's a bad idea, so that the rest can be still be merged.

  Note that patch 7/25 has a small discussion in it.

  The series comes in 2 parts: the parse-options construction, split
into small pieces to introduce each feature. And the migration of a few
builtins. Diffstats and shortlogs follow.

  The branch is available from git://git.madism.org/git.git in the topi=
c
branch ph/parseopt. I just rebased it onto the last "next" spearce
produced.

  Thanks to Alex Riesen, Johannes Schindelin, Jonas Fonseca and Kristia=
n
H=C3=B8gsberg for their help, patches and advices.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Part 1
-----------------------------------------------------------------------=
-------

  Alex Riesen (1):
      Rework make_usage to print the usage message immediately

  Johannes Schindelin (2):
      Add tests for parse-options.c
      parse-options: Allow abbreviated options when unambiguous

  Pierre Habouzit (5):
      Add a simple option parser.
      parse-options: be able to generate usages automatically
      Add shortcuts for very often used options.
      parse-options: make some arguments optional, add callbacks.
      parse-options: allow callbacks to take no arguments at all.

  .gitignore               |    1 +
  Makefile                 |    6 +-
  parse-options.c          |  328 +++++++++++++++++++++++++++++++++++++=
+++++++++
  parse-options.h          |   70 ++++++++++
  t/t0040-parse-options.sh |   92 +++++++++++++
  test-parse-options.c     |   35 +++++
  6 files changed, 529 insertions(+), 3 deletions(-)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Part 2
-----------------------------------------------------------------------=
-------

  Jonas Fonseca (1):
      Update manpages to reflect new short and long option aliases

  Kristian H=C3=B8gsberg (1):
      Port builtin-add.c to use the new option parser.

  Pierre Habouzit (16):
      Make builtin-rm.c use parse_options.
      Make builtin-mv.c use parse-options
      Make builtin-branch.c use parse_options.
      Make builtin-describe.c use parse_options
      Make builtin-fetch.c use parse_options.
      Make builtin-revert.c use parse_options.
      Make builtin-update-ref.c use parse_options
      Make builtin-symbolic-ref.c use parse_options.
      Make builtin-http-fetch.c use parse_options.
      Make builtin-for-each-ref.c use parse-opts.
      Make builtin-fsck.c use parse_options.
      Make builtin-count-objects.c use parse_options.
      Make builtin-name-rev.c use parse_options.
      Make builtin-pack-refs.c use parse_options.
      Make builtin-show-ref.c use parse_options [small backward incompa=
tibility].
      Make builtin-pack-objects.c use parse_options.

  Documentation/git-add.txt          |    4 +-
  Documentation/git-branch.txt       |    2 +-
  Documentation/git-mv.txt           |    2 +-
  Documentation/git-rm.txt           |    4 +-
  Documentation/git-show-ref.txt     |    4 +-
  Documentation/git-symbolic-ref.txt |    2 +-
  builtin-add.c                      |   70 +++------
  builtin-branch.c                   |  147 +++++++------------
  builtin-count-objects.c            |   32 ++--
  builtin-describe.c                 |   70 ++++-----
  builtin-fetch.c                    |  146 ++++++------------
  builtin-for-each-ref.c             |  138 ++++++++----------
  builtin-fsck.c                     |   80 +++-------
  builtin-http-fetch.c               |   65 ++++-----
  builtin-mv.c                       |   84 +++++------
  builtin-name-rev.c                 |   64 +++-----
  builtin-pack-objects.c             |  294 +++++++++++++++++----------=
---------
  builtin-pack-refs.c                |   47 +++----
  builtin-revert.c                   |   67 ++++-----
  builtin-rm.c                       |   54 +++----
  builtin-show-ref.c                 |  127 ++++++----------
  builtin-symbolic-ref.c             |   52 +++----
  builtin-update-ref.c               |   65 +++-----
  23 files changed, 654 insertions(+), 966 deletions(-)
