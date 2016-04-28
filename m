From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] git_connect: add some flexibility
Date: Thu, 28 Apr 2016 10:41:12 -0700
Message-ID: <xmqqbn4t637r.fsf@gitster.mtv.corp.google.com>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:41:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpwK-0003Hi-1D
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcD1RlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:41:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752693AbcD1RlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:41:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A485A145DC;
	Thu, 28 Apr 2016 13:41:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yFshN9pHHu2qA+IBTUc8ugokcPo=; b=UM1FY5
	mT1QnI41YxHObWvH4TvS2qLFyy8jLzVejnXJT9tlkII+8ukKMQm44SPcuNCkfD1E
	38vGFfv+c0wauLqauCkS/+n7M2z+TqBP+XJDFadV5aie8cX1FG/n2WxjBaMz85PI
	u2S5Eb/SAUoRijHD0ZpDgWi63TZcTTM0lZYoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ce0cOXzcS21Kj7Y87ijFXZv0G2rNvZos
	vQiG3ndtytvUGrecFajEHOLXe381WQPprDArrgP/ljYQiprYCA9EfP3bVSjg7MtX
	b6Bu28O9dfRl8/4fhR9AjRKw2Y6bjMF/th0RG0cX5z7mBpSYUrSuwZXV6A7/UQvG
	NF0fA4Kgaj0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CF0F145DB;
	Thu, 28 Apr 2016 13:41:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE096145DA;
	Thu, 28 Apr 2016 13:41:13 -0400 (EDT)
In-Reply-To: <1461852759-28429-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Thu, 28 Apr 2016 23:12:35 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6728F504-0D68-11E6-B4A9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292927>

Mike Hommey <mh@glandium.org> writes:

> As you may be aware, I'm working on a git remote helper to access
> mercurial repositories (https://github.com/glandium/git-cinnabar/).
>
> At the moment, a small part is written in C, relying on the git code
> base, but eventually, there would be more C.
>
> As I want to get rid of the dependency on Mercurial itself, I'm planning
> to implement the wire protocol parts in git-cinnabar.

While all of the above sounds like a good thing to do, what I do not
understand is why you need to even touch git_connect() at all, and
we certainly do *not* want you to touch it to make its external
interface unnecessarily ugly and complex with features that are only
necessary if it needs to talk to non-git services.

In other words, why can't this cinnabar thing live on the other side
of transport API, just like Git transport itself does not know about
cURL and HTTP when talking with https:// repositories?
