From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Wed, 12 Dec 2007 00:56:35 -0800
Message-ID: <7vy7c08f5o.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
	<alpine.LFD.0.99999.0712111703380.555@xanadu.home>
	<20071212013828.GC19857@steel.home>
	<alpine.LFD.0.99999.0712112045040.555@xanadu.home>
	<7v3au89utj.fsf@gitster.siamese.dyndns.org>
	<854peo8fm5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2NP8-0007kZ-SY
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758518AbXLLI46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758423AbXLLI46
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:56:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758238AbXLLI44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:56:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 487DD622D;
	Wed, 12 Dec 2007 03:56:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 69F176220;
	Wed, 12 Dec 2007 03:56:42 -0500 (EST)
In-Reply-To: <854peo8fm5.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	12 Dec 2007 09:46:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68015>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> Still, I like your swapping of size and nmemb parameters, regardless
>> of the "don't bother calling fwrite(3) if size is zero" fix.
>
> I don't.  Far too obscure, looks like an unintentional wart waiting to
> be corrected.

Oh, I did not mean it in the sense that would be a bugfix, but in the
sense that we are writing N instances of 1 byte, not 1 instance of N
byte blob, and should express size and nmemb parameters to fwrite(3) as
such.  IOW, I would have preferred:

	if (size && fwrite(buf, 1, size, stdout) != size)
        	barf(...);
