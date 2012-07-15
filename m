From: Jeff King <peff@peff.net>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sun, 15 Jul 2012 03:44:42 -0400
Message-ID: <20120715074441.GA18385@sigill.intra.peff.net>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
 <loom.20120714T114718-783@post.gmane.org>
 <7vzk725c86.fsf@alter.siamese.dyndns.org>
 <7vr4se5bg4.fsf@alter.siamese.dyndns.org>
 <CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com>
 <7vmx32590u.fsf@alter.siamese.dyndns.org>
 <CAAa3hFMNf_wA22ngypSu379jr31r3L3yAjTkvDUd_L-mVwPJkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@gmail.com>,
	git@vger.kernel.org
To: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 09:45:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqJVl-00045Q-6N
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 09:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab2GOHoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 03:44:46 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:59986
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2GOHoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 03:44:44 -0400
Received: (qmail 18547 invoked by uid 107); 15 Jul 2012 07:44:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 15 Jul 2012 03:44:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jul 2012 03:44:42 -0400
Content-Disposition: inline
In-Reply-To: <CAAa3hFMNf_wA22ngypSu379jr31r3L3yAjTkvDUd_L-mVwPJkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201472>

On Sun, Jul 15, 2012 at 01:24:18AM +0300, Zeeshan Ali (Khattak) wrote:

> > Think what "log ^^ origin" would mean.  Is it "log ^HEAD^ origin"?
> > Is it "log HEAD^^ origin"?  They mean totally different things.
> 
> Sorry for my ignorance here but what does ^ *before* HEAD even mean? I

It means "not" (before "HEAD" or any other commit specifier). See
"Specifying Ranges" in "git help revisions".

> > Compared to that, at least ~<n> does not have such ambiguity within
> > the context of Git (having to quote is an ambiguity within the
> > context of using Git with shells that support dirstacks in their
> > tilde expansion).
> 
> Don't know whats dirstacks support either but that I guess just means
> that bash (the shell I have always used) doesn't do that.

Bash does support them, but you may not use them personally. Here are
some examples of how a more bare "~" can go wrong:

  $ set -x
  [this instructs the shell to show us what it is executing]

  $ git log ~
  + git log /home/peff
  [oops, the shell expanded our home directory and passed it to git]

  $ git log ~1
  + git log '~1'
  [this one works ok, but...]

  $ pushd /tmp
  $ pushd $HOME
  $ git log ~1
  + git log /tmp
  [oops, pushd users cannot use ~<n> without quoting]

-Peff
