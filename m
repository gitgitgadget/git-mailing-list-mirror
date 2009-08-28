From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
  with various fanout schemes
Date: Thu, 27 Aug 2009 20:02:14 -0700
Message-ID: <7v4orsbpzd.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
 <200908280103.06015.johan@herland.net>
 <20090827233900.GA7347@coredump.intra.peff.net>
 <7viqg8hj98.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com>
 <7vocq0d86p.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908271951t1f2db976jb1de1e7687ad9791@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 05:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgrjn-000101-TE
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 05:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbZH1DCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 23:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbZH1DCi
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 23:02:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZH1DCi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 23:02:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B8EC1B3C9;
	Thu, 27 Aug 2009 23:02:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Cz1QeUNkTcsnyVsr/kfJk9cuMs=; b=c7oPsW
	zqTjhu5X960uu/DOKLYpNCUAoywdAXUj62kPOjNTd26sDR92/FSlhDjUknJEGUTc
	5XKIL80qv5yF1aMWnEze+eopAgjZbXOaQlzp/tOrb608uMsSTTOX5RB+j8qGNaEd
	dLN9ixn1DaPzgRd2nwO/8EHJmFXp0gvK+LV78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cRD+M66CB8o0XCROu1pFBL/AZVQpubNK
	MRSsQa+rlzRYZ4LAA9qZnxC9JFVUuIMiIeOqCRe9agJOs/ycLbwVEsChsOLcgHwT
	EMjNcB3gd4LZncLY91IDfIfblDSfgyR/gltZpfYMCFow3sPpo3OQozR1sLyXc9vq
	47BK+q0MJcc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2CC71B3C6;
	Thu, 27 Aug 2009 23:02:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6845B1B3C2; Thu, 27 Aug
 2009 23:02:16 -0400 (EDT)
In-Reply-To: <fabb9a1e0908271951t1f2db976jb1de1e7687ad9791@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 27 Aug 2009 19\:51\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38B18E12-937F-11DE-BAC4-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127247>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Thu, Aug 27, 2009 at 18:43, Junio C Hamano<gitster@pobox.com> wrote:
>> Did you mean "a commit in branch bar referred to a commit in branch foo",
>> similar to the way the "cherry-picked from X" comment can refer to a
>> missing commit?
>
> Yes, sorry, I meant referred to in the commit message.

In such a case would you rather want to see the commit itself first, or at
least, commit _and_ notes _together_?

I admit that this all depends on what application the notes are used for,
but I am suffering from lack of imagination to come up with a plausible
scenario in which you would want to look at the notes to that missing
commit first, without getting the commit itself.
