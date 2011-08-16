From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff/xprepare: improve O(n*m) performance in
 xdl_cleanup_records()
Date: Tue, 16 Aug 2011 10:39:25 -0700
Message-ID: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
References: <loom.20110809T093124-847@post.gmane.org>
 <1313464312-5132-1-git-send-email-rctay89@gmail.com>
 <20110816113710.000025a7@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Marat Radchenko <marat@slonopotamus.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 19:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtNbx-0000qq-FF
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 19:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab1HPRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 13:39:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab1HPRj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 13:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CED4772;
	Tue, 16 Aug 2011 13:39:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6uIMZfhrpxBagbn2n2dyjJwK12k=; b=IG8L7W
	Pw3R7nxOsdNmb7rYTA7nLcytZRrblpZ0BSPCA1/Ju54kxgrrL6GwimByM5hQKKcq
	0DzgN3Aiq1t+QmvR/mXib9SR7NYfvZGb46nd0cLFnxvO1uWVa4UH4xgfEEDhZd/4
	MYuLEu8TF3zbNcZhkymdpoJAyYTPMk4KkZB2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QkqHazcj35L7cfgos83sPnlQ/7mdAnpq
	WslhOFxerbT3lwJ6ZGmfh2iux4qAhQ5+2QxG+xPRQxeCdoy50c+AYAJ+zdorMZRO
	at/lac40YLfHDyxPWeoeK0PPrjeVTltjEQFP6tEnQikfK79ptE2CtSTwQ4cdD5pi
	4JOFl3s/qNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FB2C4771;
	Tue, 16 Aug 2011 13:39:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1690476F; Tue, 16 Aug 2011
 13:39:26 -0400 (EDT)
In-Reply-To: <20110816113710.000025a7@unknown> (Tay Ray Chuan's message of
 "Tue, 16 Aug 2011 11:37:10 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B01F1C2C-C82E-11E0-B3ED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179461>

Tay Ray Chuan <rctay89@gmail.com> writes:

> From 0da9ec94604978f877e7f7c00d307b5cdbb22b29 Mon Sep 17 00:00:00 2001
> From: Tay Ray Chuan <rctay89@gmail.com>
> Date: Tue, 16 Aug 2011 11:35:28 +0800
> Subject: [PATCH] xdiff/xprepare: improve O(n*m) performance in
>  xdl_cleanup_records()

You do not need these four lines. Thanks.

> In xdl_cleanup_records(), we see O(n*m) performance, where n is the
> number of records from xdf->dstart to xdf->dend, and m is the size of a
> bucket in xdf->rhash (<= by mlim).
>
> Here, we improve this to O(n) by pre-computing nm (in rcrec->len(1|2))
> in xdl_classify_record().

Could we have some benchmarks to let the readers get a feel of how much
improvement this patch brings in?

This tries to trade cycles with memory, right? How much bloat are we
talking about here?
