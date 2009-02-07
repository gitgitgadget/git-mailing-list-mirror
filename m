From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Sat, 07 Feb 2009 13:45:44 -0800
Message-ID: <7viqnludiv.fsf@gitster.siamese.dyndns.org>
References: <20090207064221.GA14856@coredump.intra.peff.net>
 <20090207064454.GB14906@coredump.intra.peff.net>
 <7vljsizog1.fsf@gitster.siamese.dyndns.org>
 <20090207114444.GB18079@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:48:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv20-0008CH-CA
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbZBGVpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbZBGVpx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:45:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbZBGVpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:45:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 997F297FE4;
	Sat,  7 Feb 2009 16:45:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4116D97FE2; Sat,
  7 Feb 2009 16:45:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0650CBC-F560-11DD-9DEB-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108886>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 06, 2009 at 11:38:38PM -0800, Junio C Hamano wrote:
>
>> >   2. If you ask for "foo/bar", and "foo/" is ignored, the
>> >      output will show only "foo: exclude: foo". This is an
>> >      artifact of the calling interface: you don't ask "is
>> >      foo/bar excluded", but rather while recursing through
>> >      "foo/" you ask "should I bother even recursing into
>> >      foo?". So the exclusion code never even knows that you
>> >      might have cared about foo/bar in the first place.
>> 
>> I do not see why it is a problem.  It exactly is what you want to know,
>> isn't it?
>
> Because I would expect "git check-ignore foo/bar | grep ^foo/bar:" to
> tell me if and how foo/bar is being excluded. But I have to instead
> check for ^foo and ^foo/bar.

Sorry, I do not understand why you need the downstream pipe that filters
using grep to begin with.

Shouldn't "git check-ignore dir/path" talk about the exclude entries that
caused dir/path to be excluded and no other patterns?  And if the reason
dir/path is exclude is because there was a higher level entry to exclude
dir/, the output would say so.  If there are unrelated exclude entries
that exclude dir's neighbour dir2 or dir/path's neighbour dir/path2, they
do not affect if dir/path is excluded, so check-ignore wouldn't show, no?
