From: Junio C Hamano <gitster-vger@pobox.com>
Subject: Re: Local tag killer
Date: Thu, 12 Sep 2013 21:03:53 -0700
Message-ID: <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
References: <52327E62.2040301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 13 06:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKKcH-0004q9-Vl
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 06:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3IMEER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 00:04:17 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:50057 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3IMEEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 00:04:16 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so1632973lbj.41
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 21:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vgrCeTMXF3AHrsWBjV6S7bwbxfEAKQnHP1dAFl4iDDM=;
        b=QrziwqMYl9zi294xHsIeC0DXHd9ptesQ9yw41quiNf2EH5jr6ilPNMe8MSdrUOCqRj
         DW2Hx/MqFlknBC14i4cgv3NF27w1Slck+TAozU28OQlrZH6shLb2mQnhnSg2gcu1zpE6
         8q0M6Cl+T2tOtgdDV9/CPf6dBzxdnqL6S+83LOOhZcrrV32Pygsayx4CxbXXeMQeayus
         38Hb8EpJW6pfPYgmaak5RoGSaO68m/z8gDRDIyVG1XPDXgslp19e/A5khTWUbjnV7BR6
         VT3RPY+ydLyAVTIORkTyK7LIZlJSwPPoo64KB8WB7cA1X4bNoOjeMZ5dtba1roeyP82v
         3yPg==
X-Received: by 10.112.149.197 with SMTP id uc5mr9950263lbb.19.1379045054057;
 Thu, 12 Sep 2013 21:04:14 -0700 (PDT)
Received: by 10.112.142.4 with HTTP; Thu, 12 Sep 2013 21:03:53 -0700 (PDT)
In-Reply-To: <52327E62.2040301@alum.mit.edu>
X-Google-Sender-Auth: Rsc_fpNe4qV9kB33AQ36u97YLp0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234724>

> When looking into this, I found a test in t5510 that appears to want to
> verify this very behavior:
>
>> test_expect_success 'fetch --prune --tags does not delete the remote-tracking branches' '

The title tells me that it wants to make sure when pruning tags it does
not touch remote-tracking branches under refs/remotes/origin/, I think.

>>       cd "$D" &&
>>       git clone . prune-tags &&
>>       cd prune-tags &&
>>       git fetch origin refs/heads/master:refs/tags/sometag &&
>>
>>       git fetch --prune --tags origin &&
>>       git rev-parse origin/master &&
>>       test_must_fail git rev-parse somebranch
>> '
>
> However, the last line seems to contain a copy-paste error and should
> presumably have s/somebranch/sometag/.

I agree that somebranch must be sometag, as it wants to make sure
that --prune --tags removes the tag the other side does not have.

I also agree that the documentation is misstated; "remote-tracking branch"
may have been a convenient and well understood phrase for whoever wrote
that part, but the --prune is designed to cull extra refs in the
hierarchies into
which refs would be fetched if counterparts existed on the other side, so
culling tags that do not exist on the remote side should also be described.
