From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 14:42:31 -0800
Message-ID: <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Miseler <alexander@miseler.de>, git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Fri Mar 04 23:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvdiD-0000ia-1H
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 23:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab1CDWmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 17:42:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932722Ab1CDWml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 17:42:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D9A84941;
	Fri,  4 Mar 2011 17:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MPBz03OCVCUTdJDkzq6DR+OD0Ak=; b=JR4ccX
	mBfl++9r/6H/oVO+QQhb1NkrywqPege306r60lwISuBe0CuWAFTMuUiouK/iEfY7
	Lqauld+Xe/8upPDzpd6t3HJ0YrU51QXCDyMirsSLXBrpDvGut70Em0dCLUV28y/A
	xbRrLVytdOkAzJus4LMejE2JMRfj2Rllmoy0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J34+2amJjDgYromWOrMMumhVeZcj6qGP
	KAK061IhYzfyQvazz+2I9fmCbeliNgHbdtCxw4wjUqeLu5SIBhRoUnJBfSjmG6cS
	4pDDU0NYnVibPMp/fc6CQxw4iqtuE+m9P6ZRbd8HAfNqYnVnW0LkCdNart28IP5V
	/g8w0O92DmA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 315884940;
	Fri,  4 Mar 2011 17:44:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 063EE493F; Fri,  4 Mar 2011
 17:43:55 -0500 (EST)
In-Reply-To: <4D7165A3.5080308@colin.guthr.ie> (Colin Guthrie's message of
 "Fri\, 04 Mar 2011 22\:20\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E59DA846-46B0-11E0-9696-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168472>

Colin Guthrie <gmane@colin.guthr.ie> writes:

> 'Twas brillig, and Junio C Hamano at 04/03/11 21:33 did gyre and gimble:
>> In short, Linus and I both know what you are talking about, and we may
>> revisit that issue later, but the thing is that it would not be very
>> pleasant, and not something that can be done in one sitting during a
>> single discussion thread on the list.
>
> As a simple option to avoid that, how about just printing out (by
> default) the line offsets if hunks don't apply 100% cleanly? This would
> at least alert you to the fact that some fixups were needed.
>
> Just a thought...

... and a patch to do so would look like this.  "git apply -v" and (GNU)
"patch -p1" seems to report exactly the same numbers for the problematic
patch and the initial state that started this discussion.

 builtin/apply.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14951da..4d22d16 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2638,6 +2643,14 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				apply = 0;
 		}
 
+		if (apply_verbosely && applied_pos != pos) {
+			int offset = applied_pos - pos;
+			if (offset < 0)
+				offset = 0 - offset;
+			fprintf(stderr, "Applied at %d (offset %d line(s)).\n",
+				applied_pos + 1, offset);
+		}
+
 		/*
 		 * Warn if it was necessary to reduce the number
 		 * of context lines.
