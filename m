From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 5/6] git-p4: add trap to kill p4d on test exit
Date: Tue, 17 Nov 2015 09:29:49 +0100
Message-ID: <8C9A93DB-040E-49FE-B6F7-8373D8CE7601@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-6-git-send-email-larsxschneider@gmail.com> <5649974A.1010903@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZybeG-00006e-VB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbbKQI3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:29:53 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35507 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbKQI3w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2015 03:29:52 -0500
Received: by wmdw130 with SMTP id w130so144067522wmd.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B7iDHpeHB7iFpOi+D+FXvxNTRL3HnPv6GyXUTzwuh90=;
        b=ORs/h4y0L6/Lp/KveatTtx9nSw3WZEzHsYowDjbVnTsJ4oyb2vLuRkoGtJU/c6blBL
         KppGUSB/NRrpvbyIDfITHWeOG7MYKT7GHB0E7J04YoJHT5sQ650xobMz4JIENzArX0Xw
         ffzaWnB9gzAY06j2fdOT924joHpEpIB/OSDm5zesukkD60/LKRcBITyGPBVs1MOh8abf
         2aFPt7QidDIG0aTXjQ8feLthleRYCwzb1y0vf/95yu12EBluYIlvCastL9VpSnDQnWee
         hYcY+mh2kz8WGN2ymuZUsdnDMPpeAbJxvuV84x2X6EPMMP1FkdLz0iwaPZl4tAipTgDj
         1suQ==
X-Received: by 10.28.229.65 with SMTP id c62mr1000746wmh.25.1447748991367;
        Tue, 17 Nov 2015 00:29:51 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4D5B.dip0.t-ipconnect.de. [93.219.77.91])
        by smtp.gmail.com with ESMTPSA id c13sm22655052wmd.14.2015.11.17.00.29.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Nov 2015 00:29:50 -0800 (PST)
In-Reply-To: <5649974A.1010903@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281389>


On 16 Nov 2015, at 09:43, Luke Diamand <luke@diamand.org> wrote:

> On 15/11/15 13:08, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Sometimes the "prove" test runner hangs on test exit because p4d is
>> still running. Add a trap to always kill "p4d" on test exit.
> 
> With this change, I've started seeing this when running the tests:
> 
> cat: /home/lgd/git/git/t/trash directory.t9819-git-p4-case-folding/p4d.pid: No such file or directory
> 
> Probably just needs the obvious "test -f" adding.
> 
> Other than, all looks good to me. Particularly nice that I can now do:
> 
> $ make T=t98* -j10
> 
> and it actually works!

Great! I can see where the cat error comes from. I will add the "test -f" condition in the next roll.

Thanks,
Lars

> 
> 
> 
> 
> 
>> 
>> You can reproduce the problem by commenting "P4D_TIMEOUT" in
>> "lib-git-p4.sh" and running "prove ./t9800-git-p4-basic.sh".
>> ---
>>  t/lib-git-p4.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> index f2a009c..f9c68d4 100644
>> --- a/t/lib-git-p4.sh
>> +++ b/t/lib-git-p4.sh
>> @@ -65,6 +65,12 @@ cli="$TRASH_DIRECTORY/cli"
>>  git="$TRASH_DIRECTORY/git"
>>  pidfile="$TRASH_DIRECTORY/p4d.pid"
>> 
>> +# Sometimes "prove" seems to hang on exit because p4d is still running
>> +cleanup() {
>> +	kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
>> +}
>> +trap cleanup EXIT
>> +
>>  # git p4 submit generates a temp file, which will
>>  # not get cleaned up if the submission fails.  Don't
>>  # clutter up /tmp on the test machine.
>> 
> 
