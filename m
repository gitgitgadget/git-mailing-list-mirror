From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set
 API
Date: Thu, 31 Jul 2014 22:14:49 +0530
Message-ID: <53DA7281.8060403@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>	<1406821662-1570-7-git-send-email-tanayabh@gmail.com> <vpqr411h69h.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 31 18:45:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCtTT-0004JZ-0s
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 18:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbaGaQoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 12:44:54 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38724 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbaGaQox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 12:44:53 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so3784675pdj.21
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0/tAiWDcsZ6/LebqJaqiQOCchpTZEbPKCXpE8miZw2M=;
        b=T94thfxrgSTofY8QvR3DMxZPilBxAXrKF3XByA+V/r/N1mU892+McxlDAZy9gx32Tq
         QZAbCxoVpFOgHyvq8F47ipj3noVKRntKaBYfMrv6SSUGQ5v40+bBw41VgAhyqzbKpdx7
         TTlTW25laZbRtyqArX9y8LmJFVQy0wNBN4jMHmBo060nMfdSYy9cVRIuGzByixyDcYNE
         UoPLtmh/X0SL1F+fEfS8PlsvSV/FXKN4FXVpxe2o9xzLl9BBisC0tno3pM4UmNM5pxfC
         bHBAhvvpqwzes/5mMMNB0XVIny+/ZCUN2Ca+VwZD47qYl8ofZbUhdorUazfFbLJud61B
         M19g==
X-Received: by 10.68.220.170 with SMTP id px10mr5873516pbc.33.1406825092388;
        Thu, 31 Jul 2014 09:44:52 -0700 (PDT)
Received: from [127.0.0.1] ([223.229.21.143])
        by mx.google.com with ESMTPSA id v17sm9041769pdj.11.2014.07.31.09.44.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 09:44:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqr411h69h.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254589>



On 7/31/2014 9:25 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> +void git_die_config(const char *key)
>> +{
>> +	const struct string_list *values;
>> +	struct key_value_info *kv_info;
>> +	values = git_config_get_value_multi(key);
>> +	kv_info = values->items[values->nr - 1].util;
>> +	if (!kv_info->linenr)
>> +		die(_("unable to parse '%s' from command-line config"), key);
>> +	else
>> +		die(_("bad config variable '%s' at file line %d in %s"),
>> +			key,
>> +			kv_info->linenr,
>> +			kv_info->filename);
>> + }
> 
> Extra whitespace before }.
> 
> Also, didn't we agree that it was a good thing to factor this
> if/then/else into a helper function?
> 

I have been thinking about it, wouldn't it be better to give users
a function like,

git_config_die_exact(key, value);

where user supplies key & value both and it would print the correct message based
on that. git_die_config() will be a wrapper over it, supplying the last value.
It will also replace the redundant code in git_config_raw() and help in the
multi value case. If the idea sounds okay, I will send a reroll.
