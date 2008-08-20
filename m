From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Wed, 20 Aug 2008 15:22:21 -0700
Message-ID: <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
References: <20080820185028.GA16626@blimp.local>
 <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080820200440.GF16626@blimp.local>
 <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080820202952.GH16626@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVw5T-000719-Qr
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYHTWW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYHTWW2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:22:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbYHTWW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:22:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A11461E5D;
	Wed, 20 Aug 2008 18:22:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 50C8F61E5C; Wed, 20 Aug 2008 18:22:23 -0400 (EDT)
In-Reply-To: <20080820202952.GH16626@blimp.local> (Alex Riesen's message of
 "Wed, 20 Aug 2008 22:29:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 787D37F6-6F06-11DD-8219-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93064>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Wed, Aug 20, 2008 22:16:19 +0200:
>> > 
>> > No. It strips refs/ OR remotes/ (because of prefixcmp with argv[0]).
>> > And I still wanted refs/<namespace>/something...
>> 
>> Yes, you are correct.  However, to fix my thinko, I deem this preferable:
>> 
>> -- snipsnap --
>> 
>>  builtin-checkout.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/builtin-checkout.c b/builtin-checkout.c
>> index e95eab9..2a076cf 100644
>> --- a/builtin-checkout.c
>> +++ b/builtin-checkout.c
>> @@ -448,8 +448,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>>  		if (!argc || !strcmp(argv[0], "--"))
>>  			die ("--track needs a branch name");
>>  		slash = strchr(argv[0], '/');
>> -		if (slash && !prefixcmp(argv[0], "refs/"))
>> -			slash = strchr(slash + 1, '/');
>> +		if (slash && !prefixcmp(argv[0], "refs/")) {
>> +			argv[0] = slash + 1;
>> +			slash = strchr(argv[0], '/');
>> +		}
>
> Yes, I agree (and its shorter). The git-checkout manpage can be
> improved, too (no DWIM is obvious, except may be for the implementor).

I think that makes sense.  Care to send an appliable patch with
documentation updates, please?
