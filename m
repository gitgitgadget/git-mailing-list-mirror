From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a scriptable way to update the stat-info in the index
 without having git open and read those files?
Date: Mon, 22 Aug 2011 15:49:58 -0700
Message-ID: <7vwre5t621.fsf@alter.siamese.dyndns.org>
References: <CABPp-BEiN7ffNmvLCvEfz056M_F36j+gV9t6J9-x_=H9q0rZFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 00:50:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvdJp-0004rX-DA
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 00:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab1HVWuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 18:50:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab1HVWuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 18:50:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADC5142E3;
	Mon, 22 Aug 2011 18:50:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T3U56c/4Dm9leiHng0A5dcqrmaw=; b=r5uNA3
	1+u4YySJecjSjRJPBK+VVRKjb/kRsAn6idOx3j+OeJHi4oQpoJRfb0xi4ncJwjrD
	KPMfQOQy2Hz+gjgQzvDtHs89E+XsxTYZxqQz50U3X2k9CLXjAFNN2B9nfzJcm895
	qxZojSx8RVz0RVOU+Apa9wHiXjeD5vcBsA0E4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1BLMx/oheluQqX2YArPKWYB21tWPBzY
	Hl3NblpkCTMmtUzwkSnFXHXsrP/0KvQi993jQ2E3LR3Wte8LOPinD1zg/qzzWUu6
	hu1jxVnGI7n4dIV4bHM0USvIs8m3Fw0aOnailteydnxfw6XBN3/SS+D6jIEttYhy
	8RMQB0tbhP8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8597642E2;
	Mon, 22 Aug 2011 18:50:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10BFE42E0; Mon, 22 Aug 2011
 18:49:59 -0400 (EDT)
In-Reply-To: <CABPp-BEiN7ffNmvLCvEfz056M_F36j+gV9t6J9-x_=H9q0rZFw@mail.gmail.com> (Elijah
 Newren's message of "Mon, 22 Aug 2011 16:28:26 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10C82280-CD11-11E0-8453-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179900>

Elijah Newren <newren@gmail.com> writes:

> A little more detail, for the curious: I have a script that is, among
> other things, renaming large numbers of files.  Calling 'git mv <old>
> <new>' on each pair took forever.  So I switched to manually renaming
> the files in the working copy myself, and using git update-index
> --index-info to do the renames in the index.  The result was _much_
> faster, but of course that method blows away all the stat information
> for the relevant files and causes any subsequent git operation (after
> my script is done) to be slow.  I inserted a 'git update-index -q
> --refresh' at the end of my script to fix that, but that is much
> slower than I want since it has to re-read all the affected files to
> ensure they haven't been modified (however, it isn't as slow as
> forking many git-mv processes).  I've tried to look for a way to speed
> up this update, but haven't found one.

Sounds like a one-off thing to me, and I personally do not think it is
worth the effort to add something even riskier than assume-unchanged to
solve.
