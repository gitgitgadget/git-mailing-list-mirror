From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 1/2] t5520-pull: Add testcases showing spurious 
	conflicts from git pull --rebase
Date: Mon, 9 Aug 2010 13:22:40 -0600
Message-ID: <AANLkTin0xvK8H8RvaXtmaNHJh1dStn0AN1Mqed7JGvuO@mail.gmail.com>
References: <1281300917-5610-1-git-send-email-newren@gmail.com>
	<1281300917-5610-2-git-send-email-newren@gmail.com>
	<7vfwyn61td.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:22:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiXvs-0002cQ-8L
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0HITWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 15:22:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51119 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab0HITWm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 15:22:42 -0400
Received: by fxm13 with SMTP id 13so235723fxm.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yANg8HpWB4rg0Ap3KKyHe5Tql0NAgDlK83A8EYmMFeU=;
        b=FiRocgrq77lIegAfVAt17ASrPy2efl1CYFyj+NrdAZmZGl9yrLjV5agTXGbPshuUFb
         WDbPIx/Ashia6bskdWKHakZdQf6pk8DjtuGpXvupXl+kuaCSBDSUxZuFNLVvCLZrBVLr
         TNuiR16gmQkC2Hf8NuR2gcaFrV1F0crx3jx7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=asfX5JtwgvuvI9Q6e+I40kryJC/re+L085P/g4mRc/JmYoYGR5XDRg5wR5HzCUHQqM
         lRsdwi0PwWCbBFf+d7pYI7LQoYh7W6fr/yLNUNDKlftTsXty0P5Ojb504LL2g3WZUuEP
         u2fTjQkC7mgyohGb3wRs83rZHAugIxdvcoyvc=
Received: by 10.223.119.136 with SMTP id z8mr16994958faq.63.1281381760424; 
	Mon, 09 Aug 2010 12:22:40 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Mon, 9 Aug 2010 12:22:40 -0700 (PDT)
In-Reply-To: <7vfwyn61td.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153002>

On Mon, Aug 9, 2010 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Elijah Newren <newren@gmail.com> writes:
<snip>
>> +modify () {
>> + =C2=A0 =C2=A0 sed -e "$1" < "$2" > "$2".x &&
>> + =C2=A0 =C2=A0 mv "$2".x "$2"
>> +}
>
> Just a style thing but I'd prefer to see the above written like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0modify () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "$1" <"=
$2" >"$2.x" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mv "$2.x" "$2"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

I copied this function verbatim from t/t4127-apply-same-fn.sh.  Would
you like me to fix that one too?

>> +test_expect_success 'setup for avoiding reapplying old patches' '
>> + =C2=A0 =C2=A0 (cd dst &&
>> + =C2=A0 =C2=A0 =C2=A0git rebase --abort;
>
> This may be hypothetical but this discards error condition from faili=
ng to
> ch into dst (for whatever reason). =C2=A0Don't we expect "git rebase =
--abort"
> to exit with a non-zero status? =C2=A0Same comment for the last one i=
n the
> patch below.

Yes, Hannes pointed out the same issue.  Does the follow-up interdiff
I posted in response to my patch address this in a way you'd like?
