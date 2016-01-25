From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in t1508
Date: Mon, 25 Jan 2016 10:50:31 -0800
Message-ID: <xmqqd1sph4so.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de>
	<xmqqa8nubekj.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQfbJUtqu2F497Usaz3Ysf-5-vQgtg-0y8qh+FUQ=HeTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Braun <thomas.braun@byte-physics.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:50:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmDn-0004af-Vz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 19:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbcAYSuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 13:50:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755589AbcAYSue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 13:50:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 394533E555;
	Mon, 25 Jan 2016 13:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uqS5MCsX4IChzka8zHtemuMb2MY=; b=NmX67h
	ZggWD2EEe+IsASXlgJuym8vLz3qdjsJUK2gBYwpZd8oD+Tw22ydQl0Kxy757ewYq
	9iJwJHzwFRPhNzJR0MAuMcxDwdbhF7xKjgVEidDp+mk3a50/6pdD3XM88+QVL/LV
	i6iOFnK67K3hE46ve6Lni+K8ZtvwxmDSDezJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oW9ibywIvCCNK0dwYz+rdgy2AUqBJHb+
	bOi+Whgnypo6auqI/lZTUXu6c46JprrKCQRVT5OWVuli0bgKYbIhVBHXIREuVb2t
	Ke3K6hbbzdHj4meXvtdz+bQMXYdsOKOnqBLRFQVbT1yn0I3z8WKdKQgY3ravu1/9
	yzUUcxMI7m8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E1AF3E553;
	Mon, 25 Jan 2016 13:50:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7EB243E552;
	Mon, 25 Jan 2016 13:50:32 -0500 (EST)
In-Reply-To: <CAPig+cQfbJUtqu2F497Usaz3Ysf-5-vQgtg-0y8qh+FUQ=HeTA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 25 Jan 2016 01:22:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 830E6CEA-C394-11E5-84A5-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284744>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jan 24, 2016 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The new test hardcodes and promises such an incompatible behaviour,
>> i.e. a request to create "@//b" results in "@/b" created, only to
>> users on MINGW, fracturing the expectations of the Git userbase.
>
> What the commit message doesn't explain is that ...
> ...
> This commit message is trying to say that MSYS shell undesirably sees
> @/fish as an absolute path, thus tries translating it to a Windows
> path, such as @C:\fish. The only way to suppress this unwanted
> translation is to manually double the slash, hence the patch makes the
> test use @//fish which, when finally seen by the program, is just
> @/fish, as was intended in the first place. So, doubling the slash on
> MINGW is not promising incompatible behavior for MINGW users; it's
> just working around unwanted path translation of the shell.

Ah, OK, thanks for clarifying it.  Presumably you would then use
"checkout @//b" to switch to it, and "log @//b" to look at its
hsitory.  When you read "git branch" output and see "@/b" in it, you
would also not complain thinking "oh I thought I created "@//b", not
with a single branch!".

Then no issues on allowing "checkout -b @//b" to create a branch
"@/b" from me.

Thanks.
