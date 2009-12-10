From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git archive formats and dashdash
Date: Thu, 10 Dec 2009 14:42:10 -0800
Message-ID: <7vws0u8n99.fsf@alter.siamese.dyndns.org>
References: <20091210212636.GA27722@Knoppix>
 <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
 <20091210222258.GQ4114@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIriN-0004lM-NB
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 23:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762017AbZLJWmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 17:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762003AbZLJWmP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 17:42:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761988AbZLJWmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 17:42:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60E69A514C;
	Thu, 10 Dec 2009 17:42:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GW0y4tQl4vFJL8hW1RP+D74E3Cs=; b=kf+1Eu
	E5rpzXWUkKy+YtGmJEydZ6ZDj7J2iWqbgCETvRLBzhqBXup8uc/RHiROYwQQD2QZ
	w06K1rhAX96kD075mASvjj4KWUMmzyt6kewqyb8+JGfz7ussgX8hwvpDcEIO710E
	EOESsahbERfyqLS+qIw3D7lqeHF0QO+gy3BrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OFvi74RTw3q/WF2sWTSs0tD64ZXhfp9T
	gdAxLsdGNZHPne//zn5/i7iGRa6KMeMzQOhGJgH+fBiVRd4PJQYC7doew2mIPES9
	nrFLf90dU17ThqTzhChBjGtGXURICBt8bFUXU2QK4u6YZhKA+npmAGsDBHRxr18q
	/FUI/r6WaHg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 327FAA514A;
	Thu, 10 Dec 2009 17:42:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B6CE6A5148; Thu, 10 Dec 2009
 17:42:12 -0500 (EST)
In-Reply-To: <20091210222258.GQ4114@genesis.frugalware.org> (Miklos Vajna's
 message of "Thu\, 10 Dec 2009 23\:22\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44BEC336-E5DD-11DE-8108-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135046>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Dec 10, 2009 at 02:05:39PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> Good catch.  Is this a regression between 1.6.5 and the current code?
>
> Ah, you version is much shorter. :)

More importantly it would avoid running "archive path --format=zip".

That may be reordered by the current parse-options implementation, and
other command line parsers (e.g. "git diff HEAD path --stat") may accept
command line in such an order, but I somehow find it utterly wrong.  We
should prepare ourselves for the (distant) day on which we start enforcing
"options then rev then paths" order from the command line.
