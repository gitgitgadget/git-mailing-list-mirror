From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Mon, 25 Jun 2012 16:53:54 -0400
Message-ID: <CABURp0od-nNFVhLQU9BsiJ=wXkdneJfhxun_PHOfV=sgzOFShg@mail.gmail.com>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
 <1340621820-19448-2-git-send-email-mgorny@gentoo.org> <4FE898BC.2020307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 22:54:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjGIf-0006Xe-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 22:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab2FYUyR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 16:54:17 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49588 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab2FYUyQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 16:54:16 -0400
Received: by ghrr11 with SMTP id r11so3233828ghr.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YUo0hf4x46U79lgitzK9ghS0Kcyo1eJF+Dn2L6DHoSQ=;
        b=yaHQf8QgTMzii+kda3rNxdism1h1eV6bioj6R42IF4mtkrJYdC+jY3DTBxj5GCxDsx
         Yb7gNJYMz2WwU0NCqugun2tm0SNgWRBjSIDqWkIz/qk9U4vfO6nZyZHFI7zVmN2nGm6O
         1oJ4ws5rVLdoIWYCOV5Tqq4FVIoQdPSOTtqyRaAJE7mDG4JC8X2TLWgwH10SqGp5vt9M
         bVNIe2toMDhtREeOQildVs2ruT2tkxdvi5UyRhaQQJB+YhYv1CZN4nhUtfDdUMYHA7eT
         J8XGnqcWTBB+uTuFkXsEbmKBrcwRa0wkPkViGNcW4WElz0dOVahXP1IhLt4aWUcUAdXJ
         IJEQ==
Received: by 10.236.75.163 with SMTP id z23mr15672292yhd.3.1340657656144; Mon,
 25 Jun 2012 13:54:16 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 25 Jun 2012 13:53:54 -0700 (PDT)
In-Reply-To: <4FE898BC.2020307@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200598>

On Mon, Jun 25, 2012 at 12:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
> Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
>> Add an 'rm' command to git-submodule which provides means to
>> (semi-)easily remove git submodules.
>>
>> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>> ---
>> Right now, it requires the submodule checkout to be removed manually
>> first (so it does not remove unstaged commits), and just removes
>> the index entry and module information from config.
>>
>> I based it on 'cmd_add' code trying to preserve the original coding
>> standards.
>
> I really like the goal of this patch but would prefer that "git rm"
> learns how to remove submodules instead of adding more code to the
> git-submodule.sh script.

I would like to see both supported, eventually. That is, git-rm and
git-submodule-rm should both work.  It would make sense to me when I
am looking for the counterpart to 'git submodule add' to find it under
'git submodule rm', and also under 'git submodule --help'.


> Also it shouldn't be necessary for the user to remove the directory
> by hand before running "git rm". At least all files recorded in the
> submodule can be removed (and if the submodule uses a gitfile that
> can be removed too). Then all that is left are untracked files the
> user has to decide what to do with (which might be removed too when
> running "git rm --recurse-submodules=3Duntracked").

That sounds like a nice next step.  But I would expect that a 'git
[submodule] rm foo' where foo has uncommitted changes to complain to
me (and do nothing else) unless I used --force.  This is similar to
how git-rm already behaves, I think.  And in the case of a dirty
submodule it makes sense to treat the submodule files as an atomic
unit.  That is, if any of the submodule files are dirty and git-rm
will "leave" them, then it should leave the whole submodule.  It would
be very inconvenient to have to restore files back into place at the
correct commit just so I could examine them in context to determine
what I should have done with them before I used git-rm.

In the special case of a submodule which does not use a gitfile, I am
not even sure if any of the submodule files should be removed. If they
are, what state does that leave the submodule repository in?  A
checked-out workdir whose files are all removed?  'git-status' would
be very noisy in this case.  I'd rather expect this to behave the same
as if I checked out a previous commit which did not have the submodule
added yet.  Today, this leaves the submodule in-place and it shows up
as an untracked file.  I don't know a better way to handle that,
though I expect it would be ok remove all the files even in this case
(if the workdir is not dirty and if the head commit is current in the
superproject).  But it seems extreme to do all of that and then leave
the .git directory lying about in the former submodule directory.

Phil
