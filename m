From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote-bzr: reuse bzrlib transports when possible
Date: Mon, 09 Sep 2013 10:55:51 -0700
Message-ID: <xmqqa9jl1u7j.fsf@gitster.dls.corp.google.com>
References: <522C0B66.1080707@bbn.com>
	<1378619269-21991-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAMg-0004va-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab3IIWzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:55:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab3IIWzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CCDA4035D;
	Mon,  9 Sep 2013 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=XdJwswRffi0LUeMpKK/XOsFC/9Q=; b=glWHoRdb5HnyaDh+uQmd
	s9VCsn3gCjdZkEmW5/wT/Eioks2XfVogds2tYiu3NXSWFKOLN5HOPF3m9Ck3xQOB
	scmTCVfFD0a+ztifNz7aQ4FmJHNjM15DHg3SLp2KzY83ebWLbKiuulmkYw2FepIx
	uWhHARAsRR2ek3QGzD3izjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TEKz6t0qd30+lFY6ElJmKY48mcK3EYPyqKDFmg7KXAn9tD
	tx3ahI6wmIIWEnx51x2+2ZNGIR5z204TKut0NNC7TqiyRX7RpHAuV2hbEjQ49tX7
	4j4diOrOTuT+HihI45E7/DgFhv70H5zoUOMZVQyHLPZaLTeDUrRscNwUhKbjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 390FC40356;
	Mon,  9 Sep 2013 22:55:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB85B4033E;
	Mon,  9 Sep 2013 22:55:14 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3BAC816-19A2-11E3-A627-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234395>

Richard Hansen <rhansen@bbn.com> writes:

>  def do_export(parser):
> -    global parsed_refs, dirname
> +    global parsed_refs, dirname, transports

As this has been acked by Felipe who knows the script the best, I'll
apply this directly to 'master'.

These additions of "global transports" however have trivial
interactions with fc/contrib-bzr-hg-fixes topic Felipe posted
earlier, which I was planning to start merging down to 'next' and
then to 'master'.  Most funcions merely use the variable without
assigning, so "global transports" can be removed, in line with the
spirit of 641a2b5b (remote-helpers: cleanup more global variables,
2013-08-28), except for the obvious initialisation in main(), I
think.  Please double check the conflict resolution result in a
commit on 'pu' with

    git show 'origin/pu^{/Merge fc/contrib-bzr}'

when I push the result out.

Thanks.
