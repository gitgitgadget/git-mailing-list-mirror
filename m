From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Tue, 4 Dec 2012 19:45:47 -0800
Message-ID: <CANiSa6iMxzQGM8mZYdfR-drPGgydwVpM5JsQ-8oO09MX5XDH+g@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<1354213975-17866-1-git-send-email-martinvonz@gmail.com>
	<1354213975-17866-2-git-send-email-martinvonz@gmail.com>
	<7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
	<7vzk20p6ik.fsf@alter.siamese.dyndns.org>
	<CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
	<CANiSa6i2f-4jXFUpYV6+fYnpG-tSRRA3cRg_v-v=UrgfwfFz_g@mail.gmail.com>
	<7vd2yunn0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 05:17:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg6Qc-0003l1-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 05:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2LEER1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 23:17:27 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:54688 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab2LEER0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 23:17:26 -0500
X-Greylist: delayed 1527 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2012 23:17:26 EST
Received: by mail-ia0-f170.google.com with SMTP id i1so2597968iaa.29
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 20:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BujqSqdRpnTZwQQzY/id15IgcH9/SeXDkfOP6WnkDbY=;
        b=TmWvKR9jI+E04AvwcKEgO+x9ePdW60jsHLUpfH/KGVwKiuX1jqEqN6Cf1NjKBNnRTd
         VqU6IV4uW23O7rbb9mK26Moxhr85fV3duxETQHb4qsZ9NsarOOGALlIFL9u6tMR/UC50
         3UJUONch55No8RblNSvyhhvPxUF6qLjSbk2SYNvBo3+Z59GryLR0aERwOZ/T6X4hO25x
         LtTe6wEt4Bz7rnvScd/LC/U3+PLRN5opieKrswqXGa9h0NFM8EGmtmzE+TxtlHQXpu8u
         d296vFLZOoVkylWwTWONwAlkGYk5Nusbbcyvq8nj8H2x2boEA+/cvvOLd3xFXV2eZlEe
         Tfow==
Received: by 10.50.190.130 with SMTP id gq2mr546502igc.26.1354679148046; Tue,
 04 Dec 2012 19:45:48 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Tue, 4 Dec 2012 19:45:47 -0800 (PST)
In-Reply-To: <7vd2yunn0e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211103>

On Sat, Dec 1, 2012 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> On Thu, Nov 29, 2012 at 2:00 PM, Martin von Zweigbergk
>> <martinvonz@gmail.com> wrote:
>>> Slightly off topic, but another difference (or somehow another aspect
>>> of the same difference?) that has tripped me up a few times is that
>>> "git checkout $rev ." only affects added and modified files...
>
> "checkout $commit pathspec" has always been about ...

I suppose the "has always been" is meant to say that it's hard to
change at this point, not that it's more intuitive the way it works..?

> ...checking out the
> contents stored in the paths that match the pathspec from the named
> commit to the index and also o the working tree.

I think I have always thought that "git checkout $commit $pathspec"
would replace the section(s) of the tree defined by $pathspec. (I'm
using "tree" in the more general sense here, as I'm understood the
index is not stored as a tree.)

> When pathspec is "dir/", it does not match the directory whose name
> is "dir".  The pathspec matches the paths that store blobs under
> that directory.

Ah, right. Unlike "git reset dir/", IIUC.

More importantly, when is it desirable not to delete deleted entries?
I find it much easier to imagine uses a "git checkout $commit
$pathspec" that does delete deleted entries. It seems like this must
have been discussed in depth before, so feel free to point me to an
old thread.

If it doesn't seem too strange to you and others if I make "git reset
--hard [$commit] $pathspec" work just like had expected "git checkout
$commit $pathspec", I might look into that when I get some time.

> ...The "please
> remove everything in dir/" part is not the job of "checkout"; of
> course, you can do it as a separate step (e.g. "rm -fr dir/").

"rm -rf dir/" would of course delete everything in there, including
e.g. build artifacts....
