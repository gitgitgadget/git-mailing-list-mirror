From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Fri, 23 Jan 2015 17:37:17 -0800
Message-ID: <xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:37:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEpfB-0007UV-IV
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 02:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbbAXBhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 20:37:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836AbbAXBhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 20:37:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D814326B2;
	Fri, 23 Jan 2015 20:37:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qS7kh/Uhtexnhc4VYENXp7gAh7A=; b=rmN9w2
	vNk5JPcHNj+kD/rNNbcwK+lLCFSlnnrlc4C9727AvyCbtTKCPt4TYaw3nlYujtVp
	EpJNABpGk9yPqPfOelEyoC72+ILDd2Ysszv6fJ2voxpzChGbKIL5pyvgME4y9Xgq
	K/X2SxVrq8Q0i8ICI95UCEyTdJ/2FSkC6jaEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vA5uukpqFwuqUATNNoqR1qgUT7ZOB1hB
	x/tdcSJPMUjayvo1MdMxwZSKDTO8FIM+GamagTOn1IFr6+H9xCYwsu3IYnYSuDl6
	/dWU7vp+PyRCvQLklKY5hEn2obOK4rZukMvXVSLolwToaV15coVCWjJBmlzF8e+y
	/1yf+oHWj9k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92EE6326B1;
	Fri, 23 Jan 2015 20:37:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14BD6326B0;
	Fri, 23 Jan 2015 20:37:19 -0500 (EST)
In-Reply-To: <CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
	(Craig Silverstein's message of "Fri, 23 Jan 2015 16:48:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88DCA2A0-A369-11E4-839F-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262985>

Craig Silverstein <csilvers@khanacademy.org> writes:

>>> Doesn't a submodule checkout keep some state tied to the working
>>> tree in its repository configuration file?
>>
>> Do you mean, in 'config' itself?  If so, I don't see it.  (Though it's
>> possible there are ways to use submodules that do keep working-tree
>> state in the config file, and we just happen not to use those ways.)
>> Here's what my webapp/.git/modules/khan-exercises/config looks like:
>> ---
>> [core]
>>         repositoryformatversion = 0
>>         filemode = true
>>         bare = false
>>         logallrefupdates = true
>>         worktree = ../../../khan-exercises
>> [remote "origin"]
>>         url = http://github.com/Khan/khan-exercises.git
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>>         rebase = true
>> [submodule "test/qunit"]
>>         url = https://github.com/jquery/qunit.git
>> --
>>
>> The only thing that seems vaguely working-tree related is the
>> 'worktree' field, which is the field that motivated me to set up my
>> patch the way it is.

That is the location of the working tree of the top-level
superproject.  Tied to the state of the submodule working tree
appear in [submodule "test/qunit"] part.

In one new-workdir checkout, that submodule may be "submodule
init"ed, while another one, it may not be.

Or one new-workdir checkout's branch may check out a top-level
project from today while the other one may have a top-level project
from two years ago, and between these two checkouts of the top-level
project, the settings of submodule."test/qunit".* variables may have
to be different (perhaps even URL may have to point at two different
repositories, one historical one to grab the state two years ago,
the other current one).

So sharing config between top-level checkouts may not be enough to
"support submodules" (the patch title).
