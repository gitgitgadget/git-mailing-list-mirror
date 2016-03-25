From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 11:32:46 -0700
Message-ID: <xmqqshze2ysx.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ684W46df9zPQATr3zWKt+e1BhGY6DZ84psfXWH4tGNw@mail.gmail.com>
	<xmqqlh564hm3.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ=de7jh7b2OnTuEoTUSJKhoNkjb+Mw41JP7w9SVWH3iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:32:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWXX-0001nm-3b
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbcCYScu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:32:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753207AbcCYScu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:32:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD5C04F84E;
	Fri, 25 Mar 2016 14:32:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zVvM0REJXVQ3d6Lpo9+7qkUm05I=; b=h1KkA1
	/88W/KJY43aoh4EFMuQqNmMgSWb/ATa54RtyPdqWFLPNoNKHXq2UnNW/DNsqYVxD
	e8SbxP7s1sCksEm5jxdFd3iGs7wY97Z8Qi+zMXD0ptgqdb28qoO8kHm+1VHLhnAE
	kkYgNAqYrahOW+6HMoI5o7fsVI8LpYKH/UJEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gEluovTeE9uV3fmrSy+pDxcx984TbQpC
	PKqQI/Xnku8UHodnQGFsmFdeYMg4diIyvzh6SLJc2Hcdjdq+NJJa5wbQvPS46qus
	rCy/SZcwe5p6tCtFr6tv8hrpGbS0h/E7SMZ9lcnhx+eo9h6Bi1BPBLr+9VZbxAbf
	Wk/gAxyWHgg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2FA84F84D;
	Fri, 25 Mar 2016 14:32:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18DCB4F849;
	Fri, 25 Mar 2016 14:32:48 -0400 (EDT)
In-Reply-To: <CAGZ79kZ=de7jh7b2OnTuEoTUSJKhoNkjb+Mw41JP7w9SVWH3iA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Mar 2016 10:05:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F95BEECA-F2B7-11E5-911F-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289935>

Stefan Beller <sbeller@google.com> writes:

> Exactly, sorry for not writing my chain of thoughts down completely.
>
> To make them reusable, I'd assume we want them to be easy to
> understand, and by using a well known way in git it is easier to
> understand.

I already said I do not care too deeply either way, but I have to
point out that "git -C $prefix" would put extra cognitive burden on
those who will be picking it up where you left off.  When they start
by first literally translating shell to C, "git -C" would mislead
them to think if they have to chdir(2) to the directory first, which
is not the case at all.  "git -C $prefix submodule--helper" in the
code after [3/4] is there only because submodule--helper code no
longer is told what the caller already knows (i.e. what is the
prefix) and is forced to find it out by itself.  Contrasting to
that, with an explicit --prefix option, the reader would know there
is no need to chdir(2) anywhere at that point, but the paths that
are held in variables it uses from the surrounding code are not
relative to the current working directory when the code is called
and $prefix is there to help adjusting it.

The reason I do not care too deeply was that I thought people who
will be taking over after you are done (well, after all that might
include you; plans would change) are clueful, but there is no need
for us to make their life more difficult than necessary.
