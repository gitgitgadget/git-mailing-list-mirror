From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 08:50:55 -0700
Message-ID: <7v62882srk.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
 <7v393d49xs.fsf@alter.siamese.dyndns.org>
 <7vy5l52ueg.fsf@alter.siamese.dyndns.org> <87sjbceiu9.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wAx-0006vY-6K
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 17:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759663Ab2HXPvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 11:51:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759653Ab2HXPu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 11:50:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04F6385E2;
	Fri, 24 Aug 2012 11:50:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i+effkVarshG4A6wONOxk8YJS4g=; b=B/yKmO
	Dsxp9aJXKdU1adsqIFus/vEMzJ4wvTjVdI8zvQUYQ7JI9oKIGRt9IupAY7ldaoO8
	uGxDyyi/yfY4QbS8Ef2ucixbNYQprtacrdJP4iPCs8H/zAmMdEm5j61hGdHjEWA8
	NzJsA3x/VbSvyGCbRxy1xjaHI2l02fxjwvgwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qGQrBdkbeVLdhGZev86GUTa8k06H1m1m
	D2slMjoY6DO3uIapy3JicCxARwQsIlIR9bIcAhqsHmYxoQD0EYEKgqubwsqpDL4V
	1ApQRm4+fgzodt+Ep3FR8CiDIhihAZbWuayzBUgHPOED79j0w3inyA3EQxUWsoKf
	RY5bHUaIOrc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5E4385E1;
	Fri, 24 Aug 2012 11:50:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63F4C85E0; Fri, 24 Aug 2012
 11:50:57 -0400 (EDT)
In-Reply-To: <87sjbceiu9.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 24 Aug 2012 11:32:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E9A3C76-EE03-11E1-B9F8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204215>

Thomas Rast <trast@student.ethz.ch> writes:

> Well, yeah, you snipped this part from my original post :-)
>
> } Even if this turns out to be flawed, we should also identify uses of
> } in_merge_bases() where the real question was is_descendant_of() [I
> } somewhat suspect that's all of them], and then replace is_descendant_of
> } with a much cheaper lookup.  This can be as simple as propagating a mark
> } from the candidate until it either goes beyond all possible ancestors,
> } or hits one of them.

Yeah, I agree with the above, and the "cheaper lookup" would
probably be merge-bases-many() without postprocess.
