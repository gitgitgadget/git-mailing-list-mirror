From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout --theirs fails
Date: Tue, 15 Mar 2016 14:47:40 -0700
Message-ID: <xmqqd1qv76rn.fsf@gitster.mtv.corp.google.com>
References: <56E845F0.9020609@gmail.com>
	<CAGZ79kbzrpHowSLfCjB6wVfeX_3MUXAjD0rQdcugryWPMrTazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Susi <phillsusi@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:47:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwoe-0001ny-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbcCOVrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:47:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753099AbcCOVro (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:47:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F5654DC11;
	Tue, 15 Mar 2016 17:47:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sard+CcAy9Wuvtt8A01xrjkCJ9o=; b=JgPnYp
	IY8GECjlx9xLJ3gd8ygacvnT5HXjQeeE9VR9ryr3+a4lo30u6POKPSRENhSVgVsz
	c6FLASprFOSPUn+HP67JN0+CMRC5hjOgecEzdfcX1CL4QkZJgmUDvHkv3aKcv0yf
	vztjkxMO5fyyEBXFD9cJoy7fkUqVzr40748YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kk1rS16uGS+Mhx4rKfwvOOEf389WXwUY
	Z6ijlp/d4G66LnfTGqSI2W4dER4PtsV1dnIA902+1AMvvDbjd4hSDTEYl1r3ijfH
	QHnteByVv1bSPYI7925cyankx8mnC/Zk2ROrooun3oj4hMlXQxglBKiJpg6VrxfL
	f/YGNfm7UbA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06CCD4DC10;
	Tue, 15 Mar 2016 17:47:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4F0764DC07;
	Tue, 15 Mar 2016 17:47:42 -0400 (EDT)
In-Reply-To: <CAGZ79kbzrpHowSLfCjB6wVfeX_3MUXAjD0rQdcugryWPMrTazQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 15 Mar 2016 14:35:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B86EFB6-EAF7-11E5-932B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288920>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Mar 15, 2016 at 10:27 AM, Phil Susi <phillsusi@gmail.com> wrote:
>> I'm doing a rebase and got some conflicts.  I just want to take their
>> version of all files, but git checkout --theirs complains:
>>
>> --ours/--theirs' cannot be used with switching branches
>>
>> What gives?  I'm not *trying* to switch branches.  I just want to
>> resolve the conflict by taking their version.  If I try git checkout
>> --theirs ., then it complains that not every single file in the
>> directory has a "their" version.  So?  Take the ones that do.
>
> I think for checking out files you'd need to add the file names.
> In case of a collision between branch name and file name, even add
> a double dash:
>
>     git checkout --theirs -- file/name

That is true, but notice that the last example by Phil gives a dot
as the pathspec to match all available files.

Having said that,

    $ git checkout --theirs -- file/name

would fail when the path file/name is unmerged and does not have
stage #3 entry, wouldn't it?  So with ".", unless all paths that
match that pathspec (i.e. all available files) are either merged
(i.e. without conflict) or have stage #3 entry, it is expected that
the command would fail consistently to the case where a pathspec
"file/name" that happens to match only one path is given, and that
is the behaviour Phil saw, I would think.
