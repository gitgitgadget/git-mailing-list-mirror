From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON prerequisite
Date: Sun, 20 Feb 2011 13:42:20 +0100
Message-ID: <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<1298143495-3681-4-git-send-email-avarab@gmail.com>
	<20110220021031.GB17305@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 13:42:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr8cN-0005Ka-1b
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 13:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab1BTMmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 07:42:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53827 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1BTMmV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 07:42:21 -0500
Received: by fxm17 with SMTP id 17so661631fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 04:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IHSISNih/VXOY8+Db5hViiRuH/8dqQBcxUvpOkkj3Mw=;
        b=mwhZky4t3wg99cYmV6RFDLAExWYLS3/avGW462PfGhd7//gNIEjPBMUPthQ+hzpAwl
         vsh6/lFHkHXuQDV583M1wS9IixSmkI9FLTKN8Kr/TTALpz6mW13gZe5NCgf9F8JwL53U
         CTwEUaoZuo7pzH57egFWQbDB5zG7UEDuFU8tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bIPZb5yKeGzEgK9fBnMlhTMpDYgkVSZ/5SsHOK6suu2ma9NBFj3LjZ/g6TBXj7/N9l
         H4ALJMUfUlH7Qzj2Dt65dhjOXsPkhtWRHIYRD+u99TQSS5unQR9pVkWFvwfcu5CP9jbj
         B5mWIgAovNtVbztKvb5O0asEC3OaycrjEtXow=
Received: by 10.223.96.12 with SMTP id f12mr438294fan.79.1298205740280; Sun,
 20 Feb 2011 04:42:20 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sun, 20 Feb 2011 04:42:20 -0800 (PST)
In-Reply-To: <20110220021031.GB17305@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167422>

On Sun, Feb 20, 2011 at 03:10, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi =C3=86var,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Add a new test prerequisite called NO_GETTEXT_POISON to t/test-lib.s=
h
>> that's always set for now.
>
> Suppose I am writing a new family of tests. =C2=A0Which of them will =
need
> the NO_GETTEXT_POISON prerequisite? =C2=A0The name doesn't make it ea=
sy to
> guess.

You shouldn't worry about it for now. FWIW NO_GETTEXT_POISON is
documented in po/README in a patch that I plan to submit later.

NO_GETTEXT_POISON is only relevant to people such as myself who are
adding new translations to the source. I.e. changing "foo" to
_("foo"). It's a sanity check to make sure that by doing so you're not
changing some plumbing test, or at least have to realize what it is
that you're changing.

It's not perfect since we don't have tests for everything, but it's
helped me a few times.

> If later the testsuite learns to take a --lang=3D option to test that
> git works correctly in my native language.

Yeah, I plan to add something like --lang later, but for now we have
POISON :)

> -# Always set the NO_GETTEXT_POISON prerequisite while we don't have =
a
> -# real gettext implementation in Git. This will be replaced by
> -# something that varies in a future patch series.
> -test_set_prereq NO_GETTEXT_POISON
> +# We can rely on output using the C locale.
> +test_set_prereq ENGLISH

It's explicitly about tests that can't deal with poison, not
non-English. See this comment in patch  28/72:

    gettextize: git-commit "enter the commit message" message

    Gettextize the "# Please enter the commit message for your changes.=
"
    message. Several tests in t7500-commit.sh and t7502-commit.sh assum=
e
    that this message starts with a newline. Change the tests to to ski=
p
    under GETTEXT_POISON=3DYesPlease.

    These fail under GETTEXT_POISON=3DYesPlease because the poison edit=
or
    message doesn't do the right thing with comments and line breaks, s=
o
    these messages will be incorrectly broken up across lines.

    This test should not be skipped under a hypothetical future testing
    mode that tests Git under language locales, since those messages
    should all start with a newline like the original.
