From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --threaded option
Date: Tue, 26 Jun 2007 23:03:20 -0700
Message-ID: <7vmyymq6hj.fsf@assigned-by-dhcp.pobox.com>
References: <11828981103069-git-send-email-aroben@apple.com>
	<7vvedaq8eg.fsf@assigned-by-dhcp.pobox.com>
	<70B55529-9309-46D4-89A0-3FFD4D4E0660@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 08:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Qcq-0007NM-UC
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 08:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbXF0GD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 02:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXF0GD2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 02:03:28 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64772 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbXF0GD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 02:03:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627060326.FFOF3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Jun 2007 02:03:26 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GW3R1X0091kojtg0000000; Wed, 27 Jun 2007 02:03:26 -0400
In-Reply-To: <70B55529-9309-46D4-89A0-3FFD4D4E0660@apple.com> (Adam Roben's
	message of "Tue, 26 Jun 2007 22:32:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51019>

Adam Roben <aroben@apple.com> writes:

> On Jun 26, 2007, at 10:21 PM, Junio C Hamano wrote:
> ...
>>> +my ($threaded, $chain_reply_to, $quiet, $suppress_from,
>>> $no_signed_off_cc,
>>> +	$dry_run) = (1, 1, 0, 0, 0, 0);
>>
>> While we are at it, you might want to make everything other than
>> quiet and dry_run overridable the same way.
>
>    --[no-]chain-reply-to, --suppress-from and --no-signed-off-cc
> already exist, so do you mean that we should support --no-suppress-
> from and --signed-off-cc (i.e., the negations) as well? Or that we
> should have equivalent config settings for these? Or both?

Sorry for being unclear; I was talking about the config.

Also "my ($a, $b, $c, ...) = ($defA, $defB, $defC, ...)" gets
extremely hard to read when the list grows longer.  I was hoping
that when adding entries to %config_settings array, you would do
something like:

	my %config_settings = (
                threaded => [\threaded, 1],
                chainreplyto => [\chain_reply_to, 1],
		...
	);
	while (my ($var, $data) = each %config_settings) {
        	my $config = $repo_config_bool("sendemail.$var);
		${$data->[0]} = (defined $config) ? $config : $data->[1];
	}
