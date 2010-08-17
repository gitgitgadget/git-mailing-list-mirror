From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] t/t0000-basic.sh: Don't run a passing TODO unless TEST_PASSING_TODO=1
Date: Tue, 17 Aug 2010 12:57:01 -0500
Message-ID: <AANLkTimx_kOr6UptsVOCdMHjxQqcde4oaDgrN2amnuYe@mail.gmail.com>
References: <1282038234-1880-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlQPq-0002HZ-GS
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab0HQR5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 13:57:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35167 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066Ab0HQR5V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 13:57:21 -0400
Received: by ywh1 with SMTP id 1so2620359ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tgRyGmg2m/ypvJWLB0RgZrExnMr4x0Q8q8QmKJaKH9Q=;
        b=MduRk+jbV76EtdnMYIlU1/F27FBgyXmce/DNHdQWnH8Hx6YQzO/JdbjFyDQs0lXJeY
         KVctWEVpRP40b1FWJ84QGdUgpqBXExYmKRi16lDcahyOttbZ+qq4aL5PPInK3S5CdwPt
         WmfqJ7XEn87UDHbtV9UZoAAgTzi623T8e/TSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AevorbeIyxGoxCWJx6bJFzNMHODX/M5ClJ4iButDVASSOGwkPCUsYY2BT5rARFCw9z
         vORXS1WZkfjlS74KbvmNpSIRZNr7zpJQIibPHkhcLKgDhHcfHvH0XVBkGyyUtaOdgDWi
         bO0FPHejA+ohYv03bItPupNK+rsxN7dHAKmVI=
Received: by 10.150.2.19 with SMTP id 19mr7457932ybb.53.1282067841143; Tue, 17
 Aug 2010 10:57:21 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 10:57:01 -0700 (PDT)
In-Reply-To: <1282038234-1880-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153770>

Heya,

On Tue, Aug 17, 2010 at 04:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Change the sanity tests in t/t0000-basic.sh to not to run a passing
> TODO test unless the TEST_PASSING_TODO environment variable is set.
>
> The motivation is to have nothing out of the ordinary on a normal tes=
t
> run for test smoking purposes.
>
> If every normal test run has a passing TODO you're more likely to tur=
n
> a blind eye to it and not to investigate cases where things really ar=
e
> passing unexpectedly.

Thanks, this has bothered me ever since I first ran the test suite.
While I understand that the test suite needs testing to, it should be
done in such a way that it doesn't produce false positives. That is,
my preference would be to still keep the test in the suite as-is, but
somehow get it to show up as a passing test instead of a fixed one.
E.g., something like:

test_in_new_harness 0 1 0 0 '
    test_expect_failure 'pretend we have fixed a known breakage' '
           :
     '
'

Where there '0 1 0 0' stands for '0 failures, 1 fixed, 0 broken, 0
success'. Not sure there's any other use for a test_in_new_harness
function though...

PS: To clarify, test_in_new_harness would not change any of the
counters (test_failure, test_count, test_fixed, test_broken,
test_success), but would instead compare those against the values
specified as argument to test_in_new_harness.

PSPS: I have no idea how easy it would be to implement something like t=
his.

--=20
Cheers,

Sverre Rabbelier
