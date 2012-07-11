From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Teach "git remote" about remote.default.
Date: Wed, 11 Jul 2012 14:55:16 -0700
Message-ID: <7vd342dku3.fsf@alter.siamese.dyndns.org>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
 <1342020841-24368-4-git-send-email-marcnarc@xiplink.com>
 <7vk3yaduh1.fsf@alter.siamese.dyndns.org> <4FFDE4ED.8020502@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp4t8-00052I-RN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 23:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301Ab2GKVzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 17:55:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab2GKVzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 17:55:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 325AB7DA2;
	Wed, 11 Jul 2012 17:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RIukRFZkObksfczU4JwzEexAwwA=; b=cjeUwP
	GTxJrXNdCP1MbTDUM8YzAwxYKWgG3uWdqbUkyutFhWfmnfsaO0c8yQWxAZreMEmi
	3W9muFTSdNVDIyPRV1GfZWjmY1sj/KVYTUMsdCnfJwKnmwTrOAgOWUFI28BK8W3A
	0rF9kafpTv+yOc1mB6EauPX1emmPrtkUMrsA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhgADZQ28sHwh3AmQlQhO0c3fn38gcsW
	DVsC+tOFTvRVOsNlUs6eIrARHjVS14liwFiVPRGi1Zl4Lg+EJZL1W6dFVzrNG8Zd
	JMJkxrYSPLAgXieph/doMmf6rCGXyEfItvkbq8UuZTfldZ6bD7XL60lnrRO/enAa
	EAOWrKu6g0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27E767DA1;
	Wed, 11 Jul 2012 17:55:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45B7F7D9D; Wed, 11 Jul 2012
 17:55:18 -0400 (EDT)
