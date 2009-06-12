From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 19:11:36 -0400
Message-ID: <ca433830906121611g5d079908ycc714adcc30c9aa@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	 <20090612084209.6117@nanako3.lavabit.com>
	 <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
	 <85647ef50906120838s37c186a9mec301e880b1a8a4e@mail.gmail.com>
	 <m3vdn12y6y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFuT-0006Vz-CD
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbZFLXLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 19:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZFLXLg
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:11:36 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:53443 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZFLXLf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 19:11:35 -0400
Received: by fxm12 with SMTP id 12so922221fxm.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FELsCHTEkJc2IAwhjUzHN08H73Xnwrfgln90PQKZeMs=;
        b=nzM49XgbPf+Eyl6ox1Px/sNmQ0RCvBkGiant2ZmZyoI5j+IBhDHRXxjUjr0EB9cj82
         tVncls3klW8Vv4s9XNseTfF/8KgOVtAktkAyEFxghpmxjXQE21mhC958X8eErjHaX2Ou
         FY9eQ73KuNH919nIoSaP80FDXcTcaBO00qOOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oCTm2+RH0tZXbah3Pn+Jh6CmU5nqwOJM8J3npjHaWazFeYD4LfMVLG45cl1S0KWhy0
         HaR2GatOG/49A14sIf/5OuuzJvxzjPPpH99bb29w11ABf2OiRgmA5bMs62v2GPDFkeib
         0cEnhESUeD3odjX+ROYeL1fnppmHOxOVQsvow=
Received: by 10.223.113.199 with SMTP id b7mr3049404faq.82.1244848296993; Fri, 
	12 Jun 2009 16:11:36 -0700 (PDT)
In-Reply-To: <m3vdn12y6y.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121466>

On Fri, Jun 12, 2009 at 12:50 PM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
> Constantine Plotnikov <constantine.plotnikov@gmail.com> writes:
>> On Fri, Jun 12, 2009 at 11:56 AM, Daniel Stenberg<daniel@haxx.se> wr=
ote:
>>> On Fri, 12 Jun 2009, Nanako Shiraishi wrote:
>>>
>>>> It would be ideal if you can inspect the certificate and decide if=
 you
>>>> need to ask for decrypting password before using it (and otherwise=
 you don't
>>>> ask). If you can't do that, probably you can introduce a config va=
r that
>>>> says "this certificate is encrypted", and bypass your new code if =
that
>>>> config var isn't set.
>>>
>>> Is this really a common setup? Using an unencrypted private key sou=
nds like
>>> a really bad security situation to me. The certificate is never enc=
rupted,
>>> the passphrase is for the key.
>>>
>> For SSH using unencrypted private key is very common for scripting a=
nd
>> cron jobs. For HTTPS situation looks like being worse since there is
>> no analog of ssh-agent that covers at least some of scripting
>> scenarios. Do we want to disable scripting for HTTPS?
>
> Actually you can use _encrypted_ private keys together with ssh-agent
> and for example keychain helper for scripting. =C2=A0You have to prov=
ide
> password to all listed private keys only once at login. =C2=A0I wonde=
r if
> something like this would be possible for HTTP certificates...

I would love something like this - it would be useful for SVN as well.
