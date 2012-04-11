From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: Use parse-options raw output for
	simple long options
Date: Wed, 11 Apr 2012 15:56:14 +0200
Message-ID: <20120411135614.GQ2289@goldbirke>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
	<1334140165-24958-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <spearce@spearce.org>, <szeder@ira.uka.de>,
	<felipe.contreras@gmail.com>, <jrnieder@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:56:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHy2A-0005Tc-04
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 15:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760259Ab2DKN4Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 09:56:25 -0400
Received: from mailhost.fzi.de ([141.21.8.250]:43044 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab2DKN4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 09:56:24 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Apr
 2012 15:56:14 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Apr
 2012 15:56:14 +0200
Content-Disposition: inline
In-Reply-To: <1334140165-24958-3-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195180>

Hi,


On Wed, Apr 11, 2012 at 03:29:25AM -0700, Stephen Boyd wrote:
> Now that parse-options supports generating lists of long options for =
any
> parse-optified git program we can remove the hand-coded lists in the
> completion script. Replace these lists with code to generate the list=
s
> lazily when a user tab completes that specific command. Unforunately,
> doing lazy evalution takes more lines than before, but the benefit is=
 we
> reduce the amount of trivial patches to update the script for new and=
/or
> removed options. It also mildly encourages the migration of git comma=
nds
> to the parse-options API.
>=20
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>=20
> Is there some way to compute these lists with some magical function i=
nstead
> of duplicating that logic over and over?

Maybe a function like this:

__git_compute_command_options ()
{
        local varname=3D"__git_${@//[ -]/_}_options"
        eval "test -n \"\$$varname\" || $varname=3D\"$(git $@ --dump-ra=
w-long-options)\""
}

And then in each completion function just need to call this function
with the command (and possibly subcommand) as parameter:

__git_compute_command_options add


Best,
G=E1bor
