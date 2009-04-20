From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in
 write_entry()
Date: Mon, 20 Apr 2009 14:17:36 -0700
Message-ID: <7vbpqrdnyn.fsf@gitster.siamese.dyndns.org>
References: <49EC2F7C.8070209@viscovery.net>
 <20090420110302.GB25059@dpotapov.dyndns.org>
 <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
 <20090420133305.GE25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw0u7-0001DL-Nq
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 23:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275AbZDTVRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbZDTVRt
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 17:17:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756587AbZDTVRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 17:17:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A5EBAC4E0;
	Mon, 20 Apr 2009 17:17:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09D07AC4DB; Mon,
 20 Apr 2009 17:17:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B190DA80-2DF0-11DE-B380-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117038>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Mon, Apr 20, 2009 at 02:58:49PM +0200, Alex Riesen wrote:
>> 2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
>> > The cygwin version has the same problem. (In fact, it is even worse,
>> > because we have an optimized version for lstat/stat but not for fstat,
>> > and they return different values for some fields like i_no). But even
>> > if we used the only Cygwin functions, we would still face the problem,
>> > because Windows returns the wrong values for timestamps (and maybe
>> > even size on FAT?). So I think the following patch should be squashed
>> > on top.
>> 
>> I just sent a patch with an "optimized" fstat. I see no problems (at least none
>> like these) with that patch. Timestamps match. Windows XP, yes. But since
>> that MSDN article mentions that it is not guaranteed, I guess I just been lucky.
>
> If the time passed between the creating file and end of writing to it is
> small (less than timestamp resolution), you may not notice the problem.
> The following program demonstrates the problem with fstat on Windows.
> (I compiled it using Cygwin). If you remove 'sleep' then you may not
> notice the problem for a long time.

I take that you mean that Alex's patch does not work as intended.  In the
meantime, I've squashed your one-liner "Cygwin-too" into Hannes's patch.

Thanks.
