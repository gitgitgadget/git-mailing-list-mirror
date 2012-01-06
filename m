From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] write_head_info(): handle "extra refs" locally
Date: Fri, 06 Jan 2012 11:45:41 -0800
Message-ID: <7vobugk42i.fsf@alter.siamese.dyndns.org>
References: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
 <1325859153-31016-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jan 06 20:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjFja-0006GS-0q
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 20:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758335Ab2AFTpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 14:45:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2AFTpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 14:45:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 917026121;
	Fri,  6 Jan 2012 14:45:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EkbV0i/UAsNgG7zACAB+MxxMHfQ=; b=VdyGpa
	rwXBE9t9DTvK/4wLijX8aYyj3ks5g9dM1EeoWyIpL41eVJrcXaNK0WiFMRE0SnJn
	oijOBaFJ/bUDSTTUtZOGeI/SpOzSzdFBaG7CxM4l7vQSTYOoupVK1Uw9lOlV7IUu
	0yCKI6mRFkQF9fUsBsYHmGrweb8SOVrYqwHoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b51GnykZZCKkQvrfLrPdoSonYK434DR0
	fLEr56fzosH+22+4g+TipL8W7s6gCN6DWSzqw+yTRn7x29kt86S+Mss249V649yv
	WRF9KseO3Bn5H3YEabB6UORYOkILPIxOwMT8zGshNYaOCjtiGuIsdfKbRYmPmPdU
	Vmgob62X+es=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F836120;
	Fri,  6 Jan 2012 14:45:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1255B611D; Fri,  6 Jan 2012
 14:45:43 -0500 (EST)
In-Reply-To: <1325859153-31016-4-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Fri, 6 Jan 2012 15:12:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04E835DC-389F-11E1-924B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188043>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> The old code basically did:
>
>      generate array of SHA1s for alternate refs
>      for each unique SHA1 in array:
>          add_extra_ref(".have", sha1)
>      for each ref (including real refs and extra refs):
>          show_ref(refname, sha1)
>
> But there is no need to stuff the alternate refs in extra_refs; we can
> call show_ref() directly when iterating over the array, then handle
> real refs separately.  So change the code to:
>
>      generate array of SHA1s for alternate refs
>      for each unique SHA1 in array:
>          show_ref(".have", sha1)
>      for each ref (this now only includes real refs):
>          show_ref(refname, sha1)

This updated logic should be equivalent to the old one as long as nobody
else called add_extra_ref() before we come to write_head_info() function,
which should hold true.

The entire series looks good. Thanks.
