From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Wed, 18 Aug 2010 15:25:00 -0700
Message-ID: <7vk4nn8soz.fsf@alter.siamese.dyndns.org>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
 <1281665352-10533-2-git-send-email-newren@gmail.com>
 <AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
 <20100818001032.GA7694@burratino> <7veidvagz8.fsf@alter.siamese.dyndns.org>
 <AANLkTik9mho7Pm5m=3dEbtMrH1r81Lc480i_z2_aHCxs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 00:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olr4S-0003tR-Dl
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 00:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab0HRWZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 18:25:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0HRWZN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 18:25:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 294A0CEA76;
	Wed, 18 Aug 2010 18:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QkE45sQlj3G+sejg6nWRq0Vdabg=; b=XAiADd
	cJitZzvGYXvYcVjVeau/lTp1PXmK2nAdB9YmkiOL7is0aa6HmPgnf2egN66jAnGm
	g0nnmaN/mDVS6myNXdlO9xbNbR5ZtUx1hXT7OOTL9QuwEFLE/4VMNk0Nf2j/jRUg
	dixLvSJxAud7/3Kisb+L61xbun0Irm2n3Ng2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FHtWz+XhRLbr7eirzJgqU/UJHRptXWl/
	62D6XH3LHEYxvA2GI2gi7SJMIIq6OSPtROi55CK1Sp4iQu01zW27cuwMp+GaxYiF
	0AEamw+l3HpnjCU6G8OBNwbPnfnUz3tTx+zlWwuXL5OXalUt72WnISEJQl4vLta7
	pU6OXWYbPX0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D77C2CEA73;
	Wed, 18 Aug 2010 18:25:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D93E6CEA63; Wed, 18 Aug
 2010 18:25:01 -0400 (EDT)
In-Reply-To: <AANLkTik9mho7Pm5m=3dEbtMrH1r81Lc480i_z2_aHCxs@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 18 Aug 2010 16\:02\:04 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 744D1D96-AB17-11DF-BEBE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153888>

Elijah Newren <newren@gmail.com> writes:

> So, I'd say it is more about programming errors, in particular ones
> where people modify the code to make process_entry() leave more cases
> unprocessed than what is currently possible without also making the
> necessary modifications to process_df_entry().

Yeah.  But they do not need to touch process_df_entry().

I actually was hoping that my weatherbaloon patch will illustrate that a
new special case these people may make to process_entry() to leave other
cases unprocessed do _NOT_ have to be handled by process_df_entry().

The "if" statement in process_df_entry() would check if the entry is
something the function is ready to resolve, and otherwise punts.  A new
exception they add to process_entry() can introduce a separate phase (just
like process_df_entry() is not done in parallel with other kinds of
entries inside the process_entry() but as a separate post-processing
phase) between the loop that calls process_df_entry() and the loop that
checks if there is a remaining entry.  And it probably should, as such a
new exception may not have anything to do with "df", and adding such a
logic to process_df_entry() would be wrong ;-).
