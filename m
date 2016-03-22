From: Jeff King <peff@peff.net>
Subject: Re: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 18:35:38 -0400
Message-ID: <20160322223538.GA1158@sigill.intra.peff.net>
References: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
 <219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
 <CAGZ79kZaV3w5TM+FPORcFOdeCY8idCYV_yB4Vt5eSNVrNomp2w@mail.gmail.com>
 <CAGZ79kb0izRAZoQaDxTjKNz0VFEBqbkCSmro2pHm_kmLpJk0mw@mail.gmail.com>
 <20160322222501.GA29577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marcus T <maddimax@googlemail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:35:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUtt-0003vj-Na
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcCVWfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:35:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:36276 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752466AbcCVWfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:35:41 -0400
Received: (qmail 24189 invoked by uid 102); 22 Mar 2016 22:35:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Mar 2016 18:35:40 -0400
Received: (qmail 19375 invoked by uid 107); 22 Mar 2016 22:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Mar 2016 18:36:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2016 18:35:38 -0400
Content-Disposition: inline
In-Reply-To: <20160322222501.GA29577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289582>

On Tue, Mar 22, 2016 at 06:25:01PM -0400, Jeff King wrote:

> I think you can simplify this quite a bit to just:
> 
>   git clone --quiet git://git.busybox.net/buildroot
> 
> That breaks, but works without --quiet. Presumably the problem is on the
> server side, as we see the remote end hang up (and using different
> versions of git on the client does not seem to help).
> 
> It seems to fail consistently for me around 2.4s, which makes me think
> we're hitting some kind of timeout. I'd suspect a bug in the keep-alive
> code in upload-pack, but that shouldn't have kicked in by then.
> 
> I guess the next step is to try to reproduce with a local client/server,
> and then bisect the server version.

That server advertises that it's running v2.7.3. So I pulled down the
repo and tried reproducing with a local v2.7.3 run, but I can't get it
to fail.

I also tried tweaking uploadpack.keepalive down to 1 second to see if
that triggered anything, but again, nothing interesting.

So I'm not sure what the trick is to stimulating the failure. Is there
any special config set up on that server or in that repository? Is it
possible to get a tarball of the server repository, in case something in
the packing is relevant? I guess both of those would require contact
with the busybox.net admins.

-Peff
