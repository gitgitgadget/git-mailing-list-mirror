From: Jeff King <peff@peff.net>
Subject: Re: Does cloning a shallow repo require special setting in the
	cloned one?
Date: Thu, 26 Feb 2009 08:19:46 -0500
Message-ID: <20090226131946.GC7911@coredump.intra.peff.net>
References: <1235620146513-2387799.post@n2.nabble.com> <87tz6hn1tg.fsf@iki.fi> <20090226104657.GB4226@coredump.intra.peff.net> <alpine.DEB.1.00.0902261216110.6258@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, roylee17 <roylee17@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 26 14:21:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcgAv-0006g3-Kx
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 14:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbZBZNTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 08:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbZBZNTu
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 08:19:50 -0500
Received: from peff.net ([208.65.91.99]:40578 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbZBZNTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 08:19:50 -0500
Received: (qmail 4819 invoked by uid 107); 26 Feb 2009 13:20:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 08:20:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 08:19:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902261216110.6258@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111560>

On Thu, Feb 26, 2009 at 12:17:36PM +0100, Johannes Schindelin wrote:

> I think it is way better to warn, since "--depth" is usually passed out of 
> concerns about disk space.  And --shared should shut that concern up 
> rather nicely.
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index c338910..5831034 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -511,8 +511,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	refspec.src = src_ref_prefix;
>  	refspec.dst = branch_top.buf;
>  
> -	if (path && !is_bundle)
> +	if (path && !is_bundle) {
> +		if (option_depth)
> +			warning("Ignoring --depth for local clone");
>  		refs = clone_local(path, git_dir);
> +	}
>  	else {
>  		struct remote *remote = remote_get(argv[0]);
>  		transport = transport_get(remote, remote->url[0]);

That seems reasonable to me.

-Peff
