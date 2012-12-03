From: Tomi Belan <tomi.belan@gmail.com>
Subject: Re: [BUG?] git-subtree behavior when the -P tree is removed and recreated
Date: Mon, 3 Dec 2012 11:39:36 +0100
Message-ID: <CACUV5ocT56iOS3dZsJ4JLo70o1HJv2TSrvBHE646SyQVmOuYRg@mail.gmail.com>
References: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
 <CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 11:41:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfTRz-0005My-9T
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 11:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab2LCKkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 05:40:10 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65365 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab2LCKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 05:40:07 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2277510obb.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 02:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=5xMvuol+EsWBYo0gyfLZM57Rfcoy4bo8FshfMJe91s8=;
        b=XgfvbZWlXI1wFAwqM1VcSDG5IshXFStLwHeJp+Z9WuuNBoeAzlseDr4wTH+Bp3gCPh
         nPwtfsY2rXb6dwW4UvH/wQu80ICsuAT4xvrS7qxbWa+NZMZ4pWr1I5jUso+DmSfIRxCg
         9WJmfIW+nO1drc+OouZUKNy14CmRcasgtKBty8sKpT/G9kcDphBwPlKXqE24pAVwLMfq
         Aw1oFKIHalin4DLllR/o0E3kn9J+COhKQgURgavEQZZNZR6DeHtOS4ojgqZ25UI5uexZ
         h1FTkx5lQBNtq4bVyMNS1YAf0R8U+YWuEq0T8equThxStkl0cC7by9tM1hePWAmuHYMT
         /2gg==
Received: by 10.182.194.2 with SMTP id hs2mr3935715obc.97.1354531206502; Mon,
 03 Dec 2012 02:40:06 -0800 (PST)
Received: by 10.76.173.198 with HTTP; Mon, 3 Dec 2012 02:39:36 -0800 (PST)
In-Reply-To: <CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211035>

Another bump. I reported this back in October, but there hasn't been
any response yet...

Note that the bug is still present in git 1.8.0.1.

Tomi

On Sun, Oct 21, 2012 at 11:18 PM, Tomi Belan <tomi.belan@gmail.com> wrote:
> This probably got lost in the mail. Could somebody familiar with
> git-subtree take a look?
> Tomi
>
> On Sat, Oct 13, 2012 at 3:47 PM, Tomi Belan <tomi.belan@gmail.com> wrote:
>>
>> Hello folks,
>>
>> I think I might've found a bug in git-subtree: I have a repository
>> containing a directory "foo". I'd like to use its code in other
>> projects, so I want to split it off into its own repository with
>> git-subtree. But it doesn't work as it should. I found out that long
>> ago, my repository contained an unrelated directory also called "foo"
>> which has since been deleted.
>>
>> Steps to reproduce (after installing git-subtree from contrib):
>> git init repo
>> cd repo
>> mkdir foo; touch foo/v1
>> git add -A .; git commit -m v1
>> rm -rf foo; touch v2
>> git add -A .; git commit -m v2
>> mkdir foo; touch foo/v3
>> git add -A .; git commit -m v3
>> git subtree split -P foo -b splitfoo --annotate="split "
>>
>> What should happen: Either (A) splitfoo only contains "split v3", or
>> (B) splitfoo contains "split v1" and "split v3"
>>
>> What happens instead: The parent of "split v3" is "v2", so splitfoo's
>> full history is: "v1" -> "v2" -> "split v3".
>>
>> Git version: 1.7.12.2
>>
>> Bonus questions:
>> - which is the intended behavior, (A) or (B)?
>> - if it's (B), how do I convince git-subtree to do (A) once this bug
>> gets fixed? (I might be getting too far ahead of myself here...)
>>
>> Tomi
