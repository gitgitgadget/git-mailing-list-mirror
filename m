From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git pull doesn't get the tags
Date: Fri, 22 Oct 2010 14:33:52 -0700
Message-ID: <7vhbgdlxof.fsf@alter.siamese.dyndns.org>
References: <20101022053747.a5427cad.coolzone@it.dk>
 <4CC153A0.7080605@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rico Secada <coolzone@it.dk>, Mathias Lafeldt <misfire@debugon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 23:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9PFc-0002aY-N4
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0JVVeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:34:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0JVVeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36F0ADFD13;
	Fri, 22 Oct 2010 17:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ym5/S9+PyJtcqw+7Vms0o7K+52E=; b=yIiGzb
	A8hEqEMRnxp9hRgxta+eIMxhbv1syf3/DcvCbcYe3AGYhnugiQhenr1jDeHlvQYF
	T868kV/AkM6GCLEseT3JJXJ3+wtWEmXLOJiyEgF3lIv/BhQqqZBbtXVPblOtSnz2
	Jpgxz1zfACDWW0T/hhLTcY58nfknQzQMNxX8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UAXVpVsgGH5j3WiSy5PIoZZfuMZma9F/
	1soJMyyK7teIUoN+BychK4Ft8k9oGJR0b04JxUM6XUvGymoYLHACXB8Y+wawjIV+
	LeciqjRyRo5F8D0ec71JM0WgE8dP+/xyVVeg5N9OILxgy7Ms/gZ5FQtYOph1k44l
	xzRIp56r3Cg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02A7EDFD12;
	Fri, 22 Oct 2010 17:33:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35C73DFD06; Fri, 22 Oct
 2010 17:33:55 -0400 (EDT)
In-Reply-To: <4CC153A0.7080605@debugon.org> (Mathias Lafeldt's message of
 "Fri\, 22 Oct 2010 11\:04\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1493DEFE-DE24-11DF-A448-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159753>

Mathias Lafeldt <misfire@debugon.org> writes:

> Try git pull --tags.
>
> From git-pull's manpage:
>
> -t
> --tags
>         Most of the tags are fetched automatically as branch
>         heads are downloaded, but tags that do not point at
>         objects reachable from the branch heads that are being
>         tracked will not be fetched by this mechanism.  This
>         flag lets all tags and their associated objects be
>         downloaded. [...]

Can somebody submit a patch to stop this part of "fetch-options.txt" from
getting included in "git pull" manpage please, by the way?

This is one of the options that are passed to the underlying "git fetch"
without sanitizing by "git pull".  "Fetch all tags and merge them" does
not make any sense as a request at the logical level, even though it might
be more convenient to type.

I do not recall offhand if we made sure the stuff fetched with --tags
request are marked as not-for-merge, and if we didn't that is certainly a
bug.
