From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/8] git submodule update: have a dedicated helper for cloning
Date: Thu, 4 Feb 2016 12:22:28 -0800
Message-ID: <CAGZ79kb-G=GHdtcH323LbHQ4V_azif04eHVuf8Z3gCeb-e=iKQ@mail.gmail.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-7-git-send-email-sbeller@google.com>
	<xmqqr3gtjs23.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbeDBf=AfA2RUhkfjwJqJ7pr30xW3UTXqiha_EPpisvnw@mail.gmail.com>
	<xmqqegctjnvm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 21:22:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRQQF-00079d-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 21:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933296AbcBDUWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 15:22:31 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36584 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933136AbcBDUW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 15:22:29 -0500
Received: by mail-ig0-f172.google.com with SMTP id xg9so34061965igb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lxYlBvtTwC/Sw4vca4mLPMaXb25GWa1gjSuLDE1amxc=;
        b=mfX90W/n4DFomxlR9PJ1MVwSA5tzp+YWSYBtfvZAxnrhKbXlUrN5OgDRVA78qu1xc2
         aSUZHfmP+1iwWsNSMZxINPn3l+RKg4qahLIqSK0vL/CMUf0rCOOXa70l98Fo9k802pp/
         qwzBT6MWY3iw7co+BdtnfFM6lqXke7qYQNiZSJbN5RhWzjI71A5Fp2llVZoGlR0HH1mR
         8Buo5geTbwHnlkOaBIkRuAHUKwGc2QfPFlqV7iA1lR+Nx33Z4fldhQ4ZQ6ZkBwMOajs4
         2jZL5pp5mKOopKSUbdYum4qiZ8EE7HY+0ptXFEdAMfKXK62TpZczXD+TbrpPIan3g/N5
         sTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lxYlBvtTwC/Sw4vca4mLPMaXb25GWa1gjSuLDE1amxc=;
        b=gXq3yviN/Mu7I2M8P1CWYen3n0VYMeZBcxyj0zSX8/iVaBSJuaBPTCRjLOJftWOFjy
         GSbxHxUX1huwh1e7WCGWl3F4kKHf3JMPNScNi8vBdIVshXYFEXIppwqSdAsiszkfPseJ
         NlCF5K0Jfvzo2E28SOZN5Xsrvpof1+oKTWMaugn+VCgWe/Xi41YQp9btZiNYvzuJA/Yi
         opON3vGgLsNYDrL9FGNtQVOSDdDuM3FmgHhiTU4M+06dIdkGLoDIFxrYmD37eeimn2sy
         wnNw2izj0JbOn/WXe3B8mDYYpKFNxYj2+5vvQkRq482xU3nkfYnSCUFLuP0CzAwJS3Y7
         4lNQ==
X-Gm-Message-State: AG10YOQXGsphCSocBfa3K8R6T4tqBYhm3LrLAjHQL6XrXotXMFm/R3UGfgJaDExgHO9gzzCr61wtL2y1bSd4o0jq
X-Received: by 10.50.102.40 with SMTP id fl8mr11600630igb.85.1454617349015;
 Thu, 04 Feb 2016 12:22:29 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 4 Feb 2016 12:22:28 -0800 (PST)
In-Reply-To: <xmqqegctjnvm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285490>

On Wed, Feb 3, 2016 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Feb 3, 2016 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> +             if (ce_stage(ce)) {
>>>> +                     if (pp->recursive_prefix)
>>>> +                             strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
>>>> +                                     pp->recursive_prefix, ce->name);
>>
>> As a side question: Do we care about proper visual directory
>> separators in Windows?
>
> You know I do not do Windows ;-)  I'll leave the question for others
> to answer (I am trying not to be one of the the only small number of
> people who review code around here).
>
>> I never run into this BUG after having proper initialization, so maybe it's not
>> worth carrying this code around. (We have many other places where
>> submodule_from_{path, name} is used unchecked, so why would this place
>> be special?)
>
> That is why I wondered if moudule_list() is a better place to do so.
> That is where the list of everybody works on come from.

I do not think that is a better place as not every consumer of module_list
(and module_list_compute as the nested function) will need to use the
submodule caching API. So these consumers are not interested in possible
bugs in the submodule cache API nor do they want the performance hit
which comes from checking unrelated stuff in there.

As said, I only saw this bug when the cache was not initialized properly,
and then such a bug is to be expected. I'd rather remove it in a reroll.
