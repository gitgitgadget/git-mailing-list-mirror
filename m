From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Wed, 8 Jul 2015 09:19:00 +0700
Message-ID: <CACsJy8De6Wt4J5ZFx5rEg2eRBt=7PsLim=31FvtLEKsX-6SMyQ@mail.gmail.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
 <CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
 <775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
 <xmqqr3ok3qad.fsf@gitster.dls.corp.google.com> <663318203.435786.1436292501411.JavaMail.apache@nm32.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Plamen Totev <plamen.totev@abv.bg>
X-From: git-owner@vger.kernel.org Wed Jul 08 04:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCexU-0000nD-0q
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 04:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbbGHCTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 22:19:32 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36781 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943AbbGHCTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 22:19:30 -0400
Received: by iecvh10 with SMTP id vh10so147013761iec.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 19:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fYy8tvWgNmbNctakGn9bbiZHehZaOAOFdWBXZ8CcgGw=;
        b=T3VEe14TQO6md5aepFyAvcsNaQhTT5gDbXiWoNSHVswMu2jIMGGgdrdOOhDZWaxlfL
         ZKEwy6l1gjGG5b1i3p1VW4Sc822t/W4VkhrAoy74LqFf88006X437FUZppmD/0xOdTDZ
         oJ0Ey77nuUKYfbo+0uZ6bmjj4oEdYSPcNgqn1OEroLJIZg4xIs3IZpgMyAQQjaE7hVki
         globPYf+tvTLE6BrSbXnnfIs9s7V3/hJcLK7p+2Ohywb9KpSS19zUdx2ZQXda+O9cOFI
         9bj6PFiw/k0sLoa5brMizSO8wz3xxu54FLca5KDMmcWD2WeQ8BysMaIsjVi04KkCEQuc
         zqpA==
X-Received: by 10.107.15.153 with SMTP id 25mr13033661iop.44.1436321969927;
 Tue, 07 Jul 2015 19:19:29 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 7 Jul 2015 19:19:00 -0700 (PDT)
In-Reply-To: <663318203.435786.1436292501411.JavaMail.apache@nm32.abv.bg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273632>

On Wed, Jul 8, 2015 at 1:08 AM, Plamen Totev <plamen.totev@abv.bg> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Plamen Totev <plamen.totev@abv.bg> writes:
>>
>> > pickaxe search also uses kwsearch so the case insensitive search with
>> > it does not work (e.g. git log -i -S). Maybe this is a less of a
>> > problem here as one is expected to search for exact string (hence
>> > knows the case)
>>
>> You reasoned correctly, I think. Pickaxe, as one of the building
>> blocks to implement Linus's ultimate change tracking tool [*1*],
>> should never pay attention to "-i". It is a step to finding the
>> commit that touches the exact code block given (i.e. "how do you
>> drill down?" part of $gmane/217 message).
>>
>> Thanks.
>>
>> [Footnote]
>> *1* http://article.gmane.org/gmane.comp.version-control.git/217
>
> Now that I read the link again and gave the matter a thought I'm not so sure.
> In some contexts the case of the words does not matter. In SQL for example.
> Let's consider a SQL script file that contains the following line:
>
> select name, address from customers;
>
> At some point we decide to change the coding style to:
>
> SELECT name, address FROM customers;

On top of this, pickaxe already supports icase even kws is used. But
it only works for ascii, so either we fix it and support non-ascii, or
we remove icase support entirely from diffcore_pickaxe(). I vote the
former.
-- 
Duy
