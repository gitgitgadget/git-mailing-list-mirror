From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 3/4] git-p4: retry kill/cleanup operations in tests with timeout
Date: Fri, 6 Nov 2015 10:47:43 +0100
Message-ID: <624E4E74-6EEF-471E-9F12-EFE69FB2A7AA@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 06 10:47:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zudcg-0003A1-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 10:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032804AbbKFJrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 04:47:49 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37974 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698AbbKFJrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 04:47:47 -0500
Received: by igbxm8 with SMTP id xm8so5687600igb.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 01:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uy9wdcmitJdPk4qTsON2dxcj2jABJjWd3ZaB+Ml6lnU=;
        b=k0HoTAZ4AC8/a+EFP4JjbZ1gW7CAmosmiAVdZcLw2UERTQ63emsPSxer6Glf/PasUw
         o7jK5PKvc8fKj0uk+7iOYKKxL65+zUzxOJij8sozudUVuqSTJIfx8XjK2JOR0qazbzNa
         CAM5JzcdQKMoCevufq8d6cqt3S5dCy0BfMNFurfMHNemPjJMrZju8sn+HsKiadBR59u2
         rojS2TDoJdOJ778yPbBmM5UAd20+t+XdArFK7NMZuH4royTIlDPwdVekz4weyqK6vHnb
         6Smwges86SdT+xELXStA+Qs8xPsvmqIrNaYQGZkQ6VPKDs3GvUhYJPx6/0m82CTCP69+
         kDXw==
X-Received: by 10.50.28.116 with SMTP id a20mr1363881igh.12.1446803266677;
        Fri, 06 Nov 2015 01:47:46 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 79sm4474086iok.35.2015.11.06.01.47.45
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Nov 2015 01:47:46 -0800 (PST)
In-Reply-To: <CAPig+cQiGqo2rNSC_Lw-WXq0ABp6PRFV-2w1wtK+XccQt2RD=w@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280970>


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