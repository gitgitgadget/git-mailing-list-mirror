From: Junio C Hamano <gitster@pobox.com>
Subject: Re: multiple-commit cherry-pick?
Date: Mon, 10 Nov 2008 12:41:37 -0800
Message-ID: <7vabc75n5q.fsf@gitster.siamese.dyndns.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
 <20081106213711.GA4334@blimp.localdomain>
 <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
 <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
 <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>
 <20081109102528.GA5463@blimp.localdomain>
 <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdc5-0003ug-4D
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbYKJUmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbYKJUmS
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:42:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYKJUmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:42:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B3637BDBB;
	Mon, 10 Nov 2008 15:42:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8AA897BDA6; Mon,
 10 Nov 2008 15:41:44 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 10 Nov 2008 20:58:11 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B6F0976-AF68-11DD-8A4A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100570>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 9 Nov 2008, Alex Riesen wrote:
>
>> Oh, I am. But it is just so convenient to have range support for 
>> commands which just show commits. Besides, git-show just errors out, 
>> instead of producing the commits like git-log does.
>
> Have fun implementing the support, and then explaining to users why this 
> shows only one commit:
>
> 	git show HEAD^..HEAD HEAD~10

I find what Alex says somewhat silly because show is always "no walk", and
range by definition means you need to walk.

But when you give that command line, Alex could also change the command to
show the HEAD and HEAD~10, by changing the way series of range parameters
are evaluated by the revision parsing machinery.  You take HEAD^..HEAD and
come up with one set (that has only one commit, HEAD), you take the next
parameter HEAD~10 and come up with another set (that also has only one
commit, HEAD~10, because show does not walk), then you take union.

I personally do not want to see that happen, though.  The way multiple
"ranges" that come from separate command line parameters combine using set
operator semantics is so useful to do something like...

	git log ko/master..master ^maint

which is my way to ask "Which commits on master are the ones that I
haven't pushed out?  By the way, I have pushed out maint already so I do
not want to see anything that is already in maint", where ko/master tracks
what I pushed out to the public repository at k.org; this query is used to
see if I can still rewrite commits when I find typo/thinko in them.
