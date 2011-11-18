From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Fri, 18 Nov 2011 08:50:20 +0700
Message-ID: <CACsJy8CB6VXjyC-M4C9qGm-n73Kuf1Q0SbH4Ync5Osts-uufQQ@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com> <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net> <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
 <20111118012715.GA7826@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 02:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDbV-000158-UT
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab1KRBux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 20:50:53 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48421 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab1KRBuw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 20:50:52 -0500
Received: by bke11 with SMTP id 11so2823436bke.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W16mZe760XMzH6+RrzE4GWb6xjR21W2ucwkecdQOs7c=;
        b=Nf9yBeGG5Ec4eC90aLY0IHTb8n9aRA9O9netk2xJ3+RIHF4hV0d1Jj9pMs+4DXVG92
         zVZ8RbEBUXqIw8QJR9DP668SGhHU95Wc+dRsNggoR54jDFPILqDfZ1kCmJxOTRm162De
         JxvYPtY7jnhCZOwly62CY7+vbssvy5z6DJdX4=
Received: by 10.205.131.3 with SMTP id ho3mr1063679bkc.11.1321581051124; Thu,
 17 Nov 2011 17:50:51 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Thu, 17 Nov 2011 17:50:20 -0800 (PST)
In-Reply-To: <20111118012715.GA7826@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185623>

On Fri, Nov 18, 2011 at 8:27 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 18, 2011 at 08:12:27AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > Older compilers will probably barf on the variable-argument macros=
=2E
>>
>> Anyway to detect if __VA_ARGS__ is supported at compile time? I gues=
s
>> #ifdef __GNUC__ is the last resort.
>
> You can check "#if __STDC_VERSION__ >=3D 19901L", but that will of co=
urse
> only tell you whether you have C99; older gcc (and possibly other
> compilers) supported __VA_ARGS__ even before it was standardized.
>
> But more annoying is that there isn't a great fallback to __VA_ARGS__=
=2E
> If you can't use it, then every callsite has to have the same number =
of
> arguments. So it's not like you can localize the fallback code to jus=
t
> the definition.
>
> Unless you really need macro-like behavior, you're probably better of=
f
> using a variadic function and making it a static inline on platforms
> which can do so.

I need to save __FILE__ and __LINE__ of call site, inline functions
probably don't help.

>> notes-merge.c introduces __VA_ARGS__ since v1.7.4 so we may want to =
do
>> something there too.
>
> I hadn't noticed. That definitely violates our usual rules about
> portability. =C2=A0That usage can easily be turned into an inline fun=
ction.
> However, since nobody has complained in the past year, it makes me
> wonder if we are overly conservative (my guess is that people on craz=
y
> old compilers just don't keep up with git. Which maybe means they are=
n't
> worth worrying about. But who knows).

=46or the record, Sun C compiler 5.9 seems to support it.
--=20
Duy
