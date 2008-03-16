From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Sun, 16 Mar 2008 15:28:02 -0700
Message-ID: <7v4pb6gv7x.fsf@gitster.siamese.dyndns.org>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org>
 <7v63vmicvf.fsf@gitster.siamese.dyndns.org> <47DD9890.3060005@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, beuc@gnu.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1LX-0003Ak-V6
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 23:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYCPW2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 18:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbYCPW2M
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 18:28:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbYCPW2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 18:28:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1A6E22DD;
	Sun, 16 Mar 2008 18:28:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D4DA522DC; Sun, 16 Mar 2008 18:28:05 -0400 (EDT)
In-Reply-To: <47DD9890.3060005@gnu.org> (Paolo Bonzini's message of "Sun, 16
 Mar 2008 23:00:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77394>

Paolo Bonzini <bonzini@gnu.org> writes:

> Junio C Hamano wrote:
>> Paolo Bonzini <bonzini@gnu.org> writes:
>>
>>> git-cvsserver does not support changes of type T (file type change,
>>> e.g. symlink->real file).  This patch treats them the same as changes
>>> of type M.
>>
>> Hmm.
>>
>> Do cvs clients even know how to handle symlinks, or will this patch just
>> start sending the readlink(2) result as if it is just a regular file
>> contents?
>
> It was before too.  The problem arises if one found the problem,
> deleted the symlink, added the regular file -- and now cvsserver stops
> working at all. :-(

I fully agree that "stops working at all" was baaaaad, and your patch may
be an improvement.

What I am questioning is what the code should do (IOW, what would be good
for cvs clients to see).  Should it send a symlink as a regular file, or
simply just omit it?  If the answer is "the former", then we do not have
to worry about it any further after applying your patch.  Otherwise we
still have to do something _else_ after applying your patch.  I did not
know which way we would want to proceed, and I still don't.
