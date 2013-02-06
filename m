From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/4] cat-file: do not die on --textconv without
 textconv filters
Date: Wed, 06 Feb 2013 14:23:36 -0800
Message-ID: <7vvca59j4n.fsf@alter.siamese.dyndns.org>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net> <20130206221912.GD27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DPc-0003RP-LF
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab3BFWXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:23:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab3BFWXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:23:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E0A4B374;
	Wed,  6 Feb 2013 17:23:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTKG59U09BbUZrIBCXU+x7Z23uI=; b=oPMy6z
	JGX5EiKeFoZGxHZx3661AbZWaTBRaNBRXwWGcDvNWWTnQR1GHH1VnzhWAOzdrBdi
	3lwjXLfZNUNAgNuaAztA6dtHrxDlTC4DtswMK2ZCC6jmUqz1pV11C0XIixc0AU34
	qWyo6lyc97Ftq+wH7auqSgWTwOfwiAFp3eqKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gopt1vvidK6a+t9qHiVwnpcas9jmgP6U
	4NA0VYW5FWiypYiCKlm/VZ5dY6+36MsiVJN6enhPw7xhxVczaeXDDgZM375Ck+Kn
	MVpiOr8TCpy1qTdjqoATUboCo66pJtA6Ctnf7e6zSxJezm8hTvnofyxeVkoLyOgt
	UdJ+brkmUak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50BB2B350;
	Wed,  6 Feb 2013 17:23:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22844B320; Wed,  6 Feb 2013
 17:23:38 -0500 (EST)
In-Reply-To: <20130206221912.GD27507@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 17:19:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD423190-70AB-11E2-A5D1-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215654>

Jeff King <peff@peff.net> writes:

> Which made me wonder: what happens with:
>
>   git cat-file --textconv HEAD
>
> It looks like we die just before textconv-ing, because we have no
> obj_context.path. But that is also unlike all of the other --textconv
> switches, which mean "turn on textconv if you are showing a blob that
> supports it" and not "the specific operation is --textconv, apply it to
> this blob". I don't know if that is worth changing or not.

OK, so in that sense, "cat-file --textconv HEAD" (or HEAD:) should
die with "Hey, that is not a blob", in other words, Michael's patch
does what we want without further tweaks, right?

By the way are we sure textconv_object() barfs and dies if fed a non
blob?  Otherwise the above does not hold, and the semantics become
"turn on textconv if the object you are showing supports it,
otherwise it has to be a blob.", I think.
