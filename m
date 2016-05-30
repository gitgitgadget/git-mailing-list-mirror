From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] perf: make the tests work in worktrees
Date: Mon, 30 May 2016 11:03:18 -0700
Message-ID: <xmqqr3cjo23d.fsf@gitster.mtv.corp.google.com>
References: <cover.1462955446.git.johannes.schindelin@gmx.de>
	<cover.1463145936.git.johannes.schindelin@gmx.de>
	<0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
	<574B1C3D.3000706@web.de>
	<alpine.DEB.2.20.1605301026430.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 30 20:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RXN-00067u-G2
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161717AbcE3SD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:03:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161330AbcE3SD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:03:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BEC91EDDA;
	Mon, 30 May 2016 14:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=96pb5kgLF/4vc9tsyRcGBtDQQ8Y=; b=t608zq
	IztqaUVO0xBbH0ixqObinGM7IrxAwTcnQ6MyoiC7eJidRpuPcsXoOqQnEWrXjpgR
	V/OKOCgPIFuzg/D1KtoTQFO21yifLPpbo2DiEDjChOQJuRnANvX5WJlSWs4/XBxb
	7Ofu+xqIlbcRi3xnsdWqiPmCzAXZrDJOE6/TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwsuvCbWjJNg7mshWxnj/8KRLPH20y4b
	Yuu/r7jV9r91FlwnmO8xfObI9GGg4nnGbulehu+2o5ZKIgWv7BdRGZPINF3P+HbE
	FR6XfAeUn7z9lN8k1BiLKceABLZ72Ovy/F6uchcLQpgzgKT4tlXccnOwsY9ClLMF
	bIagmugNMl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1542E1EDD9;
	Mon, 30 May 2016 14:03:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F0581EDD8;
	Mon, 30 May 2016 14:03:20 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605301026430.4449@virtualbox> (Johannes
	Schindelin's message of "Mon, 30 May 2016 10:28:04 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB19755C-2690-11E6-9206-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295916>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This breaks perf for the non-worktree case:
>
> Oh drats!
>
>> lsr@debian:~/src/git/t/perf$ make
>> rm -rf test-results
>> ./run
>> === Running 12 tests in this tree ===
>> cp: cannot stat '.git/objects': No such file or directory
>> error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash directory.p0000-perf-lib-sanity'
>> cp: cannot stat '.git/objects': No such file or directory
>> error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash directory.p0001-rev-list'
>> ...
>> 
>> Here's a fix:
>> 
>> -- >8 --
>> Subject: perf: make the tests work without a worktree
>> 
>> In regular repositories $source_git and $objects_dir contain relative
>> paths based on $source.  Go there to allow cp to resolve them.
>> 
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>  t/perf/perf-lib.sh | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
>> index 5ef1744..1888790 100644
>> --- a/t/perf/perf-lib.sh
>> +++ b/t/perf/perf-lib.sh
>> @@ -84,6 +84,7 @@ test_perf_create_repo_from () {
>>  	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
>>  	mkdir -p "$repo/.git"
>>  	(
>> +		cd "$source" &&
>
> I fear that interacts badly with the `cd "$repo"` I introduced later
> (replacing a `cd ..`)...

What do you want to do then?  For now before -rc1 we can revert the
whole thing so that we can get a tested thing that works in both
layouts.
