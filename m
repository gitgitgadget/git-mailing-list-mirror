From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Mon, 08 Oct 2012 08:50:03 -0700
Message-ID: <7v391pnetw.fsf@alter.siamese.dyndns.org>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com>
 <7vy5jku549.fsf@alter.siamese.dyndns.org>
 <CACsJy8DhymVp1ncHvtqd4S7TkBDQvNKBf3A0JTft9bX8_-WX_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 17:50:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLFb8-0003u0-4u
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 17:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab2JHPuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 11:50:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab2JHPuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 11:50:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E8CB879D;
	Mon,  8 Oct 2012 11:50:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zdHOo++pyiO5JQPl8HJz7Qh23l4=; b=cxUQPz
	V91IYg4jKT3W7Wf7qmRry5uXwtuxTPSjLxcPDAG+O0nPpTn8UeMSGRIMf5IWDyHv
	W063y+oZsxKra3S5KfmZMoZQB4MMzLq6KGuNVTigJ/KkYBx8RXyeUydXk5wqj1bx
	ft7S1buwGFE5Hd2p5bWEjhjNyKYFm5xqylZDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+HNBkfThQuG1lImIHTGYUDyNIuw8smY
	Hkf+kO0eulbwz7+9TRO6iMkrHXHjbm15EbHzURCfYagDL88qV4PnWKtd+F8Ms4vF
	Xysh88GeqjBaXWiZReuoVO//ZUtir1LBOAG8bE+j28m40eKMT4sdYBKDmcgVamgf
	eT68vdXYJgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C0DE879C;
	Mon,  8 Oct 2012 11:50:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74C72879B; Mon,  8 Oct 2012
 11:50:05 -0400 (EDT)
In-Reply-To: <CACsJy8DhymVp1ncHvtqd4S7TkBDQvNKBf3A0JTft9bX8_-WX_w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 8 Oct 2012 10:26:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D44AA668-115F-11E2-85A6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207233>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> My objection is no-op lines are timed bombs. But users can already do
> "dir attr" (no slashes), which is no-op. So yeah, no-op is fine.

Exactly. If you are not catching and barfing the no-slashed variant
at the syntax level (and you shouldn't), you shouldn't do so for
slashed ones.
