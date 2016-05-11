From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/7] submodule-config: keep labels around
Date: Wed, 11 May 2016 10:41:01 -0700
Message-ID: <CAGZ79kYSxccNLvJ-=UghabQ_MG73jRSabVy5rgfNo-A6Fjz_yQ@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-4-git-send-email-sbeller@google.com>
	<xmqqh9e5l7id.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 19:41:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Y8C-0004oR-Pb
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 19:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcEKRlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 13:41:04 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35812 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcEKRlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 13:41:03 -0400
Received: by mail-io0-f176.google.com with SMTP id d62so63797131iof.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u+vO9tiXibQAyn6WD/+57XrHM27SF6CkuSxC5F45B40=;
        b=msZSxBGMSFPeYIrnBU/J+ZkA1/RyzDVOYIzA+x+nlOH+Rv/RuiEebWqwYiyOg17dgN
         umHGz3xrazrscDVdlQZZQVZY8RJ9NuDsbKSYb87NRzlqRbqY5AkvbYTSOotYIGt+RqXZ
         ZG/Gn96Bwgp8alYBXF5n2JRAFmVf2mEinwDQ2jM5ZI4KQ9fCA2jmxWjce/DLMZ/XjiqE
         9syGUBxau0X7aIqCN7JiLOcsOgGJsZhg7TxdPeQB0LrOqkX4/An8Z73FqJ7R62Zz6rWV
         zyR6yJdF+dR7YNYRU5thaJtTL+xoPPi0JEoYXeLjlChjnt4BXCd9K7Ft504lWdcr0NNK
         Dk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u+vO9tiXibQAyn6WD/+57XrHM27SF6CkuSxC5F45B40=;
        b=dQBkWUqFnQkgsHQdADI+vEq8THny+MksiAsCxGlh677LyiQWbPLmfz461KzjHvuziU
         4qEvUveTSvKmQbAIT01nHXxRYuMwoZD7D7n2V45R86HWo4UFRoDmxMT+9iBtbw6iOoqx
         jZ4rXOma5hao6GvaemhIoxdvPoo524dTIMUksXHuuDoUpKbATkNuGEU6zQcvN3oCals/
         APRCr1qbhtI9d4Plao+l70mcEOv/jpxauT9z49c1vC6GbXhs11yG8JMmp7Zxsn0pBvt1
         0cvo9SYYU0FnincCqszElG0hsEdDQ+VCOpMS7lqnI6ZySmyUk+gz6NAeqUAmXJusP37b
         Wh5A==
X-Gm-Message-State: AOPr4FWaZrrMWr1tiSriBzL5sxgTamd2ixc896fV7bWqdVhM2RCkwrNTXbohs4y9WPyiogHfYkyUaazqgdgxcF9X
X-Received: by 10.36.14.71 with SMTP id 68mr5617513ite.98.1462988461774; Wed,
 11 May 2016 10:41:01 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 11 May 2016 10:41:01 -0700 (PDT)
In-Reply-To: <xmqqh9e5l7id.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294358>

On Tue, May 10, 2016 at 6:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -199,6 +203,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>>       submodule->update_strategy.command = NULL;
>>       submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>>       submodule->ignore = NULL;
>> +     submodule->labels = NULL;
>
> Hmph, is there a reason to do this, instead of embedding an instance
> of "struct string_list" inside submodule structure?
>
> I am not yet claiming that embedding is better.  Just wondering if
> it makes it easier to handle initialization as seen in the hunk
> below, and also _clear() procedure.

Thanks for pointing out that alternative.  That looks so much
better in this patch. Let's see how the follow up patches develop.
As we'd not check != NULL first, but check against the count of the
string list. (I expect no problems down that road though).
