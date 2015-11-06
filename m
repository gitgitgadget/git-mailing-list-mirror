From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 3/4] git-p4: retry kill/cleanup operations in tests with timeout
Date: Fri, 6 Nov 2015 14:19:37 +0100
Message-ID: <493416AE-4514-437F-909D-BE2894FF118D@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com> <1446800323-2914-4-git-send-email-larsxschneider@gmail.com> <CAPig+cQiGqo2rNSC_Lw-WXq0ABp6PRFV-2w1wtK+XccQt2RD=w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:19:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zugvf-0007Lc-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033215AbbKFNTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:19:39 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38361 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033190AbbKFNTi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:19:38 -0500
Received: by wicll6 with SMTP id ll6so28581796wic.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kKXDfrSzzye7fSB5yYAY7WPX+mzzf9sb6JOiAuURzyc=;
        b=xcIGI2o3tYaTTEmz8DB6Q+GKaVGbxHDfKq2qNNzDrs9/FffEtdOz9HvSxNXf4JHrPa
         7LgIA2Dt1gMIk2oNci5EMGN6/TSGW3SQh8o+0E3RA1MpuenN5NtYyNsD6j4Ifcuh3PhC
         XNejgMMB/gcRTOJoJHkZVix8cqbC8ibah4qlf2KFmbg1OCydJfYJS6AEnC6EC11TiVvI
         qGnZLpkYG2yu17L8w1vThRh7CNpzCjmQVtuW0rFM9cp7XWAows0Y94kcqBObpf0kh6E9
         PaknkFGAsl+pGFUsy/eNND2h8N0Xl1C4Bm5kiFL5h9t/hle6QhjemQtbgNhztxu5sL7A
         CxVQ==
X-Received: by 10.194.176.70 with SMTP id cg6mr16613543wjc.155.1446815977941;
        Fri, 06 Nov 2015 05:19:37 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r9sm99133wjz.35.2015.11.06.05.19.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 05:19:37 -0800 (PST)
In-Reply-To: <CAPig+cQiGqo2rNSC_Lw-WXq0ABp6PRFV-2w1wtK+XccQt2RD=w@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280976>


> On 06 Nov 2015, at 10:28, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Fri, Nov 6, 2015 at 3:58 AM,  <larsxschneider@gmail.com> wrote:
>> In rare cases kill/cleanup operations in tests fail. Retry these
>> operations with a timeout to make the test less flaky.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> +retry_until_success() {
>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
>> +    until "$@" 2>/dev/null || test $(date +%s) -gt $timeout
>> +    do :
>> +    done
>> +}
>> +
>> +retry_until_fail() {
>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
>> +    until ! "$@" 2>/dev/null || test $(date +%s) -gt $timeout
>> +    do :
>> +    done
>> +}
> 
> I'm confused by this. Patch 2/4 was already calling
> retry_until_fail(), but it's introduction seems to be here in patch
> 3/4. Am I missing something obvious?
No, my fault. I reordered the commits and forgot about this. I will fix the order in the next roll.

Thanks,
Lars
