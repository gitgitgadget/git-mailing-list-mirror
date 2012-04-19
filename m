From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH nd/threaded-index-pack] index-pack: disable threading if NO_PREAD is defined
Date: Thu, 19 Apr 2012 13:44:32 -0700
Message-ID: <xmqqhawfv4cv.fsf@junio.mtv.corp.google.com>
References: <1334844329-24557-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 22:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKyDY-0006us-1H
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 22:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab2DSUof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 16:44:35 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:48043 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab2DSUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 16:44:34 -0400
Received: by eaaq10 with SMTP id q10so429374eaa.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VfGxOOCxOIAHwPlyulgRTf3gAEs8++GSeJnGyTRl5/w=;
        b=f1mEqfg4mmNqtnPGxC0lg3A+txRQM6NzxZ7zCpSwXa8Fzrr1g4xPrggIsvyR5SfaON
         ygE4Hiz1j3NuzkRyDBdaoHEQFdpA8j6ojjFB7+KSd8fQiP3+bFvig7RhswkGsov4gy1I
         QPABXx4VGVI6VfvNWBYwNo6eGfWs2qXw5pwgEhNFck/gj3a/VaVCVWVdGOL3VY8roDka
         +m2cGTPs3PJo5GJKKoBGc8LWvlufBhR57gzAvPVfCeqnzuoolwLMLS21aii1wUm0Kclm
         Qj555AEpzSXMOn1l8HtlwyKUYSmjdy0TLCNYXnvGRBWxCnpC960hRV/wkuJyknpiesVJ
         0R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=VfGxOOCxOIAHwPlyulgRTf3gAEs8++GSeJnGyTRl5/w=;
        b=HF95BI3OYY2Iw9Ph0ebO/6knL6l8SQBk3D6jjF6HG8my56gSnWd9YChMPsu/y5aVSk
         6teriQwizY1HqtoKMZ+1C0aDo6T+PbbGTtgW5lT3ZxoNHqaKaqNt9rwVKh2GLQpPWuOj
         2xLMuGSWi6+OJyWI1YNpwQFgyfsPTkCjG0Ga3LeZMb9+SAVpfGszoJNOtJP3nQGT5t+u
         hR8LTEEqOaiN2rW4H/K4erG9qyhWmPSuwn3PZJ/cYrbCK1eDZ3NsRrFMq3Op6KnwOC+h
         KwoTZDFhnpUCtwGTMkmjGFi7ogWRn2PVj57AR+C28k80t5ZNO6YTNSCnGDQFHLn/em10
         RZYA==
Received: by 10.213.105.210 with SMTP id u18mr336763ebo.19.1334868273710;
        Thu, 19 Apr 2012 13:44:33 -0700 (PDT)
Received: by 10.213.105.210 with SMTP id u18mr336741ebo.19.1334868273507;
        Thu, 19 Apr 2012 13:44:33 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si3149018een.0.2012.04.19.13.44.33
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 13:44:33 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 5042520004E;
	Thu, 19 Apr 2012 13:44:33 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 8BCEAE1209; Thu, 19 Apr 2012 13:44:32 -0700 (PDT)
In-Reply-To: <1334844329-24557-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 19
 Apr 2012 21:05:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk/cD28hA/tM//e9VrcCn7NB4upwfegDCx138fJYmsKUAA1/faylmLNMOJC6hXOJ7jPYxAm/TckESQbclDwWa+WXLyV6MSj7m3DTsg2NOTkJbbVZ4u04kCeS1DodhLDn0I24XS/eqekhMCRkRKX1b0VoURs6JxOWew4oHWnWqORAXOZ1q4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195969>

Thanks; will queue.
