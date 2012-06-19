From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 11:31:09 -0700
Message-ID: <7v8vfj17de.fsf@alter.siamese.dyndns.org>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Lortie <desrt@desrt.ca>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 20:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh3Cz-0008Ps-3T
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2FSSbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 14:31:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab2FSSbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 14:31:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EC6E842D;
	Tue, 19 Jun 2012 14:31:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5GFMVXM9as1E+5xWJJpLuzRNhu0=; b=T2RaEF
	UIzMr2dZTbsvCNkEYrzbPn5ukX8DArnXwI8wYgafvfuMCh46dDx0FbVRGozgWdJ2
	2lTP0lIPi/xhzLCYGCYN01hx4g2JhFiRdpUAM/cjD6tnjCQw5t57RPF8zaTmz4d9
	O3dmD0CWWarKycrV/MXHtIpWDNdc84t4kE8GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0NXHa5kdcQTVe/ND2kR6uzPTp4A59tJ
	+H90Ipxe2ANY3KyIYJbNm9yKTMYdwRre3ZIW/5+fNN39rFULet0aYg13+2XiJ1ql
	EPxGj+FNIvAl+bhteZOaDM1dPlL0rI8eiAAwqkFKKsPuGXvoO6phGBd7Gk5HLMIt
	Di9eVK1KVbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9525E842C;
	Tue, 19 Jun 2012 14:31:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 280F3842A; Tue, 19 Jun 2012
 14:31:11 -0400 (EDT)
In-Reply-To: <87a9zztdxt.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Jun 2012 19:21:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F19597FC-BA3C-11E1-89A0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200223>

Thomas Rast <trast@student.ethz.ch> writes:

> Ryan Lortie <desrt@desrt.ca> writes:
>
>> In this case, the user wanted to checkout a branch of a module.  They did:
>>
>>   git clone git://git.gnome.org/gtk+
>>   cd gtk+
>>   git branch gtk-3-4
>>
>> Obviously this is a user error, but it's a pretty innocent one, and
>> puts the user in a bad state.  When they figure they should have typed
>> "git checkout gtk-3-4" it is already too late -- they will be taken
>> onto their locally-created copy of the master branch.
>>
>> So feature request: 'git branch' should not allow creating a local
>> branch that has the same name as a branch that already exists on
>> origin' (or any remote?) without some sort of --force flag.
>
> How does this fit with the fact that git has forever(?) created a
> 'master' branch when cloning, and usually points it at origin/master
> too?

A big difference is that it by default is set to integrate with
origin/master.

> I honestly haven't decided whether I should like or hate your proposal,
> but ISTM that outlawing an operation that git does on every clone is a
> bit moot.

I am sympathetic to this particular example of the user regretting
that he has said "git branch" when he meant "git checkout", and also
am sympathetic to the wish that "git branch" somehow figured out the
situation and offered an advice, or outsmarted the user and forbade
the operation. But I do not think "git branch" can sensibly and
correctly make that decision for the user---at least I do not sense
any of the people who is in this thread has clear idea on what to
base that decision on, and "the same name appears in an existing
remote" is not it.  "The same name appears, and the new branch is
not set to integrate with it" may be closer, but that may forbid
valid use cases too much.
