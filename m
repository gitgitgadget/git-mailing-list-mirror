From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --progress for git submodule update?
Date: Wed, 14 Mar 2012 14:45:05 -0700
Message-ID: <7vd38eoo0u.fsf@alter.siamese.dyndns.org>
References: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com>
 <4F5D0FFD.1020509@web.de>
 <CAOVFbFhMfpFa5=a0Z50H7nHdQFHn9Y4ApUnQJq6GCOFP+AKy5A@mail.gmail.com>
 <4F60F4A6.1070507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Kees <cekees@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7w0U-0005xP-VH
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 22:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151Ab2CNVpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 17:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761503Ab2CNVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 17:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8654A6B96;
	Wed, 14 Mar 2012 17:45:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lgg4EHdVZgKrUT3zHj1+B0gvalE=; b=T/OMFb
	OL+n1GO+ri+8T+sAHNb4kmXEC0kmMgBG1/u9n+7ZcJr+1a6Q91RXzFU2/Em7UqkS
	zHIK7kDkaooGEOZJJvSuv09cDMOgtYKZLFaLuJAWatHsY6mJcTJDje7QmaUwg9aD
	ShYLFsuQQs1kkvYsnM13H/Vskh7QsXRT2NtBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HbDDb4VtJvHdIgnWyhsC3UerQ14pvKYa
	PBGxRXQOWixkLD2yTpq7ST2TIOvJOQsEWtn78i3sxCnNrhFarlwZOslFYaT13zZH
	yWzoa7txLxZt+tvvgoVq5Nt+4MCYopEaQzZmfCSUwX4zei1GEhPLyMEpyu6VzSmq
	jxVbtzYLexM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D1216B95;
	Wed, 14 Mar 2012 17:45:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E44036B91; Wed, 14 Mar 2012
 17:45:06 -0400 (EDT)
In-Reply-To: <4F60F4A6.1070507@web.de> (Jens Lehmann's message of "Wed, 14
 Mar 2012 20:42:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6F9B3F0-6E1E-11E1-A1F6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193165>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 13.03.2012 03:17, schrieb Chris Kees:
>> It's 'git submodule update --recursive' that is taking so long
>> silently.  The problem is mainly on the first time. There are about 10
>> submodules that together have taken more than 30 minutes. It's not
>> really just the amount of data, I think there are also network traffic
>> issues that slow things down on some systems.
>
> I suppose with "first time" you mean right after "git submodule init",
> when the submodules have to be cloned initially? Thinking about that
> again, you mentioned a buildbot doing all that. When the submodules
> are updated from a script, no progress output is shown at all and only
> the line "Cloning into 'xxx'..." will appear for each submodule, which
> explains why you don't see output for quite some time.
>
> So I suspect increasing the timeout on your buildbot is the way to go,
> as progress output is intended for humans.

Considering that more often than not, people who run stuff from cronjob
request us to be quiet when nothing wrong happens, I think that is a
sane thing to suggest.

I do not mind "submodule $subcmd --progress" to pass "--progress" down to
whatever underlying git commands it uses, or squelch "-q" that it uses
when running them by default, though.

We may even want to make "git submodule init -q" to squelch the "Cloning
into..." message, but that is a separate topic.
