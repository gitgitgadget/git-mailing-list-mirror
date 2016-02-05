From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv8 1/9] submodule-config: keep update strategy around
Date: Fri, 5 Feb 2016 12:33:09 -0800
Message-ID: <20160205203309.GA28749@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
 <1454623776-3347-2-git-send-email-sbeller@google.com>
 <20160205005946.GA19501@google.com>
 <CAGZ79kYfxYAZif4P0GRdy5LQVXuHAyr3VtwEtX7Uu0sDyD4yoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRn4a-00077f-LK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 21:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbcBEUdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 15:33:41 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33352 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbcBEUdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 15:33:40 -0500
Received: by mail-pf0-f171.google.com with SMTP id w123so74592418pfb.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S6myZv4wsfx22X0EFZjTWfmrCyVMulOfU/r2kvbRPfg=;
        b=ZCNgkFOrzjQCPampMTWPXzodOk/+JdkKRUdOf5g26BzXDexdwj4t7sy5nY42m8iijh
         bVy6ZdqqwrDR1SbhJnVy1tT7DZvr/bQnW5XWAmjq5Ht2Xxq7BWN87v07TgM2T4iUAuZy
         f9cooq132g2Ci8QIcgAZdhTzqsmpMscki3fSauS4W5c6RqfKox3ug4+EKzTZ7rFeVh75
         XSsEpVZfmZSJA04wTNo+XnXBtzdA6wbp/fhuqy9Y8MkfcBu0m4pPKWz8h1iVMn46LRrp
         Me1Dk+LWLcuCzuuS5D0ZHw07ucvyADZyxZzGO4ijrjK8ZnQc9pJIZmX/tfnnYXZHPP3k
         iXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S6myZv4wsfx22X0EFZjTWfmrCyVMulOfU/r2kvbRPfg=;
        b=i+jWtQKOQeEEC4SDx2PBbZXBeCts7jg3ZImBulIryAeUlXA1T6DjQMmZJOAPpQg9z0
         T0ujDxPg7EVMBK9z6ZZ8n2xBMNBm4+OD+hdIEuLIx6wwjrjsUu1gtjdgEdOIJoJ8uk8/
         4fXHn7ZwBFt3tZGZHhRLfQQrkTCCuVFefRq+eekKOv1Ir+wO8K3cRtiO2jFV4SVPl4uk
         ndtmsKoVHILhcJKV0XjDw/f3Cl3CkjTKeOvbAs8cnqaERbvpFc1541E5o9Y6RHr0JvDN
         synTIfuAA/p00p9X+pwI718/4VqWPzLlC6zjXXY0MzPrRrtSdWA68VzyIePgbme3MLMh
         9k1w==
X-Gm-Message-State: AG10YOTRJjbbmSQYM5fdvw8+CcycnO+i3FTkS8wSQDubplLfuYBKdhzIEmE3HKD1AS4msw==
X-Received: by 10.98.73.8 with SMTP id w8mr22766288pfa.106.1454704419839;
        Fri, 05 Feb 2016 12:33:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d5a0:f713:2934:4c2])
        by smtp.gmail.com with ESMTPSA id v29sm26451008pfa.31.2016.02.05.12.33.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 12:33:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYfxYAZif4P0GRdy5LQVXuHAyr3VtwEtX7Uu0sDyD4yoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285626>

Stefan Beller wrote:
> On Thu, Feb 4, 2016 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:

>>> +++ b/submodule-config.h
>>> @@ -14,6 +14,7 @@ struct submodule {
>>> +     const char *update;
>>
>> gitmodules(5) tells me the only allowed values are checkout, rebase,
>> merge, and none.  I wouldn't know at a glance how to match against
>> those in calling code.  Can this be an enum?
>
> "Note that the !command form is intentionally ignored here for
> security reasons."
>
> However you can overwrite the update field in .git/config to be "! [foo]",
> which we also need to support, so let's keep it a string for now?

I had forgotten about "!command".  I think making it a string makes
the field hard to use: how do I determine whether it was checkout,
rebase, merge, custom, or none?  Are they case-sensitive?  Am I
supposed to strip whitespace?

One possibility would be to have an enum and a string:

	enum submodule_update_type update;
	const char *update_command;

Thanks,
Jonathan
