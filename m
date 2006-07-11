From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Tue, 11 Jul 2006 16:03:02 -0700
Message-ID: <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
	<20060711145527.GA32468@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
	<44B4172B.3070503@stephan-feder.de>
	<Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 12 01:03:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0RG0-0003vR-1O
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 01:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWGKXDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 19:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGKXDE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 19:03:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20201 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751342AbWGKXDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 19:03:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711230302.VCNY27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 19:03:02 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 11 Jul 2006 15:09:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23746>

Linus Torvalds <torvalds@osdl.org> writes:

> So if we have a uncompressed header, we'd need to add a separate 2-byte 
> fingerprint to it _before_ the real header that isn't divisible by 31, and 
> use that as the thing to test.
>
> Ho humm. I'll see what I can come up with.

I do not like to rely too heavily on what zlib compression's
beginning of stream looks like.

I think the new format can be deflated new header (fully
synched) followed by deflated payload.

So the sequence unpack-sha1-header followed by parse-sha1-header
would notice we are dealing with new format and reinitialize the
deflator at the point where the header deflator left off.

Wouldn't that work?
