From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Makefile: use curl-config to determine curl flags
Date: Tue, 15 Apr 2014 09:50:45 -0700
Message-ID: <xmqqa9bmleoq.fsf@gitster.dls.corp.google.com>
References: <1397344502-23459-1-git-send-email-dborowitz@google.com>
	<xmqqioqboe50.fsf@gitster.dls.corp.google.com>
	<CAD0k6qQJE6a5DmRnpiFpOc_MFjSn9eFyiJ2nFaL63rctvxwt5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 18:50:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa6ZT-0005my-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 18:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbaDOQuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 12:50:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbaDOQuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 12:50:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E107A82B;
	Tue, 15 Apr 2014 12:50:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+EwQU97i1yrvyOZXxCumgqIxr1E=; b=rrKLod
	qt+Dx/zj23E77ac8CaO3+4uJfbxVjkV4jgmRLjH/tFHDIofXz69sSXQCSpZ9dYTH
	ho6u9XWJdONgqp1R1OCn04NDWzTpvOAE2r/khyJyOV03/eBwgI/hXpiccYNbdiff
	IMrzIO2OeThx9hAvck5eLt1rkOEnqjrc0gH+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ghm6SY8zdUXfx0i0duZUgnXqGNfISCeX
	sp361fCmmyOFbvF60SLrkW6uY2FQnzxQrG2ZqFsvj66+H9MVw3ALXNROhtA0ptB8
	d6wfYjGU6a9N4cSxBd3HWcI3JWv3piGhWDNDHBuAIPgMxz+LUVqdxy+VABG21uNY
	VJyBq4Cez9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D1437A829;
	Tue, 15 Apr 2014 12:50:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B843D7A828;
	Tue, 15 Apr 2014 12:50:48 -0400 (EDT)
In-Reply-To: <CAD0k6qQJE6a5DmRnpiFpOc_MFjSn9eFyiJ2nFaL63rctvxwt5Q@mail.gmail.com>
	(Dave Borowitz's message of "Tue, 15 Apr 2014 06:20:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18A721FC-C4BE-11E3-B406-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246291>

Dave Borowitz <dborowitz@google.com> writes:

> My end goal is to statically link git on Mac OS X (10.9) against a
> newer version of libcurl than ships with the OS. The normal CURLDIR
> approach should work with system libcurl:
>
> $ /usr/bin/curl-config --libs
> -lcurl
>
> But it gets a bit more complicated with a recent curl version. This
> likely has to do with the set of enabled options; I passed flags to
> ./configure based on the build script "MacOSX-Framework" included in
> the curl distribution:
> $ ~/d/curl-out-7.36.0/bin/curl-config --libs
> -L/Users/dborowitz/d/curl-out-7.36.0/lib -lcurl -lgssapi_krb5 -lresolv
> -lldap -lz
>
> And with --static-libs there's just that much more:
> $ ~/d/curl-out-7.36.0/bin/curl-config --static-libs
> /Users/dborowitz/d/curl-out-7.36.0/lib/libcurl.a
> -Wl,-syslibroot,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk
> -arch x86_64 -Wl,-headerpad_max_install_names -framework
> CoreFoundation -framework Security -lgssapi_krb5 -lresolv -lldap -lz
>
> So I don't think specifying NEEDS_*_WITH_CURL scales to this use case.

Thanks.  As I said, the kosher way to learn how to link with libcURL
is by asking curl-config about the details of options to give to the
compiler and the linker, so I am all for this change.

> While writing this up I also noticed an issue with the second patch,
> namely that `curl-config --static-libs` is empty when curl is not
> built for static linking.
>
> I will reroll with a more detailed commit message and a fix to the second patch.

I love it whenever I see the contents of the patch improved after
spending a bit more time trying to describe the problem and the
solution (which is time worth spending).

Thanks.
