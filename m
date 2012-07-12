From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 13:00:35 -0700
Message-ID: <7v629sbvh8.fsf@alter.siamese.dyndns.org>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com>
 <7va9z4byl3.fsf@alter.siamese.dyndns.org> <4FFF2720.6090705@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 22:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpPZ6-0003LB-0t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 22:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758129Ab2GLUAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 16:00:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748Ab2GLUAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 16:00:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6D3A8349;
	Thu, 12 Jul 2012 16:00:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6KQlPMfTLi5iysJ5uV3O0JYHxig=; b=tbfYe6
	KW0abmQVSHoREcdSjef+q9H03JEyftj2yrllVjlZJhB1lQahCYYpdf3dj3NTcwoz
	e30mO1d0PYpbk5vg57yFJoY5PMu4MeyjTeq6bVCUThtarGS8w9YObz5k1YxDF81K
	yg6HN05nndctrLUwUJi77ZEUHBOrZqX6x8cCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YPRSgPCbYKgJj5rlGC6mETBFq/S9/wey
	3tfklQh0o2I8kAP5Y2TYo6jniTKPf/dWU7ly0xtMPRtTc0oaok8REaTNZF4tAJqK
	JQFIOWQu1KolUvpcRSv9resfrHnZJu+yVodZwEtFWJkyhpq0PGvjN2yOpCtiyGkQ
	i+ZtOXmC+G8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50128348;
	Thu, 12 Jul 2012 16:00:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29EF48347; Thu, 12 Jul 2012
 16:00:37 -0400 (EDT)
In-Reply-To: <4FFF2720.6090705@windriver.com> (Paul Gortmaker's message of
 "Thu, 12 Jul 2012 15:36:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F795158-CC5C-11E1-BF73-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201377>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

>>>> This is _NOT_ fine, especially if you suggest "patch" the user may
>>>> not have, and more importantly does not have a clue why "git apply"
>>>> rejected it ("am" does _not_ use "patch" at all).
>>>
>>> I'm not 100% sure I'm following what part here is not OK.  If you
>>> can help me understand that, I'll respin the change accordingly.
>> 
>> Do not ever mention "patch -p1".  It is not the command that "git
>> am" uses, and it is not what detected the breakage in the patch.
>
> This may be true, but it _is_ the command that I (and others) have
> defaulted to using, if for no other reason than ignorance.
>> 
>> The command to guide the user to is "git apply".
>
> OK.  But I don't see a "--dry-run" equivalent -- and "git apply --check"
> just gives me a repeat of the same fail messages that "git am" did.
>
> With "patch -p1 --dry-run"  I get information that immediately
> lets me see whether the patch is viable or not.

What do you mean by "viable"?  

Independent from the answer to that question...

Running "git apply -p1" would by definition give you the same
failure without --dry-run (because you know it already failed), no?
Then you could ask for rejects or attempt to apply with reduced
contexts to "git apply" all without having to say --dry-run, as
unapplicable change will not be applied.
