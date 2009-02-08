From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Sun, 08 Feb 2009 01:50:27 -0800
Message-ID: <7vmycxz28s.fsf@gitster.siamese.dyndns.org>
References: <20090207064221.GA14856@coredump.intra.peff.net>
 <20090207064454.GB14906@coredump.intra.peff.net>
 <7vljsizog1.fsf@gitster.siamese.dyndns.org>
 <20090207114444.GB18079@coredump.intra.peff.net>
 <7viqnludiv.fsf@gitster.siamese.dyndns.org>
 <20090208085933.GB4392@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6KX-0005sF-CG
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZBHJuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752795AbZBHJue
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:50:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbZBHJud (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:50:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B27B72AAFC;
	Sun,  8 Feb 2009 04:50:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC80B2AAF9; Sun, 
 8 Feb 2009 04:50:28 -0500 (EST)
In-Reply-To: <20090208085933.GB4392@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 8 Feb 2009 03:59:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED27B608-F5C5-11DD-BC3E-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108939>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 07, 2009 at 01:45:44PM -0800, Junio C Hamano wrote:
>
>> > Because I would expect "git check-ignore foo/bar | grep ^foo/bar:" to
>> > tell me if and how foo/bar is being excluded. But I have to instead
>> > check for ^foo and ^foo/bar.
>> 
>> Sorry, I do not understand why you need the downstream pipe that filters
>> using grep to begin with.
>
> Sorry, I should have been more clear. The grep was meant to simulate
> what my eyes and brain are doing. That is, if I ask "what are patterns
> affecting foo/bar?", I expect to see "foo/bar" in the output.

Oh, then the output format would, just like "grep" given more than one
file tells which file it found the match in, talk about which path the
output entry talks about when given more than one path.

Something like:

	$ git check-ignore foo/bar xyzzy~ hello.c
	foo/bar: foo/.gitignore:4: ??r
        xyzzy~: .git/info/excludes:22: *~

that says "foo/bar is ignored because line 4 of foo/.gitignore tells us to
ignore any three-letter filename that ends with r, xyzzy~ is ignored
because .git/info/excludes tells us to ignore everything that ends with
tilde on line 22, and hello.c is not ignored at all."
