From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry
 run
Date: Thu, 19 Jan 2012 10:46:26 -0800
Message-ID: <7v8vl3jzst.fsf@alter.siamese.dyndns.org>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
 <7vobu0liwj.fsf@alter.siamese.dyndns.org> <8762g87y4q.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:46:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnx0a-0002b5-MC
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 19:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab2ASSq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 13:46:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543Ab2ASSq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 13:46:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1255D69;
	Thu, 19 Jan 2012 13:46:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pXmp9VLRJn8RigRh8BMw2p2PKHU=; b=EHFwkQ
	xqS+ivbMOJ+QUzf2iuaFXg/IjRt4XaUs+voY3b7O7Pja1m19Oh7sI8x1SZJEREWa
	6Z+WnsAIdpfRfqpwsKH2Jx0pTOtYNajBuGAOh8v91hhnCjAYQQd/7K7S3/Abs9MM
	Ya3YNzfa0rLA806t/YYoCcsJNnYWe694P02WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iiU66h2kjEwwHEc8PakKWyOinpIXMV9Y
	Nw+5yqNWdKxPKNrlt6emN6OTuByCDP5a4GgV1mXkwYh3JBilj5sOZA1PqRGD/3EW
	OIm/eczr2yYTew0jnE9vLo7eFkOIndOazQMSXT3x1xAOndaqW56d6JDFeWedjSgK
	5Rfemuu6oh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 458F75D68;
	Thu, 19 Jan 2012 13:46:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF46B5D67; Thu, 19 Jan 2012
 13:46:27 -0500 (EST)
In-Reply-To: <8762g87y4q.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 19 Jan 2012 12:03:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E52EAFD0-42CD-11E1-895A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188824>

Thomas Rast <trast@student.ethz.ch> writes:

> [dropped Dieter as this really goes off on an internal tangent]
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If somebody is writing a script using "git add" (which is not recommended
>> to begin with)
>
> Can we still stick to that stance?  Our tests are increasingly using
> 'git add' instead of 'git update-index --add':
>
>   $ git grep 'git[ -]add' t/ | wc -l
>   1540
>   $ git grep 'git[ -]update-index --add' t/ | wc -l
>   269
>   $ git grep 'git[ -]update-index --add' v1.6.0 t/ | wc -l
>   251
>   $ git grep 'git[ -]add' v1.6.0 t/ | wc -l
>   705

Stop being silly.

Have you actually looked at these usage?  Some of them are genuinely
testing if "git add" works correctly, so it is out of the scope of this
discussion, but others that could be "git update-index" are feeding the
paths known to the script to exist (and we want 'git add' to error out
if that is not the case).

More generally, scripts in t/ directories are "scripts", but it is totally
different from the kind of "user facing script that behaves as if it is a
complete command, taking its own command line arguments, passing them
through to the underlying plumbing commands".
