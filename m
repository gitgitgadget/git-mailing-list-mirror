From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff weirdness (bug?)
Date: Tue, 18 Feb 2014 11:12:25 -0800
Message-ID: <xmqqbny4fd5y.fsf@gitster.dls.corp.google.com>
References: <52FE6C64.4060700@gmail.com>
	<xmqq8utdihqx.fsf@gitster.dls.corp.google.com>
	<53014A43.6080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dario Bertini <berdario@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFq5s-0004p3-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaBRTMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:12:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbaBRTMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:12:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8950C6B38D;
	Tue, 18 Feb 2014 14:12:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hUqugWLVBWK+Ai0Q5FgVhpKn/DQ=; b=uNstjp
	yCH5l7fiD7xSfBNoXUv5ITe/BG3RtxEQefYitjn8fFexxrOqFXVGjkDm96JMAn2o
	oZzzwQNRoBvZ7VcrO51FnEB8qOKV/h4Y2usdMUTFnYn9mmfOKj0H1P0kYSobPUPw
	ZwUjl8SfqB2NKOXu+bmf70dCWxjDgqpjW2twU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=exxViyKFPY0c2cKxxB1tc7gZ/Q/Ux5CY
	s3GoO4PuuEkF/4eM6ULDTlvaI6ig9JJGFCw9wrzm6TupCJb+GA9I+RsE1gjohBYF
	KgzVIhMWq766N3TrNNUCV0gjgOmmVNEdug+G5Wmks6eUaGTC4KM9Z8s/3TN+swwL
	SvLIInDBAwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C678B6B38B;
	Tue, 18 Feb 2014 14:12:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 579806B386;
	Tue, 18 Feb 2014 14:12:29 -0500 (EST)
In-Reply-To: <53014A43.6080505@gmail.com> (Dario Bertini's message of "Mon, 17
	Feb 2014 00:31:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C45A62E-98D0-11E3-AA8B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242338>

Dario Bertini <berdario@gmail.com> writes:

> On 02/14/2014 09:03 PM, Junio C Hamano wrote:
>> This is a combined diff, and yaml-related lines are added relative
>> to your _other_ branch you are merging (notice these + are indented
>> by one place).  Relative to what you had at the tip of your branch
>> before you started this operation that ended up conflicted, the
>> half-merged result removes if/else that sets DIST_MODULE_PATH and
>> replaces it with a single line (their +/- are on the first column,
>> signifying that these are differences relative to the first parent,
>> i.e. your state before you started the operation).
>> 
>>> if we remove these 3 lines, we'll get this diff:
>> 
>> With that understanding, I think the output after removing these
>> three lines is perfectlyh understandable and correct.  You are
>> looking at the three lines that used to exist in the version you
>> started from, that were missing from the other side.  If you remoe
>> them, it will show as removal from _your_ version (notice these -
>> that shows what _you_ did manually are on the first column, saying
>> that that is relative to _your_ version).
>> 
>
> Thank you, I was completely unaware of combined diffs. Still: I can't
> see how this would explain the empty diff when deleting 4 lines instead
> of 3.
>
> Also: in the diff output I get 2 hashes, but these are not the hashes of
> the commits, but the contents of the files apparently. One should be
> HEAD (but if I run sha1sum over the file the hash doesn't match), but

A blob object name (or for that matter, names of any type of object)
is not the same as the hash over its contents alone.

See "combined diff format" section of "git diff --help" if you are
interested in reading what the output format is telling you.

> the other can't be the commit which I reverted: the diff is too small...
> or at least this is what I understand
>
> By the way, in the man of git diff there's the briefly mentioned '-m'
> flag. If anyone else reading this mail in the archives is confused by
> the combined diff output, just use "git diff -m HEAD"... I'll probably
> add this in my git aliases

If you are primarily interested in what a merge (or other
mergy-operation like revert) did to your working tree state,
relative to the state it operated on, "git diff HEAD" is most likely
what you want.
