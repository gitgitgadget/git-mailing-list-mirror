From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Stop producing index version 2
Date: Mon, 06 Feb 2012 21:21:46 -0800
Message-ID: <7vehu743rp.fsf@alter.siamese.dyndns.org>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-3-git-send-email-pclouds@gmail.com>
 <7v4nv4a131.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 06:21:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RudV3-00078h-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 06:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab2BGFVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 00:21:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab2BGFVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 00:21:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38DE56970;
	Tue,  7 Feb 2012 00:21:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PM97uB7YGLMvkOXUvhAevTAl1cg=; b=c5CqH5
	Se29WnRlvqG4J0Hnul9PvVKbOrmdmC00RE6HmbCfqaPG6oX5g3MjSWoGEZB+XRxn
	kWKOxETMPi8VtIaNCZ5d74xj6NVDKRUA8cd9gu4YoUwRPqLzLzTFiQ7xldFdbgbQ
	LhJMFg4wxLprtLkutDviD7+4LLzbrZaF1mL2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wj7V0OuSsVFKnp2nKckkjVowE2ugDZ4y
	bFStZ4V4mBue0yNTWIVhkcfqf6YaPTjBB49JCbR4jZQcwbs5JQ6eFxfGeX1k3yGN
	5eQweZRkzRmT7d1JcXLpXRgW42TUzzeDomdmnKahd6E1CNDNGrU0Rq3ct3uLY+MS
	Kepv9ltdT4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 303E5696F;
	Tue,  7 Feb 2012 00:21:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAE73696C; Tue,  7 Feb 2012
 00:21:47 -0500 (EST)
In-Reply-To: <CAJo=hJvtRnmvALcn3vKpYTr3j6ada8iboPjWN3cQnwwKzRvrDA@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 6 Feb 2012 19:09:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1DC0DB8-514B-11E1-B5C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190141>

Shawn Pearce <spearce@spearce.org> writes:

> <thinking type="wishful" probability="never-happen"
> probably-inflating-flame-from="linus">
>
> I have long wanted to scrap the current index format. I unfortunately
> don't have the time to do it myself. But I suspect there may be a lot
> of gains by making the index format match the canonical tree format
> better by keeping the tree structure within a single file stream,
> nesting entries below their parent directory, and keeping tree SHA-1
> data along with the directory entry.

I suspect that is not so "never-happen wishful thinking".

In an earlier message, I alluded to a data structure that starts with a
single top-level tree entry that is lazily expanded as the index entries
are updated. The above shows that at least two of us share the same (day)
dream, and I suspect there are others that share the same "gut feeling"
that such a tree-based structure would be the way to do large index right.

It would be a large and possibly painful change, but the good thing is
that the index is a local matter and we won't have to worry too much about
a flag day event.

</thinking>
