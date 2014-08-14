From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fetch: silence git-gc if --quiet is given
Date: Thu, 14 Aug 2014 15:56:15 -0400
Message-ID: <20140814195615.GB19337@peff.net>
References: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
 <1408017065-17437-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mflaschen@wikimedia.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI18H-0006jK-NR
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 21:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbaHNT4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 15:56:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:52035 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752444AbaHNT4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 15:56:17 -0400
Received: (qmail 26877 invoked by uid 102); 14 Aug 2014 19:56:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Aug 2014 14:56:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Aug 2014 15:56:15 -0400
Content-Disposition: inline
In-Reply-To: <1408017065-17437-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255274>

On Thu, Aug 14, 2014 at 06:51:05PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Noticed-by: Matthew Flaschen <mflaschen@wikimedia.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/fetch.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 9394194..4ff4080 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1197,6 +1197,8 @@ int cmd_fetch(int argc, const char **argv, cons=
t char *prefix)
>  	string_list_clear(&list, 0);
> =20
>  	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
> +	if (verbosity < 0)
> +		argv_array_push(&argv_gc_auto,"--quiet");
>  	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);

I think this is a fine fix for this specific problem, and we should
apply it. But I do wonder if it would be simpler in the long run to
treat verbosity as a global option, and pass it around via a GIT_QUIET
(or GIT_VERBOSITY) environment variable.

I would not be surprised at all to find that there are other cases wher=
e
sub-programs do not respect the parent verbosity (I know we have had
problems with progress reporting flags carried over the transport
interface in the past, but I think we fixed all of those).

-Peff
