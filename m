From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] xmerge.c: minimum readability fixups
Date: Sat, 30 Aug 2008 08:42:46 -0700
Message-ID: <7vk5dy1pc9.fsf@gitster.siamese.dyndns.org>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0808301130250.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZScI-0001G2-3L
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 17:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbYH3Pmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 11:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYH3Pmx
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 11:42:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYH3Pmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 11:42:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A1FE5A404;
	Sat, 30 Aug 2008 11:42:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 859B15A403; Sat, 30 Aug 2008 11:42:48 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808301130250.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 30 Aug 2008 11:31:17 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DBAFC00-76AA-11DD-9DC8-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94382>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -449,12 +449,11 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
>>  			chg0 = xscr1->i1 + xscr1->chg1 - i0;
>>  			chg1 = xscr1->i2 + xscr1->chg2 - i1;
>>  			chg2 = xscr2->i2 + xscr2->chg2 - i2;
>> -			if (ffo > 0)
>> -				chg2 += ffo;
>> -			else {
>> +			if (ffo < 0) {
>>  				chg0 -= ffo;
>>  				chg1 -= ffo;
>> -			}
>> +			} else
>> +				chg2 += ffo;
>
> I do not understand why the order was changed, but hey, I do not care that 
> deeply.

Everywhere else the code deals with variables var0, var1 and var2 in this
order, and that is because "if" blocks are consistently about changes made
on side#1 while "else" blocks are about changes made on side#2.  This
statement alone was inconsistent, and now it all reads 0, 1 and then 2.
