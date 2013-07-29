From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove deprecated OPTION_BOOLEAN
Date: Mon, 29 Jul 2013 11:11:28 -0700
Message-ID: <7v4nbd1bjj.fsf@alter.siamese.dyndns.org>
References: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com>
	<1375112281-3935-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3ruz-0005pt-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab3G2SLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:11:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab3G2SLc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:11:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9C6A340CC;
	Mon, 29 Jul 2013 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VkKSIF7sUECf5hj3q4sTxBKUiMc=; b=klL9z6
	jL2WNI76MjpYt5rStCB7/bUsnAGDSQNaGDYpTHz75a2ZXCBCUG4CFqSyC4YsRXHm
	9xKe4qb/j9PF1Wy9yHcBXwGXRFtV1zpAjAlAj3qFjAUuvrR55fkaFZpI9K7kdcc+
	iCugX7wEsSRoA7aAd9FAKo5AWqiq06XceQyUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rB0I8fOW/kcX666J5ODdy2bCDkdiMnFh
	Vr7m09I+LfxiFR2CktJOoCamt/lZ3Jx89DxU1P+JeJmUXUVBtEMxCGKeHIPGdUwB
	h1r+9Fui0uVsgc/LaApF1mED+WHjD3V5rDSSUrW/1JNIvrQncMhU61TO88R/IDa4
	5ieTBUI6ZtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE642340CB;
	Mon, 29 Jul 2013 18:11:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BC69340C9;
	Mon, 29 Jul 2013 18:11:30 +0000 (UTC)
In-Reply-To: <1375112281-3935-2-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Mon, 29 Jul 2013 17:38:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B3C4AF4-F87A-11E2-B376-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231313>

Stefan Beller <stefanbeller@googlemail.com> writes:

> As of b04ba2bb4 OPTION_BOOLEAN was deprecated.

The primary purpose of b04ba2bb (parse-options: deprecate
OPT_BOOLEAN, 2011-09-27) is to deprecate OPT_BOOLEAN(), which was
hard to use correctly.

OPT_BOOLEAN() is not touched at all with this patch, it seems.  Do
they want count-up semantics?

> This commit removes all occurrences of OPTION_BOOLEAN.
> In b04ba2bb4 Junio suggested to replace it with either
> OPTION_SET_INT or OPTION_COUNTUP instead. However a pattern, which
> occurred often with the OPTION_BOOLEAN was a hidden boolean parameter.
> So I defined OPT_HIDDEN_BOOL as an additional possible parse option
> in parse-options.h to make life easy.
>
> The OPT_HIDDEN_BOOL was used in checkout, clone, commit, show-ref.
> The only exception, where there was need to fiddle with OPTION_SET_INT
> was log and notes. However in these two files there is also a pattern,
> so we could think of introducing OPT_NONEG_BOOL.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

At first glance, it looked to me that OPT_HIDDEN_BOOL was a good
addition, given how often we have PARSE_OPT_HIDDEN.  While I think
some of the hidden ones are justified, I am not sure if the hiding
of many options are.  If we stop hiding many of them, HIDDEN_BOOL
may become not so useful.  I dunno.
