From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rewrite `git_default_config()` using config-set API functions
Date: Mon, 21 Jul 2014 11:07:17 -0700
Message-ID: <xmqqa982k2lm.fsf@gitster.dls.corp.google.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<53CCFD02.6010704@gmail.com> <vpqha2addyn.fsf@anie.imag.fr>
	<53CD2273.3000600@gmail.com> <vpqzjg2204x.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Hzl-0005g3-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 20:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933319AbaGUSH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 14:07:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51576 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbaGUSHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 14:07:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3932E2B3EA;
	Mon, 21 Jul 2014 14:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4iBhe3cfWG4R6AKMCF20wlHsXy0=; b=hhiKrO
	3R2fr2a8+bNdLboNMeJ7fdS1P9RuJ57ncCkXkJweIxYxsbxKJxT3NyoAPSdzQ8DP
	05S0IAFLxYwhSjfrqf7ZLu3rtmNc7PpWFL6rh83ur6uB1/P8g7t32NN7MxGJPovs
	Z/2evC+6m5WycTAsJEelbKVy/uezt96fPYESY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rczMx+l0pZ9xtDjLLEjPoGVECnWHh8tk
	fKkf8GkCIp2s8cCxh4Swt+sA2PWibFNZxJH2wn5qYZyypNNuJCQ412gXOZ4IS7BO
	XotDF/te4p1QPc6SaWJab0t+4/f+av5vQSG2XvJ5FyYlZ9IrqO4tKS10+ft/WeEw
	bRhGRg+Apdk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BD8B2B3E9;
	Mon, 21 Jul 2014 14:07:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F5332B3E4;
	Mon, 21 Jul 2014 14:07:19 -0400 (EDT)
In-Reply-To: <vpqzjg2204x.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	21 Jul 2014 17:37:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAE01D48-1101-11E4-ACB1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253985>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> In general, most strings one manipulates are "const char *", it's
> frequent to modify a pointer to a string, but rather rare to modify the
> string itself.

We seem to have a disagreement.  Unlike git_config_get_value() that
lets callers peek the only cached copy, git_config_get_string()
gives its caller a new copy that the caller needs to free.  Such a
new string can and should be given as mutable, I would say.
