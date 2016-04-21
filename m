From: Junio C Hamano <gitster@pobox.com>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 10:23:07 -0700
Message-ID: <xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
References: <20160421113004.GA3140@aepfle.de> <87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:23:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIJw-0004NH-HA
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbcDURXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:23:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751340AbcDURXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:23:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8925814151;
	Thu, 21 Apr 2016 13:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hteXqylHxBEi+IemwEbxv5AEl5E=; b=NIm3UD
	nCYIV03FiTbc6Cs60irpz18sokPdVLPu4Q9EQrpzVSM2voyTjCPX5z4wAN8EPkoO
	37f3GpLMnRClzhLNzYzLKkk/3Dc5IY9K9IgRYOcT/30/Un5atYTj9MZp134NPpDe
	mCIn07Mw1JcHlEQlojg0Ji1Gwm8nhcJ1BL5Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kqkA8jEE3mIVRdRSjLtjWHQ/dxQtTJUz
	RkFEOq6i1gAFJAVRtMD0SAfe+wUZF0L8BqxXiG1/H9I0pXqze0qnX4TlaVEmZAhx
	yf/LJX+AwrxmAGrq3p/Ut68ySpHOFFO/GvZvaK+/eUuc4+Ux9yNF9x+xq7Swp8mw
	O4t/RMvIJ6k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FFD014150;
	Thu, 21 Apr 2016 13:23:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D34191414F;
	Thu, 21 Apr 2016 13:23:08 -0400 (EDT)
In-Reply-To: <CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 21 Apr 2016 10:00:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B77E7D68-07E5-11E6-B581-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292131>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 21, 2016 at 9:36 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> This seems to be a git bug.
>>
>> That commit aed06b9 can also be described as
>>
>>     v3.13-rc7~9^2~14^2~42
>>
>> so describing it as 'v4.6-rc1~9^2~792' is clearly not closer in any way.
>
> Hmm. I think I see what's up. The git distance function has a special
> hack for preferring first-parent traversal, introduced long long ago
> with commit ac076c29ae8d ("name-rev: Fix non-shortest description").
>
> Changing that
>
>   #define MERGE_TRAVERSAL_WEIGHT 65535
>
> to be a smaller value makes git find the shorter path.
>
> I do not know what the correct fix is, though.

I think avoiding side branches to describe with the weight is a
right thing to do, i.e. if you have this history:

    X---o---o---o---o---v4.6
     \             /
      o-----------o

you do not want to explain X as "v4.6~^2~2", and instead you want it
as "v4.6~5", even though the former is 4 hops while the latter is 5
hops (which is longer).

But when comparing a name based on v4.6 (which I think the algorithm
with the weight heuristics would choose v4.6~5) and another name
based on v3.13, I suspect that we compare them with number of hops
with the weight heuristics, and that is what gives us a wrong
result, isn't it?

I think it should instead compare the number of true hops.

v3.13-rc7~9^2~14^2~42 = 9 + 1 + 14 + 1 + 42 = 67 hops from v3.13
v4.6-rc1~9^2~792 = 9 + 1 + 792 = 802 hops from v4.6-rc1
