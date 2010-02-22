From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodules: ensure clean environment when operating in a
 submodule
Date: Mon, 22 Feb 2010 14:43:38 -0800
Message-ID: <7vljek51t1.fsf@alter.siamese.dyndns.org>
References: <20100218203726.GD12660@book.hvoigt.net>
 <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njh0P-0004LU-Me
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab0BVWnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:43:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab0BVWnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:43:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED2D9CDAB;
	Mon, 22 Feb 2010 17:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Bas3YGK0tafbpt4WDPQHeMRCNU=; b=rTUNM6
	ugMHHn1CgCJ76H5L5u4giHhJWsJt/GuBXKpDyYMZtghBhgiZuYeHgDLsmRmqAZSw
	to7sZYPjizwBg9TigxPJ1lR0rDjMjWqyVKuD/nD0Z/U5jr6ftSWgX9NgG7b4NyCu
	vKpqgxxKOt+szYtT3RubLeX9vWu/OJroWPy+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjQe2FN4i/EbxT7I4t22Td6/I0aD6k6X
	Bri0nIH/7LetpYkGZpDh3cT05sWozMeNJybysu6l87Sez6sHdYe94yv80KtVJxVj
	8pbVG7bs16GBptMhtjX+/V/peUgtRStgQDwzD39P0UwpljwkcgS1QjrzWLT4Mbvy
	Fmzj2D/UPZA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B13589CDA9;
	Mon, 22 Feb 2010 17:43:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC8EE9CDA5; Mon, 22 Feb
 2010 17:43:39 -0500 (EST)
In-Reply-To: <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Mon\, 22 Feb 2010 23\:16\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC15796A-2003-11DF-8D1F-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140733>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I'm pretty confident fixing this on the submodules side is the more correct
> approach, since otherwise even a simple
> $ GIT_WORK_TREE=. git submodule update
> on the command-line can fail.

True; while I didn't bother to check what the codepaths after these
unsetting do, I suspect you should also think about what effect it has to
have other GIT_* environment variables seep through to them (GIT_INDEX_FILE,
GIT_CONFIG and GIT_OBJECT_DIRECTORY come to mind).  You would probably
want to have a single shell helper function to unset even if you end up
deciding that it is sufficient to clear GIT_DIR and GIT_WORK_TREE and
nothing else.
