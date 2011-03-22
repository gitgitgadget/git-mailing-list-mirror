From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 23:37:45 -0700
Message-ID: <7vlj07mzie.fsf@alter.siamese.dyndns.org>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net>
 <4D879516.3060204@gmail.com> <20110321195846.GA4277@elie>
 <4D87B00D.2010905@gmail.com> <7v62rcp6m6.fsf@alter.siamese.dyndns.org>
 <7vsjugnqig.fsf@alter.siamese.dyndns.org> <20110322052742.GA7637@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 07:38:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1vEE-0006s8-K4
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 07:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab1CVGiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 02:38:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1CVGiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 02:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CBE72255;
	Tue, 22 Mar 2011 02:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bng9yLclcEtj//xGSRVe3vhwc84=; b=XDVx6J
	QBCxign2H2WQtjE+V8LkUFNGb6EL9mK08fn3aR3ZQXq+I9hK7lXHEo7nIy83seZb
	5eXdbjSDo1v37of/I+1vqLhtroON1wikBsp4Uvy3WmULyES5LAk6A4n/qmNB47zD
	a4Eudk1j/bxprRdMw7MU4Tm10geTlzI7+zQDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RuCSt4eGc+aolgJ5MAc6Zz5uYV/t00c6
	aIzbBvuUIlLFCnYtudCL2Q+nxRqAK4GTBTX4NgwN0ZqhKVY74W4VtzzIkY9VBRI3
	7IfcK8/81AE4tD6hR95vcnnWkeFkFUvDlnFwk7vwzp9Wk/cPZqaU0VmFdjMQspPs
	a9FPZI9+lps=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19B152254;
	Tue, 22 Mar 2011 02:39:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A46272253; Tue, 22 Mar 2011
 02:39:25 -0400 (EDT)
In-Reply-To: <20110322052742.GA7637@elie> (Jonathan Nieder's message of "Tue,
 22 Mar 2011 00:27:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 245990B2-544F-11E0-942E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169702>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -24,6 +24,37 @@ ifndef::git-format-patch[]
>>  --patch::
>>  	Generate patch (see section on generating patches).
>>  	{git-diff? This is the default.}
>> +
>> +-1 --base::
>> +-2 --ours::
>> +-3 --theirs::
>> +-0::
>> +	These make sense only when comparing the index and the working
>> +	tree (i.e. `git diff-files` or `git diff <path>...`) and compares
>> +	against the "base" version, "our branch" or "their
>> +	branch" respectively.  With these options, diffs for
>> +	merged entries are not shown.
>> ++
>> +The default is to diff against our branch (-2) and the
>> +cleanly resolved paths.  The option -0 can be given to
>> +omit diff output for unmerged entries and just show "Unmerged".
>
> I am not sure what this comment about the default means.  Isn't the
> default to use --cc?

Depends on where this is included.  That passage originally came from
diff-files, for which "-2 if exists otherwise -0" has been the default.
When included in "diff" (and perhaps "show"), --cc is used by default.
So we would need the "ifdef::git-diff-files[]/endif::git-diff-files[]"
around it.

>> +
>> +-c::
>> +--cc::
>> +	Produce "combined diff" (and "dense combined diff" showing how the
>> +	result is different compared to more than one original.

Similarly, we would need "ifdef::defaults-to-cc[]/endif" around a sentence
here to say that this is the default when showing unmerged entry.

> Missing an article after "Produce" (produce a combined diff) and a
> closing parenthesis after "dense combined diff", I think.
>
> More importantly, it might be nice to say
>
> 	See the section "diff format for merges" of
> 	linkgit:git-diff[1] for details.

Thanks.
