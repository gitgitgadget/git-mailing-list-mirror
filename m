From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] add basic lua infrastructure
Date: Tue, 25 Sep 2012 14:18:30 -0700
Message-ID: <7vy5jxvm1l.fsf@alter.siamese.dyndns.org>
References: <20120925002325.GA19560@sigill.intra.peff.net>
 <20120925002511.GB19605@sigill.intra.peff.net>
 <robbat2-20120925T032006-952720661Z@orbis-terrarum.net>
 <20120925034211.GC3656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 23:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGcWg-0000xF-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 23:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab2IYVSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 17:18:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab2IYVSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 17:18:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D8AE98F3;
	Tue, 25 Sep 2012 17:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fL8m7GUscnfbtJHZjphUZWPqoJw=; b=OO6k2l
	lwixdJPXBUPKn9p6m5M6d+1e9mCO8HvM/k6SsbIM2QbhESh5p9bfZ5XA2+WFApsE
	j0VdgPnM1sNrazEH7H/IO3Q8TL9KKwBW3EMZdULNkLRbX8KHmKg7gnwGbPRtGymw
	Wq907WVW/3o/rc22VqHINpwNZGykTrSQslrCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JOD+3WVwG7HGqojuYz8JZZp2ynSTtxe7
	T4qpT3ALsFB6SN4CUHTPBGu0aW3PuhqCv9crl+y6UiIpOymRTAQY7Br2Yxxay6PE
	j4x270xa8yLLYaptNKDFLFruIjZoftXygl3Z5P35UTj3cFAThBQw07Mcg26p5P+Y
	/ILgLVnzIeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1876298F1;
	Tue, 25 Sep 2012 17:18:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B08F98EE; Tue, 25 Sep 2012
 17:18:31 -0400 (EDT)
In-Reply-To: <20120925034211.GC3656@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 24 Sep 2012 23:42:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E8901DC-0756-11E2-95B1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206378>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 25, 2012 at 03:21:10AM +0000, Robin H. Johnson wrote:
>
>> On Mon, Sep 24, 2012 at 08:25:12PM -0400,  Jeff King wrote:
>> > +ifdef USE_LUA
>> > +	BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
>> > +	EXTLIBS += `pkg-config --libs lua5.2`
>> > +endif
>> Can you please hoist the packagename out to a variable? It's just plain
>> "lua" on Gentoo.
>
> Yeah. I mentioned these patches were very rough, but I didn't go into
> detail on all the bad points.  That is definitely one of them. I have no
> idea what the "normal" name is; my debian system sticks the version
> number in to allow multiple concurrent versions.

Yeah, there is no point nitpicking yet.  Even the choice of lua is
not all that interesting; embedding _any_ reasonable interpreter,
and figuring out which operations and codepaths in us benefit most
from such embedding, are of bigger interest at this early stage.

How about doing this on top at the minimum?  You can let pkg-config
to tell you where -I<directory> and what -l<lib> is, or you can set
it yourself.

    $ make USE_LUA=YesPlease \
    	LUA_INCLUDE_ARG=-I/usr/include/lua5.2 \
        LUA_LINK_ARG=-llua5.2

or

    $ make USE_LUA=lua5.2


 Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git i/Makefile w/Makefile
index 620df89..90335ba 100644
--- i/Makefile
+++ w/Makefile
@@ -1898,8 +1898,14 @@ ifdef USE_NED_ALLOCATOR
 endif
 
 ifdef USE_LUA
-	BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
-	EXTLIBS += `pkg-config --libs lua5.2`
+	# You can say
+	# $ make USE_LUA=YesPlease LUA_INCLUDE_ARG=-I/usr/include
+	# or
+	# $ make USE_LUA=lua5.2
+	LUA_INCLUDE_ARG ?= $(shell pkg-config --cflags $(USE_LUA))
+	LUA_LINK_ARG ?= $(shell pkg-config --libs $(USE_LUA))
+	BASIC_CFLAGS += -DUSE_LUA $(LUA_INCLUDE_ARG)
+	EXTLIBS += $(LUA_LINK_ARG)
 endif
 
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
