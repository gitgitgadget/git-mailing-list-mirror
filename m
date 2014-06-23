From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of xmalloc + sprintf
Date: Mon, 23 Jun 2014 15:43:02 -0700
Message-ID: <xmqq61jrb62x.fsf@gitster.dls.corp.google.com>
References: <20140619211659.GA32412@sigill.intra.peff.net>
	<20140619212800.GF28474@sigill.intra.peff.net>
	<CAPig+cTyZxH6Ka3JVpYBP7=i=HAWoSYBt9MScwfVaTcKKmi1UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzCxH-0003f5-4J
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 00:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbaFWWnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 18:43:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51736 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbaFWWnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 18:43:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5503422B1F;
	Mon, 23 Jun 2014 18:43:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7n/MeltpXZLuurtAxtbbFfr8130=; b=gQ8Aat
	lIS7MCle//h4Ak0xlX1i3mvN0Kf6qAlooF90vMh6QcxMgiAZ2f2657pX8qT77Gr6
	qiQ2j2+FbysEhmCJ5Fkj1RzCgzRMCoB6C0ro/9+Ma4He1Z3vSqj1ncUTe7JGfo2b
	tFxqfS5Su4FpPTzeDgsF31loy1rxmThkLoqTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KmyoxtGs3Rnbgx2NqjdEkLt2bovikzpP
	5Wp3mi+LpCIfGd9R204uYPVOWXdysN63VwA41gwC1HlBGxNy2pWSpxcbHTwa03K5
	fmkiY7Kdr604kftBIb7B9GmKIiOvJhg3KlgRQ5EfxR5TsfBrFk8DaqLbb9FS31sn
	6KdF3xe4mko=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48F5322B1D;
	Mon, 23 Jun 2014 18:43:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A3BDB22AF7;
	Mon, 23 Jun 2014 18:42:59 -0400 (EDT)
In-Reply-To: <CAPig+cTyZxH6Ka3JVpYBP7=i=HAWoSYBt9MScwfVaTcKKmi1UA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 23 Jun 2014 06:21:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BA294C86-FB27-11E3-A77C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252374>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jun 19, 2014 at 5:28 PM, Jeff King <peff@peff.net> wrote:
>> This is shorter, harder to get wrong, and more clearly
>> captures the intent.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I wondered if there was a reason to avoid this (because we are in
>> setup_git_env, which can potentially be called by git_pathdup). But the
>> git_graft_file initialization below already uses it, and I
>> double-checked that it is safe once git_dir is set.
>
> This patch will conflict textually with patch 6/28 of Duy's
> nd/multiple-work-trees series [1].

Thanks; I noticed that and dropped the other topic tentatively, as
it is being rerolled anyway.  In addition to that, because this
series seems fairly focused and well done, and the owners of two
topics known to be competent and active folks, I do not think there
is not much to be worried about ;-).

>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/242300/focus=243649
>
>>  environment.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/environment.c b/environment.c
>> index 4dac5e9..4de7b81 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -135,15 +135,11 @@ static void setup_git_env(void)
>>         gitfile = read_gitfile(git_dir);
>>         git_dir = xstrdup(gitfile ? gitfile : git_dir);
>>         git_object_dir = getenv(DB_ENVIRONMENT);
>> -       if (!git_object_dir) {
>> -               git_object_dir = xmalloc(strlen(git_dir) + 9);
>> -               sprintf(git_object_dir, "%s/objects", git_dir);
>> -       }
>> +       if (!git_object_dir)
>> +               git_object_dir = git_pathdup("objects");
>>         git_index_file = getenv(INDEX_ENVIRONMENT);
>> -       if (!git_index_file) {
>> -               git_index_file = xmalloc(strlen(git_dir) + 7);
>> -               sprintf(git_index_file, "%s/index", git_dir);
>> -       }
>> +       if (!git_index_file)
>> +               git_index_file = git_pathdup("index");
>>         git_graft_file = getenv(GRAFT_ENVIRONMENT);
>>         if (!git_graft_file)
>>                 git_graft_file = git_pathdup("info/grafts");
>> --
>> 2.0.0.566.gfe3e6b2
