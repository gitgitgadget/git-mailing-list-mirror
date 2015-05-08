From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 08 May 2015 10:20:14 -0700
Message-ID: <xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:20:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqlwn-0002yp-Ub
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbbEHRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:20:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932310AbbEHRUR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 299174E070;
	Fri,  8 May 2015 13:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j0u2PS8VL9iNk7hwSg1SwEhaJDc=; b=CJzXUP
	0ZXLfsKWwR6WVHXob+dFYHUjVuMF2hMTKN3Ef5mR1pg/5QvSMsRGBKAg3K+HDFMe
	ZdNQgOn1iwq3acO8zArBUBav7oD6l2biT7+QCG1P5zDrBoXxau/rJTQvpLedRmM/
	k28S7ikMuH2dNVOsUt+u+zmankuXIQyRD6yfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATILrrjqKWYyugsfYAZYsPj5YS72eJ9F
	HbFDKS9O52ZXE569ZQ+OuQCJT0xAxVnvyn78hiLOa4E4bdlfWCP8dh9uUDjZ2lmx
	+bfOUW4t4ZcsiMEKXoKcpqQqjW3tGRl3bdudy+960+jXiPFuA+HJzTFaQWwTwwi9
	3eizo4FaBfU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 226944E06F;
	Fri,  8 May 2015 13:20:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90A864E06E;
	Fri,  8 May 2015 13:20:15 -0400 (EDT)
In-Reply-To: <CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 8 May 2015 13:10:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E0D3B98-F5A6-11E4-9F5E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268627>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 8, 2015 at 12:53 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> sequencer.c: abbreviate hashs placed in the middle of messages
>
> s/hashs/hashes/
> ...
>> + return error(_("Commit %s... is a merge but no -m option was
>> given."),
>> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
>
> Are short SHA1's followed by "..." anywhere else in the project? It
> seems strange to introduce such usage here.

There are (and used to be the norm), as in "git diff --raw", for
example.

But I doubt the value of pointing out exact commit in the first
place, which leads me to say that "no -m option was given but
history has a merge" might be a viable alternative.

If identifying the exact commit has value, on the other hand, we can
rephrase it like this:

	error(_("no -m option was given to pick a merge '%s'", ...));

to place it not in the middle.  We can do similar rephrasing for
other messages as well.

>> -                       return error(_("Commit %s does not have parent %d"),
>> -                               sha1_to_hex(commit->object.sha1), opts->mainline);

	error(_("No parent %d for commit '%s'", opts->mainline, ...);

>> -               return error(_("Mainline was specified but commit %s is not a merge."),
>> -                       sha1_to_hex(commit->object.sha1));

	error(_("-m option was given for non-merge commit '%s'", ...);
