From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for
 fixed-strings
Date: Fri, 06 Nov 2009 16:00:51 -0800
Message-ID: <7vzl6ztd8s.fsf@alter.siamese.dyndns.org>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091106084855.GA20964@coredump.intra.peff.net>
 <7vbpjg0y8k.fsf@alter.siamese.dyndns.org>
 <20091106101316.GA22549@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Collins <bricollins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 07 01:01:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Yjt-0007J6-L2
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 01:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZKGAA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 19:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbZKGAA5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 19:00:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbZKGAA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 19:00:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CB9C95350;
	Fri,  6 Nov 2009 19:01:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/9VbB9FjCtRkPpeN0Z6DUO8/Sm0=; b=TtEoBp
	fEIEJ+2MYBCvJef8GrwERcu7xyenVVZfx0esxFZktrOdIpwST+5yYaNF+1QmCeEI
	bIoUPfjutUNSkwKBfRiw1ec0Fh6lFhXoNWL8b7fyLEXeNWr2j3r8PE587vt7K3wK
	TsGhfb6pgUft4S9bz0u7FKWvsQSsebcBIZlgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p9r1IHzZ0eR9cYO34JguK0DRX4SnzDQq
	kOf7gYyHd7oiz0njS6UJ7DBuYNydkwlViLzRoT/K9QHZ+jXcZiEVpQQELISEiQL2
	kCWPJKG/MYW11CHksMoSX+RvwgjPeNhgVZ4jU/LfldTTOYWRBi7mAxhVkfZzD0C+
	YPvTS4GtOEw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F329F9534F;
	Fri,  6 Nov 2009 19:00:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 834E49534E; Fri,  6 Nov 2009
 19:00:53 -0500 (EST)
In-Reply-To: <20091106101316.GA22549@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 6 Nov 2009 05\:13\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0834038-CB30-11DE-BD84-D595BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132348>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 06, 2009 at 02:00:11AM -0800, Junio C Hamano wrote:
>
>> But I didn't try hard to find out what _else_ we are depending on.
>
> It is not really _us_ depending on it. It is "things the user wants to
> do that _we_ support, but that their grep might not." So I don't think
> there is much point in enumerating features. If their system grep
> doesn't handle options that they want to use, then it won't work for
> them. If they don't use them, then they will be fine.
>
> Though "-e" might be the exception, as I think we might use it
> unconditionally. But something like "-F -i" really depends on whether
> the user wants to use it.

Yes and no.

Even though we currently punt on a few platforms for simplicity and build
with NO_EXTERNAL_GREP, we could check if the set of options given are
within the feature set of what the platform's grep understands and choose
to spawn "grep" unless some options that are unsupported are used, in
which case we fall back to the internal one.

We could certainly do something like this if it turns out to be a problem.
An invocation that does not use -F and -i together can still spawn
external grep if that is faster.

You are correct about "-e".  Our NO_EXTERNAL_GREP on SunOS cannot be
avoided.

 builtin-grep.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 1df25b0..2905f64 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -357,6 +357,9 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 
 	if (opt->extended || (opt->relative && opt->prefix_length))
 		return -1;
+	if (NO_GREP_FIXED_IGNORE_CASE &&
+	    opt->fixed && (opt->regflags & REG_ICASE))
+		return -1;
 	len = nr = 0;
 	push_arg("grep");
 	if (opt->fixed)
