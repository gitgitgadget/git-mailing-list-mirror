From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Sat, 12 Sep 2009 18:01:06 +0800
Message-ID: <be6fef0d0909120301r79072d5ase0d4b174753af9b5@mail.gmail.com>
References: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
	 <0016e6470f36315b8a0472bc75a8@google.com>
	 <20090904212956.f02b0c60.rctay89@gmail.com>
	 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
	 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
	 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
	 <20090907172751.6cf38640.rctay89@gmail.com>
	 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
	 <20090909203350.e3d7e5dc.rctay89@gmail.com>
	 <7veiqdzwrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 12:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmPby-0006gj-J1
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 12:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbZILKJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2009 06:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbZILKJR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 06:09:17 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:58757 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbZILKJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 06:09:16 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Sep 2009 06:09:16 EDT
Received: by iwn8 with SMTP id 8so767751iwn.4
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZeZ7ePRI47eVBX1dWtW5tXPbqpDaZSLDR4bw8qMwAYE=;
        b=dzzPxvQv8D4qrN20iyx2XVEq9xSunpxgMrS0UjHFPjCbK5fnqLGCsFaDi679cnUGD1
         RtZi8phoyi/cEpCDWktOMSk2ZxdyRsYut+I20u+E3iQQbS++mfBJxZ/I1iTjuo2U5yYI
         +U2WABG9FcKmPn4NWiz5UQdtCtJxWdGvH8O3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N8Y8ERFnNkJx6a5zWaOkmobM2Y2JN7ZSu/JH2OKWB4eqbYRQBijKN/AHonwTYlSwg5
         y+Lb5V+FaFoUEjSf88VqcJvJG7pQOBBzMl9LAmM1uajPznwt2Ch7QNLPfL9jYJljtpnP
         dK9oj/RaAWHJpQMgRo3Gm/LEYuRvLtxF2T6No=
Received: by 10.231.6.164 with SMTP id 36mr7806504ibz.39.1252749666409; Sat, 
	12 Sep 2009 03:01:06 -0700 (PDT)
In-Reply-To: <7veiqdzwrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128245>

Hi,

On Fri, Sep 11, 2009 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =A0- You fetch, and the walker walks the loose objects, and then find=
s one
> =A0 object that cannot be obtained as a loose object. =A0It tries to =
look up
> =A0 in the *.idx file and finds it in B.
>
> =A0 But the packfile B is long gone.
>
> I didn't follow the codepath that uses http_get_info_packs() and then=
 uses
> repo->packs list to see what it does, but as long as the above does n=
ot
> happen we should be Ok.

To determine which pack to get when fetching an object, http-walker.c
does not refer to the *.idx files git already has (that is, those
found locally). Instead, it builds a list of *.idx files (repo->packs
or walker->data->alt->packs) from the remote's objects/info/packs, and
uses that.

So even if the *.idx file for pack B was downloaded from a previous
fetch, it won't be used at all.

Therefore, your concern (over fetching a non-existent pack) won't play
out, unless the server does a repack -a, but forgets to update the
pack list (at objects/info/packs).

PS. The above was solely based on my reading of the code, no testing do=
ne.

--=20
Cheers,
Ray Chuan
