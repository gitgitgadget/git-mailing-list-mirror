From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 15:09:47 -0700
Message-ID: <7va9yqjfis.fsf@alter.siamese.dyndns.org>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
 <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
 <20120723205209.GA6745@sigill.intra.peff.net>
 <7vr4s2jiqk.fsf@alter.siamese.dyndns.org>
 <20120723211312.GA12533@sigill.intra.peff.net>
 <7veho2jh4q.fsf@alter.siamese.dyndns.org>
 <20120723214339.GA13931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQpB-0005vs-4O
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 00:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab2GWWJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 18:09:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab2GWWJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 18:09:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F138EAA;
	Mon, 23 Jul 2012 18:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eRV5cWlF0Xbq1lbMVVXlgEFiUYo=; b=OCMZh/
	oCTWEC6OPo7nsfUmFPV5X6vL/nM8+DWiniHsUw6XfgCrrs7wbvBSo3504JcyNjgx
	q/+S7UAut5En4nfLvJiFCV54hF3EkcEO/lC08tF4kyY7/RTxpR2xsF2X+V01r9Q2
	nvxtgeSi2XCz6pcPKhlanM6BuTrg473ripYQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tdKMWcEnH3c880z1KR1S2W/nTyMGtb+b
	CsflamLP6r8g9mSrK0v+1Pmv/Das124N0XMxFJ7W32U0YaSs8MpexfrKRLbiMNBU
	J0d2pkumrl3EwBGm2YM+q1KfiaPg/bv9zRuRGHAY1egCBcRn9o9PmY8mMDMDXCLx
	2qGAbb6S5DE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70E268EA9;
	Mon, 23 Jul 2012 18:09:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1C3F8EA7; Mon, 23 Jul 2012
 18:09:48 -0400 (EDT)
In-Reply-To: <20120723214339.GA13931@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 Jul 2012 17:43:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E6C21B0-D513-11E1-A01A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201994>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 23, 2012 at 02:35:01PM -0700, Junio C Hamano wrote:
> ...
>> I also wondered if something like the following might be useful, but
>> it probably falls into the "water under the bridge" category.
>> 
>>  builtin/commit.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 149e07d..83bcee4 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -768,6 +768,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>  				"with '#' will be kept; you may remove them"
>>  				" yourself if you want to.\n"
>>  				"An empty message aborts the commit.\n"));
>> +		status_printf(s, GIT_COLOR_NORMAL,
>> +			      _("The file '%s' keeps a copy of the log message\n"
>> +				"you edited, if you wish to inspect it later.\n"
>> +				"It will be wiped by the next invocation of 'git commit'.\n"),
>> +			      git_path("COMMIT_EDITMSG"));
>
> That seems excessive, as it is inside the file itself. Unless your
> editor is terrible, it already shows you that information.

The pathname was not the part that was interesting; "If you wish to
inspect it later" was.

But that is what makes it water under the bridge.  The message will
be gone by the time you really need it.
