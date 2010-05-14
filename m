From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: interactive rebase editor pathname variable
Date: Fri, 14 May 2010 14:49:48 +0200
Message-ID: <AANLkTimb8fCQoX31GkPqsjtnKgi6TLlUPToodZcZocHJ@mail.gmail.com>
References: <hshglg$p2q$1@dough.gmane.org> <20100514075913.GA3690@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 14:49:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCuKy-0003IU-Of
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 14:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0ENMtv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 08:49:51 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:40381 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0ENMtu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 08:49:50 -0400
Received: by gxk9 with SMTP id 9so1589919gxk.8
        for <git@vger.kernel.org>; Fri, 14 May 2010 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YmDIi4bOC6kEMN3xBLzGKFXPsMaPJBPilKqy4CtOmdU=;
        b=iQdpA2qy68l+6SpQhGvoG5+OAxHf+mTZOYzyq3OtreOLIpUfqbjT02SXQIOEie8Hl7
         s5EZEkyOVkGa+fJZ1LtNsdUfUJR+GndMKFiGSdRYw5r7cBEaeoZwCvfA+kyJAfuPMpoB
         w9DPM8YLA75fT9yI/BKwPItr64fZ+iaShlgps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BRQ9rcJVneIBAbeGDXyl1AylygxV/KtPz6L+HQ7zgrk0SqcMRNEOnkTm4+yEU/V0ig
         qerifqipyX6++3fRAOKATykpWBQv6U6naY9iDAFXezRrqMfxs0e2tdp3XnMYrfTO0DDK
         Hbp9oAtO8z4mKfHPXGgIGVPl3nnKn7TRkT2qI=
Received: by 10.231.147.21 with SMTP id j21mr832068ibv.65.1273841388998; Fri, 
	14 May 2010 05:49:48 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Fri, 14 May 2010 05:49:48 -0700 (PDT)
In-Reply-To: <20100514075913.GA3690@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147086>

On Fri, May 14, 2010 at 09:59, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi Neal,
>
> Neal Kreitzinger wrote:
>
>> git-rebase -i passes an absolute pathname to the
>> core.editor, e.g.
>> "home/someuser/someworkingtree/.git/rebase-merge/git-rebase-todo". =C2=
=A0This
>> causes problems in our shop because our proprietary editor cannot ha=
ndle
>> pathnames beginning with a period (it translates the period to a sla=
sh) and
>> therefore our entry for core.editor is 'someeditor "$PWD/$1"'.
>
> For your example, git uses the shell to run the following command.
>
> =C2=A0someeditor "$PWD/$1" "$@"
>
> I would suggest something like the following instead.
>
> =C2=A0[core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0editor =3D "sh -c '\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case \"$1\" in=
 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*|[A-Za-z]:*)=
 file=3D\"$1\";; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*) file=3D\"$(=
pwd)/$1\";; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0someruntime so=
meditor \"$file\"' -"
>

Barely tested:

someditor "$PWD/${1/#$PWD\//}"

Bert

> Hope that helps,
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
