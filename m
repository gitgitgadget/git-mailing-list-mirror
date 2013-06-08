From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 05:14:46 -0500
Message-ID: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 12:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlGAe-0003io-Tw
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 12:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab3FHKOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 06:14:49 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34491 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab3FHKOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 06:14:48 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so2631885lbi.39
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IosmdJShZoeALBxeAtAWOTtxZMvD/C8w+em+40HUIGU=;
        b=nobRrOvCu2kNNIVUuwrkvvV+Hs+qC4dBN7VxvWQCRkHr8b4OzZFjz+jG9T29GVvcp1
         W5VJRxjM6jTujzDMVbVGr59lzYwMJ6k0lj0Gxi0WhYm39+2mBsk9eQTCJCn4+DsTkC56
         HnlCi2a5S4fywaWoBG0ovH7vdRlaYU8q1GX5DDZSYMqkyZmZ5RZHmdzGm/UKP6oD9KER
         FbYbR9D4qKZMw0WJ6vtyEyOiHXxMW+jazpcMpGKGhJbSm5ZOXMD7miSXp3s6ZM8kPD8u
         RaC85Tij6GklDQeAFVL3qzPgfa49ryRCpjN9u6+b3qa3oS+2Bc5F7crwN3V/jrK61WWp
         1rqA==
X-Received: by 10.152.22.130 with SMTP id d2mr584183laf.33.1370686486923; Sat,
 08 Jun 2013 03:14:46 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 03:14:46 -0700 (PDT)
In-Reply-To: <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226796>

On Fri, Jun 7, 2013 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 5:16 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This code is only useful for cherry-pick and revert built-ins, nothing
>> else, so let's make it a builtin object, but make sure 'git-sequencer'
>> is not generated.
>
> As you can see, the convention is builtin/foo.c corresponds to git-foo
> (and maybe more). Why make an exception for sequencer?

Why not?

> What do we gain from this?

Organization.

> A lot of code in libgit.a is only used by builtin commands,
> e.g. fetch-pack.c, should we move it to?

Yes.

> I ask because I moved
> fetch-pack from builtin out because of linking issues and I don't want
> the same happen to sequencer.c.

I'm sure those linking issues can be solved.

I don't see why libgit.a couldn't eventually be the same as libgit2.
We need better organization tough (e.g. builtins/lib.a).

If you are arguing favor of a more messy setup, then we should link
all the builtin/*.o to libgit.a, because the current situation just
doesn't cut it.

For example, init_copy_notes_for_rewrite() cannot be accessed by
sequencer.c, and while it's possible to move that function (and
others) to libgit.a, it doesn't make sense, because it can only be
used by builtins.

-- 
Felipe Contreras
