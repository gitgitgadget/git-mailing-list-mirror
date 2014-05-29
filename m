From: Jonathan Leonard <johanatan@gmail.com>
Subject: Re: .gitmodules containing SSH clone URLs should fall back to HTTPS
 when SSH key is not valid/existent
Date: Thu, 29 May 2014 16:12:38 -0700
Message-ID: <CA+OJ3utofb+od5uct4HF1yoQGfWgX7YTn4hPChDpC7LTFVJDYQ@mail.gmail.com>
References: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
	<53871B8D.40608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Albietz <inthecloud247@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri May 30 01:12:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq9V5-000604-QF
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 01:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbaE2XMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 19:12:40 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:53708 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaE2XMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 19:12:39 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so3114580qgd.24
        for <git@vger.kernel.org>; Thu, 29 May 2014 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1dF4UAKKe1uaTDYvjjp+msellCNThtJOWS47x8ltna0=;
        b=EV45p5G28QmaX0ynpuhy9OYv2qtg+Ht8Yhf3Qep1a73bxfqUOMcvYiBslye2pa3M3V
         I9YxOcTSGM8ElMxmiNABXgdw4EsOiZCFgyFPRc4744NfnhA53zIyB6DUA+H5dpiMmkBh
         ZxZmVljQZ3Zd2HhvmTzqiD/k/it8ZblZZgZAcQfpzJo5a3q92Gsp+2CoeQSbXJXi+fPU
         88JgqiTEL8ZvnUwbUiThpLZT3IkTPEWH0R+Hp1ewnV33xgCR2zIU2TCDU2SzSByeHuAV
         RpG7Kn/5AtM3dWNtI/4nWLG7S3k4/Ur6J5Y/zTGMBietSrt5ZGr0H9CmgvA7grBoM5d7
         ygcg==
X-Received: by 10.140.42.165 with SMTP id c34mr14576144qga.40.1401405158621;
 Thu, 29 May 2014 16:12:38 -0700 (PDT)
Received: by 10.140.108.203 with HTTP; Thu, 29 May 2014 16:12:38 -0700 (PDT)
In-Reply-To: <53871B8D.40608@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250417>

> But you do not give much information about your special use
> case. I assume you have submodule repositories for which some
> developers have a valid ssh key and others don't (maybe
> because they should only have read access via https)?
>

Precisely. Specifically this is for a collection (17 or more) of
GitHub-hosted projects which are maintained by only a couple of people
(who have the ability to directly push via git:// or ssh://).
Everyone else (including deployments and ordinary users) who clones
the repo should be able to just grab the code via HTTPS and have it
work.

> If that is the case you might want to look into access control
> tools like gitolite.
>

We are using GitHub.

>>  Lack of this feature (or presence
>> of this bug [depending on your perspective]) is a major PITA.
>
> But why is https special? Why not fall back to the git
> protocol? Or http? (And no: I'm not serious here ;-)
>

HTTPS isn't special except in that it is the least privileged
transport type (and thus should be the last resort). Whether to
fallback to git:// from ssh:// or vice versa is inconsequential to
this request.

> After the first failed clone of the submodule at via SSH the
> developer could also just do a
>
>    git config submodule.<name>.url https://host/repo
>
> and override the URL from .gitmodules.
>

Yes, this would work. But it would be a painful manual step which we
would not want to force on ordinary users (and would not want to
experience ourselves either).

It should be noted that this is only really a problem as the other
options GitHub gives us are also equally (or more) painful:
a) - a unique deploy key per machine and project. (which at current
would be 17 * 3 keys all manually maintained via clicking through a
GUI [unless we wanted to automate via GitHub API (which is also a
non-trivial amount of work)]).
- or -
b) - a fake 'team' with read-only access with a single fake GitHub
account as member thereof.

I imagine this feature would be convenient for non-GitHub scenarios as
well though.

--Jonathan
