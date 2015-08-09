From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 9 Aug 2015 14:13:33 -0400
Message-ID: <CAPig+cQ0fSc+rjzgDyaw4xvCPCswJLDcQSmbxXnxG-uc6zB0qA@mail.gmail.com>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
	<20150805091747.242e8fa1@jvn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:13:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOV6J-0002s5-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 20:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbbHISNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 14:13:35 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32852 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbbHISNe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 14:13:34 -0400
Received: by ykaz130 with SMTP id z130so16597857yka.0
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wUssSrYx7jeAQOji/y8qH2usGtoRBRjkQa4FSLX+hGI=;
        b=TkmZN1ksgPceiKCudkCOdPZl8ey5Mnu2g3GEwZsuwHQDO5lxK9k3qfjWB9B137AaG3
         RyQ5hYr5Is++YbidoP8FUecaidR/47iJoJYGCKUk99c8UJf9gZQKYmXE+0OHkV2VVh0i
         9QfIPpYupGjGLJZ7IzAVOmuVRbY8En5Bf5ZOMXf8gHhGWmchiioKcBxp1fJEYenxgE3h
         qwHPKi1ezG9mB09x5aetG2gMKkMMtX06aCl7oBxE+flcojnh0HJRLTebKeXKUyGhSSep
         Z2xDshe2xND4sR7VVBsB33WCzYCW6ucxEID1dhZspx2kxIg+b/xA6xEk0S9de+Xccyn1
         mq9w==
X-Received: by 10.13.192.132 with SMTP id b126mr17608115ywd.163.1439144013938;
 Sun, 09 Aug 2015 11:13:33 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 9 Aug 2015 11:13:33 -0700 (PDT)
In-Reply-To: <20150805091747.242e8fa1@jvn>
X-Google-Sender-Auth: 323IiHkYVaeeULcA6hGmNCl-YuE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275555>

On Wed, Aug 5, 2015 at 3:17 AM, Jan Viktorin <viktorin@rehivetech.com> wrote:
> Do I understand well that you are complaining about too
> narrow commmit message?

Yes, I'm a complainer. ;-) It's minor, though, not a big deal, and
certainly not worth a re-roll if that was the only issue. In fact,
other than the undesirable "Supported:" line in the documentation, all
comments on v2 were minor and not demanding of a re-roll.

> I am trying to figure out how to write a test. It is
> not very clear to me, what the testing suite does. My
> attempt looks this way at the moment:
>
> 1657 do_smtp_auth_test() {
> 1658         git send-email \
> 1659                 --from="Example <nobody@example.com>" \
> 1660                 --to=someone@example.com \
> 1661                 --smtp-server="$(pwd)/fake.sendmail" \
> 1662                 --smtp-auth="$1" \
> 1663                 -v \
> 1664                 0001-*.patch \
> 1665                 2>errors >out
> 1666 }
> 1667
> 1668 test_expect_success $PREREQ 'accepts SMTP AUTH mechanisms (see RFC-4422, p. 8)' '
> 1669         do_smtp_auth_test "PLAIN LOGIN CRAM-MD5 DIGEST-MD5 GSSAPI EXTERNAL ANONYMOUS" &&
> 1670         do_smtp_auth_test "ABCDEFGHIKLMNOPQRSTUVWXYZ 0123456789_-"

Wouldn't this one fail the regex check you added which limits the
length to 20 characters?

> 1671 '
> 1672
> 1673 test_expect_success $PREREQ 'does not accept non-RFC-4422 strings for SMTP AUTH' '
> 1674         test_must_fail do_smtp_auth_test "../ATTACK" &&
> 1675         test_must_fail do_smtp_auth_test "TOO-LONG-BUT-VALID-STRING" &&
> 1676         test_must_fail do_smtp_auth_test "no-lower-case-sorry"
> 1677 '
>
> * I do not know yet, what to check after each do_smtp_auth_test call.

If you were able somehow to capture the interaction with
Auth::SASL::Perl, then you'd probably want to test if it received the
whitelisted mechanisms specified via --smtp-auth, however... (see
below)

> * Perhaps, each case should have its own test_expect_success call?

The grouping seems okay as-is.

> * Why send-email -v does not generate any output?

As far as I know, git-send-email doesn't accept a -v flag.

>   (I found a directory 'trash directory.t9001-send-email', however, the
>   errors file is always empty.)

Was it empty even for the cases which should have triggered the
validation regex to invoke die()?

> * Is there any other place where the files out, errors are placed?

No.

> * I have no idea what the fake.sendmail does (I could see its contents
>   but still...). Is it suitable for my tests?

It dumps its command-line arguments to one file ("commandline") and
its stdin to another ("msgtxt"), but otherwise does no work. This is
useful for tests which need to make sure that the command-line and/or
message content gets augmented in some way, but won't help your case
since it can't capture the script's interaction with
Authen::SASL::Perl.

> * Should I check the behaviour '--smtp-auth overrides
>   sendemail.smtpAuth'?

That would be nice, but there doesn't seem to be a good way to do it
via an existing testing mechanism since you can't check the
git-sendemail's interaction with Auth::SASL::Perl. The same holds for
your question above about what to check after each do_smtp_auth_test()
call.

One possibility which comes to mind is to create a fake
Authen::SASL::Perl which merely dumps its input mechanisms to a file,
and arrange for the Perl search path to find the fake one instead. You
could then check the output file to see if it reflects your
expectations. However, this may be overkill and perhaps not worth the
effort (especially if you're not a Perl programmer).
