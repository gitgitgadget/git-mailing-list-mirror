From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 22 Jul 2008 17:48:53 -0700
Message-ID: <7vbq0pifwq.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org>
 <20080722234703.GD5904@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Marin <dkr+ml.git@free.fr>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSYZ-0005wM-6z
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYGWAtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYGWAtP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:49:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYGWAtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:49:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D1C437823;
	Tue, 22 Jul 2008 20:49:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1403737820; Tue, 22 Jul 2008 20:49:00 -0400 (EDT)
In-Reply-To: <20080722234703.GD5904@leksak.fem-net> (Stephan Beyer's message
 of "Wed, 23 Jul 2008 01:47:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2AE69D96-5851-11DD-B6CB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89580>

Stephan Beyer <s-beyer@gmx.net> writes:

> Hi,
>
> Junio C Hamano wrote:
>> Olivier Marin <dkr+ml.git@free.fr> writes:
>> > @@ -203,9 +204,10 @@ then
>> >  
>> >  	case "$abort" in
>> >  	t)
>> > -		rm -fr "$dotest" &&
>> > +		git rerere clear &&
>> >  		git read-tree -m -u ORIG_HEAD &&
> [...]
>> diff --git a/git-am.sh b/git-am.sh
>> index a44bd7a..5cbf8f4 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -203,9 +203,9 @@ then
>>  
>>  	case "$abort" in
>>  	t)
>> -		rm -fr "$dotest" &&
>> -		git read-tree -m -u ORIG_HEAD &&
>> -		git reset ORIG_HEAD && :
>> +		git rerere clear
>> +		git read-tree --reset -u HEAD ORIG_HEAD
>
> Perhaps I am confused, but ...
> Why is there "HEAD" and "ORIG_HEAD" and not only "ORIG_HEAD"?

Just being a bit defensive -- in this case I think it might be Ok to say
"read-tree --reset -u ORIG_HEAD", but I haven't checked in a conflicted
case.

If some path was added between ORIG_HEAD (that is where we started from)
and HEAD (that is where we are and we decide we do not want it), and that
path is conflicted in the index, a single tree form "read-tree --reset -u
HEAD" would leave it behind in the working tree, wouldn't it?
