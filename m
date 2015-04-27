From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Mon, 27 Apr 2015 11:10:25 -0700
Message-ID: <xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:10:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmnUH-0001Yb-5P
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbbD0SK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:10:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932817AbbD0SK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:10:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2C6D4C633;
	Mon, 27 Apr 2015 14:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DIk+M43+CLk7DNX6aeTRMyNq/Xk=; b=jIFs83
	MlK4NLIbSMeLrMym92Tkhc5vb5tBG99GBdCj89blDNpa5IciPwj73ZJadq+D2kRz
	ziVFJYxHucsej369Az0ohHn5f+Jtn15Ki1J4UrzB8NxaxVhUtevP2CHhV17297EJ
	jJZsHJ2cOiRjPQDoHuvmCL6rjk6GOVeD5L3cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CkfUtm0Ek+BPyBwDquKueP4olSTDbsJJ
	pCaOjxKcNVTn+1v8aPA6zopw+9VzxI3f3tZHuFtfwb2YMv30PDifKLaPqwatt6tS
	AGqntBpd2HJ3OxymnMurejMUH1gxYD77xUI/7c1x5e8jy5SFa8S3ru0Y3ZWkOF/2
	ZgsLswo2T2Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9C204C631;
	Mon, 27 Apr 2015 14:10:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E7124C630;
	Mon, 27 Apr 2015 14:10:26 -0400 (EDT)
In-Reply-To: <CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	(Quentin Neill's message of "Mon, 27 Apr 2015 08:46:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE13A058-ED08-11E4-B843-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267862>

Quentin Neill <quentin.neill@gmail.com> writes:

>> It's not clear why you relocated documentation of --show-email from
>> git-blame.txt to blame-options.txt, and the commit message does not
>> explain the move. If there's a good reason for the relocation, the
>> justification should be spelled out so that people reviewing the patch
>> or looking through history later on will not have to guess about it.
>
> I moved it to be with the other variables that had configuration
> options, but I will move it back.

Please do not do anything before you understand why there are two
places, and if you don't understand, ask.

If you do this:

    $ git grep blame-options Documentation/

you would discover that blame-options.txt is meant to hold things
that are shared across "git annotate" and "git blame".  What is
understood only by "git blame" but not by "git annotate" is to be
described in git-blame.txt, I think.  So the criteria is not "does
it have configuration?"; it is "does git-annotate understand it?"

>>> @@ -1926,7 +1927,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>>>                 printf("%.*s", length, hex);
>>>                 if (opt & OUTPUT_ANNOTATE_COMPAT) {
>>>                         const char *name;
>>> -                       if (opt & OUTPUT_SHOW_EMAIL)
>>> +                       if ((opt & OUTPUT_SHOW_EMAIL) || show_email)
>>
>> The desired behavior is for a configuration setting to provide a
>> fallback, and for a command-line option to override the fallback. So,
>> for instance, if blame.showemail is "true", then --no-show-email
>> should countermand that. Unfortunately, the way this patch is
>> implemented, it's impossible to override the setting from the
>> command-line since show_email==true will always win (when
>> blame.showemail is "true").
>>
>> More below.
>
> I followed the code for blame.showRoot and blame.blankboundary.

I do not think that is quite true.

The code strucure for other existing options is perfectly fine.
What they do is:

    - show_root is initialized to the fallback default value of
      false by being in BSS;

    - configuration is read to tweak that default;

    - command line parser may override the default with --show-root
      or --no-show-root.

And then show_root is used throughout the system.

If you truly followed this code pattern, I would expect that there
will not be a separate show_email variable introduced to support
this new configuration variable.  The OUTPUT_SHOW_EMAIL bit in the
opt flag word corresponds to show_root and blank_boundary variables,
so the code to read configuration variable would set that bit in the
opt flag word before the command line parser would kick in.  And the
code that checks "opt & OUTPUT_SHOW_EMAIL" currently does not have
to change at all.
