From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] clone: fix refspec on "--single-branch" option
Date: Fri, 14 Sep 2012 12:22:29 -0700
Message-ID: <7vd31o4dfu.fsf@alter.siamese.dyndns.org>
References: <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
 <1347646267-25891-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 21:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCbTN-0003kQ-Fw
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 21:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759945Ab2INTWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 15:22:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759886Ab2INTWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 15:22:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 507EE9592;
	Fri, 14 Sep 2012 15:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pIVA7LIOS8ucMZQqPdsjd74VFoU=; b=SQKGqO
	lgjuznbrKcH300STA+XaQ+bEF9GdVbuRmT54ATFVduMKJjLg/uz2qvwp6XyQhWog
	b2w9+sqT91Kc5bhVpRl87jgDYnFIP/JYtz5Pb7/jRbc2XSjV2CMWh6peSQ9sq2we
	jR/17EQ/Hh96bvvyC9xkczWJTJi97xBzcVz5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LIFhh34IZlHMlS1rYrqjHMx2JHY//0nu
	WQQPe3t6yQUnYwcZXDSBIS7nfO/EnEQ+1dw7ux1p/bNC9CI7bnC4PzH0JYTANor5
	OMWiXW79YoH6P/5r+mT+8zc6aF+nAiB0GLwY1v38ilSvvKfeY/+TvAM5kGWrSGc+
	Za29oWjZYVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DE8E9591;
	Fri, 14 Sep 2012 15:22:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABC259590; Fri, 14 Sep 2012
 15:22:30 -0400 (EDT)
In-Reply-To: <1347646267-25891-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Fri, 14 Sep 2012 20:11:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8711D70C-FEA1-11E1-B2A4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205527>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> +			else if (remote_head_points_at)
> +					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
> +									branch_top.buf, prettify_refname(remote_head_points_at->name));

As refspec maps names that appear on the source side to names that
appear on the destination side, and for fetch, the "soruce side"
is the remote, using "our_head_points_at" on the source side makes
it look very fishy (even though it may be a name derived from
remote_head_points_at and has the correct and appropriate value).

"prettify" also is very questionable.  It is meant to strip commonly
known prefix to make it easier to read by humans, and we can change
its result based solely on aesthetics in the future.  It is not
suitable for coming up with a value for configuration in the longer
term.

Can we make the part you moved de-dented a bit, perhaps by making it
into a small helper function or something?  It is extremely hard to
read with overly looooooong lines.
