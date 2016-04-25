From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] string_list: use string-list API in unsorted_string_list_lookup()
Date: Mon, 25 Apr 2016 19:35:41 +0200
Message-ID: <87eg9t8uc2.fsf@gmail.com>
References: <20160422173500.32329-1-ralf.thielow@gmail.com>
	<alpine.DEB.2.20.1604240901570.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukQI-0003Fo-A4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbcDYRfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:35:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33548 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbcDYRfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:35:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so23725718wme.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7PmMEOnewB30chQAh4qus9x9ALVwRJBwU4uxUxws/o=;
        b=0JgggAUxNQc39J68QC3Xp7UdagX+VdlpbTwo9ZkmAWSScikmt4xdCowfaDqSavrJrt
         e5LNWrlEgQm52omkUMAai2aM+50799E6vTkVxNfm8Z6be7E970N5RmRlxEEf5i0x54vo
         K9aE69Nn4ILfEUIUUhd8JybjW6i9h3N3OGTJW1sfruuBUHu/yDnNmwDrk1Gd/11pQZLr
         U78z2oNtI1Qo6Wa9t1c6G5lHSzcJtRkawYRCNOHSqr0RcacG63VnsDnQv3J+R2CFH9EZ
         2Zd4LQXmFA8s9NsnaxGw1n6HjfQoUQHE060bJd/cmyTuKH0c+Sxo2EtKsrGESU/RSj1G
         OGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=B7PmMEOnewB30chQAh4qus9x9ALVwRJBwU4uxUxws/o=;
        b=ZUd18vu2le9q2/pqBFTGdjatUd7Kzg9oNwXwF1WePlDuNU92G3DPMiI8GOIYLdQHJG
         n9NC4+rO+Ytqon1HZIsYEmebBVo3iblZqfWVRr8S0ZEtd24Vc26M1pMsGvzbuvzAdZCX
         90g+oR4KxCRfOBbcy1Cp+m73bP4ThrqqdsZ+9eOgrg3FMsKvOpHVQbe5NkkExPobg4Z0
         g5V4fL11lac+j3R1sqbIWjGQ/+jGnOnqofqI6I9akARJteLFIKgpI9D5qOfJKwAkKYl9
         ROcstH1nBegxE8xFnMyFFM5WZdx4kJ7oNr8OYmO+H+gXNhqml/pyvyPr6wZlFh2sL3J+
         HAew==
X-Gm-Message-State: AOPr4FWAcea1I0efQMblV3zDzt7cisU5UIGF92CnqaIn3N5WkHLKB7dWY0Xp7UORbKR9/g==
X-Received: by 10.28.172.132 with SMTP id v126mr13791290wme.28.1461605743705;
        Mon, 25 Apr 2016 10:35:43 -0700 (PDT)
Received: from ralf-ubuntu (cable-86-56-27-240.cust.telecolumbus.net. [86.56.27.240])
        by smtp.gmail.com with ESMTPSA id d1sm24573603wjb.47.2016.04.25.10.35.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 10:35:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604240901570.2896@virtualbox> (Johannes
	Schindelin's message of "Sun, 24 Apr 2016 09:06:12 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292530>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  
>> -	for (i = 0; i < list->nr; i++)
>> -		if (!cmp(string, list->items[i].string))
>> -			return list->items + i;
>> +	for_each_string_list_item(item, list) {
>> +		if (!cmp(string, item->string))
>> +			return item;
>> +	}
>>  	return NULL;
>
> If you drop the extra curly braces (thereby matching Git's coding style as
> an additional bonus), at least the patch won't increase the number of
> lines.
>

Oops. I'll send a new version of the patch without these
extra curly braces.

Thanks!

> In any case, I like the simplification of the code.
>
> Ciao,
> Dscho
