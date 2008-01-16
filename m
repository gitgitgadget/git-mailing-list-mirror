From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 12:36:54 -0800
Message-ID: <7vodblo6c9.fsf@gitster.siamese.dyndns.org>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.44.0801152006260.944-100000@demand>
	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFF0z-00030M-0c
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYAPUhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYAPUhI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:37:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYAPUhG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:37:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A76F4BC8;
	Wed, 16 Jan 2008 15:37:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 34AD64BC1;
	Wed, 16 Jan 2008 15:36:57 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 16 Jan 2008 12:08:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70742>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 16 Jan 2008, Junio C Hamano wrote:
>> +
>> +void close_lock_file(struct lock_file *lk)
>> +{
>> +	close(lk->fd);
>> +	lk->fd = -1;
>> +}
>
> Since one of the main purposes of closing would be the error testing of 
> writes that haven't made it out yet on filesystems like NFS that do 
> open-close cache serialization, I'd suggest doing this as
>
> 	int close_lock_file(struct lock_file *lk)
> 	{
> 		int fd = lk->fd;
> 		lk->df = -1;
> 		return close(fd);
> 	} 
>
> to give the return code.

Yup!  You are as always right.
