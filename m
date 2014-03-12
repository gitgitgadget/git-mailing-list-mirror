From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New GSoC microproject ideas
Date: Wed, 12 Mar 2014 12:04:29 -0700
Message-ID: <xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
References: <532049A7.6000304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:04:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoSR-0002QE-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbaCLTEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:04:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbaCLTEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:04:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AADD73BDA;
	Wed, 12 Mar 2014 15:04:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UnFDKnfIzx7h2bWOIS7D/22nnc=; b=aLFaw4
	NW5CNegXbSLAfB++rYnKynTTJWuXHjwmGTXtbug9Lb9yUDdxs4wF19FDv7R+B4wE
	EM8oOL4xJQAdU2Wdtw9H+Sd8Bmfwaz8knTzkyYlM1hOGGCNWnxgvVqy89S6hfW9d
	AbfOnAqM5+XVQhtFjtCRs8port7Zo58ZCpJKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rQMX4YY7602D6hVNdc81Af/oAaGMS5Ef
	85yEG8CxbEQ3ytXuhEAvVw8NDeNXWjcUI49FMMFaIPkxFm7i3bN3yPjKiZuvdZyh
	pWWaoOFan7kokXfk4Zh08uTrbltJPq9e+Qmm50E4gEq5V8fWF/INfzDddmPi/L1r
	yHCw8ZwDn4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5470E73BD9;
	Wed, 12 Mar 2014 15:04:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5666A73BD6;
	Wed, 12 Mar 2014 15:04:32 -0400 (EDT)
In-Reply-To: <532049A7.6000304@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 12 Mar 2014 12:48:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 250B95AA-AA19-11E3-B378-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243965>

Here is another, as I seem to have managed to kill another one ;-)

-- >8 --

"VAR=VAL command" is sufficient to run 'command' with environment
variable VAR set to value VAL without affecting the environment of
the shell itself, but we cannot do the same with a shell function
(most notably, "test_must_fail"); we have subshell invocations with
multiple lines like this:

	... &&
	(
        	VAR=VAL &&
                export VAR &&
                test_must_fail git command
	) &&
        ...

but that could be expressed as

	... &&
        test_must_fail env VAR=VAL git comand &&
	...

Find and shorten such constructs in existing test scripts.
