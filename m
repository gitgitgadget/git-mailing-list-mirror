From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule update --force
Date: Wed, 09 May 2012 23:18:37 -0700
Message-ID: <7vk40kpnia.fsf@alter.siamese.dyndns.org>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
 <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
 <7vobpwpoyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Thu May 10 08:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMi7-0008Qa-6i
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab2EJGSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:18:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab2EJGSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:18:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73970629E;
	Thu, 10 May 2012 02:18:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=idzoKmiXFFkrSSxFbrXVpJhfAzM=; b=bi+UF4
	l+8lnJs41oaTNOqKI5DiU1cxvemyubZNsn+cpstvMIE/Qhkw2IVuo3w2kKBo4C2Z
	ZCOrgKSkTG8H0Xd242qUhnvh5MW2hHk6h6RMF1dmLK/rlf/AcVe+18yegkv7GzD/
	kpsaHUx7EtIykimCyNQt1YUWtQeZtOw4RUmEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vllq0fgPR3n8uMpkQzvyVPJY6b+HcA3l
	UpP1K4fPY1YCyA3VkAwsWcKkmG8ObN+PtrfcgWVbOHikmjm1OZdPJ6LqSmE5Fl83
	ANXkeUzFgpXZ/lZkePkqRay2i2PH9jpvxifEBg3Gn63rj1pcRNtjLJRwI9ZXvYSQ
	9T2OYnSRta4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B697629D;
	Thu, 10 May 2012 02:18:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD020629C; Thu, 10 May 2012
 02:18:38 -0400 (EDT)
In-Reply-To: <7vobpwpoyi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 May 2012 22:47:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB791A9A-9A67-11E1-84CA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197546>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Zager <szager@google.com> writes:
>
>> I'd like to propose amending the documentation thusly:
>>
>> According to the docs:
>>
>>        -f, --force
>>            This option is only valid for add and update commands. When
>> running add, allow adding an otherwise ignored
>>            submodule path. When running update, throw away local
>> changes in submodules when switching to a different
>>            commit; if not switching to a different commit, a checkout
>> to HEAD will still be run.
>>
>> ... and here's the patch to implement it:
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 64a70d6..8b045d9 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -536,7 +536,7 @@ Maybe you want to use 'update --init'?")"
>>                         die "$(eval_gettext "Unable to find current
>> revision in submodule path '\$sm_path'")"
>>                 fi
>>
>> -               if test "$subsha1" != "$sha1"
>> +               if test "$subsha1" != "$sha1" -o -n "$force"
>>                 then
>>                         subforce=$force
>>                         # If we don't already have a -f flag and the
>> submodule has never been checked out
>>
>> Thoughts?
>
> Even though I admit that I do not use submodule heavily myself, I think
> this is a sane thing to do.  After all, the user explicitly said "I want
> to force update it", and it is a strong sign that what is in the working
> tree is suspect and the user wants to make sure everything is in sync.
>
> This is a tangent, but what strikes me odd with the code before this patch
> is that the decision to recurse into the submodule repository is made
> solely on the status of the submodule, and there is no way for the user to
> say "I do not want it to recurse" (in other words, "--recursive" option
> from the command line does not have any effect on this part of the code).
>
> Perhaps that is because we consider submodules that have been "init"ed
> always interesting, and if that is the case that may not be a big deal,
> but it might not be a bad idea to allow "--no-recursive" option to mean
> something stronger than not giving --recursive option, i.e. not recursing
> in a situation where it normally would even when run without --recursive.

And similarly, it might be a good idea to make the presense of "--recursive"
a bit stronger than the command line that did not say either "--recursive"
nor "--no-recursive", so that a subcommand that normally inspects the
state of the submodule and decide to recurse (or not) can be told to
always recurse into it.

If we follow that line of thought, it may make more sense not to implement
your feature like the above patch, but instead make it so

	if the user told us never to recurse
        then
		nothing
	elif the user told us to always recurse ||
             subsha1 != sha1
        then
		do the "recurse" thing
	fi

so that you can still force it recurse into the submodule, even when you
do not necessarily want the "force checkout" thing to happen to clobber
the working tree.
