From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 10:15:39 -0700
Message-ID: <7vhak6f0w4.fsf@alter.siamese.dyndns.org>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <20130320164806.GA10752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, spearce@spearce.org,
	git@vger.kernel.org, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMcV-0003W9-8g
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab3CTRPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:15:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab3CTRPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:15:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB31CAEC3;
	Wed, 20 Mar 2013 13:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6l9GJELv/2x2KIK8Avwgb8pFHNk=; b=tCXovI
	oBe0FY7UKys9bpNTlZVVBHvLmbVG+EbGz9bT1hSYzx434iMjfW6M7TXlEIVh5zNk
	Nn6bqk79ehfiNUJ4cOKJswYA/iHoMREmNLgOtZ2iZYEkkNbuGT3u9x72dh/BqX+a
	gpt0BiOTEXiXfQqeUM9M++ZlpyuHxvxGkLKcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGCZoudbN+HFpuMFq4it5xjK+Cn3R3BO
	HqE+S3bLDxYby+QucJX9UKF2hyENP3sPkqsiTS+rkW4r7kW7u0loLpVGI8NKL4B9
	RzhnMIURS2MgxCIf52mXSNDOs/GALLLV4zkBQ2urDWQ8xT44j0Q1ZzQ5Yzr5Ups5
	R5oyeVweNYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B073EAEC2;
	Wed, 20 Mar 2013 13:15:41 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4D65AEBE; Wed, 20 Mar 2013
 13:15:40 -0400 (EDT)
In-Reply-To: <20130320164806.GA10752@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Mar 2013 12:48:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA813686-9181-11E2-BC33-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218623>

Jeff King <peff@peff.net> writes:

> So maybe just run "git status >/dev/null"?

In the background?  How often would it run?  I do not think a single
lockfile solves anything.  It may prevent simultaneous runs of two
such "prime the well" processes, but the same user may be working in
two separate repositories.

I do not see anything that prevents it from running in the same
repository over and over again, either.  "prompt" is a bad place to
do this kind of thing.
