From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 19:14:42 -0800
Message-ID: <xmqqbn7de6hp.fsf@gitster.mtv.corp.google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
	<xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZZRENjVhfrhSfPmSNNQ_qrwpzWk=pocQ4GY6kBos1r6Q@mail.gmail.com>
	<CAGZ79kZwgBJQ2bkvKSuT+ULiSPL9x5WTcwVJG0FATNv-D_-AhQ@mail.gmail.com>
	<xmqqio1lehbp.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY7aYmDcz+JYwpzizfzRV3bUeN8TU-4jRjKqToJJTBHoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 04:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWbWr-0008V3-I2
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 04:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322AbcBSDOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 22:14:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753790AbcBSDOo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 22:14:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10A1145401;
	Thu, 18 Feb 2016 22:14:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=llQ/P7tZB7K1fahx2VBeSTU59l0=; b=F4u4Eu
	889MJwbmLkpQRkYPSRkuyd/4+S9IhzKQo7v9CcDlCiEAkIgC6g9o56ARCmxMUYpE
	CIVSMDYNvHUBMgPsuuZBs5/Rrs1yVyN928Fkk85R/fJTZQevne2223cpAr9sZYLF
	d6TssSMIfMxwAb5v48V+eqgtiHK2kzuSQJ1ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxyemMVpuhMCVr4uZ7TjLdJbABXVP1O5
	IZovSE+6x3n2OPS//ecLR21NxLunFJkLVjuoAmHggN1UenmsQWLlVqzOMCNqQr7L
	0WiyOhMzq5nbxc5HrxLeFrNxRcDxv8Aa1DgY+D1NBShD4kz4GlOm01NbjVaOQS0S
	TaDkjmfr69A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07F64453F9;
	Thu, 18 Feb 2016 22:14:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 791BB453F8;
	Thu, 18 Feb 2016 22:14:43 -0500 (EST)
In-Reply-To: <CAGZ79kY7aYmDcz+JYwpzizfzRV3bUeN8TU-4jRjKqToJJTBHoA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 18 Feb 2016 15:27:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBEACA9E-D6B6-11E5-BF7A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286655>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 18, 2016 at 3:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Thu, Feb 18, 2016 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>>>> Unless you count "I want to write differently from what was
>>>>> suggested" is a desirable thing to do, I do not see a point in
>>>>> favouring the above that uses an extra variable and skip_prefix()
>>>>> over what I gave you as "how about" patch.  But whatever.
>>>>
>>>> The skip_prefix was there before, so it stuck there.
>>
>> Sorry, but I thought this "parsing update strategy" was all new
>> code.
>
> I meant previous patches or in my mind. That's why I was hesitant to
> throw out the skip_prefix.

I actually think the attached on top of your final version would be
the best.  It would not make too big a difference in this codepath
that skips just one byte, the pattern naturally would apply to
prefix of any length, and this would serve as the BCP, ready to be
copied-and-pasted by others when writing new code.

And of course it does not waste an otherwise unnecessary temporary
variable ;-)

diff --git a/submodule.c b/submodule.c
index 911fa3b..8e08159 100644
--- a/submodule.c
+++ b/submodule.c
@@ -223,9 +223,9 @@ int parse_submodule_update_strategy(const char *value,
 		dst->type = SM_UPDATE_REBASE;
 	else if (!strcmp(value, "merge"))
 		dst->type = SM_UPDATE_MERGE;
-	else if (value[0] == '!') {
+	else if (skip_prefix(value, "!", &value)) {
 		dst->type = SM_UPDATE_COMMAND;
-		dst->command = xstrdup(value + 1);
+		dst->command = xstrdup(value);
 	} else
 		return -1;
 	return 0;
