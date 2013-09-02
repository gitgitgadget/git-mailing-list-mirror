From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 7/8] update-ref: support multiple simultaneous updates
Date: Mon, 02 Sep 2013 13:23:28 -0400
Message-ID: <5224C990.8070701@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com> <xmqqbo4eyeps.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXsS-00029Q-57
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab3IBRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:25:18 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52220 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754869Ab3IBRZR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:25:17 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]) (using TLSv1) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTJ/f1fxiJeQDgVlgWoBazJoNWwWive@postini.com; Mon, 02 Sep 2013 10:25:17 PDT
Received: by mail-ob0-f169.google.com with SMTP id es8so4863153obc.28
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=A/L5s6AF1o7hVddS2lWWZNjOAICJognHklVUmo9v6Nk=;
        b=S4maY/bTiSQMArVpZEowYfh/AvQHGFYCHntdU+A5LRgcQkh2h5gtGenP+rH2QGWj/a
         3ssgyA1BBbkqcDTPoR+WRCm/lfUknRRY9PTsLnu2aAaTBA7LbdthfPOM8BDkca/J0E3n
         MSXLzBixUFzG49ZD74Aa696hfB4rfU0e3DZq/atLl2BKeq6DJEC1YcprNjq/RkZ4fU+5
         YhpW4+PVX+TVV+2bLfxs2liHuUOdc8AkFtkV7HHpBSDnY39MaPu7D2nLBXRsTz7XwyY6
         ZGPA5ve4Y0ZIAbUTZBvL+ESGHyKjobIXbHws0AyjQjypXmXqeNLCUs3UUe2mdLaoZByg
         FAOA==
X-Gm-Message-State: ALoCoQlfpmWRXHUu785xUxPQ6rg5cxn3CH4v2a5Ox8DLtFckU0sTub1HD7nTPBMinaA7A4xexLOfwCQPtgvFoqQY7+hRSyiWeTvj8DCO/RpW6tO8eR8EqKb9c9YQ5Sd/94rLpYc5Fsh9ztP4QK9pb3QPNtLc/ggKPA==
X-Received: by 10.60.174.75 with SMTP id bq11mr9855704oec.17.1378142716659;
        Mon, 02 Sep 2013 10:25:16 -0700 (PDT)
X-Received: by 10.60.174.75 with SMTP id bq11mr9855702oec.17.1378142716590;
        Mon, 02 Sep 2013 10:25:16 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id s14sm14624700oeo.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:25:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqbo4eyeps.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233642>

On 08/30/2013 06:51 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> +With `--stdin`, update-ref reads instructions from standard input and
>> +performs all modifications together.  Empty lines are ignored.
>> +Each non-empty line is parsed as whitespace-separated arguments.
>> +Use single-quotes to enclose whitespace and backslashes and an
>> +unquoted backslash to escape a single quote.
> 
> That is somewhat unusual.
> 
> When we need to deal with arbitrary strings (like pathnames), other
> parts of the system usually give the user two interfaces, --stdin
> with and without -z, and the strings are C-quoted when run without
> the -z option, and terminated with NUL when run with the -z option.

Great, this was the kind of suggestion I was looking for in the original
PATCH/RFC cover letter.  Thanks.  I'll start with the C-quoted version
and think about adding -z once we've agreed on that format.

>> +Specify updates with
>> +lines of the form:
>> +
>> +	[--no-deref] [--] <ref> <newvalue> [<oldvalue>]
> 
> What is -- doing here?  refs given to update-ref begin with refs/
> (otherwise it is HEAD), no?

The existing update-ref command line can be used to create all kinds
of refs, even starting in "-".  I didn't want to add any restriction
in the stdin format.  I'm not opposed to it though.

Thanks,
-Brad
