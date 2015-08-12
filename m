From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: enhanced remote ref namespaces
Date: Wed, 12 Aug 2015 12:02:07 -0700
Message-ID: <CA+P7+xq_v+TjqSDC3aR2bdUmCJyj=zLXSE5SbVgOEr+SojOUQQ@mail.gmail.com>
References: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
 <xmqqegj8l4lw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:02:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbIF-00033h-Lq
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbbHLTC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:02:27 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36078 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbHLTC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:02:26 -0400
Received: by iodv127 with SMTP id v127so14036701iod.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vIYzpT9otI1ebQwvIfXyTCLd7snXCLjt3ad4xMgrk0Y=;
        b=l16gfgaMbZIWdNOwr1SNa2dXmk5zVo4I6+hn9QOWEQVtoaEKIyx1vLoBrEkTZAyHco
         8CaKSYx61CiKMH9dSCMg1zvsjUbLq6OKHBGJPAdlcn1zavYAMCNMKY3jYeI7okWC7ddG
         6Ciekw5OIlj86vRXX2uQkRm+e2oOM0gG0XXfMxjCSNKrUnZaHlKhNgwuDOImP1i6K/HY
         SvnbrCIovZDUVS1eHwipndM6cF+fk3Da35q6p4ncXaWZq7uZlFI8RHZa5Ll6XDFwpbZr
         a8MrMkRv4x23p8jOSpm9sjvyxj/NxsrrDsU8PeC//dPqKTEQIj91lCqrh+SqymNbUJgE
         mfkA==
X-Received: by 10.107.153.206 with SMTP id b197mr42755213ioe.71.1439406146276;
 Wed, 12 Aug 2015 12:02:26 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 12:02:07 -0700 (PDT)
In-Reply-To: <xmqqegj8l4lw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275796>

On Wed, Aug 12, 2015 at 11:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> Just thinking aloud, perhaps we can introduce a brand new top level
>>> hierarchy refs/remote/$O/{heads,tags,notes,...}, and give backward
>>> compatibility by making a moral equivalent of a symbolic link from
>>> refs/remote/$O/heads to refs/remotes/$O/.  The true remote-tracknig
>>> refs continue to live in refs/remotes/$O/* and old tools that do not
>>> know the new layout would not be hurt.  New tools that want to
>>> ignore and look only at refs/remote/$O/* can do so through the moral
>>> equivalent of a symbolic link.  "remote remove" needs to be taught
>>> about this single exception (i.e. "the symbolic link"), but the
>>> places it needs to touch is limited only to two places and will not
>>> grow.
>>
>> I think this proposal makes the sense..  I'd go with something like:
>>
>> refs/tracking/<origin>/(heads|tags|notes|replace|etc)/*
>>
>> with a symlink from or into
>>
>> refs/tracking/<origin>/heads -> refs/remotes/<origin>
>
> I actually do not think we even need the "symlink" thing.
>
> We can just say refs/remotes/$O has been and forever will be where
> the remote-tracking branches will live.  With or without the symlink
> for backward compatibility, the updated Git will need to be aware of
> the two places to deal with older and newer repositories anyway.
>
> "everything is now under refs/tracking/$O, not spread over many
> unbounded number of places like refs/remotes-$foo/$O" may appear to
> be cleaner but two is already not too bad and will greatly reduce
> the transition pain.

Ok, so.... just have branches be in refs/remotes/$O and all new things
be in refs/tracking/$O/category

that sounds reasonable enough to me.

That still hasn't really resolved the question of how to deal with
tags, but it does solve the question of how to deal with replace and
notes refs.

Regards,
Jake
