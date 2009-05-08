From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with 
	Git 1.6.3
Date: Fri, 8 May 2009 09:24:02 +0200
Message-ID: <81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
	 <1241708714-20326-2-git-send-email-spearce@spearce.org>
	 <200905080102.44053.robin.rosenberg@dewire.com>
	 <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
	 <7vprekbfik.fsf@alter.siamese.dyndns.org>
	 <20090508004741.GU30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 08 09:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2KRJ-00044R-9C
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbZEHHYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbZEHHYE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:24:04 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:43790 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZEHHYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 03:24:03 -0400
Received: by bwz22 with SMTP id 22so1193126bwz.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tp6kx9/LJBOwbZ62Tt0Y6AB+mPwMhIrn2fL0ASjtgZA=;
        b=ZRPtfy7XZuSqvTF7Puq16h2e5sIgX4Jxaqky4OyyZpw+DJbLHJ7geE+WIx7LTdCarl
         Z1xtpRtKvxyM582umpm3S7EX9MuAF0epr3RPjyeU555RlI06bv13QSLLXRKk/wYqpqjy
         zKMfZYn7UIIzMNvdlt8c5e2FLUAelazt6GVbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G65izEYvh2vAIkjxYi5qb7dSuzVCPDMa5zbwv8skP7R6IaBiAk8TXKy9BMlqZeFpAv
         fDvB3OuWC4fnWH9mGWEEA0C2SUkYtFtffxnXri7vpWxRrpcDu5X8YcTZJerf82LJkPvW
         moD/NXvv3lcLpbw4YAHSqFsrzcsKmMHHfR/HU=
Received: by 10.204.124.7 with SMTP id s7mr3280374bkr.105.1241767442049; Fri, 
	08 May 2009 00:24:02 -0700 (PDT)
In-Reply-To: <20090508004741.GU30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118573>

2009/5/8 Shawn O. Pearce <spearce@spearce.org>:
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -129,11 +129,11 @@ static int lock_file(struct lock_file *lk, cons=
t char *path, int flags)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(lk->filename, path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * subtract 5 from size to make sure there=
's room for adding
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* ".lock" for the lock file name
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* "..lck" for the lock file name
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(flags & LOCK_NODEREF))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resolve_symlin=
k(lk->filename, sizeof(lk->filename)-5);
> - =C2=A0 =C2=A0 =C2=A0 strcat(lk->filename, ".lock");
> + =C2=A0 =C2=A0 =C2=A0 strcat(lk->filename, "..lck");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lk->fd =3D open(lk->filename, O_RDWR | O_C=
REAT | O_EXCL, 0666);

There must be at least some deprecation period during which
also the old .lock lockfiles are considered and created.
Just imagine someone modifying the ref with an older version,
which knows nothing about ..lck.
