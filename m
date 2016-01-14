From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Worktree "gitdir" file being mangled after upgrade to 2.7.0
Date: Thu, 14 Jan 2016 10:29:29 +0700
Message-ID: <CACsJy8D2Bz42kvBD1e=0oqxrYDry7_wCOy5Fi3oS-sGJxux4-w@mail.gmail.com>
References: <20160113234753.GA26473@gmail.com> <xmqqh9iglwf3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Johnson <palehose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 04:30:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYbu-00068U-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcANDaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:30:00 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35287 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbcAND37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:29:59 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so320298026wmf.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 19:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OuQXFbIZvuBDGmIEMbM+4EPEaz0Vx/RrA97ClGCRpVo=;
        b=jlcSUToAN99GJSiCbRZCE/lTpzw0AaINa9Oi20Gf2bZ4yzL7ozTHSlAVv6/ygumISf
         KQMa0JFJHWrnULcXCQSl0X1pXOHlCGKSfi5GqAFmwcXwSC7R4WayHtRpgVXlw/okPJTZ
         uorb1NYJJ2YQM6kvAYPhsDNpgDIxk9ruCzE8v/Tpt4rJdzz6i20Dty89dAOjMuiRegb/
         LSh4+7SO6tiujszUgCdTmINdD35L42WujXDNKriWLXUf71IU5OscmHcsw9f2wwkdb+Vc
         C5KpKDzpjjAEdTQo9uP+R8zXwJ3/sgZwprx8A5ptCMe+DrX73wQVS0ikFyEFYpALMgh+
         WyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OuQXFbIZvuBDGmIEMbM+4EPEaz0Vx/RrA97ClGCRpVo=;
        b=jfSpSBDn8rtuL2Peg6osbE9MSqX0I9fZfmSPkbNCdBGiV2L2YHh0u5msx/yyr7L+nk
         l4irQ54Km6DT/LefUZTP3vcua0Vf2FQxEkgXXr36MeLIwHSguezPW+QshssaWFl0KelD
         NUiCOvRgJrtehvLQbDOkNfKeJJ6hdITdSNmHbEBXtpxOiWnw6JV6Oy3plwgN50tlos4P
         liahthDc3Mw0JBoh3QiSISC2XZ5WQrgAO1uDFLf5fNrhCkEiH26Wy0POTuKo2eUHBFYG
         stAoC1LZszD7oxwEj2y0k6J1kmtY1j5SWnIEhCK6WARtF41/o7Sp8s19sGLTzizcWPqc
         YiYg==
X-Gm-Message-State: ALoCoQkH0fOjPk4IQWOveNcBeEYNKWGhu2kSQCWaZLMY7VZVcnpEQ9K1AzNsNj5hlo81o/V/QAQcb+dmoBkcEeVFp9I+r4sVfw==
X-Received: by 10.112.12.2 with SMTP id u2mr508964lbb.145.1452742198678; Wed,
 13 Jan 2016 19:29:58 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 13 Jan 2016 19:29:29 -0800 (PST)
In-Reply-To: <xmqqh9iglwf3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284014>

On Thu, Jan 14, 2016 at 9:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Johnson <palehose@gmail.com> writes:
>
>> Since upgrading to 2.7.0 last week, eventually I'll get to a point when
>> I run 'git worktree list' where several worktrees are incorrectly
>> reported as pointing to my main git checkout. Further analysis of the
>> files in $GIT_DIR/worktrees/worktree_name/ shows that the gitdir file
>> for the worktrees which display incorrectly contains ".git" instead of
>> what it should contain (i.e. "/path/to/worktree/.git".
>>
>> This was reported a couple days ago on Github:
>>
>> https://github.com/git/git-scm.com/issues/650
>>
>> Since the audiences for the mailing list and Github don't overlap
>> completely, I figured I'd report it here to get this issue in front of
>> as many eyes as possible.
>
> Thanks for relaying.  Duy, Michael, I think this is your area?

The only place that a relative pat hcan be written is
update_linked_girdir() unless i'm mistaken. That function is being
deleted "soon" because it causes another problem
-- 
Duy
