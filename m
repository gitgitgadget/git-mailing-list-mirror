From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Mon, 12 May 2008 11:42:58 -0700
Message-ID: <7vzlqvxt1p.fsf@gitster.siamese.dyndns.org>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home>
 <20080302154238.GD2973@steel.home>
 <alpine.LSU.1.00.0803021555500.22527@racer.site>
 <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
 <20080512175654.GB3128@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?utf-8?Q?S?= =?utf-8?Q?=C3=BCsserott?= 
	<newsletter@dirk.my1.cc>, Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvd0e-0006WE-27
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757995AbYELSnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757992AbYELSnK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:43:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890AbYELSnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:43:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 057A74EB1;
	Mon, 12 May 2008 14:43:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 26C374EAF; Mon, 12 May 2008 14:43:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4309901C-2053-11DD-8018-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81901>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sun, Mar 02, 2008 17:59:13 +0100:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > On Sun, 2 Mar 2008, Alex Riesen wrote:
>> >
>> >> -			add_file_to_cache(path, verbose);
>> >> +			if (add_file_to_cache(path, verbose))
>> >> +				exit(1);
>> >
>> > Does it really, really _have_ to be exit(1)?  I mean, now you block even 
>> > the faintest chance that we can libify libgit.a by overriding die_routine.
>> 
>> I think Alex did so not to break the existing scripts that rely on these
>> dying, but it should have been exit(128) to really stay compatible.
>
> I corrected the series to use die() again and rebased it off current
> master (65ea3b8c). So it is more compatible with libification (does
> not hinder it more than previos code) and keep the exit code.

But you did not answer my question in the part you did not quote, did you?

Now when somebody either forgets to check the return value from this
function, or deliberately ignores it, the resulting index will not match
what the code is told to update it with.
