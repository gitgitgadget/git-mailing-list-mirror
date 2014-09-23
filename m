From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 13:40:42 -0700
Message-ID: <xmqqbnq6hxyt.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
	<5421CAA6.3040107@redhat.com>
	<xmqqwq8ui00n.fsf@gitster.dls.corp.google.com>
	<5421D900.7060607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWtG-0003ek-6i
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbaIWUkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:40:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55634 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbaIWUkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:40:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3DB43B16F;
	Tue, 23 Sep 2014 16:40:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHXPVkBBaXp5+jq3oGt+SazqyHs=; b=EdveOH
	GNs/snWZ9/z9BTc6CAHyLxFCRnrkAJolMn/O5b6YnjDykHer61vC/JcvLAgrXr6l
	0Qpb3lZB3hDo3nawxuGfMSzjIbhPMoaxNouq+TUmtJxdCurrOEbzjQGzWElbfkMc
	iOMrB6WfHZXJk8FKPJpro7pAudJH6CQzGPUM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZWeo1KSorOTBvccx6lePDFFsNF/UPr/
	ufF5aGhjhZp7hJBgqT7tIYE3LRFBzZabNSPIKGk7O9ZKHFSQbYWL1j8ksSlBYDms
	TzbfU6SPN6QDNeeRcszu3RQVcBB/XvPGJAdno19tYzBSGQm9u8DsmoD2KTVcgqL9
	EzE34hIM9hw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 800AF3B16D;
	Tue, 23 Sep 2014 16:40:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B31983B16C;
	Tue, 23 Sep 2014 16:40:43 -0400 (EDT)
In-Reply-To: <5421D900.7060607@redhat.com> (Laszlo Ersek's message of "Tue, 23
	Sep 2014 22:33:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E39AFF60-4361-11E4-9C5D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257441>

Laszlo Ersek <lersek@redhat.com> writes:

> On 09/23/14 21:56, Junio C Hamano wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> 
>>> What do you think about accepting only "/dev/null\n" and "/dev/null\r\n"?
>> 
>> I thought we agreed that what you are doing is not workable in the
>> first place, no?
>> 
>> I suspect one way to handle "In this project, the files that are
>> checked out must be with CRLF line endings no matter what the
>> platform is" might be to use the line ending attributes to force
>> that while keeping the in-repository data with LF line endings.  The
>> diff output (format-patch output is just one of them) comes from
>> comparing the in-repository representation, so you won't have \r\n
>> that will be stripped via MTA in it, "apply" and "am" will apply the
>> patch without having to worry about \r\n, _and_ the line ending
>> attributes would end the lines in your in-working-tree files with
>> CRLF that way.
>
> This would be a perfect solution if the git repository was not a mirror
> of a Subversion repository that contains all files with embedded CRLFs.

Yikes.

> Anyway I accept defeat, thanks for your time.

I do not consider that a "defeat".  It is just I do not think it is
the right solution for the problem you are having to butcher "apply".
You'd need to find some other way to solve it, and other people on
the list may be able to offer a solution neither of us thought of in
this thread.

Perhaps those who are on Windows have more experience in situations
like yours?
