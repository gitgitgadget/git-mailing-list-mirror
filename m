From: James Nylen <jnylen@gmail.com>
Subject: Re: [PATCH] Add --unannotate option to git-subtree
Date: Thu, 17 Jan 2013 15:56:57 -0500
Message-ID: <CABVa4NhwcD584ptSazOR9WvSWep1z+krhxkWDvUk8nXaF8EYxQ@mail.gmail.com>
References: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
	<87a9st4sb8.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Thu Jan 17 21:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvwWW-0000iP-MM
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 21:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab3AQU47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 15:56:59 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:63933 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3AQU46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 15:56:58 -0500
Received: by mail-vc0-f180.google.com with SMTP id p16so2969966vcq.39
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=npw0TgUjjleX13BwUvAho4zdRtr1pFwedMmgeSlbPYY=;
        b=ChcBx5dvpXfpgyEqROfUlUywUOYl3mOvMcSCUnkMnFjzwtN9Lh4ihiKAU41vTdw4SV
         eVZD6Mg1Ooa63QyJiipkD5dCAmE/IGKMAzLR+l4a7YouwPTRSu1MkJKVjMmNxVd777ZE
         75JUudTQtrBzzqxDK5VHIrd8enNN+nGFJacbSLW2D1atqdtODyCink0vdQXJoQUt1Fro
         JNGus3f6aWBg3ivk75reYFc+aRL9+gpM25dnKDYsruPdeBdxsB/1sAr/eugHixJwGdkg
         u64m26htQ2kxlF/1TWMtQAeruJPFN0veQ+bogm67e8mbACtJOBwkqLvdyDDe9DufEF5m
         ufRw==
X-Received: by 10.52.70.205 with SMTP id o13mr6161124vdu.75.1358456217905;
 Thu, 17 Jan 2013 12:56:57 -0800 (PST)
Received: by 10.220.125.65 with HTTP; Thu, 17 Jan 2013 12:56:57 -0800 (PST)
In-Reply-To: <87a9st4sb8.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213877>

On Mon, Dec 31, 2012 at 8:15 PM,  <greened@obbligato.org> wrote:
> James Nylen <jnylen@gmail.com> writes:
>
>> Rather than adding a marker to each commit when splitting out the
>> commits back to the subproject, --unannotate removes the specified
>> string (or bash glob pattern) from the beginning of the first line of
>> the commit message.  This enables the following workflow:
>
> I applied the patch to my working copy but it doesn't seem to do
> what I'd expect.  The test script does something like this:
>
> - create project A
> - add file to project A with message "subproj: add F1"
> - add file to project A with message "subproj: add F2"
> - add project A as a subtree of project B under directory subdir
> - add a file to subdir with message "subproj: add F3"
> - do a split --unannotate="subproj:"
>
> I expected to see a log with no mention of "subproj" anywhere.  Instead
> I get:
>
> add F3
> subproj: add F2
> subproj: add F1
>
> Is this as you intend?  Is --unannotate only supposed to strip the
> string for commits added when A was a subtree of B?
>
> I guess this behavior makes sense in that the user would want to
> see the same commits that existed before A became a subproject.
>
>                    -David

Wow, I missed a bunch of emails on this.  Thanks for applying and for
writing tests!

This is as intended.  You wouldn't want subtree to modify commits that
occurred in the full repository for project A.  Furthermore, you
wouldn't have a "subproj:" commit in project A's standalone repo since
it wasn't a subproject at that time.

The --annotate option confused me because it was the reverse of what I
wanted.  As in your example, a typical use would be 'add a file to
subdir with message "subproj: add F3" ' to make it clear that you were
committing to the "subproj" part of a larger repository.  Then, when
splitting back out to subproj's main repository, you'd want to remove
the prefix.
