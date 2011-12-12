From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/51] is_dup_ref(): extract function from
 sort_ref_array()
Date: Mon, 12 Dec 2011 09:14:34 -0800
Message-ID: <7vaa6x67b9.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu>
 <20111212083345.GA16106@sigill.intra.peff.net>
 <4EE5E918.8090104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 12 18:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra9Sd-0000VV-5a
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 18:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1LLROi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 12:14:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab1LLROh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 12:14:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF72460D7;
	Mon, 12 Dec 2011 12:14:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=csQDydO3qigqQGYQ9bt3UaTuZXg=; b=jtwen4
	7jvMdTIncw6iD18urbbU9g6eYTKxoO9E7Bg8eWUD8ALgsvnDGLk80BzgMrqrzByg
	a9OUI8jzoo09qQAkz1G5prjgGauG4JJ4wJpnFt66phKx3/vJvsGLoNzwGkxerOVR
	bW89btJ71BQQ9SG4gvpx1KKi6YuLQRcjGYOfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dqDNtzJXiW6NYSvLDB+itiZPUGOrvnL0
	NoLCttQ6+18xRBqgEFbXU0Tt7SxwOBCb83rlXZeNNk6zIf+NdQ/x6GurEZfz3YfX
	jA/e0D6g4rgF+72zanpiXiKidXfXxM99HhONTZn0LsdaovsS4vMs1POrBtUFG3P0
	cRJ9TRVC8iE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0DCD60D6;
	Mon, 12 Dec 2011 12:14:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D28ED60D3; Mon, 12 Dec 2011
 12:14:35 -0500 (EST)
In-Reply-To: <4EE5E918.8090104@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 12 Dec 2011 12:44:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C416E3E6-24E4-11E1-8611-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186918>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Extra refs are created locally by other git code that I am not familiar
> with, so duplicate extra refs could only be created by a bug in git.

I think we already discussed this, but just in case you forgot.  They are
used to tell git to treat as if objects in histories leading to certain
commits are complete and available, i.e. only their object names matter
and the refname field is primarily for debugging. It would be a grave
regression if you errored out seeing duplicate names in them.
