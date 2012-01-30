From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 30 Jan 2012 16:50:43 -0500
Message-ID: <20120130215043.GB16149@sigill.intra.peff.net>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrz7i-0000K4-0l
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab2A3Vup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:50:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48782
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab2A3Vup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:50:45 -0500
Received: (qmail 24812 invoked by uid 107); 30 Jan 2012 21:57:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jan 2012 16:57:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jan 2012 16:50:43 -0500
Content-Disposition: inline
In-Reply-To: <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189432>

On Mon, Jan 30, 2012 at 12:10:08PM -0800, Junio C Hamano wrote:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f1984d9..195c40b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -922,6 +922,19 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	return argcount;
>  }
>  
> +static int switch_unborn_to_new_branch(struct checkout_opts *opts, const char *old_ref)
> +{
> +	int status;
> +	struct strbuf branch_ref = STRBUF_INIT;
> +
> +	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
> +	warning(_("Leaving the unborn branch '%s' behind..."),
> +		skip_prefix(old_ref, "refs/heads/"));
> +	status = create_symref("HEAD", branch_ref.buf, "checkout -b");
> +	strbuf_reset(&branch_ref);
> +	return status;
> +}

Is it really worth warning? After all, by definition you are not leaving
any commits or useful work behind.

Also, this has the same strbuf reset/release leak as the last patch. :)

-Peff
