From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 11:35:20 -0700
Message-ID: <7vr5v7vehj.fsf@alter.siamese.dyndns.org>
References: <4a8c373f@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ib@wupperonline.de (Ingo Brueckl)
X-From: git-owner@vger.kernel.org Wed Aug 19 20:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdq1b-0002kQ-TA
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 20:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZHSSfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbZHSSf3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 14:35:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZHSSf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 14:35:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C90510973;
	Wed, 19 Aug 2009 14:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qud8CZ2f1kcGq0fW7bF2MEtFs/4=; b=iHKzS5
	2MeMpt0GNgIN0Q/TsqN3b/66h1reqQ4mlX3Id3E8JX4EsOJfz2Q5jDp7/nENuW+3
	z5g3wILcmsCrlUnRJTFZJ8cswpu8VXWllpyYw+BCp1bbxaxoQ3K9JBO9M23wHB60
	g/syL9CDniZfO85FYoMjT/3d3k1hzzec/qD1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xyLok0dQQVYvotgsvDoGsKr2BEdiynLh
	8fRLZ/VOhkEyht3OFGDZWPyJo14j6UUhOoqKLSVMN5qU5wIp3WGEw6N7S3g1ODny
	4asKkTU8eqhpbifOEACqK9CdNsJxrxw0apZ6YU+NUV5BnG8Iv7/BtPRjP15fq/+w
	DcbKmPUa3DM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29DD610971;
	Wed, 19 Aug 2009 14:35:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 885881096E; Wed, 19 Aug
 2009 14:35:22 -0400 (EDT)
In-Reply-To: <4a8c373f@wupperonline.de> (Ingo Brueckl's message of "Wed\, 19
 Aug 2009 19\:33\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 109A957C-8CEF-11DE-A25C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126571>

ib@wupperonline.de (Ingo Brueckl) writes:

> I'm a git novice and have a comprehension question concerning branches.
>
> Within a git repository, I do:
>
>   git branch test
>   git checkout test
>   # edit foo.bar
>   git checkout master
>
> I'd expect that master is in the exactly same unchanged state it was at
> branching time, but what a surprise, foo.bar is modified here, too!

No.  Local modification that are not committed do not belong to any
branch.  Rather it belongs to your work tree and the index, and follow you
when you switch branches.

This is one of the most useful features.  For example, it is an essential
part of supporting the workflow described here:

    http://gitster.livejournal.com/25892.html

On the other hand, there are cases that you do not want to see your local
changes to foo.bar appear when you switch back to master, and the most
obvious case is "I started working on something, and I used a separate
branch 'test' because the change will be involved.  I am in the middle of
the work, the changes so far I made to foo.bar is far from ready, but I
have to handle emergency fix on the master branch".  For that kind of
situation, you can use "git stash", like:

    http://gitster.livejournal.com/29577.html
