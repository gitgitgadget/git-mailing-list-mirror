From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 20:20:53 -0500
Message-ID: <76718491002041720y104c0778s8614fea5e9038905@mail.gmail.com>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
	 <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
	 <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
	 <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
	 <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
	 <alpine.DEB.1.00.1002041946170.4505@intel-tinevez-2-302>
	 <76718491002041157o37de139brb7995076274375aa@mail.gmail.com>
	 <7vmxzose72.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 02:21:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdCsW-0007Xf-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 02:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0BEBUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 20:20:55 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:51563 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0BEBUz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 20:20:55 -0500
Received: by iwn27 with SMTP id 27so408628iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 17:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IlxNCo1F6PvRTA1O2ypyxmr7Kr6zFjvlEFPDcaIM1gE=;
        b=UT2jq8UEdIB63BlTvQsoDfS/6Gv9DChGI1JvLqxGYrjSzkW7cfIvsttE6KEivqWG/h
         dXZeOqJeOmFZR3vYZkpQ8hQ9lar6U4DSH7muZy/Fvl21YfFVj3c8ZcGt44dTQSGK2Seq
         v4gRw/v6P4mrQWJJfEzmqwHAGJtbAYToOx1nM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kl6JAnZbDSzNr9ju61lwqiWsKtniJIQcNfzMjp9chaoaonMehfwFqIXnG3MENvfzFq
         V+G7B9TcJ9s31IQFGiin5TUAAq1AsIJpK66Q5EkePMVhq2kVdFLRYFTYy1ZImzquqWjy
         oIWNf6hJ5FH5h/NARP2rODyrNODtsyvzqUHhg=
Received: by 10.231.168.132 with SMTP id u4mr1031265iby.79.1265332853956; Thu, 
	04 Feb 2010 17:20:53 -0800 (PST)
In-Reply-To: <7vmxzose72.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139019>

On Thu, Feb 4, 2010 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I think Dscho's point is that cherry-pick internally runs the same
> merge-recursive.

Ah hah, that's what I was missing. Thank you.

> When you have a change C based on its parent C^ and want to replay th=
at
> effect on a (possibly unrelated) commit A, you would run three-way me=
rge,
> merging C into A as if C^ is the common ancestor. =C2=A0The rebase sc=
ript
> cherry-pick, and revert all work with the same principle (for revert
> obviously you would swap C and C^---you are applying the effect of go=
ing
> from C to C^ in that case).
>
> And no, "format-patch --stdout | am -3" pipe in the normal rebase cod=
epath
> will stay unless you can produce a benchmark that says the performanc=
e of
> merge machinery is good enough these days. =C2=A0Back when "rebase -m=
" was
> introduced, it wasn't.

Indeed, the difference is painful on a largish tree (910M after gc
--aggressive, 39k files). Best of 3 runs for each of these:

$ time git rebase --onto HEAD~11 HEAD~10
=46irst, rewinding head to replay your work on top of it...
[...]
real	0m11.164s
user	0m2.671s
sys	0m4.836s

$ time git rebase -m --onto HEAD~11 HEAD~10
[...]
real	0m40.507s
user	0m17.848s
sys	0m16.052s

$ time GIT_EDITOR=3D"sed -i -e 1d" git rebase -i HEAD~11
[...]
real	0m27.758s
user	0m12.615s
sys	0m13.134s

It looks like there's room for improvement to rebase -m. (2.53 Ghz
Core 2 Duo Macbook Pro, 4GB memory.)

j.
