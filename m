From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Sun, 15 Nov 2015 13:53:31 +0100
Message-ID: <D21E9A9A-7444-4585-9066-3546F172A0EC@gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com> <20151113053547.GD29708@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 15 13:53:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxwoN-0001wy-3p
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 13:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbbKOMxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 07:53:35 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35499 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbKOMxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2015 07:53:34 -0500
Received: by wmdw130 with SMTP id w130so79682639wmd.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Oq3s13ShSHSTVgA/R3zlz6CBGj+dq0D7ZeFoXLbYqBs=;
        b=fSs24G9VKnNrqxl8LReBwtb6cij0ZpoB5xKmmWorH47kbOxlGeZQTSrAmUOnFMmxpj
         xFjvm4jsib3mUxF4fYELwqiXkNzlC0tJgCppr4ewwcSIgKj2dc+CEAVOpggsMSGzhnHr
         bEQng39SAYKmhyOdctKaC98N9tVpLFcXtVy5iTC0BDvnI8KkxEE+leEDkps20iNG72np
         bquTQqv40jCXMfwIJPnVtYcYxdaqaPxPUXUHoFfuVXnrah8DUFBpvgNhTtz16V7G8GEO
         wBIwoeWx9EnoqPaHRtF3Dc007EAtof2yEIECutrkZwy5QOLdZVhRviCVhEMlbf1QZT02
         9gYA==
X-Received: by 10.194.82.99 with SMTP id h3mr26232725wjy.41.1447592013085;
        Sun, 15 Nov 2015 04:53:33 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id lv4sm29295716wjb.43.2015.11.15.04.53.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Nov 2015 04:53:32 -0800 (PST)
In-Reply-To: <20151113053547.GD29708@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281312>


On 13 Nov 2015, at 06:35, Jeff King <peff@peff.net> wrote:

> On Thu, Nov 12, 2015 at 10:37:41AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> "git clone --recursive --depth 1 --single-branch <url>" clones the
>> submodules successfully. However, it does not obey "--depth 1" for
>> submodule cloning.
>> 
>> The following workaround does only work if the used submodule pointer
>> is on the default branch. Otherwise "git submodule update" fails with
>> "fatal: reference is not a tree:" and "Unable to checkout".
>> git clone --depth 1 --single-branch <url>
>> cd <repo-name>
>> git submodule update --init --recursive --depth 1
>> 
>> The workaround does not fail using the "--remote" flag. However, in that
>> case the wrong commit is checked out.
> 
> Hrm. Do we want to make these workarounds work correctly? Or is the
> final solution going to be that the first command you gave simply works,
> and no workarounds are needed.  If the latter, I wonder if we want to be
> adding tests for the workarounds in the first place.
> 
> I'm not clear on the expected endgame.

I see your point. I'll remove the workaround tests in the next roll. That being said, I think the we should do something about the workarounds, too, because it certainly confused me as Git user. Would you merge a patch that prints a warning message like "--depth parameter not supported for submodules update command" or something if a user tries this command?

Thanks,
Lars