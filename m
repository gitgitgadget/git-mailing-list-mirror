From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 09 Jan 2009 12:53:24 -0800
Message-ID: <7vvdsoyzej.fsf@gitster.siamese.dyndns.org>
References: <20090108195511.GA8734@chistera.yi.org>
 <7v7i552clz.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901091405460.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 21:55:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLOOC-0008KE-FS
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 21:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbZAIUxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 15:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZAIUxi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 15:53:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbZAIUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 15:53:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 41FCA8FCCB;
	Fri,  9 Jan 2009 15:53:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7B50E8FCC7; Fri,
  9 Jan 2009 15:53:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9599FD08-DE8F-11DD-BBEA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105039>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 8 Jan 2009, Junio C Hamano wrote:
>
>> If we find the "common" context lines that have only blank and 
>> punctuation letters in Dscho output, turn each of them into "-" and "+", 
>> and rearrange them so that all "-" are together followed by "+", it will 
>> match Bzr output.
>
> So we'd need something like this (I still think we should treat curly 
> brackets the same as punctuation, and for good measure I just handled 
> everything that is not alphanumerical the same):

I meant by punctuation to include curlies (my wording may have been wrong
but from the example with " }" line it should have been obvious).

But I agree with both points Linus raised.  The criteria to pick what to
pretend unmatching should be "small insignificant lines" (small goes for
both size and also number of consecutive "insignificant" lines), and the
coallescing should be done to join a block of consecutive changed lines of
a significant size (so you do not join two 1 or 2-line "changed line"
blocks by pretending that a 1-line unchanged insignificant line in between
them is unmatching).
