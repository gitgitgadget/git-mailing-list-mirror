From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 04 Apr 2012 11:44:36 -0700
Message-ID: <7vpqbn8hgr.fsf@alter.siamese.dyndns.org>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <CACsJy8A+cJtzKdqJSWbmjT1LgP10LB69-NHfOv8S6BusGcMeFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFVCG-0002xx-8s
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 20:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab2DDSoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 14:44:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261Ab2DDSoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 14:44:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E5887D92;
	Wed,  4 Apr 2012 14:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B4bsj1MkNaRwDYmO/yqe0GivUF4=; b=AtamkC
	2oKq+M4Eln+Ea64lfhVHyXLbbyUQFQBIlL4YwNMn3Aia9LWGguCcFOmly8l2Chn0
	Jto6hrTxNycBY4VIoE9ZizRMOgB+5hoRdpIGOUmFknjg1QshsvjKwlDdVgLB2gvF
	ciKm5WU+d3OoGSMvbVBDynxk0b0hUvnfhDwys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sQfU2YfnUVrecijp+trWrcD3pddgjG11
	NPXvn28wBZrAPybtuuVmzr0XMiptC0uigAWzX5+cu7XrG+4lqGySpKixjRt51qnj
	sjL190hMVoe4hjgyZl4r0qHLRRMaDIL4XPV2sk0PnWHWNoTQcpwt+AruE80BIteD
	RWsxCKcyAbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 358AB7D91;
	Wed,  4 Apr 2012 14:44:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D7FA7D8D; Wed,  4 Apr 2012
 14:44:37 -0400 (EDT)
In-Reply-To: <CACsJy8A+cJtzKdqJSWbmjT1LgP10LB69-NHfOv8S6BusGcMeFw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 4 Apr 2012 19:34:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AD9E55A-7E86-11E1-A401-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194719>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Apr 4, 2012 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> I wonder what causes user time drop from .29s to .13s here. I think
> the main patch should increase computation, even only slightly, not
> less.

The main patch reduced the amount of the data needs to be sent to the
machinery to checksum and write to disk by about 45%, saving both I/O
and computation.

This is a tangent, but I wonder why we are not using csum-file API to do
this (I know the dircache code came first way before csum-file; I am
wondering why we haven't rewritten the codepath using it later).

> Anything else you have in mind for v4? Any chance we can adopt crc32
> instead of sha-1?

I am not interested in sacrificing integrity over unproven/unmeasured
performance "issues" on SHA-1, so I am not planning to experiment with
such a change myself.  The choice of hashing algorithm from my point of
view is the least interesting part.
