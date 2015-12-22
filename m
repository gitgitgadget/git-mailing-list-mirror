From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 11:09:26 -0800
Message-ID: <xmqq1taee1w9.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
	<56796F37.1000600@alum.mit.edu>
	<CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
	<567985A8.2020301@alum.mit.edu>
	<CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 20:09:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBSJT-0002bK-8S
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 20:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbbLVTJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 14:09:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751723AbbLVTJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 14:09:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CE013578F;
	Tue, 22 Dec 2015 14:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vVjAT0ybcHy7NYaUW9S50WX3VaY=; b=pev/Pj
	5fuFfGfTXAlOr/m10XqpOX39ztzTlEo1HFDySB88TJE/NJ+zr0xntZf2GXf7yTUs
	NdBxHOH9eR0tn9fGInT2hRGCYvVWbB9EXJE3soZoWKy27zeSwMg5cy3XwYI2f3Tj
	qs7vptI+SkUhxW6IoYTkv0YJJdEZaMVuff7wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dy0aJXs42hbSxvqkwmNEZF3RjHsB6FK/
	2S2ccDPCSwp7iEDEw7pzb0+ufCvItjdbCMUNCQu2RPtp4PQThXzaN0Xu9NYYMMqA
	pNP83Ko0XOwcSbeJrF5v4Rxjynxi/2HdBWfl1ZScjlSd040zZ2XlzDgZ9L6pKYNq
	ZQaSJeFSKNA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 73D7B3578D;
	Tue, 22 Dec 2015 14:09:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D5AD03578C;
	Tue, 22 Dec 2015 14:09:27 -0500 (EST)
In-Reply-To: <CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 22 Dec 2015 10:50:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 85BC4D7E-A8DF-11E5-BA45-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282900>

Shawn Pearce <spearce@spearce.org> writes:

>> But really, aside from slightly helping
>> disambiguate references from paths in the command line, what is it good
>> for?
>
> Nothing really; today refs/ prefix is used to encourage to the tools
> that you really meant refs/heads/master and not
> refs/heads/heads/master or some other crazy construct. You can thank
> the DWIMery inside the ref rev parse logic for needing this.

Aren't you two forgetting one minor thing, though?

A layout without refs/, i.e. $GIT_DIR/{heads,tags,...}, will force
us to keep track of where the tips of histories are anchored for
reachability purposes, every time you would add a new hierarchy
(e.g. $GIT_DIR/changes)--and those unfortunate souls who run a
slightly older version of Git that is unaware of 'changes' hierarchy
would weep after running "git gc", no?
