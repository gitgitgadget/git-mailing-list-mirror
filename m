From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] notes: preserve object type given by "add -C"
Date: Fri, 11 May 2012 14:16:41 -0700
Message-ID: <7vzk9eju4m.fsf@alter.siamese.dyndns.org>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
 <1336699506-28388-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 23:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSxCk-0003dL-9D
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 23:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945948Ab2EKVQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 May 2012 17:16:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933263Ab2EKVQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2012 17:16:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06467E0F;
	Fri, 11 May 2012 17:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nnBK98hbCnRh
	/4jncPNjmMQkICo=; b=mWnlQC5LfbOJVQtPrT/exTkfz3irci4iWmzhWrIhMjZl
	SPGfl0ef4+zKsHHzo02WVscKtJqs1NRRCLgke+Lv1ZzEx6zBLA21RMv8PrsCKA0m
	TMSzUnZL+uhp+2sQMdbyPzIOMUrBh1hH1jPT0SwQ0ZdyVkh5J1LRnvSJ2KE2R20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eSp0vN
	eM5jEqO8v3nRFhs8M8Vq/6pqy7D407/qO/z0fXLox6D2NNzhg5Tym5eFVGOFR8XT
	qUJZVabvXiiRDwGDmQKrOVB5dt67ZoLjcf+0+RSKeUhGuMjKiP+O/5cIFq/T1TZc
	x7U3mRtaA4gCbsM8VbsEEUB/v0AEa5OWMgVbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B8F7E0E;
	Fri, 11 May 2012 17:16:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F8207E0D; Fri, 11 May 2012
 17:16:43 -0400 (EDT)
In-Reply-To: <1336699506-28388-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 11 May
 2012 08:25:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B8B0E70-9BAE-11E1-99AC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197698>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> _Automatically_ converting a non-blob object to a blob is
> wrong. Either this way, or reject non-blob objects upfront.

But wouldn't it be even _more_ wrong to stuff a non-blob object at the
leaf level of the notes tree?

It is not automatically "converting"; as far as the notes subsystem is
concerned, the data you throw at it to be associated with an object the
note annotates has always been uninterpreted stream of bytes.  If an
application wants to store the raw representation of a commit object
including the log message and its header, it has every right to expect
that it can use "git cat-file commit $argument_to_the_C_option" as the
source of that uninterpreted stream of bytes, doesn't it?
