From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Since gc.autodetach=1 you can end up with auto-gc on every
 command with no user notification
Date: Wed, 8 Jul 2015 19:47:54 +0700
Message-ID: <CACsJy8AKbXqsuNJL7Usb-haiynDcCDQXk56WYh5PxzGU3NvaAw@mail.gmail.com>
References: <CACBZZX5hUr8TMRXYWRqdb1AQ=oOBpEFuoMwYHczPdHN82ceuTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 14:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCom7-0003bt-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 14:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbbGHMs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 08:48:27 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35645 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbbGHMs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 08:48:26 -0400
Received: by iecuq6 with SMTP id uq6so154523971iec.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UEiiQLzy3tdJ0iOqB03H4aPTzrUBchARK2nKCWF2oCo=;
        b=weaOfG7x5gPW82D0F9VadGuhZakgHVve8dBnUATN5D+UofkmpgKdYgQzTXN5y6/4sl
         A5sT/2YjCynQrE7Tm660c2DyWDgLZ6dEbyvhr0fMvPGZDe6Mi4HMVBFXm7RZYbQBDLIQ
         NV+VpwP6g5Y8eB5AjQ47UxkX0T2DoZ9j2guw4Lkz/WThXn7WueUjsbzlWOD7iJS4RM1O
         VBeILL66c9pg+Th7zBEpEqTwLOfZTiQtTr16yz+4zmEqc1giBBTqKMtpE2Y0gRZlzTAs
         rS3LC5UYbUhlxbc6wOlSu8IFpB0R1uYQAytDo6gTa8fdlpwWkwmyfdAj2Dh0C4yrtBjc
         h2bA==
X-Received: by 10.50.164.233 with SMTP id yt9mr87080969igb.41.1436359703865;
 Wed, 08 Jul 2015 05:48:23 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 8 Jul 2015 05:47:54 -0700 (PDT)
In-Reply-To: <CACBZZX5hUr8TMRXYWRqdb1AQ=oOBpEFuoMwYHczPdHN82ceuTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273679>

On Wed, Jul 8, 2015 at 7:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Someone at work came to me with the problem that they were getting th=
e
> "Auto packing the repository in background for optimum performance"
> notice on every Git command that they ran.
>
> This problem is a combination of two things:
>
>  * Since Nguy=E1=BB=85n's v1.9-rc0-2-g9f673f9 where we started runnin=
g "git
> gc" in the background the user hasn't seen the "There are too many
> unreachable loose objects" message added back in v1.5.3.1-27-ga087cc9
>
>  * The checkout has a lot of loose objects. So even after "git prune
> --expire=3D2.week.ago" the .git/objects/17 directory has 317 objects.
> More than 27 in that directory trigger "git gc --auto".
>
> So it's partly a UI issue. Since the repacking is happening in the
> background the user never sees the message suggesting that they run
> "git prune".
>
> But perhaps the heuristic of "are there more than 27 objects in
> .git/objects/17" could be improved, but I don't know with what
> exactly.
>
> But having something fork a gc to the background on every fetch (and
> similar object-modifying operations) is quite sub-optimal.

Thanks for reminding me. Two related threads: [1] is about that "17"
heuristics and [2] the UI thing. I need to reread them before making
any more comments.

[1] http://thread.gmane.org/gmane.comp.version-control.git/265734/focus=
=3D265756
[2] http://thread.gmane.org/gmane.comp.version-control.git/266182
--=20
Duy
