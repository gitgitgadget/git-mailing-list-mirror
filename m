From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 12:40:21 -0700
Message-ID: <B85D5671-9F8C-452E-87B9-EB4DE3C85955@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <561B69AE.8050403@gmail.com> <xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:40:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlixV-0007QZ-Up
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbbJLTk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:40:29 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35320 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbbJLTk2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 15:40:28 -0400
Received: by pabve7 with SMTP id ve7so103878830pab.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=73inYoYNKDyT4Q9cFjDmF6kjF5O/Bm2Cth2KMngs12U=;
        b=wYZffDlZoYGZ7Sv/bD/a7TgHReXMB4xD5GscaD+kDbKcM8y4898Yhs5VvAIcnUX9Sz
         WCMrdQqeqfozuBr3vqp+JwdzYSKANJdivLjXpUJfMq0Qe4c5kGaBSCZ5HmJKcwE9/0ba
         kncYFtkZzsgUPhb8dytgaKzpB//fHl03urrwwq8uPS2CGDc8mPa47Zy0KJWFNpw5pg9p
         FshYEi2Qr1uKMrhyZ4MD4AsFYb0ZuogiaO0xuq4h4S/WJXKoO2gvjAncUdhMfENsBQPX
         PklS8E2UHqpfGV3LTNk4J4AcCwHKk+pqgnTH5GETNMv+Po1z9HEddzjUJs3bhvifmeGM
         QkwQ==
X-Received: by 10.67.22.97 with SMTP id hr1mr30300360pad.81.1444678828170;
        Mon, 12 Oct 2015 12:40:28 -0700 (PDT)
Received: from sfo99wgxz1.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id gd2sm19821132pbb.41.2015.10.12.12.40.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 12:40:27 -0700 (PDT)
In-Reply-To: <xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279408>


On 12 Oct 2015, at 09:02, Junio C Hamano <gitster@pobox.com> wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
>> Semantically, it does not seem correct to me that configuarion goes to
>> the install step. As "make test" will build git anyway, I'd instead
>> propose to get rid of "install" and just say:
>> 
>> before_script: make configure && ./configure
>> 
>> script: make --quiet test
> 
> Very good point.  Do we even need to do anything in the "install"
> target?  We aim to be able to testable without any installed Git,
> and not running "make install" at all, ever, would be one way to
> make sure that works.
The Travis CI "install" stage is independent of "make install". AFAIK you can use the Travis lifecycle stages pretty much as you want. However, I agree we should not use the "install" stage to avoid confusion.


> This is a slightly related tangent, but we saw a few build issues
> reported recently on customized configurations like NO_PTHREAD.  If
> we are to start using automated tests, I wonder if we want to build
> (and optionally test) with various combinations of the customization
> options (e.g. NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL etc.)
This easy to do. However, the more we environment settings we define the longer the build runs. I created a test matrix that runs the following combinations:
{Linux | OSX} * {gcc | clang} * {Default, NO_PTHREAD, NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL}

These result in 28 (= 2*2*7) combinations. I created a build without the "Default" environment (=24 combination) here:
https://travis-ci.org/larsxschneider/git/builds/84978673

Should I add them them to the Travis CI patch?

Thanks,
Lars
