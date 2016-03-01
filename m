From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] environment.c: introduce DECLARE_GIT_GETTER helper macro
Date: Tue, 01 Mar 2016 10:14:05 -0800
Message-ID: <xmqqy4a26p76.fsf@gitster.mtv.corp.google.com>
References: <1456601744-18404-1-git-send-email-kuleshovmail@gmail.com>
	<20160301150543.GN12887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:14:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaooL-0003VZ-J3
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 19:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbcCASOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 13:14:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751349AbcCASOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 13:14:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3571B48FF7;
	Tue,  1 Mar 2016 13:14:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FsWBkyYZu0Sj3cuPYTQPoKEw2/U=; b=Ghk6uJ
	V3v0oovZrllrCpu2b8W6PU8j9DJQBWzHoKfN16C9QFXWlNMHUdWvbO/l9rBLfos/
	WlCYBHTVFoU+m7KrmrFmewl+Tkr5C6rJJyJILUrucn6nZRlat9ohAVQNrkORL/mM
	pd0In6b70lL2+SwOr1+OI3V0fxV+zi8lgDaO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gluYXdIwt6pAaH1/s16/JFAd+lom4BUT
	ZKE81Euu4CR57NqCseJPt2wo41XmbToLPnZ6hsQMQLBoptPyHKrKPFOWtVfC6m5s
	Og14KcijbouSEVAgECqRlKmi1AqB2CvGjwfKuZ0/cFkjvGKk91PuIz3XSKmedspT
	78akHFg5PLk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0919748FF6;
	Tue,  1 Mar 2016 13:14:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 26AD948FF5;
	Tue,  1 Mar 2016 13:14:07 -0500 (EST)
In-Reply-To: <20160301150543.GN12887@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Mar 2016 10:05:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 634FD73E-DFD9-11E5-8A40-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288050>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 28, 2016 at 01:35:44AM +0600, Alexander Kuleshov wrote:
>
>> +DECLARE_GIT_GETTER(const char *, get_git_dir, git_dir)
>> +DECLARE_GIT_GETTER(const char *, get_git_namespace, namespace)
>> +DECLARE_GIT_GETTER(char *, get_object_directory, git_object_dir)
>> +DECLARE_GIT_GETTER(char *, get_index_file, git_index_file)
>> +DECLARE_GIT_GETTER(char *, get_graft_file, git_graft_file)
>
> Hmm. I'm somewhat lukewarm on this patch. It's fewer lines and less
> duplication, which is nice, but this kind of code generation often makes
> things annoying (to step into with the debugger, to find with ctags,
> etc). I dunno.

For this particular set of functions, single-step-ability would not
be a huge issue, but I am not enthused, either, even though these
are vastly more palatable than what was originally proposed.

Another minor annoyance is that I expect to see a semicolon after a
pair of parentheses that follows a token, but adding one of course
would break the compilation.
