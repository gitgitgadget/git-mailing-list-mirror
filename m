From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH/RFC] read-cache: fix file time comparisons with different
 precisions
Date: Tue, 29 Sep 2015 12:23:37 +0200
Message-ID: <560A66A9.2010606@gmail.com>
References: <5605D88A.20104@gmail.com> <560918F8.1080905@gmail.com> <763be6c1331ac57cf7dee3636d82f994@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 29 12:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgs4V-0003ja-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 12:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbbI2KXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 06:23:41 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34449 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227AbbI2KXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 06:23:39 -0400
Received: by wicfx3 with SMTP id fx3so143083751wic.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=n/pXi/wAhGY1+OoMpQfd1FT8DC7ChjdSKH+Q8Q8qv9M=;
        b=vluGyZ8LHT+sbP7MHTrhGklrictqlbzDqz2LWi7OyBysmHPOEXRTfpKHVXR+7hAPFd
         IfIHfq/TdGtYU/kUc6A/fhzSF1b1z7AymB9LiFSetAbZzyyoULlBFcEWBw7Cacyi6c5f
         3vOzLxt/xtST684j9xpzDEcwphODK/TLQLKPfNB5u0ylewjnKZaZF3xppjuFtjGYn5YM
         OVnY45TYpVLLcyLK3Aej678zudN/qNDmr11ki5+2WnzPBlkREf09NE+W4XnhY/sDrcU1
         OC+V4KMgvcDjvQ1S+bPt9J8Ud04gWOUTPB12Phexrr0SR7PuTz/FRKiRlSuXyg6rCA68
         lqow==
X-Received: by 10.180.230.197 with SMTP id ta5mr23084720wic.26.1443522217800;
        Tue, 29 Sep 2015 03:23:37 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id lm3sm23079358wjc.39.2015.09.29.03.23.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2015 03:23:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <763be6c1331ac57cf7dee3636d82f994@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278817>

Am 28.09.2015 um 14:52 schrieb Johannes Schindelin:
> Otherwise there would be that little loop-hole where (nsec % 1000) == 0 *by chance* and we assume the timestamps to be identical even if they are not.

Yeah, but in this case the file would be racy, as racy-checks use
the same comparison now.

IMO change detection is so fundamental that it should Just Work,
without having a plethora of config options that we need to explain
to end users.

If that means that once in a million cases we need an extra content
check to revalidate such falsely racy entries, that's fine with me.

Cheers,
Karsten
