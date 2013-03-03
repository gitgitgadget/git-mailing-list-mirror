From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] describe: Exclude --all --match=PATTERN
Date: Sun, 03 Mar 2013 13:15:21 -0800
Message-ID: <7vfw0cb2xi.fsf@alter.siamese.dyndns.org>
References: <7v1uc1jyq0.fsf@alter.siamese.dyndns.org>
 <20130303205232.GL22203@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Mar 03 22:15:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCGG6-0007lo-GM
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 22:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab3CCVPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 16:15:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab3CCVPY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 16:15:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4F00A5A8;
	Sun,  3 Mar 2013 16:15:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0M17VYQTfHWy
	/Xk2VKFmq8Xu58Q=; b=a6KO9ufyYJhqCCRUiW14qY6aDq8ds3+KmGEadH0TQ1G0
	SvkgsWTR7a/tpDdgseESJZBverneLErX6L01j28GMUfl2cBTmkjQmYEk1paTvOs0
	2GZw5IQxqUd/JFDsBoP80sNcv5idOLOpM1wh9K9MOy6nx1RIXnTVyoWCJ977tDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cZWZAe
	1RGh7iLhgDXIHguEKpuCu3g8r1Ss4DvrjNy4yAjyziI02PbCqNd11nbBmCyBBuBn
	2BYJ7f7YXA7f0na2N5H+BYh8ATKVyAPWxGfuYAUDxBfXuDXvT6KxbL5A6RQ2/nCX
	hjqoyPsCWLkZ3xyupqsR7F1rmZ5SyYNrK6yd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA164A5A7;
	Sun,  3 Mar 2013 16:15:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A72BA5A4; Sun,  3 Mar 2013
 16:15:23 -0500 (EST)
In-Reply-To: <20130303205232.GL22203@biohazard-cafe.mit.edu> (Greg Price's
 message of "Sun, 3 Mar 2013 15:52:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76003F36-8447-11E2-81DC-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217360>

Greg Price <price@MIT.EDU> writes:

> On Wed, Feb 27, 2013 at 12:20:07PM -0800, Junio C Hamano wrote:
>> Without "--all" the command considers only the annotated tags to
>> base the descripion on, and with "--all", a ref that is not
>> annotated tags can be used as a base, but with a lower priority (if
>> an annotated tag can describe a given commit, that tag is used).
>>=20
>> So na=C3=AFvely I would expect "--all" and "--match" to base the
>> description on refs that match the pattern without limiting the
>> choice of base to annotated tags, and refs that do not match the
>> given pattern should not appear even as the last resort.  It appears
>> to me that the current situation is (3).
>
> Hmm.  It seems to me that "--all" says two things:
>
>  (a) allow unannotated (rather than only annotated)
>
>  (b) allow refs of any name (rather than only tags)
>
> With "--match", particularly because the pattern always refers only t=
o
> tags, (b) is obliterated, and your proposed semantics are (a) plus a
> sort of inverse of (b):
>
>  (c) allow only refs matching the pattern

I would think it is more like "only (a), without changing the
documented semantics of what '--all' and '--match' are by adding (b)
or (c)".

I do not think in the longer term it is wrong per-se to change the
semantics of "--match" from the documented "Only consider tags
matching the pattern" to "Only consider refs matching the pattern",
and such a change can and should be made as a separate patch
"describe: loosen --match to allow any ref, not just tags" on top of
the patch I sent which was meant to be bugfix-only.
