From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Fri, 27 Jun 2014 10:19:32 +0200
Message-ID: <53AD2914.4030508@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>	<53A84077.4010200@ramsay1.demon.co.uk>	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>	<53A99FEB.5040808@ramsay1.demon.co.uk>	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>	<vpq1tubinbx.fsf@anie.imag.fr>	<xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>	<53AC724E.3090106@gmail.com> <xmqqzjgz2wqr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:19:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0RNi-0003So-DS
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 10:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbaF0ITe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 04:19:34 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:60328 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbaF0ITc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 04:19:32 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so4703261wgh.28
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=be48x1uDZY98ZVXxsQl/oFw75plaZRGuz75imVtxks8=;
        b=A3uEkxUfGAY6Di85QDvFvCmw4sENH4Al9rq3z0WZ5Fyadpj/XWYC2aFbWkQ8RO+OVv
         vWzXutzAxsOXDfMlyCiB55rlCZGxhNIMt52bDurQwGqOjyUQjjUred8Rl59nUGixQmHW
         up4llfF9ZnxGTOrY8/rDZy2UsteP626iHP1kwirHGInujAzGiPOv4tDS8c3pYQk5Kvtg
         7MGCLc4CNXWWwPrfxSwpOo8FTgatiRFy5wdr5eFXGBWE7mU8LmuzQNY0j4rBOMzs73zk
         iEcHhaReaW8MEihqOr5rg/uttcv8jrJ5baKKoakMORMur5sGfjbYtAiIzZaa3Hy1CJKg
         Rxkg==
X-Received: by 10.194.24.36 with SMTP id r4mr23888471wjf.35.1403857170893;
        Fri, 27 Jun 2014 01:19:30 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w5sm75220416wif.3.2014.06.27.01.19.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Jun 2014 01:19:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqzjgz2wqr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252539>

Am 26.06.2014 23:21, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>>> Because I had an experience under my belt of a painful refactoring
>>> of "the_index" which turned out to be not just a single array, I
>>> simply suspect that the final data structure to represent a "set of
>>> config-like things" will not be just a single hashmap, hence I do
>>> prefer to have one layer of abstraction "struct config_set", which
>>> would contain a hashmap and possibly more.  Doesn't "is the hashmap
>>> initialized" bit belong there, for example?
>>
>> Would an additional
>>
>>   int hashmap_is_initialized(constr struct hashmap *map)
>>   {
>>     return !!map->table;
>>   }
>>
>> API help? (Note that hashmap_free() already does memset(0), so the
>> usual notion of "zero memory means unitialized" applies).
> 
> It may remove the need for the separate "hashmap_initialized" bit
> that was implemented as a file-scope global in the patch.
> 

That the variable is redundant was all I was trying to say, sorry for
the misunderstanding. But reading through api-hashmap.txt again, I
found that documentation of the hashmap members is pretty vague, so
perhaps improving the docs would suffice (e.g. "hashmap.table != NULL
indicates the hashmap has been initialized.").

> I however am not convinced that it will be the _only_ thing other
> than the hashmap we would need to use to keep track of the in-core
> "set of config-like things", and usually a blanket statement "these
> are the only thing we would ever need" tends not to hold for long,
> so...
>

I think having an extra type for the configuration is a Good Thing
(even if the only member is a hashmap). Although I wouldn't call it
'config_set', as it conflicts with the verb 'set', resulting in
weird APIs ('config_set_get_value()', 'config_set_set_value()').
Perhaps 'config_map' or 'config_settings', or just 'config'?
