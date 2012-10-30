From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 23:18:04 +0100
Message-ID: <CAMP44s2KNmr7zAvFo2gOR8G=YaoBWiGPCjPY47x00eev6MOAFw@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
	<CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
	<CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
	<CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
	<CAGdFq_h3L-1rPvb=dSYeXqEea+f+g2kRHp7aAjaU-AxjZHB7dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:18:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTK8a-0002FT-OM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab2J3WSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:18:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64767 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2J3WSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:18:05 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so807046obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MgIsTpU/MiX3vBuNbV6v8pvm4MDxn8Gd1wTVVLnh4YQ=;
        b=JFQAkq7HQ5drgZ2e1SQ9pkbNnPJJluiR8a0jJgCqtK0AF3Nv9NTMaqvghNQorj0gdy
         2sQzIryx4jAUljSxp3JCM0uK6UspJFHt+dPtLrS6tddjLWkaWVVLJXFkB1v91paoRf8n
         Kbgvo/FOwlgt5r7ooy2qdXuUDMDXPO824eXAvJayUEkx70Hmm+jgUIMHVL4UUNwwMRD5
         DkBb8S9xlUAjF46AH8ypk3NtTX4SB3f4Cy84+Y7DJ7tgcpETFeS7exKBYSVuw7UAA9AT
         1AN1phh6G+sfGgA7ZXCEK68uNtE/aS/BWhM8qlJcRZgz5MLSn/p0RcU2wf6MK4+viQtQ
         wHTA==
Received: by 10.182.116.6 with SMTP id js6mr28599163obb.82.1351635484164; Tue,
 30 Oct 2012 15:18:04 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 15:18:04 -0700 (PDT)
In-Reply-To: <CAGdFq_h3L-1rPvb=dSYeXqEea+f+g2kRHp7aAjaU-AxjZHB7dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208759>

On Tue, Oct 30, 2012 at 10:59 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Oct 30, 2012 at 2:35 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Oct 30, 2012 at 10:17 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>>> On Tue, Oct 30, 2012 at 11:47 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> Why would it? We are not changing the way objects are exported, the
>>>> only difference is what happens at the end
>>>> (handle_tags_and_duplicates()).
>>>
>>> Because the marking is per-commit, not per-ref, right?
>>
>> Oh, you meant using marks?
>
> No, I meant the 'SHOWN' flag, doesn't it get added per commit, not per
> ref? That is, commit->object.flags & SHOWN refers to the object
> underlying the ref. So I suspect this scenario doesn't pass the tests:

Without marks you cannot have the SHOWN mark at that point; we haven't
traversed the commits.

> git init &&
> echo first > content &&
> git add content &&
> git commit -m "first" &&
> git branch first &&
> echo two > content &&
> git commit -m "second" &&
> git branch second &&
> git fast-export first > actual &&
> test_cmp actual expected_first &&
> git fast-export second > actual &&
> test_cmp actual expected_second
>
> With expected_first being something like:
> <fast-export stream with the first commit>
> <reset command to set first to the right commit>

Why would a 'reset' command be expected if the 'first' branch is
already pointing to the 'first' commit?

> And expected_second being something like
> <fast export stream with the first and second command>
> <reset command to set first and second to their respective branches>

Ditto, plus, why would 'git fast-export second' do anything regarding
'first'? It wasn't specified in the committish; it's not relevant.

Before an after my patch the output is the same:

% git fast-export first:
reset refs/heads/first
commit refs/heads/first

% git fast-export second:
reset refs/heads/second
commit refs/heads/second
commit refs/heads/second

Which is expected and correct; the branch already points to the right
commit, no need for an extra reset.

Cheers.

-- 
Felipe Contreras
