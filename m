From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] remote: use remote_is_configured() for add and
 rename
Date: Mon, 15 Feb 2016 18:09:21 -0500
Message-ID: <20160215230920.GC30631@sigill.intra.peff.net>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455575984-24348-5-git-send-email-t.gummerer@gmail.com>
 <CAPig+cTH+S67_T=O58E_x--ZhawQEZKjCmK8G+unzm_8f2w8eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:09:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVSGo-0007W7-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbcBOXJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 18:09:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:42622 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751478AbcBOXJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 18:09:24 -0500
Received: (qmail 5935 invoked by uid 102); 15 Feb 2016 23:09:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 18:09:23 -0500
Received: (qmail 14191 invoked by uid 107); 15 Feb 2016 23:09:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 18:09:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 18:09:21 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTH+S67_T=O58E_x--ZhawQEZKjCmK8G+unzm_8f2w8eA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286287>

On Mon, Feb 15, 2016 at 05:52:14PM -0500, Eric Sunshine wrote:

> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > @@ -157,6 +157,24 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
> > +test_expect_success 'add existing foreign_vcs remote' '
> > +       git config --add remote.foo.vcs "bar" &&
> > +       git config --add remote.bar.vcs "bar" &&
> > +       test_when_finished git remote rm foo &&
> > +       test_when_finished git remote rm bar &&
> 
> Nit: If the second git-config fails, then none of the cleanup will
> happen. You'd either want to re-order them like this:
> 
>     git config --add remote.foo.vcs "bar" &&
>     test_when_finished git remote rm foo &&
>     git config --add remote.bar.vcs "bar" &&
>     test_when_finished git remote rm bar &&

Good catch. Do we actually care about "--add" here at all? We do not
expect these remotes to have any existing config, I think. So would:

  test_config remote.foo.vcs bar &&
  test_config remote.bar.vcs bar

do? I guess technically the failing "git remote rename" could introduce
extra config that is not cleaned up by those invocations, and we need to
"git remote rm" to get a clean slate, but I don't think that is the case
now (and it does not seem likely to become so in the future).

-Peff
