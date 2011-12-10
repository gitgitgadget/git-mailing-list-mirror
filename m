From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [POC PATCH 0/5] Threaded loose object and pack access
Date: Sat, 10 Dec 2011 22:51:40 +0700
Message-ID: <CACsJy8DxupdnKturE1Ows6+OcC22wPer0=Q56g+P93mP_+BKZA@mail.gmail.com>
References: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 10 16:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZPDl-0003uA-Qc
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 16:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934Ab1LJPwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 10:52:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63091 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab1LJPwM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 10:52:12 -0500
Received: by bkcjm19 with SMTP id jm19so108794bkc.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HVxs7LAzemL7vunb3eyJIcLtQz3ipq53oskh3u/hI1c=;
        b=iqkpQ449mmdO0M8dSa55xoCIZlEOWn7H7R3b6jp6AgSG4QIhz2H1JgUhdPjAJVg5tx
         h8q/TBu1pgjZ+cS0wFig3b7X7kTLF3VMDILsz3I1I8qvVxYnBhNpP6E2CnTmFarZY4O8
         ReB23lDzQgkcrsd+lL9RzNboA05L7ElcsweYA=
Received: by 10.205.129.148 with SMTP id hi20mr6032579bkc.25.1323532331181;
 Sat, 10 Dec 2011 07:52:11 -0800 (PST)
Received: by 10.204.129.205 with HTTP; Sat, 10 Dec 2011 07:51:40 -0800 (PST)
In-Reply-To: <cover.1323419666.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186784>

On Fri, Dec 9, 2011 at 3:39 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Well, just to make sure we're all left in a confused mess of partly
> conflicting patches, here's another angle on the same thing:
>
> Jeff King wrote:
>> Wow, that's horrible. Leaving aside the parallelism, it's just terri=
ble
>> that reading from the cache is 20 times slower than the worktree. I =
get
>> similar results on my quad-core machine.
>
> By poking around in sha1_file.c I got that down to about 10. =C2=A0It=
's not
> great yet, but it seems a start.
>
> The goal would be to improve it to the point where a patch lookup tha=
t
> already has all relevant packs open and windows mapped can proceed
> without locking. =C2=A0I'm not sure that's doable short of duplicatin=
g the
> whole pack state (including fds and windows) across threads, but I'll
> give it some more thought before going that route.

Another potential user for parallel pack access is fsck. Although fsck
access pattern may be different from grep, fsck would open and read
through all packs.
--=20
Duy
