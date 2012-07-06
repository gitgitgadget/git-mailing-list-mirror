From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default
 configuration setting.
Date: Fri, 06 Jul 2012 12:31:29 -0700
Message-ID: <7vhatkofe6.fsf@alter.siamese.dyndns.org>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
 <1341526277-17055-3-git-send-email-marcnarc@xiplink.com>
 <7v4nplrfe4.fsf@alter.siamese.dyndns.org> <4FF6F805.20403@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:31:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEFe-0006VU-By
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab2GFTbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:31:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab2GFTbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:31:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6CB38E18;
	Fri,  6 Jul 2012 15:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2wiunor2UeND9n4KQ0Y62q41jko=; b=UIJnL3
	54VR4+3dMEarHiEJL2UkdzTf+6q5qIU104WuFFsaPwk74ddsq4n7UX7xGPdjPMX/
	rz2R5gJ+TOTBFUauRi06jh5C7djWRQkwyM28NiqBtrZPtJOb5HTRCr2yzfWfH9+Q
	ag9Oq3Bbg6K0d+/0OUeZzdcqIJbg97tef5gos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aRAb7fjwNFhxMeXHyoReaQBBO0xl/Aqk
	uLYSYURbPFte0DHj6Gopz67P5d24QKz9eZdyKbjGPyPpW8mNOpb7BH8aCmrhoNHh
	zTfIf9kQPjdjGq+9g/kwEEldyge82+DfhDZztGS61GNsH+OSnQ4ipylIiYNPo+mY
	1EYBLcRuHEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE94B8E17;
	Fri,  6 Jul 2012 15:31:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52E678E13; Fri,  6 Jul 2012
 15:31:31 -0400 (EDT)
In-Reply-To: <4FF6F805.20403@xiplink.com> (Marc Branchaud's message of "Fri,
 06 Jul 2012 10:36:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 306697D0-C7A1-11E1-B19F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201141>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-07-05 06:50 PM, Junio C Hamano wrote:
>> 
>>>  - effective_remote_name is the name of the remote tracked by the current
>>>    branch, or is default_remote_name if the current branch doesn't have a
>>>    remote.
>> 
>> The explanation of the latter belongs to the previous step, I think.
>> I am not sure if "effective" is the best name for the concept the
>> above explains, though.
>
> Well, the previous commit removes default_remote_name, so the explanation
> wouldn't be valid verbatim.

The previous one introduces "effective" (which I still think is not
the best word for the semantics you are trying to give to the
variable) without explaining what the variable is for and justifying
why "effective" is the right word (or at least a better than
"default") for it.  Something like the "- effective_remote_name is the ..."
above is necessary in its commit log message.

> How about keeping the above here, and I could add the following to the
> previous commit's message:
>
> 	effective_remote_name is the remote name that is currently "in
> 	effect".  This is the currently checked-out branch's remote, or
> 	"origin" if the branch has no remote (or the working tree is a
> 	detached HEAD).

Yeah, along that line.

> The read_config() function already has logic to avoid re-parsing the entire
> config over and over again.  There are many places in remote.c that call
> read_config(), and I thought I was just following that pattern.

OK.
