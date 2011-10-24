From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Mon, 24 Oct 2011 17:37:20 +0100
Message-ID: <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com> <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 18:37:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RINXA-0007nu-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 18:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015Ab1JXQhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 12:37:52 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46803 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962Ab1JXQhv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 12:37:51 -0400
Received: by qyk27 with SMTP id 27so5705708qyk.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U7rLvwX1qC4pbUh3x6p9AW7NOMAFi07oiDqdSAaleco=;
        b=Up38BiTZ1TzJR6YEinuJWSFEw98/535FzTb4pePjCIdHd9QPybEwgqpdlVNCijijaw
         SdpVbXKjofww6JEarUMM/IuELb4B6A33V1umm6sBvPfQ2yT1HVj3whLZhIAMWaAauXK5
         BNO2twGBr4JykbSzT7agASXdbGpCz6/QnzkPg=
Received: by 10.68.74.4 with SMTP id p4mr49023533pbv.47.1319474270071; Mon, 24
 Oct 2011 09:37:50 -0700 (PDT)
Received: by 10.68.43.162 with HTTP; Mon, 24 Oct 2011 09:37:20 -0700 (PDT)
In-Reply-To: <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184181>

Hi,

This thread did not receive any updates for a long time.
Could someone provide some feedback?

Is this feasible? Does it make sense to add this command? If not, why?

Thanks,
Vitor

On Tue, Sep 27, 2011 at 9:57 AM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> On Sat, Sep 24, 2011 at 10:19 PM, Dmitry Ivankov <divanorama@gmail.co=
m> wrote:
>> On Sun, Sep 25, 2011 at 1:37 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>> Thanks. =A0I must have missed the earlier discussion. =A0What are t=
he
>>> semantics of this command and its intended purpose?
>> My guess is that if fast-import is used to manage a set of "remote"
>> branches, it should be able to delete branches. Then, it should
>> be allowed to do non-fastforward updates too (--force). Why can't
>> it just ignore branches deletion (considering --force)?
>
> I started by using --force, but I did not want to completely disable
> these checks. The idea of the drop command is to add support to the
> exceptions that require non-fastforward updates.
>
>> Random thoughts:
>> 1. once 'drop' is executed, fast-import can't tell if the branch was
>> actually deleted. And moreover any attempt to read this branch
>> head becomes illegal (either it's missing in .git or fast-import is
>> instructed to use a dropped branch).
>> 2. 'reset' command is a bit like proposed 'drop' but it never delete=
s
>> a branch ref. Consider following imports:
>> 1) import branch topic
>> 2) reset topic
>> 3) import branch topic2 starting at topic (incorrect import)
>> If 1-3) is done in one fast-import process, the error is reported.
>> If 3) is done separately, it succeeds but the result is strange:
>> topic2 isn't started from scratch but from old "erased" topic.
>> So, maybe, reset should be fixed to erase branches on --force.
>
> I think you are not considering the possibility that checkpoints coul=
d
> have been done along the way. I use them frequently to be able to
> analyse branches with diff-tree. As soon as a checkpoint is done,
> update-branches will issue an error (commit A is not part of branch A=
').
>
>> One more scenario is:
>> 1) import topic
>> 2) reset topic
>> 3) import topic
>> If 1-3) go together - no error
>> If 3) goes separate - no error, but non-fastforward update.
>> Much more harmless, but still may look strange.
>
> Not exactly true if there is a checkpoint done after step 1.
>
> My scenario is:
>
> 1) import topic
> 2) checkpoint
> 3) diff-tree and processing
> 4) exit if processing returns ok
> 5) reset topic to another HEAD
> 6) goto 1)
