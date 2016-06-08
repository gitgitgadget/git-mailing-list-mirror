From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 8 Jun 2016 20:38:58 +0000
Message-ID: <20160608203858.GA513@dcvr.yhbt.net>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:39:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAkFm-0007ld-0o
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 22:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbcFHUjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 16:39:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43936 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757059AbcFHUjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 16:39:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FDB720078;
	Wed,  8 Jun 2016 20:38:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296851>

Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> +++ b/perl/Git.pm

> +sub parse_email {
> +	my %mail = ();
> +	my $fh = shift;
> +	my $last_header;
> +
> +	# Unfold and parse multiline header fields

When you libify, I suggest you localize $/ since $/
may be set to something other than "\n" by a caller
and change the behavior of <$fh> and $fh->getline.

	local $/ = "\n";

> +	while (<$fh>) {
> +		last if /^\s*$/;
> +		s/\r\n|\n|\r//;

And, as Eric Sunshine stated:

		s/\r?\n$//;

Explicitly localizing $/ means you wouldn't have to worry about
multiple \n showing up in the line, either.
And chomp/chop wouldn't work, here.

Otherwise I like the move to Git.pm, thanks.
