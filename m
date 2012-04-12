From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Wed, 11 Apr 2012 20:21:00 -0700
Message-ID: <CAJDDKr5q=a+5D0SKUiCTuL=qCxNBoLWJc=_aBFWu2ZfD_0VUzw@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr76eMiA4rOHQhar3aToVThDfbc8Ki5tr2PGU_UpDMAVeA@mail.gmail.com>
	<CAFouetijF5vt9r1GfbntJ0BEqoo0FpztkeqrmeN=-6DK1Q_XRA@mail.gmail.com>
	<CAJDDKr7XXqWBRVXhEenWVcE+7526sYVV821Ytty0xbZBvshd-w@mail.gmail.com>
	<CAFouetgfPuiYO9xKPGQ1GGjr6JvMXM7et_7oYrWRrg+RMj9mCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 05:21:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIAap-0002xA-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 05:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934160Ab2DLDVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 23:21:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43914 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654Ab2DLDVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 23:21:01 -0400
Received: by yenl12 with SMTP id l12so867042yen.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 20:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MTRRxvqRS3xLUOLF8equ3uhhLnni91jEFUMxlEn8Kt8=;
        b=BeeybZzyKWzh+hFFxMz70yElL7QHt4yJ0nf2YjlacnvnD4geMrdsxHVwEdaAkzoXRE
         jSxKvxk4i9F/C+cy7Grqc6Y4CYBh4W8AgVNLCH++0czwSVdeRF0RXrnFN/m2o7KRJo28
         gJaf/JCdGVkuCr+4oTRUCYXUnBDNYYFisuEir9EwJv94gq6nUaMQuETXWMejMJUnzAe7
         iYUN7sw72HO7qZSa1lTkldPbkaBcNer2eIaXqIwNW48yERba+4wWw4/XZw1i3EUXo5hQ
         vnSTs5ZaRwpr91EUKG/zxYqk2+cCjyJcC2nzL4gYisNYicyXRN0d7YXp1haPLWKtVltw
         nnBQ==
Received: by 10.236.187.68 with SMTP id x44mr609048yhm.129.1334200860604; Wed,
 11 Apr 2012 20:21:00 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Wed, 11 Apr 2012 20:21:00 -0700 (PDT)
In-Reply-To: <CAFouetgfPuiYO9xKPGQ1GGjr6JvMXM7et_7oYrWRrg+RMj9mCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195290>

On Wed, Apr 11, 2012 at 9:46 AM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> On Wed, Apr 11, 2012 at 5:02 AM, David Aguilar <davvid@gmail.com> wro=
te:
>> On Tue, Apr 10, 2012 at 10:24 AM, Tim Henigan <tim.henigan@gmail.com=
> wrote:
>>> On Mon, Apr 9, 2012 at 8:14 AM, David Aguilar <davvid@gmail.com> wr=
ote:
>>>> On Wed, Apr 4, 2012 at 12:21 PM, Tim Henigan <tim.henigan@gmail.co=
m> wrote:
>>
>> I think the right thing to do would be to not override GIT_DIR at al=
l.
>> =C2=A0I haven't read it deeply enough to know whether it was being
>> overridden for a specific reason, but I think it should be safe to
>> leave it as-is.
>>
>> Git.pm ends up overriding these variables itself anyways when callin=
g commands.
>
> I tried to avoid setting $GIT_DIR in earlier versions of the patch.
> However as discussed here [1], either 'git update-index' or 'git
> checkout-index' did not work as expected without explicitly setting
> $GIT_DIR.
>
> If $GIT_DIR is not set, 'update-index' and 'checkout-index' will only
> work if 'difftool' is called from the repo root. =C2=A0If 'difftool' =
is
> called from a subdirectory, then one of the commands fails.
>
> I suspect that when $GIT_INDEX_FILE is set but $GIT_DIR is not, then
> $GIT_DIR is assumed to be 'pwd'. =C2=A0However, I was not able to pro=
ve
> that.
>
>
>> The GIT_WORK_TREE check should use $repo->wc_path(). =C2=A0Git.pm's =
already
>> done all the hard work ;-)
>
> I also tried this in an earlier version of the patch. =C2=A0As noted =
here
> [2], I found that when 'difftool' was run from a subdirectory of the
> repo root, '$repo->wc_path()' returned the subdirectory rather than
> the repo root.
>
> Thinking about this again now, I realize it was a side-effect of
> $GIT_DIR being set in the script. =C2=A0The man page for git config s=
tates
> that:
>
> =C2=A0 =C2=A0If --git-dir or GIT_DIR is specified but none of --work-=
tree, GIT_WORK_TREE
> =C2=A0 =C2=A0and core.worktree is specified, the current working dire=
ctory is regarded as
> =C2=A0 =C2=A0the top level of your working tree.
>
> So, if I explicitly set $GIT_DIR just for the 'update-index' and
> 'checkout-index' commands, I need to unset it afterwards. =C2=A0This =
should
> allow '$repo->wc_path()' to behave as expected.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/193296/fo=
cus=3D193302
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/193601/fo=
cus=3D193603

That's right.  If we set it for one command we have to remember to
unset it afterwards else it won't work as expected.

If we're setting GIT_DIR then we should probably set GIT_WORK_TREE
too.  It seems like one way would be to call repo_path() and wc_path()
early, set the variables with the returned values, and then worry
about managing GIT_WORK_TREE before+after calling checkout-index.
That might work.

And in case the code needs it, there's a GIT_PREFIX variable that is
set when the current directory is a subdir beneath the repo root.
--=20
David
