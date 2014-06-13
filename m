From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 10:42:26 -0700
Message-ID: <xmqqtx7o3dvh.fsf@gitster.dls.corp.google.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
	<1402601942-45553-4-git-send-email-caleb@calebthompson.io>
	<20140613065942.GB7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Mike Burns <mike@mike-burns.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVVG-0006y9-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbaFMRm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:42:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58287 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbaFMRm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 782301FFE0;
	Fri, 13 Jun 2014 13:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rLwatD4/hxX07C4lpoQki4hTS6A=; b=ePCNjV
	GMqZQQZ9jg+TepXgOx/2QjB3vg19KgVnmVclRXS2bp+i2sUV7mMVAWz/B0FTalE4
	a3qM8UEAdAXKgvr76GVgtoOkmbaHjQTqd93/aeip/rQ93UqRtGg9u4A1/5xRtUx+
	O2FVKMq4M374Bex8DPAMcRWTxU5m7pzedbrV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9PZJoGZKZve40jKMqXRy++A6HKE4nn1
	FN61JhVVrZm1NE1QDDz6k/nMkhikFc+IWYw6jT/NTf1fAAQFwYiWEYBaKORY6y5m
	pGWGQhaZcK864K6NVW93E4JDDT95b+CSBpGCJJkoLAZKrJVLciEz/NR3YoH2TSJQ
	KyeVc1ff/xU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DCF81FFDE;
	Fri, 13 Jun 2014 13:42:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B55691FF4D;
	Fri, 13 Jun 2014 13:42:27 -0400 (EDT)
In-Reply-To: <20140613065942.GB7908@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jun 2014 02:59:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16349930-F322-11E3-B28E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251620>

Jeff King <peff@peff.net> writes:

> [1] It might make sense for test_set_editor, when run from within a
>     test, to behave more like test_config, and do:
>
>       test_when_finished '
>         sane_unset FAKE_EDITOR &&
>         sane_unset EDITOR
>       '
>
>     I don't know if there would be fallouts with other test scripts,
>     though.

The default environment for tests is to set EDITOR=: to avoid
accidentally triggering interactive cruft and interfering with
automated tests, I thought.

If the above sane-unset is changed to EDITOR=: then I think that is
probably sensible.
