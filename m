From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 10/20] git-remote-testgit: fix error handling
Date: Mon, 20 Jun 2011 20:02:10 +0200
Message-ID: <BANLkTimW8paPUHoYLpB_diY_s0L4aQCcgQ@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-11-git-send-email-srabbelier@gmail.com> <20110619225810.GG23893@elie>
 <jfzVoEhsVKgfY8Vp692jfTk1lNp2lhg9JCJc8MiY6N6th3PzBJoHzw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 20 20:03:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYioJ-00061g-Rm
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 20:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab1FTSCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 14:02:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62335 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab1FTSCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 14:02:50 -0400
Received: by pvg12 with SMTP id 12so931181pvg.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=qlIJa7OAtzbn08PYOyVCgr2ONrYlDxaawssIXHVNNcw=;
        b=LQM5KhgAcTmi5BeC4BfJpZmhMtuAdS3qsMXh/5fslCFNxPZiuozcb68hekzVOmtSWe
         lfHTDzH0qCu1pmuC2O7mc/7xg578INDU5nemuK9+6/BminDrhwqM+9R06NhBbkPCbqvX
         6C+oWwH4Kf+mcRGWjE50U+rY2YxBz68pwxirk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZhqEoFMzLpaTgcGMmzR7OzNridnF7JEiCFJgIJyDvVPmbE5Xc6XHICV/DKhHUCSi+l
         HulOEgYdO2LelwqVrmZ8LVdhycfUqfdW1x4uHOn9ReOoW3bfQ/XHSlq9hwoRJebgSuZZ
         476Q3Gyv5jBp/ppX0zhtDVjQTF8Y3rBdRUPoI=
Received: by 10.68.15.101 with SMTP id w5mr2272641pbc.209.1308592970057; Mon,
 20 Jun 2011 11:02:50 -0700 (PDT)
Received: by 10.68.41.99 with HTTP; Mon, 20 Jun 2011 11:02:10 -0700 (PDT)
In-Reply-To: <jfzVoEhsVKgfY8Vp692jfTk1lNp2lhg9JCJc8MiY6N6th3PzBJoHzw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176082>

Heya,

On Mon, Jun 20, 2011 at 19:50, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> Well, I don't see anywhere where CalledProccessError is actually caug=
ht.
> i.e. I don't see
>
> =C2=A0 except subprocess.CalledProcessError:
>
> anywhere. =C2=A0So, on python 2.5+ if this exception is ever raised, =
the
> script would just exit and produce a backtrace right?

We're not trying to catch it, but we raise it (since that's what the
python 2.5 implementation of check_call does). But if it's not defined
in python 2.4, then my patch broke 2.4 again :).

> On python 2.4, it would also exit and produce a backtrace that
> looks like this:
>
> =C2=A0 =C2=A0 File "test.py", line 11, in check_call
> =C2=A0 =C2=A0 =C2=A0 raise subprocess.CalledProcessError(retcode, cmd=
)
> =C2=A0 AttributeError: 'module' object has no attribute 'CalledProces=
sError'

Yeah, it would, my bad :(. I'll just define a dummy CalledProcessError
if it isn't defined to support python 2.4

> Btw. the only reason I submitted those changes to support python 2.4
> was because RHEL 5.X ships with python 2.4, and the changes were not
> too intrusive. =C2=A0So, it should be considered whether supporting 2=
=2E4
> is desirable. =C2=A0I wouldn't want to increase the maintenance burde=
n
> on the real python developers (i.e. not me).

Wikipedia says RHEL 5.x will ready End of Production 1 on Q4 2011, but
RHEL 6.x has been out only a little over half a year, so it's probably
worth doing.

--=20
Cheers,

Sverre Rabbelier
