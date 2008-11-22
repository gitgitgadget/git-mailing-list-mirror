From: Jeff King <peff@peff.net>
Subject: Re: git commit -v does not removes the patch
Date: Sat, 22 Nov 2008 15:10:01 -0500
Message-ID: <20081122201000.GA5903@sigill.intra.peff.net>
References: <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com> <7vej1j40x5.fsf@gitster.siamese.dyndns.org> <20081111000706.GA26223@coredump.intra.peff.net> <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com> <20081111102914.GA30330@coredump.intra.peff.net> <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org> <20081112081609.GA3720@coredump.intra.peff.net> <20081120130851.GA17608@neumann> <20081120152015.GA6283@coredump.intra.peff.net> <20081122155541.GC6885@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 22 21:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ypR-0003Zy-CC
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 21:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYKVUKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Nov 2008 15:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbYKVUKI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 15:10:08 -0500
Received: from peff.net ([208.65.91.99]:1418 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbYKVUKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 15:10:07 -0500
Received: (qmail 9098 invoked by uid 111); 22 Nov 2008 20:10:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 22 Nov 2008 15:10:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Nov 2008 15:10:01 -0500
Content-Disposition: inline
In-Reply-To: <20081122155541.GC6885@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101556>

On Sat, Nov 22, 2008 at 04:55:41PM +0100, SZEDER G=C3=A1bor wrote:

> Thanks for the tip.  Junio's suggestion about '# Everything under thi=
s
> line is deleted.' could be implemented this way fairly easily (just a=
n
> additional echo in prepare-commit-msg, and other pattern in
> commit-msg).  But 'git commit --no-verify' is indeed a problem.
> Although I never use it explicitly, 'git rebase -i' does so.

One other option would be to munge the editor script instead of using
hooks. I.e., something like this:

  $ cat ~/local/bin/git-editor
  #!/bin/sh
  echo '# Everything under this line is deleted' >>"$1"
  git diff --cached >>"$1"
  $EDITOR "$1" || exit $?
  sed -i '/^# Everything under this line is deleted$/Q' "$1"

  $ git config core.editor ~/local/bin/git-editor

Of course, then you end up with the munging for things like "git rebase
-i" picking commits, but it should be harmless (since we end up removin=
g
it anyway).

-Peff
