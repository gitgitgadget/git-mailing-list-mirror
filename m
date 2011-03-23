From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diffcore-rename: fall back to -C when -C -C busts
 the rename limit
Date: Wed, 23 Mar 2011 09:41:19 -0700
Message-ID: <7vfwqdg574.fsf@alter.siamese.dyndns.org>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
 <1300830649-22830-1-git-send-email-gitster@pobox.com>
 <1300830649-22830-3-git-send-email-gitster@pobox.com>
 <20110323155854.GB30337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:41:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2R7r-0003rS-4A
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab1CWQld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 12:41:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab1CWQlc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 12:41:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7AE533FF2;
	Wed, 23 Mar 2011 12:43:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+AkJNPWvsQpGKOkG2ZZGDnbKoz8=; b=aF/GxM
	QwdUOT1fFFMva7ky/Hd0yNcegn7oUwUZEItv/I9QuzUBEJYPA8fFbhzVG+JSSmAb
	/uccPS8JxahUdOp9v/oxgB2tGSl9NzOA3P/ja/Nmk1cR7VUPwB2Z9PXT/bpBMtJR
	oTigGutuWckoFwXqw53Wl6+/0Ecke20rdiq70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=imhX9qm31KNtAQaMHUPhoe7AiKxTg+Zz
	DKH558HIo00MXQ1d4AUl3a4ZMm5HymAvJXfvam4jA2LDWI5nq/WvCr+BR1rQ00+u
	2TfEg/ck2+v+4T+CnNlUDnLXfC90x+05D+mnKgBnPNmxXRawosSngT1NJGZ5p8L7
	JqW71sdMthg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A88B3FEB;
	Wed, 23 Mar 2011 12:43:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 57D963FE8; Wed, 23 Mar 2011
 12:43:02 -0400 (EDT)
In-Reply-To: <20110323155854.GB30337@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Mar 2011 11:58:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A18585F0-556C-11E0-AB8C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169851>

Jeff King <peff@peff.net> writes:

> "find the highest limit needed and report once" strategy you used above?

Wasn't "find the highest limit" your invention in merge-recursive?  The
only deliberate fix in merge-recursive codepath on top of what you did is
to allow squelching the warning when verbosity is set to more quiet than
the default, and removal of the "set var to this value" advice when the
value we are going to suggest is too high already and will not help.

As to the warnings in "log" output, I actually prefer leaving saved_* out
and showing the warning per internal diff invocation. My initial iteration
was indeed coded that way, and I did the "find the highest" only to mimic
what was already in merge-recursive.
