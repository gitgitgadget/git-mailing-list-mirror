From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-pull.sh: overhaul error handling when no
 candidates are found
Date: Thu, 12 Nov 2009 10:06:26 -0500
Message-ID: <20091112150626.GA24848@coredump.intra.peff.net>
References: <1257945756.26362.79.camel@heerbeest>
 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
 <20091112155310.7836c388@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bG2-0001TK-PC
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbZKLPGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 10:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbZKLPGf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:06:35 -0500
Received: from peff.net ([208.65.91.99]:55213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbZKLPGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 10:06:35 -0500
Received: (qmail 22206 invoked by uid 107); 12 Nov 2009 15:10:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Nov 2009 10:10:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Nov 2009 10:06:26 -0500
Content-Disposition: inline
In-Reply-To: <20091112155310.7836c388@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132772>

On Thu, Nov 12, 2009 at 03:53:10PM +0100, Jan Kr=C3=BCger wrote:

> * The longish error message displayed when the user uses "git pull" b=
ut
>   has no remote/merge/rebase lines configured for the current branch
>   contains example configuration to remedy the situation... but the
>   example uses a rather invalid syntax, using the dotted syntax "git
>   config" accepts, but also "=3D" separators which are used in the co=
nfig
>   file format. It also implies that this syntax is valid in git confi=
g
>   files. This changes the example to use valid config file syntax.

Personally, I would go the other way: give them something they can cut
and paste on the command line, like:

  git config branch.${curr_branch}.merge ${upstream#refs/heads/}

> +	if [ true =3D "$rebase" ]; then
> +		op_type=3Drebase
> +		op_prep=3Dagainst
> +	else
> +		op_type=3Dmerge
> +		op_prep=3Dwith
> +	fi
> +
>  	curr_branch=3D${curr_branch#refs/heads/}
> -	upstream=3D$(git config "branch.$curr_branch.merge")
> +	upstream=3D$(git config "branch.$curr_branch.$op_type")

Isn't branch.*.rebase a boolean value?

-Peff
