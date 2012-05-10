From: Subho Banerjee <subs.zero@gmail.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 18:49:36 +0530
Message-ID: <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
 <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com> <20120426203136.GA15432@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 15:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSTHz-0001AA-3r
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 15:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261Ab2EJNT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 09:19:59 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37202 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758172Ab2EJNT5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 09:19:57 -0400
Received: by vbbff1 with SMTP id ff1so1504740vbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XdFIH8TeUatWwez4/7+R10kaLQ/V8wWYi9fUHeJavkI=;
        b=X9qmWszURl+OMYypV8Rkhcqnk6peIwREcxTkNYQdUNXlpcCmGRri+/SXDEmBWcJmSW
         Z4TjUH8y9nE96ZKfcUJ4xcZyaCsU2PNpS3paxwsoCnkT40mLuDuH6Un1I5lWz/QYsy7l
         /4jvRxg+T7RcqScsTp0+mqiBwmKYD3pTbFpEqmhGixER91OX+gjklUuEXq75UepwqbRK
         vtPtLzQL+QQuH/CUzYOk3Hf3Yf1hq7cXtFWXGqlpf7hAKkV8bLjBWO/0dHbz10P7Eqfd
         RGGwg80X+scyg+3rizbUpGOCmPiWXwDg82CUpGw757Q0J/ipMoX+H3vgXxAfBRwPI9ug
         6ntQ==
Received: by 10.52.67.19 with SMTP id j19mr2050028vdt.46.1336655996884; Thu,
 10 May 2012 06:19:56 -0700 (PDT)
Received: by 10.220.189.137 with HTTP; Thu, 10 May 2012 06:19:36 -0700 (PDT)
In-Reply-To: <20120426203136.GA15432@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197561>

Hello,
I have started looking into how the error catching mechanism
implemented right now. I have looked into the more modern error
catching/throwing mechanisms in use in perl, and I am of the opinion
that Try::Simple would probably be the best candidate for being the
new error catching mechanism. I also wanted to discuss some aspects of
the changes to be made -
------- Replacing the Error::Simple stuff should be relatively
straightforward. It can be achieved with simple changes to the syntax
of the perl module itself.

------- What I feel will be more complicated, and will require some
discussion before it is implemented is the Git::Error module. This has
modified some of the code in the original Error module and is used
only when there are calls made to the git system command. Using the
Try::Tiny will mean that this can be simplfied to a very large extent.
As a mater of fact I am in favor of getting rid of this completely and
implementing whatever is required in the Git.pm as required. Because
the Try::Tiny module no longer requires exception objects to be
thrown. Its just simply passing strings around.

This I believe is a big decision, and I would like to hear what you
guys have to say before I actually get along changing and playing
around with stuff inside the code.

Cheers,
Subho.

On Fri, Apr 27, 2012 at 2:01 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Subho Banerjee wrote:
>
>> I will take care that I dont break those.
>
> Thanks, sounds good.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 Should the tests in the t/
>> folder of the codebase be enough to make sure everything is working =
as
>> it should be even in the Git perl module?
>
> No. :)
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 Also is there anything like
>> a public build server which actually catalogs which tests are
>> currently failing so that I know what has gone wrong after my change=
s,
>> or are all commits supposed to pass every test?
>
> When tests are known to fail, they are marked with test_expect_failur=
e
> so they don't affect the test result.
>
> Hope that helps,
> Jonathan
