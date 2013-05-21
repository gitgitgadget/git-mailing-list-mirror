From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 15:20:47 -0700
Message-ID: <7v4ndwm0u8.fsf@alter.siamese.dyndns.org>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 00:20:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeuvO-0002Rg-UF
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab3EUWUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 18:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3EUWUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 18:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3A312192D;
	Tue, 21 May 2013 22:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ChX5SQrPv2vHzoOjA6jWH9lD1c=; b=r31BX5
	z4Y3S4jOyJyiNn3Ac36eLigEiXZN0+pw4XYDr12urFm66SKKgAQNfOVTusjgoBE5
	LXuLVu9xscFE0t5C3XTXOftWmjIBETGhVNzJVLlTdSbDVlnCiZgBrYTuG/KqpU4m
	uaCNWNCc44Hj8fJkQBJFRYxrZ6nKKvdHktzKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dy8fG7/+Rm2nsokFP59gN6BEklQZdsfp
	dnt9tF+3hItt+Gl6IvMbiyJW2tyMb8WFumGJbOr2L8/wnKvg+PvVXv1V55MssQn7
	8DCJ3u2jusrqH7l37d9n7PHXn3EMOTly6zhjPkF0AwML9BamOp6T1WCVigUWfqhM
	EgdPR80Thko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9890A2192C;
	Tue, 21 May 2013 22:20:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1519321929;
	Tue, 21 May 2013 22:20:48 +0000 (UTC)
In-Reply-To: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
	(Chico Sokol's message of "Tue, 21 May 2013 18:21:49 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0A9C12E-C264-11E2-B995-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225085>

Chico Sokol <chico.sokol@gmail.com> writes:

> Hello,
>
> I'm building a library to manipulate git repositories (interacting
> directly with the filesystem).
>
> Currently, we're trying to parse commit objects. After decompressing
> the contents of a commit object file we got the following output:

Who wrote this commit object you are trying to read?  Us, or your
library (this question is to see if you are chasing the right
problem)?

> commit 191
> author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
> committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>
> first commit
>
> We hoped to get the same output of a "git cat-file -p <sha1>", but
> that didn't happened. From a commit object, how can I find tree object
> hash of this commit?

If you care about the byte-for-byte compatibility, never use
"cat-file -p".  That is meant for human consumption.

"git cat-file commit <sha1>" gives you the raw representation after
inflating and stripping out the first "<type> SP <length> LF" line.
