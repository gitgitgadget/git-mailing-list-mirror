From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 12:56:24 -0700
Message-ID: <xmqqwq8ui00n.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
	<5421CAA6.3040107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 21:56:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWCO-0004kI-0l
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 21:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680AbaIWT42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 15:56:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58120 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038AbaIWT41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 15:56:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6184D3A210;
	Tue, 23 Sep 2014 15:56:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JR/EmKz0Q6GPyrYDH0UyTFPYjbY=; b=drfJZd
	Jpcpt48Dx8bqaXRlPOai9kdxEfKJt5G+DJSQZUC6k33IwBa0CPq0/hXvFvFJ15Gl
	4EDco+7FnvNOGzooeiWDP+dL5zmnFggbpliUeGHajEydBr8gLzbn22n++NVUcQLB
	PRCa8HpQsJjghYSCvfOr2TR5TST2MkTijAEA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=poAmmcVht3K84R7Dkif11NUdkJ3g0wbO
	Pu8tyfujx+XwrySCT0Yga06ksdUem6t5p7bOn1HbnVTUp0d24bSx37GvKHFzWEiq
	rg6oVXZykBREnqop1WFQqHwDHz2hsaezdLcYvYJeyhqGK8WsScPkRiUdxj+fIqi0
	BUco3a7kQK4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 563973A20F;
	Tue, 23 Sep 2014 15:56:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C46D83A20E;
	Tue, 23 Sep 2014 15:56:25 -0400 (EDT)
In-Reply-To: <5421CAA6.3040107@redhat.com> (Laszlo Ersek's message of "Tue, 23
	Sep 2014 21:31:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B35B2574-435B-11E4-BB31-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257435>

Laszlo Ersek <lersek@redhat.com> writes:

> What do you think about accepting only "/dev/null\n" and "/dev/null\r\n"?

I thought we agreed that what you are doing is not workable in the
first place, no?

I suspect one way to handle "In this project, the files that are
checked out must be with CRLF line endings no matter what the
platform is" might be to use the line ending attributes to force
that while keeping the in-repository data with LF line endings.  The
diff output (format-patch output is just one of them) comes from
comparing the in-repository representation, so you won't have \r\n
that will be stripped via MTA in it, "apply" and "am" will apply the
patch without having to worry about \r\n, _and_ the line ending
attributes would end the lines in your in-working-tree files with
CRLF that way.
