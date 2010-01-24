From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sun, 24 Jan 2010 12:05:15 -0800
Organization: 
Message-ID: <7vr5pf5kw4.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <201001232141.49556.j6t@kdbg.org> <fabb9a1e1001231301o149bb13es236a7150f57ce161@mail.gmail.com> <201001241457.43297.trast@student.ethz.ch> <20100124190424.GA30585@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 21:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ8k8-0006K0-10
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 21:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0AXUF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 15:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719Ab0AXUF0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 15:05:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0AXUFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 15:05:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 472D793A5F;
	Sun, 24 Jan 2010 15:05:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AlqjCqxAx+nmYYctGhsMX6SfgwA=; b=ZnOkks
	OfTdwQFhL5mLHJ7gV5eHBSMWmQxQG0oPDiy1wn+n48JpTDMv2+uDS3FqCrARGO04
	ayG1wqqLVAKCHioaavHTzl4qhEmYsdGY1l26riEdlxI07BNMss3RSrefclgXoXZ4
	q38onamhZu6ZQkZoDXGgbJgZ97N/UuqRfmYU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYejaX3ZdWi4sfnemISazvuUECfxks9L
	JN6brbXmMIaylBr71MxlgwgeuANfKIGrUtNOWZQXJmWLoOuRc1X4YVV10/i0U8Nl
	GkrwBq4PeZkJ0dK5FE0N/yoMTNpKuzflwwNdGykDTRqNfqnwJQs/SP+KiRNIo5Ti
	FKYLKmWcblE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1618493A5E;
	Sun, 24 Jan 2010 15:05:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5306193A5B; Sun, 24 Jan
 2010 15:05:17 -0500 (EST)
In-Reply-To: <20100124190424.GA30585@pcpool00.mathematik.uni-freiburg.de>
 (Bernhard R. Link's message of "Sun\, 24 Jan 2010 20\:04\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCE70E80-0923-11DF-B686-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137917>

"Bernhard R. Link" <brlink@debian.org> writes:

> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap03.html#tag_03_266
>
> | 3.266 Pathname
> |
> | A character string that is used to identify a file. In the context of
> | IEEE Std 1003.1-2001, a pathname consists of, at most, {PATH_MAX} bytes,
> | including the terminating null byte. It has an optional beginning
> | slash, followed by zero or more filenames separated by slashes. A
> | pathname may optionally contain one or more trailing slashes.
> | Multiple successive slashes are considered to be the same as one
> | slash.

Which is a bit stale, and there is an update that is crucial when
discussing the issue that is the topic of this thread.

Try this one instead, especially the last ", except for" which is an
important clarification.

http://www.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html

| 3.266 Pathname
| 
| A character string that is used to identify a file. In the context of
| POSIX.1-2008, a pathname may be limited to {PATH_MAX} bytes, including the
| terminating null byte. It has an optional beginning <slash>, followed by
| zero or more filenames separated by <slash> characters. A pathname may
| optionally contain one or more trailing <slash> characters. Multiple
| successive <slash> characters are considered to be the same as one
| <slash>, except for the case of exactly two leading <slash> characters.

And 4.12 in the same issue of POSIX says pathnames with exactly two
leading slashes may be handled in an implemenation defined manner
(i.e. three or more means the same thing as a single slash).  Confusing
;-)
