From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filename quoting / parsing problem
Date: Sat, 02 Jan 2010 10:37:08 -0800
Message-ID: <7v8wcge4kr.fsf@alter.siamese.dyndns.org>
References: <201001011844.23571.agruen@suse.de>
 <7vws01li4c.fsf@alter.siamese.dyndns.org>
 <7vr5q9lhm8.fsf@alter.siamese.dyndns.org> <201001021236.26947.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sat Jan 02 19:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR8qr-0000oO-Qp
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab0ABShS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 13:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464Ab0ABShS
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 13:37:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab0ABShR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 13:37:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87BDD8DA76;
	Sat,  2 Jan 2010 13:37:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zHGmtOlL9mrq2IChJ8rTdBEYOjg=; b=tBYkPn
	8W0eDIF9H+koP+3xi1WuiOi5ms+rmPWQ5kbxRcB6m+DmcSeRFfUKBxjYwoBfTHv0
	yO6dqGbRfTAz40/g9OeC8Wl4fP4XN3kkfEM9DOq/GDcv3RI7CkS5emzpowmuFJmp
	F4ejKqhqDPwUPX0dICTBOP/j8tbD1gEICMy5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xzODUE38bi8gq9a0Yul5LfbKLbBk+Q4q
	vmpk8nvrV3R5hIo6+ct/kuG61+n6bqXJ0vLWrSgGMwKDHMGalVIximm0q9jlEA7W
	kf602yZ49ycSFi+mFyfZzVJgdOrXgvs4XEGw0ZDMs+pZqMKLLUOavwU8EKeoV3Tr
	pEbcPgC6Op0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 600118DA75;
	Sat,  2 Jan 2010 13:37:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 972AE8DA74; Sat,  2 Jan
 2010 13:37:10 -0500 (EST)
In-Reply-To: <201001021236.26947.agruen@suse.de> (Andreas Gruenbacher's
 message of "Sat\, 2 Jan 2010 12\:36\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D81711EA-F7CD-11DE-982C-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136037>

Andreas Gruenbacher <agruen@suse.de> writes:

> On Friday 01 January 2010 09:01:19 pm Junio C Hamano wrote:
>> > Both "b file" and "c file " are parsed by "git apply" perfectly fine.
>
> Right, the "diff --git" lines are technically still parseable when the file 
> name stays the same.  With renames, lines like "diff --git a/f a/f b/f" or 
> "diff --git a/f b/f b/f" are possible, but then there will also be "renamed 
> from" and "renamed to" headers which will disambiguate things.  Still, it 
> doesn't seem like a good idea to allow such ambiguities in the first place.

You already realized that there is no ambiguity because "diff --git" lines
are parsable and renames have explicit names.  Why do you still maintain
that we are allowing such "ambiguities" when there is none?

>> Having said all that, I don't think we would mind a change to treat a
>> pathname with trailing SP a bit specially (iow, quoting "c file " in the
>> above failed attempt to reproduce the issue).
>
> I would prefer quoting file names which contain spaces anywhere,...

The only reason I said I don't think we would mind changing the trailing
SP case is because the reduced risk of getting our patches corrupted by
MUA _might_ outweigh the benefit of not quoting to avoid an eyesore [*1*].

But what you said would add to eyesore of quoted names (which you omitted
from your quote) without any justification other than "I would prefer".
The pros-and-cons in such a change is quite different; as we have already
established that there is no ambiguity, "disambuguation" is not a "pro" in
this comparison.

[Footnote]

*1* Strictly speaking, it is not just "an eyesore" that is an issue.  Our
diff output without renames are designed to be grokkable by other people's
patch implementations (e.g. GNU patch), and the quoted pathnames are not
understandable by them.  Even though our final version of quoted path
format came from the GNU diff/patch maintainer (back then, at least):

    http://article.gmane.org/gmane.comp.version-control.git/10103

I don't think it happened in the GNU land yet, and you would be the person
to know about it ;-).
