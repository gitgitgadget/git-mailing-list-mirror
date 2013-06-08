From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 18:42:29 +0700
Message-ID: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com> <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 13:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHYB-0007r9-8o
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 13:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab3FHLnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 07:43:00 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50752 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab3FHLnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 07:43:00 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so7909003obc.12
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l1RVrPqyehp/jpaD0PHeTLwmzQJJSJcr0tfLOjZ740M=;
        b=v3jFj1nXAuU91zg2xALuo2BwLJGDcPvIVfO6f1cjs0xs5grqIh4FbZRSick6dhGq6Y
         WuXDB/O+xkl9zLZqI/kGYeIIojbwC77kmh2+OZ30XAduL15cR2yet4f+WBKoSxuQphPX
         ZQcJWox1tYdwl0WZUn7ov1ivHtI/UvQaZMbFxOEqVBZaqVXh2CfHndPbJZqjxaJKXc+z
         K/DvLvJXugdZ950knWAxshsKq0vZW/CPH9Q19NbYu37LZwMGypeUUqgTlMNEwEDXrerl
         ptU7srNnReUXkfWfV1PLonAy717GhCiIuJl30yhkCfojWgutzvDmSWRmEucykMiFYgej
         n6hw==
X-Received: by 10.60.125.101 with SMTP id mp5mr2036655oeb.18.1370691779648;
 Sat, 08 Jun 2013 04:42:59 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 04:42:29 -0700 (PDT)
In-Reply-To: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226803>

On Sat, Jun 8, 2013 at 5:14 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Jun 7, 2013 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jun 8, 2013 at 5:16 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> This code is only useful for cherry-pick and revert built-ins, nothing
>>> else, so let's make it a builtin object, but make sure 'git-sequencer'
>>> is not generated.
>>
>> As you can see, the convention is builtin/foo.c corresponds to git-foo
>> (and maybe more). Why make an exception for sequencer?
>
> Why not?

And while we are at "why not", why don't you fork git?

>> I ask because I moved
>> fetch-pack from builtin out because of linking issues and I don't want
>> the same happen to sequencer.c.
>
> I'm sure those linking issues can be solved.

Yeah, I scratched my head for hours and finally gave in. Maybe you are
better at the toolchain than me.

> I don't see why libgit.a couldn't eventually be the same as libgit2.
> We need better organization tough (e.g. builtins/lib.a).
>
> If you are arguing favor of a more messy setup, then we should link
> all the builtin/*.o to libgit.a, because the current situation just
> doesn't cut it.
>
> For example, init_copy_notes_for_rewrite() cannot be accessed by
> sequencer.c, and while it's possible to move that function (and
> others) to libgit.a, it doesn't make sense, because it can only be
> used by builtins.

libgit.a is just a way of grouping a bunch of objects together, not a
real library and not meant to be. If you aim something more organized,
please show at least a roadmap what to move where.
--
Duy
