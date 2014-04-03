From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/10] log: --function-name pickaxe
Date: Thu, 03 Apr 2014 14:44:40 -0700
Message-ID: <xmqqwqf6ozp3.fsf@gitster.dls.corp.google.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
	<62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>
	<533DD1B1.3000107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David A. Dalrymple \(and Bhushan G. Lodha\)" <dad-bgl@mit.edu>,
	git@vger.kernel.org, peff@peff.net,
	"David Dalrymple \(on zayin\)" <davidad@alum.mit.edu>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 23:45:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVpRW-0005Wk-D3
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 23:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbaDCVo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2014 17:44:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbaDCVoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2014 17:44:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6418B79F5E;
	Thu,  3 Apr 2014 17:44:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fH0A/xdOxxuT
	OCijk+J6sg1eyeM=; b=C+PEjBxmahlQgU7CGie9jrlUv/UnO+yHSC6LvQTihpPg
	w2A2ZRanPkYRPVbz/rBf3KpUsOHzE9OSf+YpxrnZ4Sw0nnNyDYkdEdCCiJQCfzQV
	++H7m4+sRNmLpKXNYP4TytCjecbqeBMHh6ejKfgypXBmubqbaM/Hf9Gx8ANMolY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OxjFeT
	aMsEzesRVCsugU1LAz9LmmzKakQgSBGqiIzMWSqPGmxLsvMmAlJJ8MIQnQ80fJR0
	N+COE/3p3PVLQ9OVZBBoySOSGgr1WAVWgZlGq2fMiDE4cfIMbZ5DRVHpcUgNNDwv
	6Yl7saef2fw8CX6sUOWEjxB9jurSkFRy0girU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0D679F5C;
	Thu,  3 Apr 2014 17:44:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A06279F5B;
	Thu,  3 Apr 2014 17:44:42 -0400 (EDT)
In-Reply-To: <533DD1B1.3000107@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 03
	Apr 2014 23:25:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2A3A76EC-BB79-11E3-8CF4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245754>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> With that approach you depend on the hunk header and apparently need
> to add XDL_EMIT_MOREFUNCNAMES and XDL_EMIT_MOREHUNKHEADS to improve
> the results.  This approach feels fragile.
>
> Would it perhaps be more robust to not base the implementation on dif=
f
> and instead to scan the raw file contents?

That is an interesting idea.

Perhaps this can be implemented as a new stage in the transformation
pipeline, I wonder?  There is currently no transformation that
modifies the blob contents being compared, but I do not think there
is anything fundamental that prevents one from being written.  The
new "limit to this function body" transformation would perhaps sit
before the diffcore-rename and would transform all the blobs to
empty, except for the part that is the body of the function the user
is interested in.
