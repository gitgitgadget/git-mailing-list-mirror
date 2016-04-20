From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 07:51:43 +0200
Message-ID: <CAP8UFD189+AcLstEx4s_2ZYWp6UOtDb=vWGYhCpJayM8ma5hxw@mail.gmail.com>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
	<xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
	<20160420035353.GA31890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 07:51:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asl3H-0007e0-6J
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 07:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbcDTFvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 01:51:46 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38870 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbcDTFvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 01:51:45 -0400
Received: by mail-wm0-f54.google.com with SMTP id u206so62502822wme.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 22:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JnlS9eJ2f7PS3kzkQs/EePu32AkcSp6pho4B8ntMCdc=;
        b=BnJAESSDIfFFr7OxEKgVJak+qCLJe7Zz7rXscbuHi46Tu0YjCik1zGwXUWRSF3ULCd
         FZzFExn++OSg3hYWGndN7lKpUI0lu6YUlNqQyk3OHOwvZG3t8Rt0WvJ7/0xP2S84Y1t8
         I4b4Ci7SD/YDT5eDRe69f2ucb/ECD85DrIIYF45/PNm/xUvWvJazadX7X+sedFK3UBDJ
         rK/yvYAyRcj9YLfEOL4MPfazzlUl2YYN8nz6y3mnESMreNdIeX1wfNK8DzC24j1QNurf
         VNJtfsDAZU5HBaXYFoNN+dFAncPZR5tcpFtT0LlJfkVgOznLeBjec6R+kAslvJD127Kc
         8fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JnlS9eJ2f7PS3kzkQs/EePu32AkcSp6pho4B8ntMCdc=;
        b=X6qFqEcODOmFZhF3TYS0xylP7j2Sd1KvNld2TXNpTVM1/Bb5YRLghi7YZZ4m0DYteh
         LfpHCHXJImI07NO2Echb17OTPbyUSftdBHRwUBrIGasTC7hApPlNbjzlRt12/K5vqgO2
         zq/4IBm4A8hLITb1zQuGFpX9Sg3eLt8A8eZMdp6/Hkjm29pHqZszppCsV+MqGxr5RIFK
         LE2xrU5yfnll+FQ4Ln3a5s4Kw23fgfHz4LUQQRpK5LBC+ph0jCiHmihahtuKPKVrXQVj
         bdz/VWV487c3BUhTGDgmRmyFxkCYe6VHfRcA3r0xQNn9e1bdteVypPYZwHrrmwbzbo59
         VEtg==
X-Gm-Message-State: AOPr4FWmioEHRBkEHZKC2rHahXRX2GOjeggIkji4+FnzLjvgWwmm7X/pL0r8p/Y+KRfovRnRm2Nix3pbuQL9oA==
X-Received: by 10.28.72.10 with SMTP id v10mr29052803wma.89.1461131503803;
 Tue, 19 Apr 2016 22:51:43 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 19 Apr 2016 22:51:43 -0700 (PDT)
In-Reply-To: <20160420035353.GA31890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291982>

On Wed, Apr 20, 2016 at 5:53 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 19, 2016 at 09:22:37AM -0700, Junio C Hamano wrote:
>
>> I can understand "we only know edit mode needs config, and we know
>> it will never affect other modes to have the new call here", and it
>> would be good for an emergency patch for ancient maintenance track
>> that will not get any other changes or enhancements.  I do not think
>> it is a sound reasoning to maintain the codefor the longer term,
>> though.
>
> Yeah. I agree the patch here is not wrong, but I would prefer to just
> have git-replace load the config when it starts. It's _possible_ that
> something might break or misbehave, but IMHO any program which breaks
> when git_default_config() is run is probably in need of fixing.

I agree.

> And I cannot recall any reason we did not read config when "--edit"
> was added; we just didn't think of it.

Yeah I think so.

Thanks,
Christian.
