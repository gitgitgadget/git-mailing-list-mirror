From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] config --get --path: check for unset $HOME
Date: Mon, 26 Jul 2010 17:48:57 +0000
Message-ID: <AANLkTin6RxdVWW6qYVAyydtncGSxLK_Aoy2aWVIuoptQ@mail.gmail.com>
References: <20100723003456.2976.899.reportbug@dr-wily.mit.edu>
	<20100723012322.GA27113@burratino>
	<20100725085939.GA5281@radis.liafa.jussieu.fr>
	<20100726005111.GA29755@burratino>
	<20100726140756.GH12476@radis.liafa.jussieu.fr>
	<20100726150651.GA4021@burratino>
	<AANLkTimf73aczIILlQ5N_id97kJNmGAUf0QLlMl8my2r@mail.gmail.com>
	<20100726170837.GC4399@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julien Cristau <jcristau@debian.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:49:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRna-0004Kc-6s
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab0GZRs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 13:48:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63697 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab0GZRs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 13:48:58 -0400
Received: by pvc7 with SMTP id 7so168129pvc.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hGAESas3Wve6sS1hBR9g6q/iC0+40jPzJIioaxpIstg=;
        b=uOZpGCG++euF22uP3U7c0JEmXrfZTqt0Nu7ZbMvq++q9++I8mlOCfnyZFa8gPwC3X7
         Vff9ucMkjmlL2WsoIGnOHrNOuHl79PEQkMET7uT7i+xZXsCjVr7aJm43l29+T4kkZBbA
         bVijdwIloVm717xlaoTstTU0wtpnjYdEyf4XY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PrbT/0zXvTVWg0F5suFS2M9vwxELuZa5Tee9Vfdfm9aGt/zKaFK3JqQJWZTy+4C0ti
         x5QReyskp4EuBOqiKij/juG6Z0oNqByHBEIrXe7YAOeFijf9+p9phgPnX31mAK/8gTCA
         HZGbOxjl55ida4RomKYbb+m4SfFHJqm016WQU=
Received: by 10.142.232.13 with SMTP id e13mr9379569wfh.133.1280166538214; 
	Mon, 26 Jul 2010 10:48:58 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 10:48:57 -0700 (PDT)
In-Reply-To: <20100726170837.GC4399@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151862>

On Mon, Jul 26, 2010 at 17:08, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> Should we maybe fall back on checking pw_dir in getpwuid() if $HOME =
isn't set?
>
> Maybe. =C2=A0Why? =C2=A0On Unix I suspect it is such a rare case as t=
o not
> justify complicating the rules, but I do not know if it would help on
> other platforms.

I don't know if this is worth it, but in the Perl world this is a
fairly common idiom:

    my $home =3D $ENV{HOME} || (getpwuid($<))[7];

Sometimes you're executing under some buggy wrapper that's scrubbing
your environment. I recall running into this issue e.g. on some odd
Solaris webserver, which was executing CGI scripts under my user, but
$HOME wasn't set.
