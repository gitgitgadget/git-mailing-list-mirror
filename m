From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patchset NTLM-Authentication
Date: Tue, 21 Feb 2012 10:02:16 -0800
Message-ID: <7vfwe4gj4n.fsf@alter.siamese.dyndns.org>
References: <4CDEC141B5583D408E79F2931DB7708301802B70@GSX300A.mxchg.m.corp>
 <87vcn0h77a.fsf@thomas.inf.ethz.ch>
 <4CDEC141B5583D408E79F2931DB7708301802BE7@GSX300A.mxchg.m.corp>
 <8762f05n9q.fsf_-_@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <avarab@gmail.com>
To: "Schmidt\, Marco" <Marco.Schmidt@cassidian.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 21 19:02:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzu2l-0008JQ-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 19:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab2BUSCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 13:02:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232Ab2BUSCW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 13:02:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE87736D;
	Tue, 21 Feb 2012 13:02:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RlSf6/rzWAw8AtcALEGHqqZq3dU=; b=ffkRKR
	LpeAbeY0B7F76WugCsuCsccpqwD02Ni9e/SZHSXHncWf8IgPD3m6R3XkM8/uZHuF
	nw1NBulv8VrW6tNE5EYe+nKm5KbIuGuJAUTygjdurAFvR0BaTNbvkO458kohvonN
	eniGMHSj8fNUf2upxnNuwtK5uE+47StIKaJ9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JHFIgWUi+Tfw2QnKgaULuAtghcxMoqwO
	oeKciJc6pqCetrfzWdfoW4gWpkj73rMlstRROZACt6bISQptMoRkWHoYD4fRLbF9
	3ToRe/PfapN+m2f9b8M3jPjH7IJNsVMuTyZj8rfdC7XZP3tQwMo/M62sMjH/QWUK
	P/BZLGk6RLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0686E736B;
	Tue, 21 Feb 2012 13:02:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00E6E7369; Tue, 21 Feb 2012
 13:02:17 -0500 (EST)
In-Reply-To: <8762f05n9q.fsf_-_@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 21 Feb 2012 14:28:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31624928-5CB6-11E1-B404-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191173>

Thomas Rast <trast@inf.ethz.ch> writes:

>   This mostly parallels http.authAny which was introduced in b8ac923
>   (Add an option for using any HTTP authentication scheme, not only
>   basic, 2009-11-27).  http.authAny was removed, and its feature
>   unconditionally enabled, in 525ecd2 (Remove http.authAny, 2009-12-28).
>   However the reasoning of the latter does not apply here because XXXX.

Thanks, Thomas.

I think this paragraph is essential, especially the XXXX part, if we were
to accept the proposed change and keep the new configuration.  Otherwise
we won't know what to do when somebody proposes to unconditionally enable
this ;-)

If it turns out that we can set CURLOPT_PROXYAUTH always to CURLAUTH_ANY
without compromising security, then an explanation why this does not have
to be optional, similar to what justified 525ecd2, needs to be there
instead, and the patch needs to be tweaked to drop the configuration bits.

Marco, I extracted your patch in the attachment and took a look at it
before composing the above response.

 - Your log message seems to be indented by two spaces for some strange
   reason;

 - it does not have any justification like the example Thomas gave
   you; and

 - it also is missing your S-o-b.

Care to re-roll one more time?
