From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sat, 25 Apr 2015 21:29:09 -0700
Message-ID: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
References: <xmqqa8xw17ew.fsf@gitster.dls.corp.google.com>
	<1429984780-22868-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 06:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmECA-0003mn-Dw
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 06:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbbDZE3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 00:29:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750801AbbDZE3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 00:29:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFDF64CA16;
	Sun, 26 Apr 2015 00:29:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NNlGI/0YzrMs
	7FM70kioaiDtMUE=; b=DFh6ehku0UM43l7P+p1+OKO7WBConWBwC4KiG2W8k+5Z
	sNoaekwsxDPnKLgFY/mthvwLRSlhK82yKoq+QGjZU0ZtLwZP1kY8KoMp2XUYP8U1
	hQ1GgqwxhlggdjpCIWJW2xObRz11B0lr0C26TTOeh5ea6hjhHrPxRgxvk+ucZns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pVMwMQ
	VNkSWBLNNfWK4G6MqssPIfo8QkHw94ihYXXcLgR5N1jUuZnoywyptyuNBoUaZIkX
	vBS6sXPBrAG2LEzbfbugUJALnRcyrY/RIDGNDkc8+qt6Z8guPsEyC3i1i61TUvMx
	/b89CqA6r7HTznddmts2bG3cZfb/+kBSo94pU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6F094CA15;
	Sun, 26 Apr 2015 00:29:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D1D14CA14;
	Sun, 26 Apr 2015 00:29:11 -0400 (EDT)
In-Reply-To: <1429984780-22868-1-git-send-email-erik.elfstrom@gmail.com>
	("Erik =?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sat, 25 Apr 2015 19:59:40
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C95AACCC-EBCC-11E4-B202-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267805>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> On Sat, Apr 25, 2015 at 6:47 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> I do not think it is wrong per-se, but the changes in this patch
>> shows why hardcoded values assigned to error_code without #define is
>> not a good idea, as these values are now exposed to the callers of
>> the new function.  After we gain a new caller that does care about
>> the exact error code (e.g. to react differently to the reason why we
>> failed to read by giving different error messages) if we decide to
>> revert this step, or if we decide to add a new error type, for
>> whatever reason, this organization forces the caller to be updated.
>
> Yes, it was a bit silly of me not to add that. Would something like
> this be ok?

Yeah, if you used symbolic constants from the get-go, then the
second patch to add the "too-large? it cannot be gitfile" safety
would not have to renumber everything; instead it would be adding a
single constant to the header file and adding a new case to setup.c
that uses the error code.
