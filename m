From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 22:54:23 -0700
Message-ID: <7vljq2zckw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
 <20090414T202206Z@curie.orbis-terrarum.net>
 <fcaeb9bf0904142009w5a21e483v7e98f91e5e35b14a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 07:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lty6Y-0003oT-OB
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 07:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbZDOFyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 01:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbZDOFyi
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 01:54:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbZDOFyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 01:54:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BF86FBED;
	Wed, 15 Apr 2009 01:54:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8ED58FBEC; Wed,
 15 Apr 2009 01:54:25 -0400 (EDT)
In-Reply-To: <fcaeb9bf0904142009w5a21e483v7e98f91e5e35b14a@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed, 15 Apr 2009 13:09:43 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3C0F936-2981-11DE-958D-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116589>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> 2. Disallow initial clones over git:// (allow updates ONLY)
>
> How can you do that? If I understand git protocol correctly, there is
> no difference between a fetch request and a clone one.

At the protocol level, you can tell a clone request by noticing that the
downloading side does not have any "have" lines, but it is a different
matter what the software does out of the box.

You can patch upload-pack to reject such requests.  I am sure gentoo folks
are capable of doing that ;-)

Also a rogue client can send a bogus "have" to fool that logic, and that
is the primary reason why we do not have such a patch to upload-pack.  It
is not worth it as a protection against determined people who want to DoS.
