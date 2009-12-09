From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [REROLL PATCH 3/8] Pass unknown protocols to external protocol 
	handlers
Date: Wed, 9 Dec 2009 09:55:01 +0100
Message-ID: <36ca99e90912090055s32d5ebc5p917dd7e528218f68@mail.gmail.com>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <1260278177-9029-4-git-send-email-ilari.liusvaara@elisanet.fi>
	 <7vskbl59ai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 09:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIIKD-0008NB-76
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 09:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZLIIy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 03:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbZLIIy4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 03:54:56 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:60462 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZLIIyz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 03:54:55 -0500
Received: by fxm5 with SMTP id 5so7204257fxm.28
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 00:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tz68qi/IVuwpq3Hzt36its2dAOzW7kJxh1CJJ4UV4XI=;
        b=hp4ftN2OPsM24IP+GJbq2ChlpqFXQTIAJDBR71y7xh6Qa+pIqxdoUv34X3nRWX20Sd
         T4+Xezj8PNsqCnNMaZ8B1fbXVI0Tyimb1u+/s60Mh3VQAkr+nfhH4qAvOJNmKQ7AvrON
         FN/SygrpEiijir7w2lzlD6/dBHbIKh5ppiViE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WN4GuyhzfhitjotqBJ/0pQB4v0kfbahZ+fOgtHliyaQ4+Eadiy1yROtLebcmMAVWUq
         93MeF3ru7I/iwTx5ICJRcwfGuf2xsJNP9udE5bgbOmD60eVUaIF7sFG8l2VDuuKQXBXv
         Pk3ox+9i5zJlnbv+Z8s4YHcDIPEzskn8Oi7tM=
Received: by 10.223.5.18 with SMTP id 18mr1404062fat.58.1260348901336; Wed, 09 
	Dec 2009 00:55:01 -0800 (PST)
In-Reply-To: <7vskbl59ai.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134949>

On Wed, Dec 9, 2009 at 00:35, Junio C Hamano <gitster@pobox.com> wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
>> + =C2=A0 =C2=A0 } else if (!is_url(url)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !prefixcmp(url, "file=
://")
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !prefixcmp(url, "git:=
//")
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !prefixcmp(url, "ssh:=
//")
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !prefixcmp(url, "git+=
ssh://")
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !prefixcmp(url, "ssh+=
git://")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* These are builtin sma=
rt transports. */
>
> Hmm, what is !is_url(url) at the beginning for, if this lists "builti=
n"
> smart transports?
I think/hope this should catch theses use cases:

       ?   [user@]host.xz:/path/to/repo.git/
       ?   [user@]host.xz:~user/path/to/repo.git/
       ?   [user@]host.xz:path/to/repo.git
