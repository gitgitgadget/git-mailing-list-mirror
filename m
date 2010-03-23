From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Test that the 'rebase -i' "reword" command always
 cherry-picks a commit.
Date: Tue, 23 Mar 2010 14:16:03 -0500
Message-ID: <20100323191603.GB1382@progeny.tock>
References: <4BA11B23.4090801@xiplink.com>
 <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
 <7vd3yw84pd.fsf@alter.siamese.dyndns.org>
 <4BA8D263.8040602@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 20:16:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu9aP-000175-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 20:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab0CWTQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 15:16:15 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:39092 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0CWTQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 15:16:14 -0400
Received: by pzk32 with SMTP id 32so530667pzk.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8rmVm8x9dUrDdazLWTfMJyxXZWPk506CMKEysxIMRN4=;
        b=lS1Np56FcTLME9+iC2Cv92twZxMsQb4slpu3oRc3rimR/gvgi+o1qTw1f69mrTMsL5
         leCDEKSyDWkkUVwldZEGeJdEhXMj+IF1gkglGDVtzOMMWG7X4LVhXinb8krMEUhzc3RV
         TgeNYsbdaokpGa3TpCqHzixLGW/Gr+kh/3BpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rjgtEhwBacK2Oi5SbWmqBa0EerMfSCnBezSPvlTplDyqlZBRw2VHbuCu/BN7gEyg88
         IMDm3+9DXolizd2V0k2FKGGb8kr3FW5Z06dMMxTWW76vSiHB2kY4kLR40YzWk2sCU5zs
         M2nn8wQTjm0u10nPREuzjycPI1297qSOYCZf4=
Received: by 10.114.188.8 with SMTP id l8mr381454waf.12.1269371774311;
        Tue, 23 Mar 2010 12:16:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 19sm1764175pwi.0.2010.03.23.12.16.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 12:16:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BA8D263.8040602@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143043>

Marc Branchaud wrote:
> Junio C Hamano wrote:

>> "rebase -i --no-ff"
>> already exists, and is probably a more natural way to do this than s=
aying
>> "reword" but not rewording anything, no?
>>=20
>> I would actually say "rebase -f P" would be even easier and clearer,
>> especially as...
[...]
> I was confused about the purpose of "rebase -f".  Jonathan Nieder eve=
n
> pointed me to it when I posted my original patch for "rebase -i --no-=
ff", but
> the description in the man page threw me:
>
> 	Force the rebase even if the current branch is a descendant of
> 	the commit you are rebasing onto. Normally the command will
> 	exit with the message "Current branch is up to date" in such a
> 	situation.
>
> I didn't realize that this is exactly the situation that "rebase -i" =
normally
> deals with (-i basically implies -f), and that "rebase -f" would do e=
xactly
> what I wanted "rebase -i --no-ff" to do.

Yes, sorry for not following up on that comment.  The point is that
rebase without --interactive never fast-forwards.  So if you do not nee=
d
to edit your branch interactively, it should work for your purpose.

> But I think I see an approach that might make sense:
>=20
>  - Teach "rebase -i" to recognize the -f parameter (instead of --no-f=
f).

I like --no-ff better. :)

>  - Update rebase's man page to better explain -f.

While at it, I should mention another documentation problem: rebase=E2=80=
=99s
man page does not explain that rebase --interactive will fast-forward a=
t
the beginning of the series.  It should say that rebase -i will do that
and rebase without -i will not.  I can prepare a patch to fix it this
evening.

>  - Update revert-a-faulty-merge.txt to explain how to use "rebase [-i=
] -f".

Sounds interesting.  Simpler to use "rebase (-f | -i --no-ff)", I think=
=2E
Or maybe rebase could learn a no-op --no-ff option to make it easier to
switch between it and rebase -i, and this would become
"rebase (-f | -i) --no-ff".

Jonathan
