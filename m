From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: clean bug on ignored subdirectories with no tracked files?
Date: Mon, 21 Nov 2011 13:51:50 -0500
Message-ID: <CAG+J_DwKeWntmi22vHS6CRud6Lo0P_+D5u5ih2Bbc50ekYji5w@mail.gmail.com>
References: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com>
	<7vy5vbj4rb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 19:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSYyQ-0001dW-OE
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 19:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1KUSwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 13:52:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46920 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab1KUSwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 13:52:03 -0500
Received: by ghrr1 with SMTP id r1so52941ghr.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tGEzgIObUMud8CfPNVd3dGbFnzGkEX1+8njT+4h+KMY=;
        b=wDzQS6ZBXiCCeUp+uX1/wYv5/eDeZBuihyoRPYelSIgJT+YaRvdXdrDgxv8hSkcs/X
         EQBnRID6N/n34nxOgxG3ehqsCPNei75TyykumJ39HGSofrjCrTf7/TVuXii4u83caKV4
         ZYti4CUMalyQamiS6qPXdFEFZzc4gigMSz7yw=
Received: by 10.236.192.233 with SMTP id i69mr22241315yhn.60.1321901510682;
 Mon, 21 Nov 2011 10:51:50 -0800 (PST)
Received: by 10.146.1.15 with HTTP; Mon, 21 Nov 2011 10:51:50 -0800 (PST)
In-Reply-To: <7vy5vbj4rb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185756>

On Sat, Nov 19, 2011 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> git init test_repo &&
>> cd test_repo &&
>> mkdir -p foo/bar &&
>> echo baz > foo/bar/baz &&
>> echo /foo/bar > .gitignore &&
>> git add .gitignore &&
>> git clean -n -d
>>
>> Initialized empty Git repository in .../test_repo/.git/
>> Would remove foo/
>>
>> Seems surprising.
>
> You said "everythingthing in foo/bar is uninteresting and can be cleaned",
> you have one untracked file in "foo/bar" hierarchy, and you have nothing
> else in "foo/" hierarchy.

Just because it is uninteresting to git does not mean that it isn't
precious. In this case the ignored files are from svn and checked out
via another tool (gclient).

> Removing the uninteresting cruft as your .gitignore instructs Git makes
> the entire "foo/" hierarchy devoid of any contents. I would *expect* Git
> to clean "foo" in this case.

But .gitignore is not for indicating "this is cruft", it is for
indicating "this is not under git's purview." You must admit that git
clean's behavior above, if not surprising to you, is at least
inconsistent with:

$ git init test_repo && cd test_repo && mkdir foo && touch foo/bar &&
echo /foo > .gitignore && git add .gitignore && git clean -n -d

which does protect foo (and its contents) from being cleaned.

git clean specifically has an option for "remove only the stuff which
is ignored" which implies that it should not be removing ignored stuff
w/o that option.

> I've seen some "surprising" behaviour in "git clean" (which I do not use
> myself, I do not consider part of "my code", and I am not surprised if it
> has many bugs), but I fail to see what is surprising in your transcript.
>
> It would be a different issue if you had ">foo/other" before your "clean".
> Then "foo/" has "foo/clean" that is not declared to be uninteresting.

Huh? clean is designed to remove untracked unignored files, so I'd
expect it to remove foo/other in that case. And what is this foo/clean
to which you refer?

j.
