From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #08; Fri, 26)
Date: Sat, 27 Feb 2016 09:42:10 -0800
Message-ID: <xmqqy4a6gidp.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwfhwey.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka_3wr7uCLRjA6DqzSUOF8V+SVH_89WxPsx=jjucaWmMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:42:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZisk-0005Q5-MC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992532AbcB0RmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:42:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756553AbcB0RmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:42:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F85F45B19;
	Sat, 27 Feb 2016 12:42:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRWtXaeZDIQlpnweZPXmuAPG5IU=; b=bCHz9h
	56fWW2PBY8GeS4uLqNdBQLoQPbp4MAnbKXGUyuazuUo0qFs6feH1PQQQqrXkpxel
	77618CQiB47xm/egyzuE038tr31rGTvckgzhHqJVLFGivBO+lRVbUeROn1tHspBO
	TZSty9EbGINQk2X1u6iLOBpNXLry0dmfI4DUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfiXp83KfdLmUycZthrLGvUiGzqXY+N2
	6ewVSivRLwzyngor6C8SNsmtiVg8S33mHoUEsmb1iLTa611ft6gX3IarH3eUxWDo
	cdYyQSzdzX9U00lWgwo3cJ6F3THyoOUljMkucWXE8XYCte7MSxrD27hPiBuTIYUs
	MoehZZDYyCI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03D4E45B18;
	Sat, 27 Feb 2016 12:42:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 73A4D45B17;
	Sat, 27 Feb 2016 12:42:11 -0500 (EST)
In-Reply-To: <CAGZ79ka_3wr7uCLRjA6DqzSUOF8V+SVH_89WxPsx=jjucaWmMg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 26 Feb 2016 15:57:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E3C0C7E-DD79-11E5-83F7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287708>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 26, 2016 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * sb/submodule-parallel-update (2016-02-25) 11 commits
>>  - clone: allow an explicit argument for parallel submodule clones
>>  - submodule update: expose parallelism to the user
>>  - git submodule update: have a dedicated helper for cloning
>>  - run_processes_parallel: correctly terminate callbacks with an LF
>>  - run_processes_parallel: rename parameters for the callbacks
>>  - run-command: expose default_{start_failure, task_finished}
>>  - run_processes_parallel: treat output of children as byte array
>>  - submodule update: direct error message to stderr
>>  - fetching submodules: respect `submodule.fetchJobs` config option
>>  - submodule-config: drop check against NULL
>>  - submodule-config: keep update strategy around
>>  (this branch is used by dt/refs-backend-lmdb and sb/submodule-init.)
>>
>>  A major part of "git submodule update" has been ported to C to take
>>  advantage of the recently added framework to run download tasks in
>>  parallel.
>>
>>  Seems to break tests when merged to the tip of 'pu'.
>
> There was a version (v17[1]) which broke tests,

I think the series was updated and this comment was left stale.
Will be fixed in the next issue.

Thanks
