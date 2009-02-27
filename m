From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Thu, 26 Feb 2009 23:24:47 -0800
Message-ID: <7vy6vsmjeo.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
 <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de> <20090227025829.GA22060@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 08:26:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcx77-0006As-5W
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 08:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZB0HZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 02:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZB0HZA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 02:25:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbZB0HY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 02:24:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13D1A9DA34;
	Fri, 27 Feb 2009 02:24:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 402979DA32; Fri,
 27 Feb 2009 02:24:49 -0500 (EST)
In-Reply-To: <20090227025829.GA22060@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 26 Feb 2009 21:58:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC256B8E-049F-11DE-B2E7-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111641>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 27, 2009 at 12:31:22AM +0100, Johannes Schindelin wrote:
>
>> Somehow --no-hardlinks got broken by making clone a builtin.  This
>> was discovered during my work on --depth being ignored for local
>> clones.
>> 
>> There will be a test case that tests for --no-hardlinks in conjunction
>> with --depth, so this patch is not accompanied by a separate test.
>
> Hmm. But --no-hardlinks has an effect later, in copy_or_link_directory,
> making it just do a copy. So it _does_ work, just not in the way you
> expect.

Yup, I agree.

> I think to turn off local shortcuts entirely, --no-local would probably
> make more sense. IOW, something like this:

So across filesystems:

 - "git clone /p/a/t/h" falls back to copying;

 - "git clone --local /p/a/t/h" should fail without falling back to
   copying; and

 - "git clone --no-local /p/a/t/h" should work as if file:///p/a/t/h
   was given.

That is much more sensible than making "git clone --no-hardlinks /p/a/t/h"
imply more than what the option really means: we are making a local copy
but do not cheat with hardlinking.
