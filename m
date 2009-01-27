From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 15:51:06 -0800
Message-ID: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
 <20090127233939.GD1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	PJ Hyett <pjhyett@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRxjW-0002q9-K3
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbZA0XvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbZA0XvR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:51:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbZA0XvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:51:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A20AE1D6B1;
	Tue, 27 Jan 2009 18:51:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 571911D69F; Tue,
 27 Jan 2009 18:51:08 -0500 (EST)
In-Reply-To: <20090127233939.GD1321@spearce.org> (Shawn O. Pearce's message
 of "Tue, 27 Jan 2009 15:39:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61564E06-ECCD-11DD-9E99-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107428>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Tue, 27 Jan 2009, PJ Hyett wrote:
>> 
>> > To expand further, here's the output from the command line when this happened.
>> > 
>> > ~/Development/github(jetty)$ git push pjhyett jetty
>> > fatal: bad object e13a86261c6e710af8fd4b5fb093b28b8583d820
>> > error: pack-objects died with strange error
>> > error: failed to push some refs to 'git@github.com:pjhyett/github.git'
>> 
>> Hmm.  The only thing I could think of is that the pack-objects used by 
>> your git-daemon is somehow not at the right version...
>
> No, that's pack-objects on the client.
>
> Its freaking weird.  I don't know why a server side upgrade would
> cause this on the client side.
>
> FWIW, in 1.6.1 the only mention of those bad object messages
> is inside revision.c.  I can't see why we'd get one of those
> by itself.  I would have expected messages from deeper down
> too, like from sha1_file.c.

As we do not know what version github used to run (or for that matter what
custom code it adds to 1.6.1), I guessed that the previous one was 1.6.0.6
and did some comparison.  The client side pack_object() learned to take
alternates on the server side into account to avoid pushing objects that
the target repository has through its alternates, so it is not totally
unexpected the client side changes its behaviour depending on what the
server does.
