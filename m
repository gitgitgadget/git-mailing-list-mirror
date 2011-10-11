From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Fix is_gitfile() for files larger than PATH_MAX
Date: Tue, 11 Oct 2011 16:58:10 -0400
Message-ID: <CABURp0ru7aCW_oUZO8eaFpau5DAHDgwWLqHSL1QMjbUDkqrANg@mail.gmail.com>
References: <alpine.DEB.1.00.1110111424010.32316@s15462909.onlinehome-server.info>
 <7vy5wre0n7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 22:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDjPK-0002B8-7N
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 22:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab1JKU6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 16:58:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47585 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1JKU6b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 16:58:31 -0400
Received: by wyg34 with SMTP id 34so7766wyg.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GIG46XCAx7GO6kFCdZHUY6wzaLbsvd6BPXKmgfcXYLs=;
        b=LTvIKkJxCPGl9mbxNj33lZ256v2YvRxF9asd0O26bls6WM8+zfNZpWnE5uGIA+nxo9
         VNRAet0+TEm99MWFZNAZMVSmSq5ceArpXYEAZ9W8D/t/zzI2dTB/9Vg0XaGSmARBYEqU
         jytqYMQPB6sl7vtC5gaJhQkdX1xOSmg9U+Z80=
Received: by 10.216.190.131 with SMTP id e3mr1283618wen.48.1318366710176; Tue,
 11 Oct 2011 13:58:30 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 11 Oct 2011 13:58:10 -0700 (PDT)
In-Reply-To: <7vy5wre0n7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183325>

On Tue, Oct 11, 2011 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> @@ -868,8 +868,8 @@ static int is_gitfile(const char *url)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 if (!S_ISREG(st.st_mode))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 if (st.st_size < 10 || st.st_size > PATH_MAX)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 if (st.st_size < 10 || st.st_size > 9 + PATH_MAX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> We are asked if the file is likely to be a single-liner "gitfile: <pa=
th>",
> and were answering yes when it is a very short file (less than 10 byt=
es)
> that cannot possibly even contain "gitfile: " prefix.
>
> I suspect that we can and should get rid of the "cannot be very long"
> check altogether---we do open and check the file, and after all it is=
 not
> like we are throwing different strings as "url" argument to this func=
tion
> at random and this function needs heuristics to reject bogus input
> early. The argument is an input from the user.
>
> Quite an embarrasing bug. Thanks for spotting.

Yes, and it's _my_ embarrassing bug.  I've caught this and have it in
a re-roll, but I got mired up and haven't submitted it again.  I'll
try to do so today.

Phil
