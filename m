From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative
Date: Wed, 07 Jan 2015 12:26:41 -0800
Message-ID: <xmqqy4peibge.fsf@gitster.dls.corp.google.com>
References: <548B7967.3060201@shysecurity.com>
	<54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com>
	<54A2FDC8.5010504@shysecurity.com> <54AC0B2B.90107@shysecurity.com>
	<xmqqiogijwdp.fsf@gitster.dls.corp.google.com>
	<54AD7F1A.3060500@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: kelson@shysecurity.com
X-From: git-owner@vger.kernel.org Wed Jan 07 21:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8xBp-0006gQ-VM
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbbAGU0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:26:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754571AbbAGU0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:26:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4C3B2D857;
	Wed,  7 Jan 2015 15:26:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i5RAw8TE7i52gVEqF7oN6CbR0YI=; b=HHH2J7
	Qim5yD5K/mqLMkZD8A/AGqhQdZWoSZ1pb6ZNnaZGHhxJz562p7MuWcZ3Axa8q0WS
	Wjft0h7U7e+HbFazx55aDHGHOFu1rgQSQnfE3cGo0BwH546IjKkR5Izvxj5A6Bzi
	8J28RNO/a8iB3bmJ1qk1Qd+/gpXQCqqm1jO1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWwFSVPaekllCn55ES099OvjS051+hUE
	ceYsfgOwuBN/zEgCq9j7JPmf9ZMwK4Fwsf8Oi3aX5Opwcm1YpZ06MU1a8IBk7Anz
	X397gfgY1l+uT2KkpE9ZgtvrW4i34V8By1fGNXr1wWUocShpeiRz0N+G//ldsfLL
	1mhYoEHExHQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A83012D856;
	Wed,  7 Jan 2015 15:26:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2D292D854;
	Wed,  7 Jan 2015 15:26:42 -0500 (EST)
In-Reply-To: <54AD7F1A.3060500@shysecurity.com> (kelson@shysecurity.com's
	message of "Wed, 07 Jan 2015 13:46:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E5097E4-96AB-11E4-8EE1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262156>

kelson@shysecurity.com writes:

>>> Content-Type: text/plain; charset=utf-8; format=flowed
>>Please.  No format=flawed.  Really.
> I'll figure out the line-wrapping.
>
>> Also this step is not about --no-relative and diff.relative but is
>> only about --no-relative option.
> Should I submit as two independent patches then? I took the approach
> of splitting them out into 1/2 vs 2/2 to distinguish, but it sounds
> like that isn't optimal.

They are indeed better to be 1/2 and 2/2; they do not have to share
the same subject, though.  1/2 now adds only --no-relative and makes
sure an earlier --relative is cancelled without even knowing that
diff.relative might appear in the future (well, you may know that,
but the system with only 1/2 applied without 2/2 would work perfectly
fine).  2/2 adds diff.relative and makes sure --no-relative cancels
its effect as well.

> On review, this may be a bad approach though. Non-locality makes it
> harder to follow/understand and introduces a subtle bug.
> current:  "git-diff --relative=path --no-relative --relative" ==
> "git-diff --relative=path"
> expected: "git-diff --relative=path --no-relative --relative" ==
> "git-diff --relative"

Exactly.
