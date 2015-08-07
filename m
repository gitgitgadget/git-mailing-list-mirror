From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 13:17:02 -0700
Message-ID: <xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, hvoigt@hvoigt.net
X-From: git-owner@vger.kernel.org Fri Aug 07 22:18:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNo50-0004Vd-F2
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 22:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946100AbbHGURF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 16:17:05 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:32975 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbbHGURE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 16:17:04 -0400
Received: by pdrh1 with SMTP id h1so30800206pdr.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8K6IilW2/zaij3nEvTjHfh3RwH9kBa2lyRg3R2DRPHk=;
        b=qOLrPxOB1yiOqUM4VCUMXF2Tf17EAmOAphg0EOQJ9JD3FAhT/CtfobqLbVxFm2+lyY
         2b+MaEP1+9ruGZjnylOQw65PQI/JVWGVSjlwYbo4npTfyavdOJodh2k6HmtwJG1WkKcC
         cp3ujCTTeZF4cM5Bo6BSvGMftvORe9VhVbXFchGBnTMVmr+YgWad/PGF98ohWhN+2KuH
         xzzQC0s0JhlhW4Bfsc8Go+C/qHNLOprZDH985D7XFV7HQamVZuDh8qN5rllbH38/B/iq
         ZFcv0j3W1NRW0D9eVLa/ba4Lf2BLgbfzNuRrP0Y28PYX1GAefvwHXxHqSy9g5w5hTqiD
         jsNQ==
X-Received: by 10.70.103.37 with SMTP id ft5mr18159567pdb.83.1438978623692;
        Fri, 07 Aug 2015 13:17:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id ph4sm11080787pdb.43.2015.08.07.13.17.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 13:17:02 -0700 (PDT)
In-Reply-To: <55C3BA5C.3030404@web.de> (Jens Lehmann's message of "Thu, 6 Aug
	2015 21:49:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275484>

Jens Lehmann <Jens.Lehmann@web.de> writes:

This change...

>> @@ -723,10 +733,8 @@ int fetch_populated_submodules(const struct argv_array *options,
>>   		if (!S_ISGITLINK(ce->ce_mode))
>>   			continue;
>>
>> -		name = ce->name;
>> -		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
>> -		if (name_for_path)
>> -			name = name_for_path->util;
>> +		name_for_path = submodule_name_for_path(ce->name);
>> +		name =  name_for_path ? name_for_path : ce->name;

... interacts with Heiko's cached submodule config work that seems
to have stalled.

I can discard the stalled topic and queue this one instead, asking
Heiko to reroll his on top once this has stabilized, or if Stefan is
really into revamping submodule now (which I hope is the case),
perhaps Heiko's work can be rerolled by Stefan (with help from
others, of course) as a prerequisite and then these changes can be
built on top of it?
