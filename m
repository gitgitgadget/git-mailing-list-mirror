From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote-helpers: tests: use python directly
Date: Sat, 18 May 2013 23:24:05 -0700
Message-ID: <7v4ndz1o8q.fsf@alter.siamese.dyndns.org>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<1368825008-2815-2-git-send-email-felipe.contreras@gmail.com>
	<7vwqqxujby.fsf@alter.siamese.dyndns.org>
	<CAJDDKr6Qnx5ddBn=6reNOY44CxaDgD254H7M3K2mb8bbd8jpmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 08:24:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udx2S-0000Qc-Su
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 08:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab3ESGYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 02:24:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab3ESGYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 02:24:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65A3F1C88B;
	Sun, 19 May 2013 06:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=C4eHLM5UjkMzJvx/wmodeqhtB5A=; b=gc9WQgzyRbPxYKUUjTzB
	gqt5+VjepBQ0UkN5zfeFiAppjXrzwG5mV5NKgMJKER+l/gxh9FpQ32cD9pLslUyN
	R1gtzInYgya3iYDxjdKuqjkZxFSikpi7BsJXGxVJLOOMm8UrzwOuuZ44T18t6l6d
	rMJFqN1ITZbVHWN3xrNojv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VskStXiUCFMTN+PcdDw+veTRyr5oJDtVDzwBOFONYuXWKT
	KDUXaXBwwxHjIfsn+zxp59Gr+VnfolMoqieRVDhi2tq5PC2vDMPn/VW9M86YhDJA
	6sZHeTVFcVgsC94cZXFFqR6hbN4ykLePJvDRGIC5NV5tWSVQmALPWiBNNa+1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 586401C88A;
	Sun, 19 May 2013 06:24:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD7F51C885;
	Sun, 19 May 2013 06:24:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5658258-C04C-11E2-A164-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224821>

David Aguilar <davvid@gmail.com> writes:

> On Fri, May 17, 2013 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> So it is a right thing to do in that sense.
>>
>> I however am having this nagging feeling that I may be missing
>> something subtle here.  Comments from others are very much welcome.
>
> Yes, this is correct.  Another way to skin this cat would be to do
> search/replace in a Makefile to burn in the PYTHON_PATH similar to how
> we do for the .sh scripts and other .py files in the main Makefile.
> The remote helpers are in contrib/ so they do not go through the main
> Makefile, which is the root cause.
>
> Longer-term, it would be good to treat these uniformly, but this is no
> worse for now.

Ahh, so my "nagging feeling" was that remote-helpers could in theory
be updated to follow the PYTHON_PATH like the rest of the system and
matching these two in that direction is the better longer-term fix?

Ok, with that in mind, I still think the patch under discussion is
an immediate solution that is fine as-is.

I somehow thought that there were valid reasons that we could not do
so for some technical reason (e.g. the instalation of python used to
run hg and/or bzr via these remote helpers and the installation of
python we use may need to be different?).  As long as the right
longer-term direction is not "we cannot fundamentally unify them",
then I am very happy.

I was worried that we might end up having to define random fine
gained knobs like PYTHON_FOR_HG_PATH to allow tuning these.

Thanks for a clarification.
