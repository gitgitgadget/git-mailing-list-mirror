From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 27 Jan 2013 12:25:26 -0800
Message-ID: <7vip6iv0eh.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin>
 <5105280A.80002@web.de> <7v4ni2y1fm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYnX-00024y-MO
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab3A0UZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:25:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755845Ab3A0UZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:25:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D353DCDAA;
	Sun, 27 Jan 2013 15:25:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hzO8lP7FFPXlULve9NH+22Q96ro=; b=QET94v
	778UxUNrneTJR5bXfeouu1nLhO0K4JcZEwar3IkM/3AzbTPU9FPPR0OWODQEptSG
	3DCKzqv97I3USN5EUjPEiP5DjP5rjNm9goj+3zOQ2XUCCMtm4It+OLp+CijESHFM
	iNYKefJpXSZMW497lwD7otLFurqVE4Iqabt9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tiiz2ew9rnorVBeK5Vj1eXMsBNHjiFNz
	mpr2DVSEZQrldQSVw6vdrbD4B5FC6qLCZK1WK4eubhxMoovZmUUKCQ2A7m49IzZI
	Fk6wUNItvQgFTRtx4e/HSZxMJmuk9coFGYY/AqKrZoIDeivacdOZNoBecOR76ujF
	w701XhrprNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F36CDA6;
	Sun, 27 Jan 2013 15:25:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E437CDA3; Sun, 27 Jan 2013
 15:25:28 -0500 (EST)
In-Reply-To: <7v4ni2y1fm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jan 2013 09:34:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B064CF8C-68BF-11E2-9F1D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214728>

Junio C Hamano <gitster@pobox.com> writes:

> If we did not care about incurring runtime performance cost, we
> could arrange:
> ...
> Then you can wrap commands whose use we want to limit, perhaps like
> this, in the test framework:
> ...
> 	sed () {
> ...
> 		done
> 		if test -z "$must_abort"
> 			sed "$@"
> 		fi
> 	}

Of course, aside from missing "then", this needs to use the
real "sed", so this has to be

	if test -z "$must_abort"
        then
		command sed "$@"
	fi

or something like that.

An approach along this line may reduce both the false negatives and
false positives down to an acceptable level, but I doubt the result
would be efficient enough for us to tolerate the runtime penalty.
