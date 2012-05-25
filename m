From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 16:11:23 -0400
Message-ID: <20120525201123.GB4364@sigill.intra.peff.net>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <20120525174237.GA4267@burratino>
 <vpqipfkrvsx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 25 22:11:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0rC-000721-8W
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545Ab2EYUL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:11:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56083
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758524Ab2EYULZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:11:25 -0400
Received: (qmail 12728 invoked by uid 107); 25 May 2012 20:11:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 16:11:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 16:11:23 -0400
Content-Disposition: inline
In-Reply-To: <vpqipfkrvsx.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198520>

On Fri, May 25, 2012 at 07:54:06PM +0200, Matthieu Moy wrote:

> Having a $GIT_WORKTREE/.gitconfig file would be very nice, but raises a
> lot of security issues, so it's a much larger project (define which
> configuration values are allowed there, possibly take them into account
> at clone time, i.e. before checking out the files, and so on). Most
> likely out of the scope of my students' project ;-).

Yes, I have proposed it in multiple forms, and the discussion always
ends in "gross, it's too complex".

If you really want to do it, the recommended way at this point is:

  # review for any issues (1)
  less .gitconfig

  # assuming it's OK, copy into place (2)
  cp .gitconfig .git/config-from-upstream

  # include it
  git config include.path config-from-upstream

And then repeat steps (1) and (2) whenever you want to update from
upstream. That fixes not only the security issues, but also means that
you won't accidentally drop back to some antique bogus config when you
"git checkout $some_old_version".

-Peff
