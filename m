From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Fri, 06 May 2016 12:02:46 -0700
Message-ID: <xmqqr3df2end.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
	<CAGZ79kaBh-SogYrMcVfgE1DS464oK2Z01ZqpBiM0eSHKMPU1Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 21:03:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayl1g-00088V-4P
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 21:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692AbcEFTCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 15:02:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756794AbcEFTCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 15:02:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71ECA19E9B;
	Fri,  6 May 2016 15:02:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I3HSgJzhFBqyD5FtDzPDB7zbHuI=; b=vkaNGG
	WeTJWn+ulyCqvyEgAU2RBwr+RF/Zcy5l77JSLPC46CHc0qT2oLhANEzKxDPdbpEJ
	hyQzlGiOrID+JM6FQiSJRo+cR8ClFvNMzbNlSxqaltCjmgGW1E54q6o5mAq2KkC6
	ERq1WIYAO0DAfVoBTxXsv267DsYYqTlTaxajM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BsOG4aAfm/h/D7uaNEdMCI1H1AHMxh/y
	Pw6qBB6p4EdGLIo0XU+oCZFsca4tp5b3x1yZvJ4J+VVdFIvz73vYA8Dgph8T+0lQ
	kA1JOw0sFJ0LD0uDm5ZhOY3Tn54tkk+G718NiBMlNHAh/WQrP4AvmcR1lW8iijxE
	zDyem6J7+aE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69DA619E98;
	Fri,  6 May 2016 15:02:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 715A419E95;
	Fri,  6 May 2016 15:02:48 -0400 (EDT)
In-Reply-To: <CAGZ79kaBh-SogYrMcVfgE1DS464oK2Z01ZqpBiM0eSHKMPU1Fw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 6 May 2016 10:13:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FCF42FC-13BD-11E6-BE93-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293849>

Stefan Beller <sbeller@google.com> writes:

> On Fri, May 6, 2016 at 3:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, May 6, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>>> I wonder if the patches mentioned have something to do with the "git
>>>>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>>>>> repository in some way?
>>
>> The same functionality is added in 8745024 (parse_pathspec: support
>> stripping/checking submodule paths - 2013-07-14) so if it didn't fail
>> to notice that before 5a76aff1a6 and did after, it's a bug.
>
> The bug seems to have existed before. However in the bug we are talking
> about the nested repo is not a submodule yet.

That agrees with Duy's recollection below:

>> I vaguely recall this symptom. It has something to do with the index,
>> the check we do requires a gitlink in the index, I think. So if the
>> gitlink entry is not in the index, our protection line fails.

So are we all on the same page that this is a bug now?
