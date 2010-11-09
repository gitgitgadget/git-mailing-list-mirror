From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 02/10] test-lib: introduce test_line_count to measure files
Date: Wed, 10 Nov 2010 00:09:41 +0100
Message-ID: <AANLkTi=NmzMpaEq+iCHdDQth9WdsweLeEbzJBkuP+hZZ@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-16-git-send-email-newren@gmail.com>
	<20101031014654.GC29456@burratino>
	<7vr5f73umz.fsf@alter.siamese.dyndns.org>
	<20101031072640.GA11483@burratino>
	<20101031073350.GC11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 00:10:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFxK7-0005SL-Ui
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 00:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab0KIXJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 18:09:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42277 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0KIXJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 18:09:43 -0500
Received: by fxm16 with SMTP id 16so7207fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RTNWAxJf4CYqpc5/slV+BIQ/+UBU6bLIOzvsRK7Hll4=;
        b=T96kLECuvAeIbt6Jadw2qWuJ9BNDYAelmLXMIfi/XrGRnXBgeqR1AOfhA+mMW1JUNS
         nWFG6i3IzKHL+ozLeX4OxbFGPjHBJNMFWMoKuTA0MIIh/NAvtrcyACDA9xLON58FF5Yd
         7NWg9KmP4stQkmp7wD0rzMvY2/59355DST+lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qdPO+eWknVXGdUi/XU/pVPn5sFgfGUIwG3PAVQLtn+tEo4LytD0VX3gXRINS/I1FrA
         jsHLcQHXb4dINfjO073o0CuHNMwMN9qAhIUQOPwRMR4YZ0Ao9QzaFU2W691tOWPiuNa0
         C8oQNIDoyih4HgRE2tehzbTcYOO8kaFFsJFxg=
Received: by 10.223.101.131 with SMTP id c3mr5905176fao.95.1289344181674; Tue,
 09 Nov 2010 15:09:41 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 15:09:41 -0800 (PST)
In-Reply-To: <20101031073350.GC11483@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161108>

On Sun, Oct 31, 2010 at 08:33, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Some tests check their output with code like the following:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$(git ls-files -u B | wc -l)" -eq 3 =
|| {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "BAD: sho=
uld have left stages for B"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> The verbose failure condition is used because test, unlike
> diff, does not print any useful information about the
> nature of the failure when it fails.
>
> Introduce a test_line_count function to help. If used like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git ls-files -u B >output &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_line_count -eq 3 output

In an earlier thread I suggested an interface like:

    test_line_count 3 "git ls-files -u B"

But I like yours much better. Ack.
