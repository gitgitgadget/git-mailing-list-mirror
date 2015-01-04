From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH/RFC: format-patch: Add format.subjectprefixsep to change separators
Date: Sun, 04 Jan 2015 11:55:24 -0800
Message-ID: <xmqqlhliqq1f.fsf@gitster.dls.corp.google.com>
References: <1420377686-25608-1-git-send-email-m.dreadlock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marc Finet <m.dreadlock@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 20:55:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7rH7-00083R-OR
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 20:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbADTzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 14:55:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752788AbbADTzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 14:55:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F3782C68B;
	Sun,  4 Jan 2015 14:55:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0LzYud/TY7rctwNl0FsNwYlc3PA=; b=ipTBbz
	9WIPUaXAYgQVwp19328LMATHHN6bo/H0yTsr41/ejWtkErR/TYPvbV8YObkcsbBx
	9fA5trvja13+2d/husHQzjrkr2na1PBfTdswOhDSdE84v0LyukjwgOSeY2syAGBm
	3ot2GylgucgA+RV5uBIF0BNTlePO6r0B0DRfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PYNxc2uaYKDKAKDN2wwrVAYJjN4IELrG
	bRE6QM9/1vQuTE3anflREDCpBGOkWYM2krB/6k3GBlhEldo1usLb68Qwcamct0sx
	epdXEtaww89CF4h8H3YxPr+V22O/qTLv2dB9f4617wIK1EUh+k85jVpiWtEjuZvE
	32NgfrtRo/A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3478F2C689;
	Sun,  4 Jan 2015 14:55:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 671A42C685;
	Sun,  4 Jan 2015 14:55:25 -0500 (EST)
In-Reply-To: <1420377686-25608-1-git-send-email-m.dreadlock@gmail.com> (Marc
	Finet's message of "Sun, 4 Jan 2015 14:21:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9FEEA740-944B-11E4-9AA1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262007>

Marc Finet <m.dreadlock@gmail.com> writes:

> Some mailing list use "PATCH:" rather than "[PATCH]" to prefix
> patches, so introduce a new option to configure:
>  - 2 chars that would enclose PATCH (and counters)
>  - 1 char that would come just after the PATCH (and counters)
> ---
> This mail has been sent with:
>  git -c format.subjectprefixsep=: send-email --annotate --subject-prefix=PATCH/RFC

A few comments:

 - "Some mailing lists" may want to say "[PATCH v3 #4 of 10]" or
   somesuch; as a customization mechanism, the approach this patch
   takes falls way short to be useful.  "--subject=<format>" option
   where <format> is similar the "log --format" options, e.g.

   --subject="[PATCH% v #%N of %T] %s"

   with format-patch specific set of substitutions (in the above
   example, %v stands for patch version, %N patch number and %T
   total number of patches in the series) may be a better way to go.

 - Do not add configuration variable before you add command line
   option.  Add option first and then when option proves useful you
   can have the corresponding variable, not the other way around.
   Make sure that the comamnd line option overrides configuration
   variable while adding the variable in the second step of such a
   patch series.

Having said all that.

What are these mailing lists and why are they using non-standard
convention?  Back when Git was young, we would have added more knobs
to adjust the behaviour to existing prevailing convention, but now
Git is older than X% of projects that use Git where the number X is
a pretty large number.  Perhaps just like they (whichever mailing
lists they are) switched out of Subversion or CVS and started using
Git to come to the modern world, maybe it is time they switch their
convention as well?
