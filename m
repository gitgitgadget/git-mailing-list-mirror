Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B4C1F728
	for <e@80x24.org>; Thu, 23 Jun 2016 06:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbcFWGYp (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 02:24:45 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:43381 "EHLO
	homiemail-a76.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750925AbcFWGYo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 02:24:44 -0400
Received: from homiemail-a76.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a76.g.dreamhost.com (Postfix) with ESMTP id E5A21458081;
	Wed, 22 Jun 2016 23:24:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=qnidh
	0OtjgL3r7pIclgOwOPoVMQ=; b=cLwKza5nn4aCLt7FQkoxzRPK+OalAKqYt+fvy
	GdMo4XuUICq5lnLtKvLY/Nh5jvJjaazeTrKZk2TQPIPnQTZxC5oXuktbU/N/PEAj
	WRU6H+dum4Vgs039guHdSmNIV5MdPUL3+iZBcyq60lj/nZhTItrxwuxzFGgX0DYx
	oEUUzU=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a76.g.dreamhost.com (Postfix) with ESMTPSA id A5C6345807B;
	Wed, 22 Jun 2016 23:24:43 -0700 (PDT)
Subject: Re: [PATCH v12 11/20] index-helper: use watchman to avoid refreshing,
 index with lstat()
To:	git@vger.kernel.org, pclouds@gmail.com
References: <57662876.3070209@novalis.org>
From:	David Turner <novalis@novalis.org>
Message-ID: <576B80AA.4040508@novalis.org>
Date:	Thu, 23 Jun 2016 02:24:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <57662876.3070209@novalis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/19/2016 01:07 AM, David Turner wrote:
> Duy Nguyen <pclouds@gmail.com> wrote:
>  > On Fri, May 20, 2016 at 4:45 AM, David Turner
> <dturner@twopensource.com> wrote:
>  > > diff --git a/read-cache.c b/read-cache.c
>  > > index 1719f5a..8ec4be3 100644
>  > > --- a/read-cache.c
>  > >  +++ b/read-cache.c
>  > > @@ -1235,7 +1235,7 @@ int refresh_index(struct index_state *istate,
> unsigned int flags,
>  > >                 if (!new) {
>  > >                         const char *fmt;
>  > >
>  > > -                       if (really && cache_errno == EINVAL) {
>  > > +                       if (really || cache_errno == EINVAL) {
>  > >                                 /* If we are doing --really-refresh
> that
>  > >                                  * means the index is not valid
> anymore.
>  > >                                  */
>  >
>  > This looks really odd. I don't see why we would need this. It seems
>  > first appeared in your "do not apply" patch [1]. Maybe leftover?
>  >
>  > I found this while re-reading the series and I have not put much time
>  > in studying this code yet. So I may be wrong. I'll post again if I
>  > find that it's true after some more staring.
>
> I don't remember the exact details here, but I think we needed this so
> that we would ever refresh a file that watchman told us had been
> modified.  We definitely were missing some invalidation if we didn't
> have it.

... and now I can't repro the problem.  So I'll remove it and re-roll 
(with some other changes)


