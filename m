From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Mon, 02 Nov 2015 15:56:16 -0500
Organization: Twitter
Message-ID: <1446497776.4131.6.camel@twopensource.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
	 <1445990089.8302.27.camel@twopensource.com>
	 <CAP8UFD3rkacENsnthdhqTPczbZP+J_iV6xr8sTXj2MFgZRx8DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Luciano Rocha <luciano.rocha@booking.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:56:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtM9P-0001Qw-2h
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbbKBU4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 15:56:19 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35551 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbbKBU4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 15:56:18 -0500
Received: by qgbb65 with SMTP id b65so126379003qgb.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 12:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=WyKLVboP5J6Qv8xdRQvYJYN2kgPI8vCc79W5K9pv9hc=;
        b=aqhzzVuhxPdglE6N0X23A2UGjqYoWCnQTxj5o1ZOX7UcQgx+Qow+uxAWAqrAThEoHw
         Qgy+usbi9BwNLIOul3XtZtTlF4ekrQYMCT4Devnc39JuBklcS0WS4JbJu9MIMiiTMXiW
         dKP90nRTXREMRy5LN6y6UZKVBYdXRJaWyamSB7rDdGBE/y4LBZjo/kGq7d+mxOlPHYI/
         zGV/tPwN48BE0UaM0hNFo+fPZOkNuCHEQotSvZIbl1jJIY+L4bSTnbwP4VmM+KwbOXK4
         yL2IJcrcmU60/B37OQZegmwihzAGDRjdOBXO0PPai8OgzMxL1FswmEgr0EZj/pGmMukU
         Smsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WyKLVboP5J6Qv8xdRQvYJYN2kgPI8vCc79W5K9pv9hc=;
        b=YvxF93UQmlBKIKzPMM6xaY2f+raj4ECy9ryVz2KFP43c0tQNZCny6B3Kizg5llEfMC
         qfRYjMbAmaG+X23X3HKQDyM0w9Eqp0kMOI5+EZZW0AH7yvXVLT5HY9WfXiZ2vZS1DHpC
         rU4WuOGmdb1S0GlLCAj9KzWe24/dD3uXb9g4QZHMQY/cdEN4ZB3UCWyt6BKkLxll1MBi
         kQBOSiRLXOHGG//0QAfRisRRsuAY5kV3Y4MzrrLG8MUVdaOuSUWMaV3KarllxHejsCgw
         LOnNpR78kQVUxSIjIj6QrLeIC7QdrePRX+6c1NXBxn+AFQgqxKtD34JNX3n1BgJH3TMS
         ve8w==
X-Gm-Message-State: ALoCoQnMS8ZLLJF0jVIp85LtPjgzjXnfZles1y6BeIWVn5aNu8yOOBT3eZ45J6ERWcs8GPttsKWV
X-Received: by 10.140.220.19 with SMTP id q19mr32926724qhb.48.1446497777897;
        Mon, 02 Nov 2015 12:56:17 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 74sm8494042qha.41.2015.11.02.12.56.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 12:56:17 -0800 (PST)
In-Reply-To: <CAP8UFD3rkacENsnthdhqTPczbZP+J_iV6xr8sTXj2MFgZRx8DQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280719>

On Thu, 2015-10-29 at 09:10 +0100, Christian Couder wrote:
> > We're using Watchman at Twitter.  A week or two ago posted a dump of our
> > code to github, but I would advise waiting a day or two to use it, as
> > I'm about to pull a large number of bugfixes into it (I'll update this
> > thread and provide a link once I do so).
> 
> Great, I will have a look at it then!

Here's the most recent version:

https://github.com/dturner-tw/git/tree/dturner/watchman
