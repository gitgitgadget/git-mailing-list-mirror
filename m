From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 6/9] For each exclude pattern, store information about
 where it came from
Date: Thu, 6 Sep 2012 18:56:10 +0100
Message-ID: <CAOkDyE-u7yzEDu++iX_zRMU==oUWbR5uM1j50N5XH4SaJkB0Ww@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
	<1346544731-938-7-git-send-email-git@adamspiers.org>
	<997D30474124498FBFBA89C2E20F7773@PhilipOakley>
	<7vipbwgnnv.fsf@alter.siamese.dyndns.org>
	<A05E4811A66D499DA6AC932AC49F1E8F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:56:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9gJR-0002nV-25
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab2IFR4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 13:56:13 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63099 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab2IFR4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 13:56:11 -0400
Received: by bkwj10 with SMTP id j10so978065bkw.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UksPm30F1oNYjPDMgecorZfsziNrYExlOtZPg3lpg80=;
        b=AGq/sQNxm0sI9XPOt4JMaMgpseS4fSRBZR5Ayligk+4ufKIpeD6IMFvhf/nykzVE/Q
         xObGssvcVp1ARmSQ9s8hEdpAdIQt+/9cQb3nlTaKls4IPxHAET6omoVz6QgMYFRpWGh2
         D5wEfYtbs/MgAtmq34maLkqYCbWYfzqXCN8QJ8GHwDGtMNQp/xqE1ZWF8EhMa8Tzgsw4
         v2kW//EtpnJWiwmra8zr5+N9byjUkJPsqByty8cyPiEaRQKUYVMGEkT6HKP/HRUvxi/0
         GBOveiT0g3U6BU5MoMOM70w1Ajzaj/ZHgo389FuvrjGPyH3Cj+6Ud+m0bcoBkH06O4Rb
         KQug==
Received: by 10.204.152.207 with SMTP id h15mr1575320bkw.5.1346954170253; Thu,
 06 Sep 2012 10:56:10 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 6 Sep 2012 10:56:10 -0700 (PDT)
In-Reply-To: <A05E4811A66D499DA6AC932AC49F1E8F@PhilipOakley>
X-Google-Sender-Auth: o4dVV5WOQhB9iXDF6ddqB-pioac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204910>

On Sun, Sep 2, 2012 at 11:36 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Sunday, September 02, 2012 8:02 PM
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>> Is there a way to identify the config core.excludesfile if present?
>>> i.e. that it is from that config variable, rather than directory
>>> traversal.

Yes, the output of git check-ignore includes the source file, so you
can easily see whether the ignore originated from a per-directory
exclude or from core.excludesfile.  One giveaway is that the former
is an absolute path, and the latter are all relative.

>> If the code handles $GIT_DIR/info/exclude then that configuration
>> would also be handled the same way, no?

Yes, they are both handled via setup_standard_excludes().

> If I've understood the regular code correctly, the core.excludesfile is
> always at one end of the exclude struct so should be easy to check at that
> position.

It's already checked in my patch series, and the tests cover this case:

  https://github.com/aspiers/git/blob/check-ignore/t/t0007-ignores.sh#L214

Having said that, I forgot to make them check $GIT_DIR/info/exclude.
I'll fix that.
