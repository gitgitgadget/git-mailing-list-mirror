From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Fri, 20 Apr 2012 00:34:53 -0700
Message-ID: <CAJDDKr7JtauR8sR3YC+wj60sx9DEgf87iaDwue2Cz6FzQX_Z+Q@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
	<CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
	<CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
	<7vsjg1knwr.fsf@alter.siamese.dyndns.org>
	<CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com>
	<7v8vhsltk3.fsf@alter.siamese.dyndns.org>
	<CAFouetg6T1pgAiTfyAeSxseR-k_omsZDfqv8X8AifekwPLoE2g@mail.gmail.com>
	<xmqqy5prv9ol.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <jch@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 09:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL8Mt-0003IQ-65
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 09:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab2DTHey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 03:34:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55940 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab2DTHex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 03:34:53 -0400
Received: by ghrr11 with SMTP id r11so4970603ghr.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y7sgrwGpCjCWEg0kdOeu58XiPlW/FbJXGKyZPZpaR8A=;
        b=KfwoMVKg51vLmiX+loueMkRR8fxw2vuVOYjfzYzE8TnHpuc0tZT8gGdKlLA/v1rbPK
         xX/Prdygisb20L4g3kgyXkBBwEjnG+9Rg0WY0lLxE6F+IpOAWfTcMW0G7s2eDRDahV2E
         TV9ppUhDm8ZXi/y+kCyk+2tLdqio6Ad4RIFIfysVEH2o4m2+Cu5MAfx4qkP2O2/PhZl9
         LTYAF8eAWZgrG9FtpqIpK9siGR1mSji5RHnS5/C+PpayVDDXMCnroNffTleoLWkLJ/m/
         EObxBOdtOeuxH7ben9ahO70UZyxVAm1R3UHltjxxkMbaO+zw/S/MbimuwSM6imfTUEJr
         P/WQ==
Received: by 10.236.181.39 with SMTP id k27mr5019258yhm.52.1334907293396; Fri,
 20 Apr 2012 00:34:53 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Fri, 20 Apr 2012 00:34:53 -0700 (PDT)
In-Reply-To: <xmqqy5prv9ol.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195983>

On Thu, Apr 19, 2012 at 11:49 AM, Junio C Hamano <jch@google.com> wrote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> I have a revised patch that prunes out all of the above and warns the
>> user when it does so [1].
>
> Thanks.
>
> As long as it works when the user uses "two temporary trees" mode
> without -M/-C, and it keeps working as well as before the change when
> the user uses "one invocation per matched path" mode with -M/-C, I do
> not care too deeply about how it is implemented in the script.
>
>> However, it also prunes them when difftool is called in serial diff
>> mode (i.e. non --dir-diff).
>
> I do not use difftool myself, but I would imagine that it is a grave
> regression, no?

An alternative would be teaching difftool to gracefully handle the R
lines in the --raw output.

Simply creating the files as they existed on each side is a reasonable
start.  It seems better form to handle all possible output from --raw
anyways.  It's better than pretending it doesn't exist, I think.

Doing "smart" things with the rename information is hairy so it's
certainly worth leaving that for another day.
-- 
David
