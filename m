From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Wed, 8 Jun 2011 18:44:14 +0530
Message-ID: <BANLkTi=i2igTyusmVf8155VcFfVLQ==u3A@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com> <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie> <BANLkTino5gmfXjeOVih7+LHcMu1usPWAoQ@mail.gmail.com>
 <20110601193126.GC9730@elie> <BANLkTinc=9aW_y6s-Zb578QsMawnxFD55Q@mail.gmail.com>
 <20110602142933.GA32487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUIap-000778-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab1FHNOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 09:14:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65492 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab1FHNOh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 09:14:37 -0400
Received: by wwa36 with SMTP id 36so555560wwa.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hfuNpJ2Gt97lQnIP7nHaThTsam+f/OECXL6bFyYXyD4=;
        b=JwEovkHHuM11dfVLQUPSCdyMCMlceIF/Rrlv6trgLSl98oUbQ4ZY2W0iJscv0UCWo1
         ahyF9ZTNWGUXuNP0Dh+TOQ/VDraX5T6ehD7+7s6bsbtIsIKNW4T/plBWJ38cN/0WUSDA
         ypgSsSqe1ee+v/aFA10/HOEui7wY2rxt97tWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WO/GGiHEKPnmOqqTD/EaHjAt8oSY1l8ipavSz/ZBG8+yjdzlvZ6/UFi4fG0cgdOspo
         Ls6oVYvarZAjMxSVGZqlU/pQjehy9wcZNvoh15uVLfgVI3w6QPYVumjDPQqS0YZXRSHR
         atzrds6ET33902qczq/ay2JnJTa2Cy6kY82/Q=
Received: by 10.216.221.32 with SMTP id q32mr4837389wep.77.1307538875067; Wed,
 08 Jun 2011 06:14:35 -0700 (PDT)
Received: by 10.216.51.213 with HTTP; Wed, 8 Jun 2011 06:14:14 -0700 (PDT)
In-Reply-To: <20110602142933.GA32487@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175368>

Hi Jeff,

Jeff King writes:
> Doesn't lock_file handle multiple locking already via the on_list par=
ameter?
>
> =C2=A0 =C2=A0$ grep -A2 on_list lockfile.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!lk->on_list) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
lk->next =3D lock_file_list;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
lock_file_list =3D lk;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
lk->on_list =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> However, I think you have a bigger problem, which is that you are
> allocating the lock_file on the stack in persist_todo and persist_hea=
d.
> So by the time the atexit() handler is called, this storage has gone
> away and you are just reading random data (not to mention that it als=
o
> should be zero-initialized before being passed to lock_file).

Right. Thanks for the excellent pointer. I was struggling to see what
was wrong on GDB; little did I realize that I was viewing nonsense. I
solved the problem by making the lock_file variables static.

Thanks again, and sorry for the nonsense.

-- Ram
