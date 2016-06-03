From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] completion: add git status
Date: Fri, 03 Jun 2016 09:34:00 -0700
Message-ID: <xmqqzir2p6yv.fsf@gitster.mtv.corp.google.com>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
	<9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
	<1464880296.3720.0.camel@virtuell-zuhause.de>
	<xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
	<8f5e515b-8efc-0160-820e-d81885fc6c36@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:39:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8s31-0007Nu-1m
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 18:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbcFCQeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 12:34:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932259AbcFCQeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 12:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86DE11FBE4;
	Fri,  3 Jun 2016 12:34:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uWRNu+RS+SogjaeZ2FYMPyZO2zs=; b=Qrz/QS
	UYWDVuaJpUdPwJsLsrtKaqVACrS+8yyIBzQ6BZS23/DYP+1Wa6ZhnFtppjQ756Sl
	3+rlYo4NJNP+alv0igZq1dd6tPiOWUnlGUUZu8ZrrZYITaqmGz3BUEDhhapbb1FN
	nPyKwRqPX7gDwzOPSec6RsD4LOa+CcnvIKWxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZ3aG4UE/O+OdufGZRTrvDeSzF5wiDPg
	QqdZlKkgPBwVc2xHfhiTATjtzRFoHU+jThag96ggVW1sYmuv3b6PW5wNdmFJwS9F
	lI3QlAFBbj8/dZRhqfQLFITzqhHSpz6AubG6vE5XGK6fpWdWSlSOeg6TsYfE45wn
	cpgOIB0u0Xc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CDFD1FBE3;
	Fri,  3 Jun 2016 12:34:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCA881FBE2;
	Fri,  3 Jun 2016 12:34:02 -0400 (EDT)
In-Reply-To: <8f5e515b-8efc-0160-820e-d81885fc6c36@virtuell-zuhause.de>
	(Thomas Braun's message of "Fri, 3 Jun 2016 17:41:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB4990B6-29A8-11E6-BD25-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296343>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

>>> +			if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
>> 
>> Same question as the "--untracked-files=no vs -uno" applies here.
>
> Is there a short version of --ignored? I could not find one in the help,
> and from a look into cmd_status in commit.c I would say there is none.

I was primarily wondering about the effect of parse-options have.
It lets you truncate a long option to its unique prefix (e.g.
"--untracked-files=all" can be spelled as "--unt=all").  It seems
that "--ignored" must be spelled in full, which means the use of
find-on-cmdline we see above is OK, but the reason why it is so is a
bit subtle.  It may deserve a comment there, perhaps.


[Footnote]

*1* The reason is because "--ignored" happens to be the shortest
truncation of "--ignored" in order to disambiguate it from
"--ignore-submodules".
