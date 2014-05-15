From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 10/42] refs.c: ref_transaction_delete to check for
 error and return status
Date: Thu, 15 May 2014 09:26:19 -0700
Message-ID: <CAL=YDWnkbyWk4iTaOey7bsoQc+Maqu7z5tOy3Vj-jX-3OjCakQ@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-11-git-send-email-sahlberg@google.com>
	<20140515001904.GG9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyUC-0004JF-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbaEOQ0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:26:21 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:63199 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaEOQ0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:26:20 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so1595097veb.20
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/0DNMHBfUfIeh5PrqYT0ivuXfgguPnVLH4ey/XhRdZo=;
        b=BWj/k947Oxv4+LqS34pIvLj/1wucZtGWgJLUe5y/u6NdUlYEj3NCFdYLhc70Y8vVQg
         AQn4aoscRLq2l/Ns3f+rJ6DJ+vhkBH57KQSgn+SwxQ+pPdTfH8OIFmbSywOrn0WIUPRF
         hulGQrlsfEwfGCI/V0kMyL0iVQDnTS+Xfp4W7Ai1RbZ5Y28ZtqpG4Qe5XamFz3jojElS
         FgxhGvEBg+G8OlXghIr+Zj7Y44yKhTdqgIsg9ykHd4GNPyhmceiLTcmhIDo5ifsQW8dL
         GUmSqZ8nPCyzmPJzBs4uvR2DpCp+vxUlY3essMMPFWwJDwH7zPGlT1y871ZBKfdDpCi5
         NnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/0DNMHBfUfIeh5PrqYT0ivuXfgguPnVLH4ey/XhRdZo=;
        b=Z0/Qg3mJz0HR+770RYVEhp404TthIrfKMATcIjYYGbkmTG0S3g+8/MSl74AmkxBuj8
         XzYHjL0D62ipLiAsyJG0O/FM5SRlLOkYlUyKO4W68Z0U16Wu6DNZJ8xKUu9KlFHGoGKr
         VJasbHMTL7rkkXbNtNKw9uBcjxBlhntusE/zQHrnpDpYP8mxWAk4hwCOlb0jZXtTODDp
         j2wpdmRiTOSiCE7wK7oO27227XLzlN5q4PCDo8k4yeeFbXXB3/bhKxsvCSchyttoLtu2
         4Ixr4lPq0CbzNIP9UJI/8tCqlODNyYl48G7Xl4o4WFTeIQqI/4Bd3QrYsP4GafTAZuD9
         2iPw==
X-Gm-Message-State: ALoCoQm84RAw+Sh60Pj1N8yt1WZF++s0jpxJnriOJusnSDAylLCIo8YMDwLNQgPWjSybLLhnIMka
X-Received: by 10.52.37.135 with SMTP id y7mr1955373vdj.38.1400171179669; Thu,
 15 May 2014 09:26:19 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 09:26:19 -0700 (PDT)
In-Reply-To: <20140515001904.GG9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249109>

On Wed, May 14, 2014 at 5:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change ref_transaction_delete() to do basic error checking and return
>> status. Update all callers to check the return for ref_transaction_delete()
>> There are currently no conditions in _delete that will return error but there
>> will be in the future.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>
> Same comments as _delete and _update. :)

Done.
Thanks.
