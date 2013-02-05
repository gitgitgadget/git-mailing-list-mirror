From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 14:09:58 -0800
Message-ID: <7vpq0equo9.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
 <7vhalqsfkf.fsf@alter.siamese.dyndns.org> <877gmmqyho.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2qx6-0005ZL-QX
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 23:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab3BEWYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 17:24:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3BEWKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 17:10:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA4E9B613;
	Tue,  5 Feb 2013 17:10:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2t6x/Knn+6SH/RSktSSgodK4IIU=; b=b1qKMb
	Eva77p2RfqHa8raQWFL/++gErID7jW41HZHsk8BxW7sVVTHh+Z17Pd/ewU+qNJRj
	0UncxRwpUjrkwgYBcADglyHul8IDHpoNrpBLjgzfgirpyZZ4cjjt+nh3t313T6VX
	ZTEoTsj+RlhCWQrG2ahQh5t74bJnD1HiyFHAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nksVOBU88zDyCe+xRYdgl131XDh5oKyg
	lciFToNMOVopIAHIQlTCnlKv3ugT8nNdSh0ZvQTjt6zWG6bTLnTnvvm9prfezF3O
	M9ZHo25mZ0Ccf5EkMTv9igW5klGiXRhdugrG4kWr5NeHiq09wHAMWAwt24rJBqSl
	qEMBB0dQkCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACCA8B612;
	Tue,  5 Feb 2013 17:10:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 101D4B611; Tue,  5 Feb 2013
 17:09:59 -0500 (EST)
In-Reply-To: <877gmmqyho.fsf@lifelogs.com> (Ted Zlatanov's message of "Tue,
 05 Feb 2013 15:47:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8711144-6FE0-11E2-ABAB-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215546>

Ted Zlatanov <tzz@lifelogs.com> writes:

> On Tue, 05 Feb 2013 11:53:20 -0800 Junio C Hamano <gitster@pobox.com> wrote: 
>
> I think it's more readable with large loops, and it actually makes sense
> when you read the code.  Not a big deal to me either, I just felt for
> this particular script it was OK.
>
>>> +	if ($file =~ m/\.gpg$/) {
>>> +		log_verbose("Using GPG to open $file");
>>> +		# GPG doesn't work well with 2- or 3-argument open
>
> JCH> If that is the case, please quote $file properly against shell
> JCH> munging it.
>
> Ahhh that gets ugly.  OK, quoted.
>
> JCH> The only thing you do on $io is to read from it via "while (<$io>)",
> JCH> so I would personally have written this part like this without
> JCH> having to use IO::File(), though:
>
> JCH> 	$io = open("-|", qw(gpg --decrypt), $file);
>
> That doesn't work for me, unfortunately.  I'm trying to avoid the IPC::*
> modules and such.  Please test it yourself with GPG.  I'm on Perl
> 5.14.2.

This works for me as expected (sorry for that open $io syntax
gotcha).

-- cut here -- >8 -- cut here --

#!/usr/bin/perl
my $io;
open $io, "-|", qw(gpg --decrypt), $ARGV[0]
        or die "$!: gpg open";
while (<$io>) {
        print;
}
close $io
        or die "$!: gpg close";

-- cut here -- 8< -- cut here --

$ perl --version
This is perl, v5.10.1 (*) built for x86_64-linux-gnu-thread-multi
