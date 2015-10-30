From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Fri, 30 Oct 2015 15:35:26 -0400
Message-ID: <CAPig+cSzF0B1rP1ns7PqZjnOuAm50t+Wky1S0EUNh2VWAmdjNw@mail.gmail.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-3-git-send-email-k.franke@science-computing.de>
	<CAPig+cRK-EPpH4dUMpYBcjR22Wqw4RnNTYeBvw-M7h=CTFGviQ@mail.gmail.com>
	<20151030182426.GA16389@science-computing.de>
	<xmqq8u6kkvam.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Knut Franke <k.franke@science-computing.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:35:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFSV-0004qx-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759777AbbJ3Tf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:35:28 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34500 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbbJ3Tf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:35:27 -0400
Received: by vkgs66 with SMTP id s66so53944521vkg.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Pji5iM2xI8MBf5NqxtjKuTkLgyclK4zHQBO15RFSIFo=;
        b=zZsYsojj7ggrAlpXSTFPqUd/xtyfP3QqaulzukacvpNOq5RaNusNJ+n3XePNUdqQs1
         WfLtSPAjdqyRJhUgmSvRPi9yXhIDGRBmMCERYk9Hltn/diuPLT+wfvNOKPC1lNPuCyYd
         0qYVX0mCm3uaeh+RQ+Kgu4O/deVsAFraJJLfjzagQxD1tWLfLSLGR92McpWobFwMGUxe
         SBOGnri4pACtVquN6q8viHpxzoZAdaC4+7OtKcHO09sTihzDUqOCbl0djwKex7Ljl0s3
         pYfP2Iy8CLd1U+QN5vbMKNtsIe7gPrWS5dbeJHfSyLrAOIqqWhv1V/tKS1r4NWQalj0N
         j1Sw==
X-Received: by 10.31.2.193 with SMTP id 184mr6545271vkc.151.1446233726712;
 Fri, 30 Oct 2015 12:35:26 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Fri, 30 Oct 2015 12:35:26 -0700 (PDT)
In-Reply-To: <xmqq8u6kkvam.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: N2w4u9oV_X2G1MrBaVYG64eimfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280533>

On Fri, Oct 30, 2015 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Knut Franke <k.franke@science-computing.de> writes:
>> On 2015-10-28 14:58, Eric Sunshine wrote:
>>> > +               }
>>> > +               if (!curl_http_proxy) {
>>> > +                       copy_from_env(&curl_http_proxy, "ALL_PROXY");
>>> > +                       copy_from_env(&curl_http_proxy, "all_proxy");
>>> > +               }
>>>
>>> If this sort of upper- and lowercase environment variable name
>>> checking is indeed desirable, I wonder if it would make sense to fold
>>> that functionality into the helper function.
>>
>> It's just for consistency with libcurl here, not generally desirable; so I don't
>> think it makes sense to add it to the helper.
>
> I agree.  Unlike many environment variables, historically these
> proxy environment variables were all lowercase only for quite a
> while (found as early as in CERN libwww 2.15 March '94).
>
> It appears that CURL did not know this and implemented only
> uppercase variants, which was later corrected to take both
> (http://sourceforge.net/p/curl/bugs/40/ shows a fix in Nov 2000).
>
> So both unfortunately are used in user's environment and we need to
> pay attention to both.  As lowercase version is the more kosher one,
> looking at uppercase first and then overriding it with the lowercase
> one is the right order, I think.
>
> It's a mess, but it is limited to these proxy-ish variables and does
> not deserve a helper to promote the pattern.

It would be great to have this explanation in the commit message or
in-code comment. Thanks.
