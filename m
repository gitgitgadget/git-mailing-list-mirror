From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line up properly
Date: Wed, 16 Mar 2016 12:32:36 -0700
Message-ID: <xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:32:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHBV-0003vX-G1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbcCPTcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:32:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752004AbcCPTck (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:32:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91D414D66B;
	Wed, 16 Mar 2016 15:32:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Jn80bOwuK29K1SOjDHs7cSzHnc=; b=HnbTdv
	uFjmq/SxWwGnlGxqDkYTcS8s0jIWUaiyD234QGtRDzHyBMMS1ePFXatyBSRQ6RS0
	o1OHs/nX3htSsWU4STcJBpNlFW42Yao3mFgwzNrhtbAv0oiJRKZX8niBe91n6xgR
	ABCIQ02kJFl05yMZhYMAzBUNAnI77g24C28lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bbwosFkD0jM+Y1KbKEG7QcUlZ15/zBe2
	lpDgtylorcDRUTOJc6//T3pPMsgat54mHpmWjbyCt1DPBONzy9X1mNnOfZqadYD1
	nj58cgU7vID2amHMV46K4uU0mC5wj4PLfW/FWLnJ/iw/LGamZ8zQx+zU7r3n1w3W
	x3+W+oiEx6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 718BF4D66A;
	Wed, 16 Mar 2016 15:32:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E76814D668;
	Wed, 16 Mar 2016 15:32:37 -0400 (EDT)
In-Reply-To: <CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 16 Mar 2016 11:21:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D75BB3B6-EBAD-11E5-8265-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289020>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Mar 16, 2016 at 11:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  (1) if turning your "preparation; do { ... } while()" into
>>      "while () { }" would make the result a bit easier to read;
>
> So it's probably partly taste, but I will also disagree with your
> "easier to read", because of the way the code is logically structured.
>
> In particular, the "no TAB" case is actually *fundamentally* different
> from the "no TAB at the end" case. The return value is different, and
> the caller does very different things - the code tries to make it very
> clear that that "no TAB" situation is very different from "we found a
> TAB".
>
> So it's not "preparation + do-while".
>
> It's "preparation + handle the no-TAB case differently", and then the
> "do-while" is very natural because by the time we get to the "ok, we
> are now going to need to do something about the line" stage, we
> already know we have a tab.

OK, I agree with that viewpoint; retracted.

>>  (2) if we can somehow eliminate duplication of "tab + 1" (spelled
>>      differently on the previous line as "1+tab"), the end result
>>      may get easier to follow.
>
> Yeah, I considered that. Either by just doing "tab++" before (so the
> +1" would come from that in both cases), or by introducing a new
> variable like
>
>     ptrdiff_t bytes_used;
>     ...
>     bytes_used = 1 + tab - line;
>
> and then just doing
>
>     line += bytes_used;
>     linelen -= bytes_used;
>
> and the code I wrote just didn't do any of those temporary updates,
> and instead just did the "+1" by hand in both cases.

The above is most likely what I would have written if I were doing
this patch.  I could squash it to save a round-trip, but let me run
the testsuite first to see if we need adjustments to existing tests.

Also your idea:

> But the code *could* be made to just always do the whole
> "strbuf_add()", and not return a return value at all, and the no-tab
> case wouldn't be explicitly written to be different.

may give us a better structure if we are going to give users a knob
to disable this tab expansion, i.e. move the addition of 4 spaces to
the caller, name the body of such a function strbuf_expand_add(),
and then make the caller do something like this perhaps?

@@ -1723,10 +1711,14 @@ void pp_remainder(struct pretty_print_context *pp,
 
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
-			if (pp_handle_indent(sb, indent, line, linelen))
-				linelen = 0;
+			strbuf_addchars(sb, ' ', indent);
+			if (pp->fmt == CMIT_FMT_EXPAND_TABS)
+				strbuf_expand_add(sb, line, linelen);
+			else
+				strbuf_add(sb, line, linelen);
+		} else {
+			strbuf_add(sb, line, linelen);
 		}
-		strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
 	}
 }
