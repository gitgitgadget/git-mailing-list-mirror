From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/7] mergetool--lib: don't call "exit" in setup_tool
Date: Fri, 25 Jan 2013 23:01:08 -0800
Message-ID: <CAJDDKr5aC6K7FqVB-EgmObUTJUfS3Qc5YOeG-0eZd289YCq1Og@mail.gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
	<1359107034-14606-8-git-send-email-davvid@gmail.com>
	<20130125195446.GA7498@serenity.lan>
	<20130125200807.GB7498@serenity.lan>
	<7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
	<20130125204619.GC7498@serenity.lan>
	<7vlibh2d8a.fsf@alter.siamese.dyndns.org>
	<20130125211601.GD7498@serenity.lan>
	<7vbocd2auo.fsf@alter.siamese.dyndns.org>
	<20130125220222.GE7498@serenity.lan>
	<20130125220359.GF7498@serenity.lan>
	<7vip6k23mk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 08:01:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyzlc-0007Km-ME
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 08:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab3AZHBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 02:01:11 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:33049 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab3AZHBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 02:01:10 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so530408wey.33
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 23:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vDwbuyV/OdfycSkhrcKko5h36BcAVhjgnsPJxNp+h00=;
        b=OMurOIHhUzXgSjxzZv1nrpbWdTNNgoT9nhOWbWU8gHevTMmoyFKoXJVkE1x0ZG1NEO
         BNuW8X7lbEKlU3nUwE4wsrxrzQnAAwDhXTAprve8tQyIy9Rg2yFAPEv+Sw7n71G7VKPR
         P7RMehX7CfH7/gx8BIbu++dT49XWmpMzp7YU+ypEkxpw7YRoAeR+1eNpjxH9fKnfSBIE
         2327e9amKpfvx5c1WGP1XOqlyyOBOqcFGGqy/+L3ueet8P7BjCzktd8iWadyMvvT8smD
         KUmGWZ6vPsSuFv5brhVts6YAEltvK+YKLNM6Fn7uroULJcmVyt63lHLl7lgtE0ESCiOw
         fAmQ==
X-Received: by 10.180.82.69 with SMTP id g5mr1220817wiy.21.1359183668480; Fri,
 25 Jan 2013 23:01:08 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Fri, 25 Jan 2013 23:01:08 -0800 (PST)
In-Reply-To: <7vip6k23mk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214612>

On Fri, Jan 25, 2013 at 4:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Applying this one on top of 1/7 thru 5/7 and 7/7 seems to break
> t7610 rather badly.

I just sent a replacement for the vim/symlink issue stuff.
I tried to keep the patch small.  John, can you rebase this
patch on top of it?

> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> ...
> ok 1 - setup
>
> expecting success:
>     git checkout -b test1 branch1 &&
>     git submodule update -N &&
>     test_must_fail git merge master >/dev/null 2>&1 &&
>     ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
>     ( yes "" | git mergetool file1 file1 ) &&
>     ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
>     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
>     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
>     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
>     ( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
>     test "$(cat file1)" = "master updated" &&
>     test "$(cat file2)" = "master new" &&
>     test "$(cat subdir/file3)" = "master new sub" &&
>     test "$(cat submod/bar)" = "branch1 submodule" &&
>     git commit -m "branch1 resolved with mergetool"
>
> M       submod
> Switched to a new branch 'test1'
> Submodule path 'submod': checked out '39c7f044ed2e6a9cebd5266529badd181c8762b5'
> not ok - 2 custom mergetool
> #
> #           git checkout -b test1 branch1 &&
> #           git submodule update -N &&
> #           test_must_fail git merge master >/dev/null 2>&1 &&
> #           ( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> #           ( yes "" | git mergetool file1 file1 ) &&
> #           ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
> #           ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> #           ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
> #           ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
> #           ( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
> #           test "$(cat file1)" = "master updated" &&
> #           test "$(cat file2)" = "master new" &&
> #           test "$(cat subdir/file3)" = "master new sub" &&
> #           test "$(cat submod/bar)" = "branch1 submodule" &&
> #           git commit -m "branch1 resolved with mergetool"
> #
> --- 8< ------ 8< ------ 8< ------ 8< ------ 8< ------ 8< ---
>
> Due to ">dev/null 2>&1", all of the error clues are hidden, and I
> didn't dig further to see which one was failing (this is why tests
> shouldn't do these in general).



-- 
David
