From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Move try_merge_command and checkout_fast_forward to libgit.a
Date: Thu, 25 Oct 2012 19:50:26 +0700
Message-ID: <CACsJy8D1_c9NP_nwvp6uJyKikG+_jqnm1hVEs_t_wnsYTLZ4Yg@mail.gmail.com>
References: <1350959091-30030-1-git-send-email-pclouds@gmail.com> <20121025094500.GJ8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 14:51:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRMty-0001S5-D0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 14:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759405Ab2JYMu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 08:50:57 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35761 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757822Ab2JYMu5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 08:50:57 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1521080oag.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=asVSOHXP+Ib4u+JarveT45tuiSC+ILz/OJzcigBMbhY=;
        b=CyfOvRDZeQYZMqgrqN+TEarj9mWQISG84g907QJcjyqPTJLlUkdSs12X22HTA2L3+R
         xLiHb2QOmpXb9ZFLgDXcRC0JAdkcz/VhV0wj9ETaK3pnrUV34tkeDX/NxOwM+x0Uphm8
         CjeYsyjSvYw/HqALuwZc+Aof64JxoDIWFLoq2O6pibgovjUXf12TCnnk3KNx07DuEmiS
         NneONr3gnI4GpEWYl+my0NmNqGzHFgdB+R8gHBOMwXRUd4Fz4vETz/A9sZxEI8Y3J5dW
         VXCw+nO0958bghEcEHmDkToKB5fUO80FyJ92bEeKPTnmbuRL6x1HpKAY96mO9fBXT8KC
         WttA==
Received: by 10.182.225.5 with SMTP id rg5mr15551546obc.49.1351169456376; Thu,
 25 Oct 2012 05:50:56 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Thu, 25 Oct 2012 05:50:26 -0700 (PDT)
In-Reply-To: <20121025094500.GJ8390@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208396>

On Thu, Oct 25, 2012 at 4:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 23, 2012 at 09:24:51AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> These functions are called in sequencer.c, which is part of
>> libgit.a. This makes libgit.a potentially require builtin/merge.c fo=
r
>> external git commands.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  I made some unrelated changes in sequencer.c and this problem shown
>>  up. merge-recursive.c is probably not the best place for these
>>  functions. I just don't want to create merge.c for them.
>
> I'm fine with this conceptually, but merge-recursive really is the wr=
ong
> place. I'd much rather see a new merge.c to collect merge-related hel=
per
> functions that are not strategy-specific.

OK. I checked around for similar issues and found these used by
libgit.a but stay in builtin/ instead:

estimate_bisect_steps: bisect.c and builtin/rev-list.c
print_commit_list: bisect.c and builtin/rev-list.c

 -> move them to bisect.c? another candidate is revision.c.

fetch_pack: transport.c and builtin/fetch-pack.c
send_pack: transport.c and builtin/send-pack.c

 -> move them to transport.c? or new files fetch-pack.c and
send-pack.c? I haven't check how many functions they may pull
together.

setup_diff_pager: diff-no-index.c and builtin/diff.c

 -> to diff-lib.c?
--=20
Duy
