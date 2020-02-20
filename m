Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7FC11D0B
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C1420659
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 16:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MnvLdNLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgBTQBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:01:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:45831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgBTQBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 11:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582214453;
        bh=Hzf62wHmWknyOLe9g1jwXISqQ4idFxG45yZ3ugGPEcQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MnvLdNLPbnD24KUueHyIcv8fDV8lCtJ5NXnZeCJmO/ZSsFOQK82eXdZg8cu1oG59h
         aId9IiuEUHmZZM3Vvg5KkHs41jrqrsLGXzmnqX6uHWYujclI3CrtOtDYPDWIcyvVIA
         wPNcb2WuMtiVGTju6N0IcYNHiIhNmiUozkzj7M/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1j3QoN3H7f-00220a; Thu, 20
 Feb 2020 17:00:52 +0100
Date:   Thu, 20 Feb 2020 17:00:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Git List <git@vger.kernel.org>, bfields@redhat.com
Subject: Re: [PATCH 1/4] parse-options: convert "command mode" to a flag
In-Reply-To: <CAPig+cQkBKJLW3-W4SS0KX9+Gs2fT-Z-DrvVpcVOLZpFmVBoQA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002201659500.46@tvgsbejvaqbjf.bet>
References: <20200219161352.13562-1-pbonzini@redhat.com> <20200219161352.13562-2-pbonzini@redhat.com> <CAPig+cQkBKJLW3-W4SS0KX9+Gs2fT-Z-DrvVpcVOLZpFmVBoQA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aqpyEj7PjE+xT8GKyFgJwowrGniSgz5kKDPwjsbd9lECxlfpZPd
 biwbKoL0UeuPfHzhl2PAVo8cKLxjDt80DamYd/dy7LlQONZsEQ26Ay5T0edDSGsoSaF8iyw
 1Pn/2cbqJXdF9uwSI3bMC/TX+BIvqB44vQuNSO1oGZm/OP8J2F6ELoHpb3JOUlKCbz4EDMt
 gLHZEnDBc25vDzlpnaq3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:36CXlD2YRHg=:wDyU69DY0V4gZwD3U3w6D3
 AHlPNbIbHGb5RH+7Vz9JZd5tsP04rBt+Lbjn0fppwuitrHZUc2CYfj6gaxTCNsJIbBLQsMA4g
 J5pHB+tQAIL5tZ68TXC1O84NHVtd6vgP+9GR28ruEQpnWbwIRjDSQZC7MtC0qAh3xPCZ6r7Im
 mm7EGWmf3m7YpR59U+nrlWyys3CcggAUhR3oqQTMVXemYAHohP8biDyqYaWevZhIonTG7k2hn
 IyWg6E3iU2kem0PGyjTtUGc4ih8sdODIIqPsTvObc6GUQuz7OuakRoWQVl09ukrlXyC5HhkW4
 ohy6Du0phiSTaEhTgMXW4K7kdzQLZXIaFQTO6xQpbt/Ve1SLSnq8mfBvDkNBQ+menpnR3j8SY
 Ri7jLMxV8xv5fOoJm78ZZWWSGNzqGHKEiaeVow00bRvKrc+CdVJCVz3N6jG0XcQp+VF7JC4Xz
 6YgQPr+oPVeE1tEzBsQYlRPaDBGyomOQTTr2otqXIkpH5vSQzICJFp7OCPzcnmaM6DjNxr4lp
 X8Y99y0oEGxEYPfGqDWCLoAVzZQnUVk/T073JziSl0ndgpoT6K05RXDu20UmonwCB26BWWPok
 EmvgT/RJ3ADEP35xYCtYjWtvvTCDmsoaMbZHWRKhupCi3gvkl0dv4y0c/rODju70fR//0O7Z3
 xQXUEQBu6K8VBYtFxOR+G28fJzK10CD+7SMX+g9yUU8Cz69XfrTQI0wXwtREVEEq54n/KNhrn
 0VLki2NkPl63cElTdHFc+jivyfzVGO8bUb0tQOMI0ieoj+GLNt3SwBsb/dWb/O4AZ6ylABbAz
 xWipT7nC8/dtK8G0nWhYfoUMJOzSz++5EI21yN8Y0buiLQpAIcaQh1ooYXwzqhu4x1xYgyswg
 OIHnwJSdwhCNuubDfHE2lUW47MrbPm34SetWuXINlI7ThqJBV0bCtIyE9BviSp8nRu9tb6ktv
 gJbSex424DcPlyaDSlq7vtYlirZPzDP5hJK8p3lpFVtzhJId+6Wi2NixCzVZ85l91uc76d0Wz
 Qo5HZVQSr6yQLU5k/NCH1P/k+pmaQ3tO8qCIFUEjR75MzCYj8BLonyyccxLFafTcOtTSIs0yF
 nPFJlT7d6EZ8LMxWXikzCC+qgVaNgD2Tt6hy0wJkNghkQZNd/h0ooNQ6KQp7IUEtVKQDi0tKX
 2fyj1Y3JanYRuveZ3gVyXvX63V/ITfe/UOcuonS4QbRIxdbb5UvjTUUrwoMt8I4KKmKQotMXR
 J/i1MZ2+YLSUCMwMt
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 19 Feb 2020, Eric Sunshine wrote:

> On Wed, Feb 19, 2020 at 11:15 AM <pbonzini@redhat.com> wrote:
> > OPTION_CMDMODE is essentially OPTION_SET_INT plus the extra check
> > that the variable had not set before.  In order to allow custom
> > processing, change it to OPTION_SET_INT plus a new flag that takes
> > care of the check.  This works as long as the option value points
> > to an int.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> > @@ -324,6 +326,22 @@ test_expect_success 'OPT_NEGBIT() works' '
> > +test_expect_success 'OPT_CMDMODE() detects incompatibility' '
> > +       test_must_fail test-tool parse-options --mode1 --mode2 >output=
 2>output.err &&
> > +       test_must_be_empty output &&
> > +       grep "incompatible with --mode" output.err
> > +'
>
> The error message may have been localized, so use test_i18ngrep()
> instead of 'grep':
>
>     test_i18ngrep "incompatible with --mode" output.err

The error message _is_ localized, causing the GETTEXT_POISON job to fail:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D31113&view=
=3Dms.vss-test-web.build-test-results-tab&runId=3D97704&resultId=3D102357&=
paneView=3Ddebug

So yes. It needs to be changed to `test_i18ngrep`.

Thanks,
Johannes

>
> > +
> > +test_expect_success 'OPT_CMDMODE() detects incompatibility with somet=
hing else' '
> > +       test_must_fail test-tool parse-options --set23 --mode2 >output=
 2>output.err &&
> > +       test_must_be_empty output &&
> > +       grep "incompatible with something else" output.err
> > +'
>
> Ditto.
>
>
