From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 17:27:17 -0500
Message-ID: <AANLkTin2kTW85UC1r_1LUDVLiexcVDvt--9ndnXZ2ARS@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<201101312244.10047.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2DU-0008He-2H
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab1AaW1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 17:27:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64859 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab1AaW1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 17:27:18 -0500
Received: by gyb11 with SMTP id 11so2196620gyb.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aMKP1siVAC2GdNmN3nmEOzJoKxtaj4PG9FYlP/rVj+k=;
        b=j7FGhuP0ZnKRelR88Ysd7B+Lhoxrht66Ifnlkare1xayK3PrtD7hAIGOyBGjZSFxdt
         Uyw3XoIWP7Qejr6r2VCxaNBE8f6SJX/iY4V+nQKh5Q8iGGEzOG1yz9Mu7/By1HyatzDb
         t/CRWTi/XN6N1rTj201LGNw8y9s1VyG9aH2Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HfuqBxkjzRrPEa6ncLiLenpaEF+TEQkjw1XrpXrsCRpGLaHi954o1DLBzud14WCUMP
         FJC39ysMFjGsYH6qR2TRtGq1XuHM/W14EvCzEjCLOq+4BR5tU0sxpNEftop8zoBJYgXr
         1/VySR4izg2sY5a4wOZJcanyLMEXWZG+UDhOw=
Received: by 10.236.108.131 with SMTP id q3mr13824539yhg.85.1296512837220;
 Mon, 31 Jan 2011 14:27:17 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Mon, 31 Jan 2011 14:27:17 -0800 (PST)
In-Reply-To: <201101312244.10047.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165765>

On Mon, Jan 31, 2011 at 4:44 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Proposal:
>
> Running "git fetch origin master" only updates FETCH_HEAD, not
> origin/master, which turns out to be quite confusing for newcomers
> especially after running 'git pull origin master'.
>
> Since the remote branches in some sense reflect the "last known state=
"
> of the remote, it would make sense to also update them to whatever a
> two-argument fetch got.
>
> Risks:
>
> Scripts might rely on the current behaviour. =C2=A0The most likely ca=
se I
> can think of would be to go along the lines of
>
> =C2=A0git fetch origin master
> =C2=A0git rev-list origin/master...FETCH_HEAD | do_something
>
> to avoid relying on reflogs to get the same result. =C2=A0Seems a bit
> arcane to me though. =C2=A0Such usage would see the updated state, i.=
e.,
> process an empty range.
>
> Migration plan:
>
> Add a fetch.updateRemoteNamespace (or so) configuration variable that
> defaults to false. =C2=A0When enabled, it turns on the auto-updating
> behaviour.
>
> In 1.8.0, flip the default.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

+1 I really wanted to write this one my self;)

I would disagree with the migration plan though.
IMHO there is no need to introduce the variable. If it will start
update both FETCH_HEAD and the remote-tracking branches since 1.8 it
will not break any code, because it is added functionality...
In this case FETCH_HEAD will reflect the latest fetch and it doesn't
even need to be removed later on.

just my 2 cents...

Thanks,
Eugene
