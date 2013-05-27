From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 14/21] remote-hg: show more proper errors
Date: Mon, 27 May 2013 11:49:08 -0500
Message-ID: <CAMP44s0Ue5MZvRL=rbN-Ng16aPMhJxZpGgV2b=Moe8o=XgnuqA@mail.gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
	<1365682997-11329-15-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2wATbq8o4kcdyAq1zt_+fbvyxUQov04xHDTXuoKYecAQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 18:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0bj-0000xf-K7
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab3E0QtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:49:11 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46233 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab3E0QtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:49:10 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so6944332lbi.35
        for <git@vger.kernel.org>; Mon, 27 May 2013 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dhRpF8SRZM+qnKRQgPy3uJrg6ZBmYbl6yw3gPgGXG9E=;
        b=PR0q9bp0FnLTJ48lSlHaaryeeBwp1ofTkSNt7gD0ZOpNBSqK3mwFoy+4T7uSILgiP3
         B9/GHWWhAZtqrQkEQ70zcOpiO1Sza3HyzBen/rn9NsyKlTbw/tLV7npEkREsGRJfUVKH
         PMDeTxycg2HkyMRNtjvdLc3qB4+FSyPzopecn1FtAgwVUfTRMTTo4YHvoLN6yp3pLJap
         nJQapgGs6RpN1shoOqqJVM+V4amAgTbGK8BWJBKb+s5C8ODyursJnYcntEz/gzTTymiJ
         WMaAirCW65u43I0mP9lh9azkHSX1fNM+UYl7OTz9dhQK3EnBXCa7wHfrKpj/Bv2HuwsY
         tqdQ==
X-Received: by 10.112.156.164 with SMTP id wf4mr14269115lbb.76.1369673348692;
 Mon, 27 May 2013 09:49:08 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 27 May 2013 09:49:08 -0700 (PDT)
In-Reply-To: <CALWbr2wATbq8o4kcdyAq1zt_+fbvyxUQov04xHDTXuoKYecAQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225608>

On Mon, May 27, 2013 at 11:30 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> Hey Felipe,
> I know that has been integrated a while ago.
>
> On Thu, Apr 11, 2013 at 2:23 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> When cloning or pushing fails, we don't want to show a stack-trace.
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
>> index ff89725..3ae3598 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -284,11 +284,17 @@ def get_repo(url, alias):
>>      else:
>>          local_path = os.path.join(dirname, 'clone')
>>          if not os.path.exists(local_path):
>> -            peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
>> +            try:
>> +                peer, dstpeer = hg.clone(myui, {}, url, local_path, update=True, pull=True)
>> +            except:
>> +                die('Repository error')
>>              repo = dstpeer.local()
>
> Can you explain why "update" went from False to True ? That can be a
> problem if the repository is BIG (two working directories instead of
> one can raise space issues).
>
> The commit message is not so helpful here ;)

Good catch. It was probably a mistake. However, I already sent a patch
that overrides this so update=False again.

-- 
Felipe Contreras
