From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 11/19] pull: check if in unresolved merge state
Date: Wed, 10 Jun 2015 23:12:06 +0800
Message-ID: <CACRoPnSQd_YEp4mNFbqDZtBJGztkHLXWbDojcAJRNvpynFRCew@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-12-git-send-email-pyokagan@gmail.com>
	<xmqqsia0uzaa.fsf@gitster.dls.corp.google.com>
	<xmqqr3pjocgm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hfw-0006jV-15
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbbFJPMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:12:09 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36835 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbFJPMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:12:07 -0400
Received: by lbbqq2 with SMTP id qq2so30780754lbb.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cvQ+YW7gES8lVloj7nPlYzzzd1CqlhSUPIS0FkTAVW8=;
        b=oEf9t+C6gtsawuvV1Z9japKyBEGGUTBN7b6bgUhWd1dw7r59dischRFyA/jT7YrcZP
         D6qvJlfCKukxbMgDsXVOowt2ORMOOYI/OuLXmuGI5/c8ZT67mJlGC2PTjkwAGy3ZcM5z
         0pKmEP4XEtdq3XgY880e0eCwXpqpKvrqh9J1vDkWOfiSwfQRvq//4GXDlb0WdT7buM9Y
         KmgtSnSNGyTBtEZr6GTyKmX/fMlSVKNYdd5lEzGKGTszcBKL5ZyrroJpJ7bQxfph9U03
         RUh4woweVjHJRy1m8XanolqKaNVpwMbyT5Valb5x3IfarDdciinXeesHK325e1FmeDPR
         4AaQ==
X-Received: by 10.152.6.105 with SMTP id z9mr4516903laz.98.1433949126108; Wed,
 10 Jun 2015 08:12:06 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 10 Jun 2015 08:12:06 -0700 (PDT)
In-Reply-To: <xmqqr3pjocgm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271297>

On Wed, Jun 10, 2015 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Paul Tan <pyokagan@gmail.com> writes:
>>
>>> @@ -422,6 +423,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>>
>>>      parse_repo_refspecs(argc, argv, &repo, &refspecs);
>>>
>>> +    git_config(git_default_config, NULL);
>>> +
>>> +    if (read_cache_unmerged())
>>> +            die_resolve_conflict("Pull");
>>> +
>>> +    if (file_exists(git_path("MERGE_HEAD")))
>>> +            die_conclude_merge();
>>> +
>>>      if (!opt_ff.len)
>>>              config_get_ff(&opt_ff);
>>
>> Hmph.
>>
>> If you are going to do the git_config() call yourself, it might make
>> more sense to define git_pull_config() callback and parse the pull.ff
>> yourself, updating the use of the lazy git_config_get_value() API you
>> introduced in patch 10/19.
>>
>> The above "might" is stronger than my usual "might"; I am undecided
>> yet before reading the remainder of the series.
>
> Let me clarify the above with s/stronger/with much less certainty/;

Uh, I have no idea what a "strong might" or a "less certain might" is. :-/

Parsing all the config values with a git_config() callback function is
certainly possible, but I was under the impression that we are moving
towards migrating use of all the git_config() callback loops to the
git_config_get_X() API.

In this case though, we have to use git_config() to initialize the
advice.resolveConflict config setting, but I don't see why it must be
in conflict with the above goal.

Thanks,
Paul
