From: Mike Galbraith <bitbucket@online.de>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 18:21:06 +0200
Message-ID: <1365783666.5814.21.camel@marge.simpson.net>
References: <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
	 <20130411200330.GA15667@odin.tremily.us>
	 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
	 <20130411222301.GA11283@sigill.intra.peff.net>
	 <20130412005748.GA17116@odin.tremily.us>
	 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
	 <20130412043501.GA12942@sigill.intra.peff.net>
	 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
	 <20130412050550.GA15724@sigill.intra.peff.net>
	 <20130412112636.GC20178@odin.tremily.us>
	 <20130412144855.GA17968@sigill.intra.peff.net>
	 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgkP-0001HK-MI
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab3DLQWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:22:43 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:65477 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab3DLQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:22:40 -0400
Received: from [192.168.178.27] (p4FE19057.dip0.t-ipconnect.de [79.225.144.87])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LcVQE-1Uspzp396c-00jlRz; Fri, 12 Apr 2013 18:21:08 +0200
In-Reply-To: <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.3 
X-Provags-ID: V02:K0:C1njbpn0bDDzJ6zippC3elNC0AA9U53hUFvRxny4pq6
 YZoEfj9MfrMydgCAJvjB0x2vn7Da7F8dHM/U7gYefTWGBrhp3I
 kNSNAILrfrLCAogsQ7QFusygVmS7hmEuwkHgv7Qa0TRwXJsJhJ
 F5qLq7nIZo6tIhQTqSwS/jgiWwNjwy0OZ6+JT+txQoxCMAHmpG
 xFtB3gqadpLJroVsyR3rn1C+MtgI9vYxzkSAquEWGCixh5vB8t
 NB9LPsaZxUsO4qZhaoYwtHiN/8WdNvJ3OaE1mrbGBdw3eKACLR
 KedjW1yURh3FiEdi9aHD8aV9mqokqLOKqKpb/FCFtbvAjz0FqB
 TKh+19O0DOrUKpSDLfeRq7XiJIE1hKG8j+SBlI1TwVWv8Dfve/
 Jq/P42QqOQC5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220998>

On Fri, 2013-04-12 at 09:08 -0700, Junio C Hamano wrote: 
> Jeff King <peff@peff.net> writes:
> 
> >> How about "and make sure any Git configuration files", since there
> >> might not be any Git configuration files.
> >
> > Yeah, that is better. Thanks.
> 
> OK, then...
> 
> -- >8 --
> Subject: [PATCH] doc: clarify that "git daemon --user=<user>" option does not export HOME=~user
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Helped-by: W. Trevor King <wking@tremily.us>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-daemon.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 7e5098a..2ac07ba 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -147,6 +147,13 @@ OPTIONS
>  Giving these options is an error when used with `--inetd`; use
>  the facility of inet daemon to achieve the same before spawning
>  'git daemon' if needed.
> ++
> +Like many programs that switch user id, the daemon does not reset
> +environment variables such as `$HOME` when it runs git programs,
> +e.g. `upload-pack` and `receive-pack`. When using this option, you
> +may also want to set and export `HOME` to point at the home
> +directory of `<user>` before starting the daemon, and make sure any
> +Git configuration files in that directory are readable by `<user>`.

The "you may want to.." is perhaps a little understated given it will
fail -EGOAWAY if git-daemon is started via init scripts if you don't.
(but otoh, that's enough of a hint to anyone setting the thing up, no
need to write paragraphs of legal-beagle boiler-plate for dinky bug;)

-Mike 
