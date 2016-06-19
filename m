Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87AF20189
	for <e@80x24.org>; Sun, 19 Jun 2016 05:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbcFSFHF (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 01:07:05 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:34317 "EHLO
	homiemail-a15.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817AbcFSFHE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 01:07:04 -0400
Received: from homiemail-a15.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a15.g.dreamhost.com (Postfix) with ESMTP id B741976C069;
	Sat, 18 Jun 2016 22:07:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=to:from
	:in-reply-to:subject:message-id:date:mime-version:content-type:
	content-transfer-encoding; s=novalis.org; bh=PrYQ6y/4cR/D4zcgUn9
	rQXf/egQ=; b=fXcsAJBTQ8vycUW0YCHBcWXd/uYpRtojFGTnbcs63zoNhg1rUdN
	MZ7neYZeBZPnwWbsIA7N/gFqg/zGYGWtgjfzmMrQwfNKeYcVsoPJRRrboXmOwyy7
	PwTilR3Phl2yu5q4ph+7xRWJkNt1nSnO1mIFlQNBoG2ikvO9nVn/xWgo=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a15.g.dreamhost.com (Postfix) with ESMTPSA id 66A3176C065;
	Sat, 18 Jun 2016 22:07:03 -0700 (PDT)
To:	git@vger.kernel.org, pclouds@gmail.com
From:	David Turner <novalis@novalis.org>
In-Reply-To: <CACsJy8DzyvFOHU_8xoWUcjej=Ws7_v475=Q2iZmwKhkzYaZ7sg@mail.gmail.com>
Subject: Re: [PATCH v12 11/20] index-helper: use watchman to avoid refreshing,
 index with lstat()
Message-ID: <57662876.3070209@novalis.org>
Date:	Sun, 19 Jun 2016 01:07:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
 > On Fri, May 20, 2016 at 4:45 AM, David Turner 
<dturner@twopensource.com> wrote:
 > > diff --git a/read-cache.c b/read-cache.c
 > > index 1719f5a..8ec4be3 100644
 > > --- a/read-cache.c
 > >  +++ b/read-cache.c
 > > @@ -1235,7 +1235,7 @@ int refresh_index(struct index_state *istate, 
unsigned int flags,
 > >                 if (!new) {
 > >                         const char *fmt;
 > >
 > > -                       if (really && cache_errno == EINVAL) {
 > > +                       if (really || cache_errno == EINVAL) {
 > >                                 /* If we are doing --really-refresh 
that
 > >                                  * means the index is not valid 
anymore.
 > >                                  */
 >
 > This looks really odd. I don't see why we would need this. It seems
 > first appeared in your "do not apply" patch [1]. Maybe leftover?
 >
 > I found this while re-reading the series and I have not put much time
 > in studying this code yet. So I may be wrong. I'll post again if I
 > find that it's true after some more staring.

I don't remember the exact details here, but I think we needed this so
that we would ever refresh a file that watchman told us had been
modified.  We definitely were missing some invalidation if we didn't
have it.

P.S. Please CC novalis@novalis.org on these emails as I don't always
check the git mailing list.

P.P.S. Since I don't have the original message in my mailbox, I am 
trying something weird to send this message with a correct in-reply-to 
header. I something ends up screwed up, I apologize.

-- 
Duy
