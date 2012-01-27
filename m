From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 15:10:30 -0800
Message-ID: <7v39b0zqqh.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
 <20120126230054.GC12855@sigill.intra.peff.net>
 <7vsjj20yog.fsf@alter.siamese.dyndns.org>
 <20120127004902.GA15257@sigill.intra.peff.net>
 <7vd3a51zlb.fsf@alter.siamese.dyndns.org>
 <20120127054216.GA23633@sigill.intra.peff.net>
 <4F2251D4.9060005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jan 28 00:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RquwR-0008GN-Uj
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 00:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab2A0XKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 18:10:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834Ab2A0XKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 18:10:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 600CA7CF6;
	Fri, 27 Jan 2012 18:10:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ScS1sUdRmUe2GrvZe6YVG8oCVWg=; b=cwyx3N
	uyCVauNgIsmubIj8XTz5Q7TCPmNR3dWEBtzFNoc7z+IW2c+Gf6WYqJPSe2q+Oe1q
	jyh/Xt2QbiXH1M/XkOQ0UgNgTAQbKZZz90UjFS1V8D1gtUyzY6JkAf16pZB9SYJX
	f7rGTpkxV4v8DXnZ3nughSUF/4xqUhVd1gAqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rX8aON2wJJguROminZWMzPuKtyJv3+Iu
	Q4f0J8f2g3lmHyU3Jhw7Ao2bRZmTa0OvWq1dVJuUf9uURd+iD0SnIUQnTx7FIvdb
	Om5t3mmd3zqZ6hNlEDn8MLZeorow+Hr8WIRo0y5dRqcVaNv0RgKHJ/S5lnj4jHIq
	gJekAPMQgHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 578D17CF5;
	Fri, 27 Jan 2012 18:10:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B135A7CF4; Fri, 27 Jan 2012
 18:10:31 -0500 (EST)
In-Reply-To: <4F2251D4.9060005@viscovery.net> (Johannes Sixt's message of
 "Fri, 27 Jan 2012 08:27:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C2C6832-493C-11E1-9CFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189242>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 1/27/2012 6:42, schrieb Jeff King:
>> That being said, I think it would be nicer for projects to carry meta
>> information like this out-of-tree in a special ref. It's just simpler to
>> work with, and it means the project's source isn't polluted with extra
>> junk.
>
> Really? I doubt that carrying configuration in a special ref outside the
> normal contents will have any practical relevance:
>
> To manage such a config file would mean to switch to a branch with
> entirely different contents. But before you can test the new configuration
> in action, you have to commit, switch branches, which exchanges the
> worktree completely; and if the config change didn't work out, repeat the
> process (and if we are talking about source code repository, this usally
> includes a complete rebuild). Sure, you could keep the config branch in a
> separate repository, but, again, how do you test an updated configuration?
> It is not funny, and nobody will go this route.
>
> Which raises doubts about the usefulness of the include.ref feature.

Hmm, good point.

What I envisioned, when I said "meta:gitconfig" might make sense, was to
do something like:

 * have a separate worktree via git-new-worktree in meta/, so that you
   do not have to switch away from the "source" branch and trash the
   working tree for it; and

 * update meta/gitconfig, perhaps make commit there, and possibly push
   it back for public consuption.

In other words, I think "you *could* keep the config branch in a separate
repository" is more like "you would most likely want to have a separate
checkout of the config branch for this 'meta' branch to be useful".

And at that point, as you said, setting include.path = meta/gitconfig
(with possibly adding meta/ in .git/info/exclude) would be far more
pleasant, because you would have a chance to experiment your changes to
the file before committing it.

So having include.ref, while it is a fun thought experiment, would not
help very much in the real life.