In-Reply-To: <4FFDE4ED.8020502@xiplink.com> (Marc Branchaud's message of
 "Wed, 11 Jul 2012 16:41:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A86ED2E-CBA3-11E1-AD7C-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201332>

Marc Branchaud <marcnarc@xiplink.com> writes:

> What about a warning displayed if "remote.default" is not set?  Something like:
>
> 	This repository does not have an explicitly configured default
> 	remote.  Selecting "origin" as the default remote repository.
> 	To suppress this warning, or if you wish to have a different
> 	default remote repository, run "git remote default <name>".
> 	In git X.Y, the default remote will be automatically configured
> 	as the first remote added to the repository.

When do you plan to issue the above message?  Any time we default to
'origin' without remote.default?  

I do not see a value to it---if the user has been happily using
'origin' as the default remote, there is no reason to give such a
noise.  We will keep defaulting to 'origin' even in the version of
Git with this series in it.

A warning is necessary if we plan to _later_ add the "first remote
created either by 'git clone' or 'git remote add' is automatically
set as the value for remote.default configuration" feature, and the
place to do so is "git clone" and "git remote add" that creates the
first remote for the repository.  If the name of the remote created
by them is 'origin', then there is no need for warning, but if the
user called that first remote with a name that is _not_ 'origin',
later versions of Git will change the behaviour.

I can see a transition plan that goes like this:

Step 0.  With this series but without the "first one becomes default"

    $ git init
    $ git remote add upstream git://over.there.xz/git.git/
    hint: You may want to run "git remote default upstream" now so that
    hint: a lazy 'git push' and 'git fetch' defaults to this 'upstream'
    hint: repository, instead of 'origin' (which you do not yet have).

    $ git config --global advice.settingDefaultRemote false
    $ git remote rm upstream
    $ git remote add upstream git://over.there.xz/git.git/
    ... nothing, as the user declined the advice ...

Step 1.  "First one becomes default" as an opt-in feature

    $ git config --global --unset advice.settingDefaultRemote
    $ git init
    $ git remote add upstream git://over.there.xz/git.git/
    hint: You may want to run "git remote default upstream" now so that
    hint: a lazy 'git push' and 'git fetch' defaults to this 'upstream'
    hint: repository, instead of 'origin' (which you do not yet have).
    hint: "git config --global remote.firstRemoteBecomesDefault true" can be
    hint: used to make the first remote added to the repository the default
    hint: remote automatically.
    $ git remote default
    origin

    $ git config --global remote.firstRemoteBecomesDefault true
    $ git remote rm upstream
    $ git remote add upstream git://over.there.xz/git.git/
    ... nothing; user already knows about remote.firstRemoteBecomesDefault
    $ git remote default
    upstream

Step 2.  Start warning the default change for "First one becomes default"

    $ git config --global --unset advice.settingDefaultRemote
    $ git config --global --unset remote.firstRemoteBecomesDefault
    $ git init
    $ git remote add upstream git://over.there.xz/git.git/
    hint: You may want to run "git remote default upstream" now so that
    hint: a lazy 'git push' and 'git fetch' defaults to this 'upstream'
    hint: repository, instead of 'origin' (which you do not yet have).
    hint: "git config --global remote.firstRemoteBecomesDefault true" can be
    hint: used to make the first remote added to the repository the default
    hint: remote automatically.
    hint:
    hint: In future versions of Git, this will happen automatically.
    hint: If you do not want the first remote to become default, run
    hint: "git config --global remote.firstRemoteBecomesDefault false" now.

Step 3. "First one becomes default" is now default

    $ git config --global --unset advice.settingDefaultRemote
    $ git config --global --unset remote.firstRemoteBecomesDefault
    $ git init
    $ git remote add upstream git://over.there.xz/git.git/
    warning: Made 'upstream' the default remote for this repository.
    $ git remote default
    upstream

    $ git remote rm upstream
    $ git config --global remote.firstRemoteBecomesDefault true
    $ git init
    $ git remote add upstream git://over.there.xz/git.git/
    ... nothing; the user explicitly told us what to do
    $ git remote default
    upstream

    $ git remote rm upstream
    $ git config --global remote.firstRemoteBecomesDefault false
    $ git init
    $ git remote add upstream git://over.there.xz/git.git/
    ... nothing; the user explicitly told us what to do
    $ git remote default
    origin

> Since the "cmd_" prefix is already used for the main commands, perhaps
> another prefix for subcommands?  Maybe "sub_"?  Some of the shell-based
> commands use the main command itself as a prefix (e.g. bisect_start()).
> Doing that here would mean "remote_default()" etc.  Any preference?

No strong preference for file-scope-statics.

>>> +{
>>> +	if (argc < 2)
>>> +		printf_ln("%s", remote_get_default_name());
>> 
>> Good.  If somebody anal cares about the vanilla hardcoded default
>> 'origin' and 'remote.default' having 'origin' as a configured value,
>> he should be using "git config" to ask the difference.  Users of
>> "remote default" interface should not have to care.
>> 
>>> +	else {
>>> +		const char *name = argv[1];
>>> +		if (remote_is_configured(name)) {
>>> +			git_config_set("remote.default", name);
>>> +			printf_ln(_("Default remote set to '%s'."), name);
>>> +		} else
>>> +			return error(_("No remote named '%s'."), name);
>>> +	}
>> 
>> I am not sure if this is a good idea.  Shouldn't "git remote default
>> frotz" followed by "git remote add frotz" work?
>
> To me it feels wrong to allow the user to set the default remote to something
> that doesn't actually exist.  It's like trying to add a non-existent file.

Every few weeks, I do this:

	ln -f -s Documentation/RelNotes/$new_version.txt RelNotes
        edit Documentation/RelNotes/$new_version.txt

> And what if the user forgets the second step?

That is why we warn on an unusual order.  A lazy "git push" will
fail and that would be sufficient clue.

And another reason for the warning (with "you do not yet have") is
to prevent this:

	git remote add frotz git://over.there.xz/git.git
        git remote default frozt

> It seems saner for a command to fail if it knows a change it's about to make
> will cause problems.

The point is that you do *NOT* know it will cause problems.  People
who want to do things in an unusual order *know* what they are doing
a lot better than you do.  Don't get in their way.
