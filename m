From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 14:49:10 -0700
Message-ID: <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 23:49:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUM65-0004iJ-JA
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 23:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbbHYVtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 17:49:33 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32881 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbbHYVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 17:49:32 -0400
Received: by iods203 with SMTP id s203so204230654iod.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C6E60TfH1pURptMNC6GjaGcHKJ8P1YKuvdY2k1ebOPo=;
        b=wATddbBviz8sLcKXhtbqmub47zF4j+YZ7WXNTKDVDR4fZCFAzbubMfsV4XiTdRyJcG
         wJ7t259ilJY34YKNbf3RsiIL3kyGBvCKzntP4yWWVSAV/MybeVKkgLiCujz4EX6qPzn4
         F7hXok+aTU2opWBzGeLRQ/ArPkJ0YP1f6ef4MouBHkZWrxFcC+WukiwcgHC1OhLvLEX+
         lhfNABt97Ku2W+iCzGV/uHCgJ0S4BytmWpXpJj1BAKFyJUzvHrEfx3YM2MLrgjudiFe3
         a9cknfrFvVRsC6EX61sPJtyceZp+CwRt0Iz5A1xHnkmmtkVARcfS/fBu16+hzwtH+MA7
         E1pw==
X-Received: by 10.107.133.213 with SMTP id p82mr35236658ioi.71.1440539372325;
 Tue, 25 Aug 2015 14:49:32 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 25 Aug 2015 14:49:10 -0700 (PDT)
In-Reply-To: <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276577>

On Tue, Aug 25, 2015 at 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, Aug 25, 2015 at 1:01 AM, Graeme Geldenhuys <graemeg@gmail.com> wrote:
>>
>> Even though I have worked with Git since 2009, I still have to
>> reference the help to remind me of what parameter to use in certain
>> situation simply because similar tasks differ so much.
>>
>> Maybe we could address this in the next major version of Git? Has
>> anybody else thought about this or started work on this? Or was this
>> discussed before and declined (link?).
>
> http://article.gmane.org/gmane.comp.version-control.git/231478 comes to mind,
> which has been linked from this entry:
>
> Discuss and decide if we want to choose between the "mode word" UI
> (e.g. "git submodule add") and the "mode option" UI (e.g. "git tag --delete")
> and standardise on one; if it turns out to be a good idea, devise the migration
> plan to break the backward-compatibility.
>
> in http://git-blame.blogspot.com/p/leftover-bits.html

I would vote for command words, as this is clean and simple. The
downside is in converting all the old options based commands, git-tag,
and similar. These commands cannot easily convert because "valid"
sequences would become invalid with no easy way to deprecate for
example in the linked gmane above, "git tag delete master" can't be a
call to delete master as it is currently a call to create a tag
"delete" at the commit marked by master.

I can't think of an easy way to deprecate the change in behavior over
time, which means that making a conversion would require some other as
yet unknown way?

It may be possible to convert other options based commands, such as
how git-branch and git-checkout do things which seem highly unrelated.
A good example is how checkout is used to both change branches, as
well as can create a branch, and can also checkout a file. The "reset"
command is used to rewind history, as well as potentially reset *all*
files, but it can't be used to reset a single file, and is completely
different from revert. Some of these distinctions are ok because it's
just no good way to make everything easy.

Some of these could be fixed by the command word setup, but as many
have mentioned an actual migration plan is difficult.

Personally, I don't want to move to the command option "--status"
format, as I think these aren't really options, and are very much
sub-subcommands. I think we should try to push more uses of this
style, and try to determine a possible migration path towards using
them. Maybe some warts simply aren't worth the effort to fix though.

Other issues are tricker to solve, and are result of git exposing more
complex functionality and users eventually simply have to learn and
understand.

Regards,
Jake
