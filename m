From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] git-p4: suppress non test relevant output
Date: Tue, 22 Dec 2015 09:47:35 +0100
Message-ID: <0185CA76-DDEE-4E7F-8EFF-65E80720E0AF@gmail.com>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com> <1450629869-49522-3-git-send-email-larsxschneider@gmail.com> <xmqqd1tzfsfm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 09:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBIbe-0001dS-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 09:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbbLVIri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 03:47:38 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34937 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbLVIrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 03:47:37 -0500
Received: by mail-wm0-f49.google.com with SMTP id l126so100696498wml.0
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l9lc9lTbzGcXFAsGX88N5S9qRjT7vd9ti1aip2fBUhA=;
        b=AlFobsWe/Wr+WrSg8Z8VEjCILr9QlElmsPYZAiAzaYx+IoBt9mfjI/HoneIjN+VRqH
         BteSpFq0+gA6dprg0RUCHWIEj+obn1pSCM4YndQailmJ5txPmkRCDmHdq3NKV3mJjndE
         Ae/i1AqiuFwqR+zoI/ToMA2/oLcikwnhdKf0O+f6sbLpkQYfig3xU/lUpAGZ2Ln9opfr
         /AasD60xpFozA0hlN8pkFy2b/wzY1Iirs+NbyzJPTYqQONubiN8QskO6Yvo4/o4N2yvK
         NDVLFsmwOONhph4vLNBeh1mB+vlp3us6HiTCZkq6IfoVkDonH24a2l4gO5UVakC2UGAI
         NEsg==
X-Received: by 10.194.19.100 with SMTP id d4mr26466763wje.18.1450774056209;
        Tue, 22 Dec 2015 00:47:36 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB452E.dip0.t-ipconnect.de. [93.219.69.46])
        by smtp.gmail.com with ESMTPSA id b82sm23904457wmf.9.2015.12.22.00.47.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 00:47:35 -0800 (PST)
In-Reply-To: <xmqqd1tzfsfm.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282836>


On 21 Dec 2015, at 21:38, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> If tests are executed in verbose mode then the retry logic clutters the
>> test output. Suppress that clutter.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> t/lib-git-p4.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> index 30bf7ae..03f29c1 100644
>> --- a/t/lib-git-p4.sh
>> +++ b/t/lib-git-p4.sh
>> @@ -174,7 +174,7 @@ retry_until_fail() {
>> 	until ! "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
>> 	do
>> 		sleep 1
>> -	done
>> +	done >/dev/null 2>&1
> 
> Eh, what does this squelch?  The sleep in the body of the loop is
> silent, "test A -gt B" on the loop condition would be silent too, so
> you are squelching the invocation of "$@" whose standard error
> stream is already sent to 2>/dev/null?
> 
> If so, why not do it there instead?  You seem to run only "kill" to
> send some signal to a process using this helper function, and it
> would be silent on its standard output stream (even though it may
> say "no such process" etc. on its standard error), so it is not
> clear to me what you are doing with this change here...

If I run git-p4 tests in verbose mode (e.g. "./t9823-git-p4-mock-lfs.sh -v") without this patch then the last lines of the output look like this:

>>> Output Start >>>
expecting success:
	kill_p4d

./lib-git-p4.sh: line 172: 26289 Killed: 9               while true; do
    if test $(time_in_seconds) -gt $timeout; then
        kill -9 $pid; exit 1;
    fi; sleep 1;
done
ok 8 - kill p4d

# passed all 8 test(s)
1..8 
<<< Output end <<<

However, I want them to look like this:

>>> Output Start >>>
expecting success:
	kill_p4d

ok 8 - kill p4d

# passed all 8 test(s)
1..8
<<< Output end <<<

This is achieved with the patch. I am no shell expert ... is there a nicer way to achieve the same?

Thanks,
Lars
