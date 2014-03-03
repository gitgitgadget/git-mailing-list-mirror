From: Guanglin Xu <mzguanglin@gmail.com>
Subject: Re: [PATCH v4] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 16:57:18 +0800
Message-ID: <CAATe9ugnq6bm8W05RP=uq+nPEZqsyRYFosRvyJwOSot+ynPOKw@mail.gmail.com>
References: <1393828581-65523-1-git-send-email-mzguanglin@gmail.com>
	<CAPig+cQ7Zg-jPewuaYJ7K8aZBfJQPPt64Pzn9g1GdbikTQORzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKOgd-0000NH-LC
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 09:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbaCCI5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 03:57:19 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37805 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbaCCI5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 03:57:18 -0500
Received: by mail-ie0-f173.google.com with SMTP id rl12so2529913iec.32
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 00:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nFwuwqABhO5BSOSjUFnpNlx4ThT/7APqMwqAu4aHz5A=;
        b=imiDvjkzJCynWJhrt8omJxbKqAI22B1BYJZLEh1yyTMj9IjzECCWreF2nGwoE0/3VX
         h41vG/FE8xDnUBwpRqpKcxBaeBifj5SfT8+yjtOAJhQf1Hyry3mySRQ6dfiURnmJzFFE
         fEHLjyORQ30F4awpQnNUU8vpGnuB7OM7Fj9Qspj5GaSfs6WdiKUGJi/W6C+5NOR/040l
         k7q9d7TIJ+rA+diXG/goxN9DZigNFJSi6IaN73MnVZyPp/MedGWNbXD3097FFXNnRlIK
         iBb3c0YebVzRHne/+P78SuodUPMetHxf5R6pD0fMYof4fWnZvHgHd7XNQ/0ba5lQ+wvm
         jSeQ==
X-Received: by 10.42.129.9 with SMTP id o9mr24689833ics.38.1393837038301; Mon,
 03 Mar 2014 00:57:18 -0800 (PST)
Received: by 10.64.14.135 with HTTP; Mon, 3 Mar 2014 00:57:18 -0800 (PST)
In-Reply-To: <CAPig+cQ7Zg-jPewuaYJ7K8aZBfJQPPt64Pzn9g1GdbikTQORzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243200>

Hi Eric,

Yes, you're right. "!!" is comfortably concise and also idiomatic in
Git sources.

Thanks,

Guanglin

2014-03-03 16:12 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Mon, Mar 3, 2014 at 1:36 AM, Guanglin Xu <mzguanglin@gmail.com> wrote:
>> to avoid a magic code of 11.
>>
>> Helped-by: Sun He <sunheeh...@gmail.com>
>> Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
>> Helped-by: Jacopo Notarstefano <jaco...@gmail.com>
>>
>> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
>> ---
>>
>> This is an implementation of the idea#2 of GSoC 2014 microproject.
>>
>>  branch.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..4eec0ac 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -49,8 +49,12 @@ static int should_setup_rebase(const char *origin)
>>
>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>> -       const char *shortname = remote + 11;
>> -       int remote_is_branch = starts_with(remote, "refs/heads/");
>> +       const char *shortname = skip_prefix(remote ,"refs/heads/");
>> +       int remote_is_branch;
>> +       if (NULL == shortname)
>> +               remote_is_branch = 0;
>> +       else
>> +               remote_is_branch = 1;
>
> A bit verbose. Perhaps just:
>
>     int remote_is_branch = !!shortname;
>
> which you will find to be idiomatic in this project.
>
>>         struct strbuf key = STRBUF_INIT;
>>         int rebasing = should_setup_rebase(origin);
>>
>> --
>> 1.9.0
