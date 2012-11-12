From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-sh-setup: refactor ident-parsing functions
Date: Mon, 12 Nov 2012 12:32:26 -0800
Message-ID: <7vr4nyh89x.fsf@alter.siamese.dyndns.org>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072522.GA9999@sigill.intra.peff.net>
 <7vpq3ik97i.fsf@alter.siamese.dyndns.org>
 <20121112194434.GB4623@sigill.intra.peff.net>
 <7vzk2mh9dm.fsf@alter.siamese.dyndns.org>
 <20121112201235.GA7210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:32:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0gV-0004tU-Au
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab2KLUca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:32:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab2KLUc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:32:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6945A314;
	Mon, 12 Nov 2012 15:32:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9/K2pYIZZ9HTZw93K7Rk/Wd33aY=; b=lpWwG9
	xr/VJSKvFRwZHkD5BVNCrDDQpnc/Q0DX0FafI3QOd6+vdIERIR7lYTjvktmDgoPN
	umjv88MsfK8v7naNKXJJD4OGtuBgk8Lxo3io43U0WQUt/MB/albcvGF1pnIK8W4p
	uoaipzEWPOTySa1q0Ikj8D+uJxN9lik93QVRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RRVjwf32rh7XJ/b5K4jaPkBLwxC3soPZ
	QFH9JXYjQX3eOdq1yWTKZMRDtCF0lD/gpzmBSy7L16TbrrbaGDUlqIVpK2GgGqzl
	CLodAkIAGqoWxciKUpkYuIjVLfyL2QweMBM0IJQVPAJUZBXJ+tD6DcEG4vFfxmI8
	wZ/WSCv/g58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A77A313;
	Mon, 12 Nov 2012 15:32:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4688DA311; Mon, 12 Nov 2012
 15:32:28 -0500 (EST)
In-Reply-To: <20121112201235.GA7210@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 15:12:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1365E998-2D08-11E2-B6B6-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209521>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 12, 2012 at 12:08:37PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Changing the interface for get_author_ident_from_commit would be a pain,
>> > but if we just wanted to help filter-branch, we could do something like
>> > this:
>> 
>> Yes, that is the direction I was alluding to.
>> 
>> Callers of get_author_ident_from_commit can also do the same and
>> avoid rebuilding the same $pick_author_script over and over again,
>> or get_author_ident_from_commit can do so for its callers.
>
> I don't think get_author_ident_from_commit can do so on demand due to
> the subshell issue I mentioned.

OK, that is what I obviously missed.

> I wonder if we should simply generate these at build time and store them
> in the script.

Yeah, my knee-jerk reaction was that it was wasteful to run script
at runtime to build a constant string, but the engineering cost may
not be worth it.
