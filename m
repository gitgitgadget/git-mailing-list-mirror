From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git
	config' access
Date: Mon, 6 Apr 2009 11:29:42 +0200
Message-ID: <20090406092942.GW17706@mail-vs.djpig.de>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Apr 06 12:04:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqlgw-0002hr-SC
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 12:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbZDFKDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 06:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbZDFKC7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 06:02:59 -0400
Received: from pauli.djpig.de ([78.46.38.139]:37878 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbZDFKC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 06:02:59 -0400
X-Greylist: delayed 1982 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2009 06:02:58 EDT
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 81F039007F;
	Mon,  6 Apr 2009 11:29:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4c5fhqMWQ71X; Mon,  6 Apr 2009 11:29:43 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 066E69007D;
	Mon,  6 Apr 2009 11:29:43 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1Lql9C-0005Rn-Hd; Mon, 06 Apr 2009 11:29:42 +0200
Content-Disposition: inline
In-Reply-To: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115803>

On Mon, Apr 06, 2009 at 11:46:15AM +1200, Sam Vilain wrote:
> +	my ($fh, $c) = $git->command_output_pipe(
> +		'config', ( $which ? ("--$which") : () ),
> +		'--list',
> +	       );
> +	my $read_state = {};
> +
> +	while (<$fh>) {
> +		my ($item, $value) = m{(.*?)=(.*)};
> +		my $sl = \( $read_state->{$item} );
> +		if (!defined $$sl) {
> +			$$sl = $value;
> +		}
> +		elsif (!ref $$sl) {
> +			$$sl = [ $$sl, $value ];
> +		}
> +		else {
> +			push @{ $$sl }, $value;
> +		}
> +	}

Any reason why you don't use --null here? The output of --list without --null
is not reliably parsable, since people can put newlines in values.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
