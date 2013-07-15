From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Mon, 15 Jul 2013 08:54:45 -0700
Message-ID: <7v4nbvddiy.fsf@alter.siamese.dyndns.org>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org>
	<20130712190531.GD8482@google.com>
	<7vtxjzk13q.fsf@alter.siamese.dyndns.org>
	<CAHREChiOE8oMWQYFY_7yzf1tz-4E2_L5W9--k33vwATFSrR==A@mail.gmail.com>
	<7vzjtoea0a.fsf@alter.siamese.dyndns.org>
	<EFAADB2C-5774-4076-99CE-887AFB2B5CCA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyl70-0006Aa-1B
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933267Ab3GOPyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:54:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932668Ab3GOPys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:54:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D8B311A1;
	Mon, 15 Jul 2013 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/AU40ROfx/XYaukq8SKzDWgmXh4=; b=gEJrQw
	PeZfmATUAKQ2js4NNOfq8hjgoO+kdGbVFJNqN8pMlp0XVQW6dm1IhaKfsSQW3fjH
	SCoVjbyn3CJfWM/+KL1vC6JJ08wjq59m+qCBSsBUHSPr4kFX+84DuCB58rnUVJ8y
	K62xRrIvoSZCzcj93GoVR7Q3E3Gn4ujuJjPlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JRz+F3+IzIyEynvSLN5cXjMb8afI793a
	kCdihUPJisrYtnJue/7nRjTdPdaruXb+OsrRSIYE4oRTe79YwsKTOhskN26hMWhn
	9wnaaYnQG2Fepy5R82oms1hPFArpcHJItgcp/TjKArteVXkk5cMA4o+5aGozpa+i
	9vJ/hlPVkkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C81A8311A0;
	Mon, 15 Jul 2013 15:54:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15C9E3119C;
	Mon, 15 Jul 2013 15:54:46 +0000 (UTC)
In-Reply-To: <EFAADB2C-5774-4076-99CE-887AFB2B5CCA@gmail.com> (Kyle J. McKay's
	message of "Sun, 14 Jul 2013 23:37:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFC16854-ED66-11E2-9DE0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230484>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> That works fine for GIT_SSL_CERT_PASSWORD_PROTECTED and
> GIT_CURL_VERBOSE, but it's a little bit awkward for GIT_SSL_NO_VERIFY
> and GIT_CURL_FTP_NO_EPSV since they have "_NO_" in their names.
>
> If the user wants to override a "http.sslVerify=false" then
> "GIT_SSL_NO_VERIFY=false" is needed rather than "GIT_SSL_VERIFY=true".
>
> We could:
>
> 1) Introduce GIT_SSL_VERIFY and GIT_CURL_FTP_EPSV and say if they are
> set the "_NO_" version is ignored.
>
> 2) Go ahead with "GIT_SSL_NO_VERIFY=false" to force http.sslVerify
> back to true (and similarly for EPSV).
>
> 3) Just leave GIT_SSL_NO_VERIFY and GIT_CURL_FTP_NO_EPSV alone.
>
> 4) Do something else, ideas?
>
> Comments?

The usual way we have done this kind of thing so far is:

 (1) Add GIT_SSL_VERIFY and GIT_CURL_FTP_EPSV support, that is
     boolean.  If that is set, it takes precedence to
     GIT_SSL_NO_VERIFY and GIT_CURL_FTP_NO_EPSV.  If not,
     GIT_SSL_NO_VERIFY and GIT_CURL_FTP_NO_EPSV are used just like
     before (setting it to any value will decline VERIFY or EPSV).

 (2) Issue a warning to tell users to use GIT_SSL_VERIFY or
     GIT_CURL_FTP_EPSV instead, when GIT_SSL_NO_VERIFY and
     GIT_CURL_FTP_NO_EPSV are used.

 (3) Later at a large version bump, remove support for *_NO_*
     variants.

We can stop at (1) and not do (2) and (3), if the resulting code
after (1) is not too cumbersome to maintain.  If we do (2) then we
must follow it through with (3), and if we plan to do (3) then we
must precede it with (2).
