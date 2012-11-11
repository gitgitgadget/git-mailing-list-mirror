From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/13] test-wildmatch: fix tests that fail on Windows due
 to path mangling
Date: Sun, 11 Nov 2012 02:47:56 -0800
Message-ID: <7vvcdco1pf.fsf@alter.siamese.dyndns.org>
References: <5096D76F.5090907@kdbg.org>
 <1352628837-5784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXV5P-00085H-4E
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab2KKKsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 05:48:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab2KKKsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 05:48:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C31B9451;
	Sun, 11 Nov 2012 05:48:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0mjsJTLXpEbs
	s7Gi2MBfeQv7MKM=; b=ASsGQUfVBCfff27Xr3V7w/lyGv1PizmmErVGVu/J0pGC
	zVEz+kaIxD5ZwUwWi9nRHKVDIuXrqUIVdMdcltvDO6H5OCkKN3y87gxtQPuJLMD/
	ZsH+42kv+q4w2RMgrNjaseXejc17GgvYNZ8eEJJ8c7pmE7QtOkZFdDDCid745/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=orNwv9
	aLBpshD67e0NSorD4yW28RraSFa4MZk4VQgqDVDL5Lz3l4ynIrQAgv8UUApbwhc+
	4WhWmDCR0jsDZ+bWWNQBl/MjHS3r2kG0hKQ5g8JlQQu6VCG45OhC8V2a+Jm+wXWW
	kb9Bf4Xio7oFKbEoGV49Nu4VROkTo4WfyV0qE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1398A9450;
	Sun, 11 Nov 2012 05:48:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE6B944D; Sun, 11 Nov 2012
 05:47:59 -0500 (EST)
In-Reply-To: <1352628837-5784-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 11 Nov
 2012 17:13:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 428F667A-2BED-11E2-9972-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209335>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Patterns beginning with a slash are converted to Windows paths before
> test-wildmatch gets to see them. Avoid this case by always writing
> XXX/abc instead of /abc. The leading XXX will be removed by
> test-wildmatch itself before processing.
>
> Any patterns beginning with a forward slash is rejected by
> test-wildmatch to avoid the same fault in future.

The title taken together with the above explanation makes it sound
as if wildmatch code does not work with the pattern /foo on Windows
at all and to avoid the issue (instead of fixing the breakage) this
patch removes such tests.

But I suspect that is not what is going on. Perhaps the title of the
change is more like "test-wildmatch: avoid Windows path mangling"
and explain with "On Windows, any command line argument that begins
with a slash is mangled as if it were a full pathname.  This causes
patterns beginning with a slash not to be passed to test-wildmatch
correctly" or something?
