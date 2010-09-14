From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] setup_tree_pathspec(): interpret '^' as negative pathspec
Date: Wed, 15 Sep 2010 08:41:46 +1000
Message-ID: <AANLkTi=i4P=Xa+PPxp1aLdJOSA7cTptA+KnMsQwjSth1@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
	<1283961023-4491-8-git-send-email-pclouds@gmail.com>
	<7viq288g2z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 00:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OveCI-00040n-Ql
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 00:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050Ab0INWls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 18:41:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34487 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab0INWlr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 18:41:47 -0400
Received: by wyf22 with SMTP id 22so7966070wyf.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tYDAY2ePAAmz+4vNEqZx6NxzAtqGCkAyBsgwbMbED7g=;
        b=volUDVaPANO3ph/s6Ha4Y7jdgdEOtAP2vo/NV3iY8gXzetvxwRDzf1bqGV772QLxBU
         i7Vvjb2N+ZMKISimNBDwMUJu6U+6ZcU0/K8YW2MnvKmLQE4KCRiYsdnZ1LGqLvfKsm9u
         fUxxQk6C/on5StDS5V/CI1pv0r7133+K7wxq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ccg850OEecl3gHLMGTd5AQ/6hvB/NVO67L9QI96EgNFXjgmIZzpXzp7DrfNPi1+JLq
         aVQZfbi0tSOnbA1pCOlQf8w6Ytv/LcOi6JI8XTPmQqiTcGtFOuQUnRTWONywMF95N1lX
         dYQr2qKJQunv1zAf49jCsatoPeLti61p/no8s=
Received: by 10.216.17.211 with SMTP id j61mr553078wej.14.1284504106367; Tue,
 14 Sep 2010 15:41:46 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Tue, 14 Sep 2010 15:41:46 -0700 (PDT)
In-Reply-To: <7viq288g2z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156215>

2010/9/15 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> This patch does preparation work for tree exclusion in
>> tree_entry_interesting(). '^' has similar meaning to '!' in
>> gitexcludes. '!' is not used because bash does not like arguments wi=
th
>> a leading '!'.
>
> Do not even mention gitexcludes as you have to make awkward excuse li=
ke
> this.
>
> Instead say something like
>
> =C2=A0 =C2=A0'^' works exactly like prefix '^' for revs (e.g. "log ^m=
aint master")
> =C2=A0 =C2=A0to mark what is prefixed is excluded.

It was not thought through. The way this patch does means
get_pathspec() will need to be updated to handle the case "(in
subdir)$ git diff ^foo", which has to be turned to "(in toplevel)$ git
diff ^subdir/foo", not "(in toplevel)$ git diff subdir/^foo".

A better approach would be separate "^" out as an argument by itself,
i.e. "git diff ^ foo". Less work in get_pathspec(), and tab-comletion
on path also works. But now as '^' stands alone, '!' can be used too
(no more bash history expansion). And I think '!' is more intuitive
than '^'.
--=20
Duy
