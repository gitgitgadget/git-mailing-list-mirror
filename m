From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] submodule-config: keep groups around
Date: Wed, 20 Jan 2016 16:20:57 -0800
Message-ID: <CAGZ79kZXSUkMx=+P0+L4yastYzqeCAUf83L2t8H9=QAC1FwuiA@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-3-git-send-email-sbeller@google.com>
	<xmqqwpr43pyz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:21:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2zq-0002uC-KW
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 01:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbcAUAVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 19:21:02 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38679 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcAUAU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 19:20:58 -0500
Received: by mail-ig0-f180.google.com with SMTP id mw1so23480486igb.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 16:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5CYQ/23nwr38ax2mhm/2JYcnccaIFW9hua5/kUyEgkY=;
        b=P4gaN7DdFrO/RLe/QGy9pUYF93yQri08ldQX5Oj0LRm+LQTGwWloRZ92YY7Xf/RcLG
         g2wuUED8/rq3hSbw706XFkZK8a1304+apRU06sKKPofWsDJ3xdu2VmEq9ePaGS8OIP02
         ZF61z8ugeFLnAD9gr1I3OCfjKrIjAoSg+hYvz9SpCPENDRGLsfoB35K7HM/6FWrjolgs
         d+zXxKcS1dXWVJz49KNFDe8S0dNzf05/GfBipvpCWELpvCj6w3EMszDbrYLlEwcv5U6T
         l5HBkQ4t7mYLSusRNgD4hYa57NYviRdDq2fwfKMyBCVt0Pb7vCnUk7yBhsLyygQL91nE
         5K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5CYQ/23nwr38ax2mhm/2JYcnccaIFW9hua5/kUyEgkY=;
        b=MlU1wKb1SXpci6kwpgbOT9bIyC3GSQsH6Zr/jGwoFN4habYwg5Jy6KrD/mqV/bUJXy
         h+WUWn5odtzNBkP5QuSWt2fsiOeDEFmlr4j7H6cg5KG66gWBt/siHuUBNG22mVxGgNWR
         G9vJqjjiqig2HdrqqRd3Hmjq6+ouQTM5qVQ+JguM7EWwm7kBI5Ud0FbEjODckwSazBX8
         06r31sepIQ7ahC+OvoStOA91uNiZUbrt3zfFDtQ+ggXG0uQdKA7N4ntBm9iS8tHQYaNw
         bHNLfFmm8eBZYpxVUrZLIfrHlchBjF6lpl9kl7YTY/swQDbxF60+S1seByEhRdaCARCB
         p+4Q==
X-Gm-Message-State: AG10YOTIsGS8Yxc1gVQHWvnb1RqgxyrDCRTcpvfRfEbDAjfzzs2RdwMQmRiJ2q/clsXGMVh79/IUr0wV9xgv+NIq
X-Received: by 10.50.28.105 with SMTP id a9mr482380igh.94.1453335657359; Wed,
 20 Jan 2016 16:20:57 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 20 Jan 2016 16:20:57 -0800 (PST)
In-Reply-To: <xmqqwpr43pyz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284492>

On Wed, Jan 20, 2016 at 1:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>       free((void *) entry->config->name);
>> +     if (entry->config->groups)
>> +             string_list_clear(entry->config->groups, 0);
>
> You are allocating entry->config->groups itself in the in the hunk
> around ll.327, so that also need to be freed, I would think.

done


>>       unsigned char gitmodules_sha1[20];
>> +     struct string_list *groups;
>>  };
>
> Is there a case where you need to enumerate and show the groups a
> submodule belongs to to the end users?  Using string_list_insert()
> to manage this list would mean you will lose the original ordering
> you saw the list of groups in their .gitmodules files, which may or
> may not matter.  I'd assume that the ordering should not matter, but
> that is something the user may want to see documented.

In this patch series we only need to check the items of that list one by one,
no need for a sorted version, so I'll change it to be unsorted and
document that.

>
>>
>>  int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
