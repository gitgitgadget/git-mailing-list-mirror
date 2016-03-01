From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command line
Date: Tue, 01 Mar 2016 11:07:24 -0800
Message-ID: <xmqqmvqi6mqb.fsf@gitster.mtv.corp.google.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
	<CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
	<xmqqh9gq85yc.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xp41mkHjA0CF=69extO4R2Oam2V3sJA7PoqNbHD=9kw+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:07:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aape5-0008FL-KW
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 20:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbcCATHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 14:07:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753712AbcCATH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 14:07:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C470149F54;
	Tue,  1 Mar 2016 14:07:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GfkpRndgHSHd3ReirHazA8R9Ntw=; b=bUiaJr
	MOGei1PAP3FJOQpkYJwe62lLrxsBE8hu/s/FtQ7GRXqxs6pIydl0Rl5isAAS8+3L
	sBvMgxBe3fLt1F3Ktbq8eDacMJp4i2Q2QQaYoOGoYvHwAYIMsHXPEAByScxwUZy7
	TDw0SBdlTZILt/NlEQKs4zW8OfngBuXcbzmX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIKxfpXeCkpmytBmq0LgpMTJ/Lybi7vu
	V2xPlBvKxWMyXwwek4eDdCzR+LMcBlMCjhHu6lz68T2Vo9nTpXkYX7cbe+9TnF8U
	zP+cCYKBEDR+vYtkeEwIH+q8rHUaV1DjvQBnj0E2PE8tinBjcvhee96UZeVE0kLU
	Z0CZvJotxjI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAE9A49F53;
	Tue,  1 Mar 2016 14:07:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 257BE49F50;
	Tue,  1 Mar 2016 14:07:26 -0500 (EST)
In-Reply-To: <CA+P7+xp41mkHjA0CF=69extO4R2Oam2V3sJA7PoqNbHD=9kw+g@mail.gmail.com>
	(Jacob Keller's message of "Tue, 1 Mar 2016 10:05:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D619DC7C-DFE0-11E5-9CAF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288053>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Mar 1, 2016 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I find this in t/lib-httpd.sh:
>>
>>         set_askpass() {
>>                 >"$TRASH_DIRECTORY/askpass-query" &&
>>                 echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
>>                 echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
>>         }
>>
>> and expect_askpass peeks at askpass-query to see if Git asked the
>> right questions.
>>
>> I think askpass-query is cleared here because the author of the test
>> suite expected that the helpers are used in such a way that you
>> always (1) set-askpass once, (2) run a Git command that asks
>> credentials, (3) use expect_askpass to validate and do these three
>> steps as a logical unit?
>>
>> That "clone" the test expects to fail does ask the credential, so
>> even though the test does not check if the "clone" asked the right
>> question, it finishes the three-step logical unit, and then you need
>> to clear askpass-query.
>>
>> It may have been cleaner if you had clear_askpass_query helper that
>> is called (1) at the beginning of set_askpass instead of this manual
>> clearing, (2) at the end of expect_askpass, as the exchange has been
>> tested already at that point, and (3) in place of expect_askpass if
>> you choose not to call it (e.g. this place, instead of the second
>> set_askpass, you would say clear_askpass_query), perhaps, but I do
>> know if that is worth it.
>
> Probably something worth looking at doing in the future.
>
> I could call expect_askpass here at each time but I don't think it
> would be meaningful after a test_must_fail.

Even if you call expect_askpass to check, another set_askpass is
expected to start the next cycle anyway (unless we restructure the
helpers around clear_askpass_query I alluded to, which I am not
convinced is a good idea yet), so you'll still be asked "why another
set_askpass to set the same 'wrong pass@host'?".

So, I dunno.
