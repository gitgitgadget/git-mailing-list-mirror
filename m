From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record base tree info
Date: Tue, 26 Apr 2016 11:58:39 -0700
Message-ID: <xmqq4maogpsw.fsf@gitster.mtv.corp.google.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
	<xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZNV+g3_Rmpynh-WQVc3dW6nuNDsTM=gTxNuJnr3V3Azg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8C7-0001EH-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcDZS6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:58:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752074AbcDZS6n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:58:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B8EC15405;
	Tue, 26 Apr 2016 14:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoMdusLOtXKMcYVEQ3ZwdPy0HAE=; b=VGcqnw
	ycHC3x0nTmIDVIF9LZYWLt/feBtIAgFojV1M0hHz1SnjBHC8+uwTk7FPqA29ZQPS
	1b7LMd04Or4q2PJjZZ+noSOBUtRFR0lcL7RznT2p/Eu64nHVxTOACRNFIWHnaWPb
	1l90fbWH3F53Z/Ukh/Ae4uYPKW7pDXI6W96Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DiVNXN0N8jT2Jm+jq1hnX/OcMlzcH9lz
	zj8vU2VsuckhSFzqcLGCtEDloTx+zdpanWPf40wXYpI9L0lWXEfmhKama/a0hfkv
	DLumBGmUCAaLkHibQTOeUfBKBSHaY+h/c9KhxmZ/IP9npTATiASXX6jHIIiFfW6B
	K6C+J4I7DLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 83D0815404;
	Tue, 26 Apr 2016 14:58:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D893615403;
	Tue, 26 Apr 2016 14:58:40 -0400 (EDT)
In-Reply-To: <CAGZ79kZNV+g3_Rmpynh-WQVc3dW6nuNDsTM=gTxNuJnr3V3Azg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 26 Apr 2016 11:43:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E425F0A4-0BE0-11E6-9356-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292647>

Stefan Beller <sbeller@google.com> writes:

>> So from where are you proposing Git to grab that information if you
>> do not tell it?  "If the HEAD is detached, assume that the base is
>> where it was detached from" or something?
>
> That would also work for me. In my first mail I was proposing to take
> the information from the format-patch argument, such that a one off fix
> would be:
>
>     (1) git checkout origin/master
>     (2) EDIT
>     (3) git commit -a -m "fix"
>     (4) git format-patch origin/master..  # <- This is the information.
>
> However you read it as taking the information from the first line,
> which is also fine with me, as then the (4) can become
>
>     (4a) git format-patch HEAD^

Either would work, but reading from (4) feels a lot less black magic
to me.

>> If you are doing "format-patch master..my-branch", what do you
>> propose to set your base to?  master@{u}, perhaps?
>
> Yes. (I usually use that command with |s|master|origin/master|, so the
> argument is the upstream already. A local master branch does not exist for me.)

Let's hear from folks at Intel ;-) Both of the above sounds like
sensible enhancements to me.
