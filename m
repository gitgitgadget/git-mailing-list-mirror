From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] revision: keep track of the end-user input from the
 command line
Date: Thu, 25 Aug 2011 18:08:31 -0700
Message-ID: <CAGdFq_he-skXpEy903RSY2ravDXo1eVCN19RzJeHXQCT__HTmA@mail.gmail.com>
References: <20110824213205.GI45292@book.hvoigt.net> <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com>
 <7vbovdgf73.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brad King <brad.king@kitware.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 03:09:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwkv7-0001iX-J2
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 03:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab1HZBJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 21:09:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57400 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab1HZBJL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 21:09:11 -0400
Received: by pzk37 with SMTP id 37so3370803pzk.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 18:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Tvifk2GQge8y8GltVTOwDw2BTRQqtKU6dJfL91wBmI4=;
        b=R2bdW0KCVEsgcSbUEQHxWQhQNH/Bjlw7cP4q10Bfwj3QeI520w/VwmE9MZvY37WDp4
         xgzXg+UPusNfkJMswpVzfn6TnIYxGUE7wr0qVrftcjunf4NsqqLzO+gGA/drkMMyHoBc
         lZSOoj5Z1ReCZvUboZW0gzyyiRjv/xyzU5RRU=
Received: by 10.142.187.12 with SMTP id k12mr248638wff.38.1314320951042; Thu,
 25 Aug 2011 18:09:11 -0700 (PDT)
Received: by 10.68.55.170 with HTTP; Thu, 25 Aug 2011 18:08:31 -0700 (PDT)
In-Reply-To: <7vbovdgf73.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180143>

Heya,

On Thu, Aug 25, 2011 at 18:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> Prepare a separate array to keep track of what syntactic element was =
used
> to cause each object to appear in the pending array from the command =
line,
> and populate it as setup_revisions() parses the command line.

Thank you! I was really dreading looking into this myself, so I'm very
glad that you could find the time to look into it yourself.

> @@ -835,6 +853,7 @@ static void handle_one_reflog_commit(unsigned cha=
r *sha1, void *cb_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct object =
*o =3D parse_object(sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (o) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0o->flags |=3D cb->all_flags;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* ??? CMDLINEFLAGS ??? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0add_pending_object(cb->all_revs, o, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!cb->=
warned_bad_reflog) {

What is happening here?

--=20
Cheers,

Sverre Rabbelier
