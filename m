From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git-completion.bash for use in zsh
Date: Tue, 20 Mar 2012 09:23:31 -0700
Message-ID: <7vr4wn6y2k.fsf@alter.siamese.dyndns.org>
References: <4E5F8CF3.3060304@randomguy3.me.uk>
 <4F686FA2.8070803@randomguy3.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Merry <kde@randomguy3.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 17:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA1qX-0005IV-Co
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 17:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438Ab2CTQXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 12:23:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030383Ab2CTQXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 12:23:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FE06AD2;
	Tue, 20 Mar 2012 12:23:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s4GuV8m+QMQBXX+I5cT1PSdDEp8=; b=kuwVn5
	gaeAUUmvRUorpv+RVh1bmEqpPqP/H9tAW6gM5shng2Su7I9MlhaD+XYCmFPn2BcB
	sDvTrhLwGzw5fwHNzZsiLdZv1kRx93tgbFSLrLomLVNnTL88xIa/FnASyWpa2T6E
	2sB5U5s2cpFwRBrmzZHXUm42o8f0GO+MJfubM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pdttTHDhz7qDJeLnmHMSFmEr4xP6/EJl
	XfBz5hjijMxLs36ImqZpFdEQkXy0t7Ni7xXDml2eaQbtAKKu36Jkfvi5VOw4NcNK
	ER7rEBZD+VUoje7vFik3TnjICF07NinpoHT2/mmcE3Va9NtYoPnwH7bJwpiCxG5r
	Hgw37l7TxcM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CECFB6AD1;
	Tue, 20 Mar 2012 12:23:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F123F6ACF; Tue, 20 Mar 2012
 12:23:32 -0400 (EDT)
In-Reply-To: <4F686FA2.8070803@randomguy3.me.uk> (Alex Merry's message of
 "Tue, 20 Mar 2012 11:53:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 095D6864-72A9-11E1-8D26-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193516>

Alex Merry <kde@randomguy3.me.uk> writes:

> This is just a reminder message, since I haven't heard anything back
> on this, and it hasn't made its way into the repo.
> I realise Felipe Contreras has been pushing a different approach to
> making it work properly in zsh, but this should be a fairly innocuous
> fix in the meantime.

Thanks.

"git grep 'local .*=('" tells me that there is only one such construct;
there is another hit but it is not an empty array "=()" but that assigns
"=($(some command output))" so presumably zsh does not mistake it for a
declaration.

Felipe, any comments?
>
> Alex
>
> On 01/09/11 14:47, Alex Merry wrote:
>> Certain versions (or option combinations) of zsh appear to treat
>> things like
>> local some_var=()
>> as a function declaration.  This makes errors appear when using it in
>> combination with the GIT_PS1_SHOWUPSTREAM option.
>>
>> Signed-off-by: Alex Merry<dev@randomguy3.me.uk>
>> ---
>>   contrib/completion/git-completion.bash |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 5a83090..89de45d 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -106,8 +106,9 @@ __gitdir ()
>>   __git_ps1_show_upstream ()
>>   {
>>          local key value
>> -       local svn_remote=() svn_url_pattern count n
>> +       local svn_remote svn_url_pattern count n
>>          local upstream=git legacy="" verbose=""
>> +       svn_remote=()
>>
>>          # get some config options from git-config
>>          while read key value; do
