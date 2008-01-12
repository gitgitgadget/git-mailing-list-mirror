From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 11:21:33 -0800
Message-ID: <7vzlvasvcy.fsf@gitster.siamese.dyndns.org>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	<f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	<62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	<7vejcnv3zk.fsf@gitster.siamese.dyndns.org>
	<46dff0320801120148r1a760bcdq4b9dcdf31354d9e0@mail.gmail.com>
	<46dff0320801120424v1b780a97x8a4ecfcfe8e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:22:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlvm-0002iq-QX
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbYALTVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYALTVm
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:21:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYALTVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:21:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B4757546F;
	Sat, 12 Jan 2008 14:21:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AC50546E;
	Sat, 12 Jan 2008 14:21:37 -0500 (EST)
In-Reply-To: <46dff0320801120424v1b780a97x8a4ecfcfe8e52f7@mail.gmail.com>
	(Ping Yin's message of "Sat, 12 Jan 2008 20:24:09 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70351>

"Ping Yin" <pkufranky@gmail.com> writes:

>> >
>> > I think you would want to read full 40-char sha1_src and
>> > sha1_dst with "while read", and keep that full 40-char in these
>> > variables, and use them when calling rev-parse here.
>>
>> Hmm, precision is really a problem. However, "git diff --raw" will not
>> always give full 40-char sha1, instead it will give sha1 with enough
>> length. So maybe i can use the sha1 from "git diff --raw" ?
>>
> Oh, I'm wrong. It seems 'git diff --raw' will always give full 40-char
> sha1 for submodule entry and abbreviated sha1 for blob entry.

It is not recommended to use "git diff" in scripts when you can
use one of the "git diff-*" plumbing.  In this case I think you
would want "git-diff-index".  Also see --abbrev option.

You can never determine how many hexdigits are "enough" from the
containing project, as it does not have to have access to the
submodule object store.  That's the reason I suggested to read
full object name from diff-index and use it for error reporting
and object retrieval, and shorten it in the UI for normal status
noise.
