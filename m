From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] fast-import: add 'ls' command
Date: Fri, 11 Feb 2011 16:40:04 -0800
Message-ID: <7vlj1mytjv.fsf@alter.siamese.dyndns.org>
References: <20110211224339.GA9973@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 01:40:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po3XF-0001OY-H9
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 01:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab1BLAkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 19:40:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1BLAkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 19:40:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E89C43402;
	Fri, 11 Feb 2011 19:41:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZV38y1hYz4cFzNM0cfClMGQjbU=; b=wfjJOC
	WfSjqCz8OQeFDDG7BPbRxgPLvwf0U2HGPgVgbS4gn+bN9Fwu8eOO1La4W289T2D0
	A6VWXRrUxdWDpF8FUmXPStTGZ5NqH3ARjtbK9HMN3OuhUuBJFnRjuItFTDijqS1b
	+AcWuOXl/nqwqO1dRqq6LZKoYsOTqmUi9EjDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OcuKSQsTY2Ep7MZDlPafBds0a8IMsRJU
	Dvk1GuArEk7IQtVgw8dz/AWB8xZT3umjNIS3AlUhwuk69AwEclPCQi0nh/wjBs/+
	Bo/s30brMU8FjxBjrQu4wTq2sKY1qBkBXrSNIAq9YaEnNDQxqRdMpZ2zaMm86cKG
	Aj8aGG3DsIc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9872C3401;
	Fri, 11 Feb 2011 19:41:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C1C43400; Fri, 11 Feb 2011
 19:41:07 -0500 (EST)
In-Reply-To: <20110211224339.GA9973@elie> (Jonathan Nieder's message of
 "Fri\, 11 Feb 2011 16\:43\:39 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CBC8B7E2-3640-11E0-8F42-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166582>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: David Barr <david.barr@cordelta.com>
> Date: Thu, 2 Dec 2010 21:40:20 +1100
>
> Introduce an "ls" command to read directory entries from the active
> commit or a named commit.  This allows printing a blob from the active
> commit or copying a blob or tree from a previous commit for use in the
> current one.
>
> There are two forms of the 'ls' command: the two-argument form prints
> the entry at <path> for the tree underlying the tree, commit, or tag
> named by <dataref>:
>
> 	'ls' SP <dataref> SP <path> LF
>
> The one-argument form prints the entry at <path> in fast-import's
> active commit.
>
> 	'ls' SP <path> LF

Is this really "ls"?

Obviously, an extended SHA-1 that is accepted by the normal git does not
have a notion of "marks", but modulo that, the first one looks to me very
similar to "rev-parse <ref>:<path>" in spirit, which suggests that "the
path in the current one" might be better spelled as "rev-parse :<path>" to
make the syntax and the concept more consistent across parts of the
system.  If it makes sense to allow arbitary <committish> (or <treeish>
for that matter) for the <dataref> part of the parameter, this observation
becomes even more true, no?

Having said that, I do not deeply care about the token "ls" itself.  I
just reacted to "<dataref> SP <path>" part.

> Dirty hack: for now, git fast-import will treat missing paths as empty
> subtrees and print them as
>
>  040000 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904	path/to/nowhere
>
> to avoid confusing frontends that inserted such a path before.

Sorry, but I am not quite sure what this paragraph is trying to say.
