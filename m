From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: fix faulty paths for case insensitive systems
Date: Tue, 04 Aug 2015 23:06:06 +0100
Message-ID: <55C1374E.5060808@diamand.org>
References: <1438528517-5028-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pw@padd.com, torarvid@gmail.com, ksaitoh560@gmail.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 00:06:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMkLa-00076g-QX
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 00:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbbHDWGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 18:06:05 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36931 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbbHDWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 18:06:04 -0400
Received: by wibud3 with SMTP id ud3so41479894wib.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5jegH+eNOMGjUtBSHEDo/o4hgIEvC1GgGDMfkOd2WXU=;
        b=cEBsSOC5Ja/NSj8pfgRVu3uM9XKP3RoBkZw8/fmtebahA32hjRZ3oDXk5ddaAE/2GK
         ocvFmq6fd4OsqhtNHGcsuHLDcAuI4kDGRJUa2FcHIZ7EtiF+z27/jTWvzl1IRsWG2tZD
         qlzgIBXnqAZ/HPE6+RtbNouxBExBMQnpkvHnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5jegH+eNOMGjUtBSHEDo/o4hgIEvC1GgGDMfkOd2WXU=;
        b=CfUSOgw7/uQ045uD/5G2t+WhkcqChjLiTb7HxA/Goth2CDtm/kUkZ3EzfrjrkSDZ+J
         HiGPG65opI9XVPNjqeI7LSuAG94LdTHlNnTm+hanPufDlQ7cSnxFyM8CfdBNod3IafjX
         C19zSN9qAISkLkf8lBBk+KehUaP6/97GK4RpYBLYLADJUzcAZhOnezFZ9ZdAm6Eq1cn0
         lP7lnGBxEIyPRSHT7lC4rOnE3QWoAY2ok5BWlAL+oYOeAtrZiHl4UP8AZv/jA4493Xyu
         vpyNSX/CoBRHG4NHKywpih2c7tj5e0msIlEMGbiOZrZICVsL18r978D1LqSGXUViHp5G
         udqQ==
X-Gm-Message-State: ALoCoQn5xHG6J4yi1wUHo6EhQ3H5If69tJEI2u8CarkGW+m5dCVyeQJnv6uOHAI45zgDKfCQoEqC
X-Received: by 10.180.198.199 with SMTP id je7mr12537019wic.34.1438725962196;
        Tue, 04 Aug 2015 15:06:02 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id y15sm1587858wib.7.2015.08.04.15.06.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2015 15:06:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1438528517-5028-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275343>

On 02/08/15 16:15, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Hi,
>
> I want to propose this patch as it helped us to migrate a big source code base
> successfully from P4 to Git. I am sorry that I don't provide a test case, yet.

Case sensitivity is a pretty tricky area with p4 - it's very brave of 
you to have a go at fixing it!

> I would like to get advise on the patch and on the best strategy to provide a
> test. Do you only run git-p4 integration tests in "t/t98??-git-p4-*.sh"? If yes,
> which version of "start_p4d" should I use?

Only the t98* tests relate to git-p4 so if you just copy one of those it 
should do the right thing.

t9819-git-p4-case-folding.sh already has a few failing tests for this 
problem. I wrote it a while back just to illustrate the problem, so it 
might be of use to you, or you might need to start again.

Won't your change make importing much slower for people with this problem?

Also, I'm not sure you can use "core.ignorecase" to trigger this: the 
problem will arise if the *server* is ignoring case as well (which I 
think you can detect by querying the server).

I'm not trying to be negative - but this problem does have some annoying 
pitfalls! Let me know if you think I can help though.

Regards!
Luke
