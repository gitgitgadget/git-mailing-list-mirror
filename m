From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman/inotify support and other ways to speed up git status
Date: Tue, 03 Nov 2015 15:32:21 -0500
Organization: Twitter
Message-ID: <1446582741.4131.37.camel@twopensource.com>
References: <CAP8UFD3Cd9SOh6EYwcx9hTVv7P24M5bEJRCYCT5Qgj=qPRJ8hw@mail.gmail.com>
	 <1445990089.8302.27.camel@twopensource.com>
	 <CAP8UFD3rkacENsnthdhqTPczbZP+J_iV6xr8sTXj2MFgZRx8DQ@mail.gmail.com>
	 <1446497776.4131.6.camel@twopensource.com>
	 <CACsJy8AC1B+b_KBBcob07LkAkjjiwFQCLnMcgX0iUdQeNdeLfQ@mail.gmail.com>
	 <CAP8UFD04C-Amt2vGQKrJmA=DYVXrR7+hhkk9e49NsT-F0wiV1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Luciano Rocha <luciano.rocha@booking.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 21:32:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtiGD-0001wj-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 21:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbbKCUc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 15:32:27 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36536 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798AbbKCUcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 15:32:24 -0500
Received: by qgad10 with SMTP id d10so23738948qga.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=COywF1EfnVs5f0pfjMWrQAEpRCmle1VlHr+BEdSiasY=;
        b=HvGbxD6JytjY862+ifIfWmKCKaQVDB15j+YaAzCManfoF0D86tszFHqvpATFmTurcp
         8YBoTjZRxNU+553eVm2Sis/Db4Tyn4lTgKnsfFec5PCtyhdxrlQSdLPNL2VfEoxgrKKr
         jyL2SZ2x1Ffi3QarulQAI+jJ5Mn/AnYIOe5f5pd+AaxByFSIo07xLF9tWKUa8lOz9Djm
         3Tmo7X6/OWBIiqqITdiPBncvnId+YnfXim8myh/cDbJXKrolJdIPw7mTUhl2GK/zHSJN
         vtXkRbkkNScGsno06NHe9/UBUwzBc6HZwR+f0pRNQt3wLZUrcp6m4yGaEQuFEpGoM0gq
         weJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=COywF1EfnVs5f0pfjMWrQAEpRCmle1VlHr+BEdSiasY=;
        b=Vh+z1cp8Fwa2GJtqL25tr0D0H+H9iPOL/MfrWaZ8ReET/BIca21+8Sw4OboEWgctMZ
         4F1hYYRaqdsXrk+FZnbJlNdtVSrZLg0oi6u3WVhUXZ7Zcr3hFN5lwof5TIF/TsmdQ+RN
         ideUrCth/N3mlXrKslKYl/nn8QEBZQ+gS3ptZfj0DDwX/+3My4RtfEiccwSOc2Y39LGf
         sfT9Y+upahWJyxYYUgRXjk7yudHgNzEgAUByMUJ/XbHbuxoj9Or/2qkcGGxcYvgCgni+
         QiSxCIUWaawQzNo3UljBZ87Ldtml2sG/ldMtPwvZs7r66bF419onKnLTWF/ELyZ801UF
         6Miw==
X-Gm-Message-State: ALoCoQn6GAq1UrT4ePrxPYAnmMjx02IkoOsFbcR6hr8+HzGHPomCxrp0Sv6NbCg31g0lzkRxJCPu
X-Received: by 10.140.93.104 with SMTP id c95mr39213771qge.101.1446582743980;
        Tue, 03 Nov 2015 12:32:23 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 76sm1439864qhj.2.2015.11.03.12.32.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 12:32:23 -0800 (PST)
In-Reply-To: <CAP8UFD04C-Amt2vGQKrJmA=DYVXrR7+hhkk9e49NsT-F0wiV1Q@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280814>

On Tue, 2015-11-03 at 08:09 +0100, Christian Couder wrote:
> On Tue, Nov 3, 2015 at 6:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Mon, Nov 2, 2015 at 9:56 PM, David Turner <dturner@twopensource.com> wrote:
> >> On Thu, 2015-10-29 at 09:10 +0100, Christian Couder wrote:
> >>> > We're using Watchman at Twitter.  A week or two ago posted a dump of our
> >>> > code to github, but I would advise waiting a day or two to use it, as
> >>> > I'm about to pull a large number of bugfixes into it (I'll update this
> >>> > thread and provide a link once I do so).
> >>>
> >>> Great, I will have a look at it then!
> >>
> >> Here's the most recent version:
> >>
> >> https://github.com/dturner-tw/git/tree/dturner/watchman
> >
> > Christian, the index-helper/watchman series are posted because you
> > showed interest in this area. I'm not rerolling to address David's
> > comments on the series for now.
> 
> Ok no problem. Thanks a lot to you and David for posting your rebased series!
> 
> > Take your time evaluate the two
> > approaches, then you can pick one (and let me know if you want me to
> > hand my series over, very glad to do so).
> 
> Yeah, I will do that, thanks again!

To be clear: I think Duy's approach is probably best in the long term.
