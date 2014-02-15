From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Fri, 14 Feb 2014 16:50:28 -0800
Message-ID: <CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
	<CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
	<CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zachary Turner <zturner@chromium.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 01:50:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WETSw-0005x8-N4
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 01:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbaBOAuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 19:50:32 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36330 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbaBOAu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 19:50:29 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so14857957obc.10
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 16:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KUiMjuQpj+OTS34zEBOwUqe1iOjSaPUsPBm/H4A7dCM=;
        b=O4mYxiJ+IoNBu2ywPfTo8H0HpsIpg65zbWViCLBl+yyhqSWLnyWr5JSOgBww5v91Q7
         r9X8epA3n6hTgHe1N6Qqzi/yNd/urIfbpNEuQbDdnN3vMhVXyaXEijN+noMeBS51n5ov
         fQpfjDyVKbtxocmVAVrcDz98ezpIpPyRk3jCP6A6lNiFMfLWoUSP+aPBfBMl3sfbXA/z
         IK4UV9vXz6cOlEnZLDp1CTa7sp9xy/0yaESzTophB0+03DzX540XPO/tlfaM5xH8qI7H
         y/cSDXeJ0wzYfnHJMw/qsvAg7zlQ6KJU+90H0nGoywEMdYYGo50JsCrOGzEBtKxam6QR
         Hs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KUiMjuQpj+OTS34zEBOwUqe1iOjSaPUsPBm/H4A7dCM=;
        b=ESe+rQucl86aEU4ndiBVLdI6Jz7lpb2IGcCEtAJalcEzpyBfjY3svN+irqmCpgG4K7
         S8e8ZB53r7JubWT6X/TzHKtXfqoT5mXN48Lzt4hndrDwCHdagt01r4weixmzWnY1V6LH
         uYXnwUQEqZNP3Oz1jRTQ2TWzLzl+38rJjdkk4LAv1o3ZRDR+viT4toTdox5yOPn/w649
         jlGJhiK229hufOYJqPljdssjFyPJCtQv1/4fs97lJC5VI8Bi0bGj5LfDWA/kd5rZagop
         V4QAEKexjBtw/18fGDqpuZYvW5+b/ME+0pOEhJM5SVnL8W3rYtly8VpDOfC55+Knn2BJ
         8nlQ==
X-Gm-Message-State: ALoCoQlkiiAu6+QF0iah4uaQ6Rrw3IEE2DtEJ1K8GUjhW0/lRDYNcHy0vr5JQWQLIyyJVqda6smRxMrsxkrvvDOxJ1c2UV3XsrBoTXfErXBGiFn27k3ObicgLPqIXN5EVhNCH1IA/9FwN9h0BXNDidYs2/KICzHaZxvV20zsZM1cTmrwULj5AO8eH1bUVxJZ7j1IrJfuQhOs
X-Received: by 10.182.29.33 with SMTP id g1mr4170723obh.59.1392425428747; Fri,
 14 Feb 2014 16:50:28 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Fri, 14 Feb 2014 16:50:28 -0800 (PST)
In-Reply-To: <CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242167>

On Fri, Feb 14, 2014 at 4:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Feb 15, 2014 at 2:16 AM, Zachary Turner <zturner@chromium.org> wrote:
>> (Gah, sorry if you're receiving multiple emails to your personal
>> addresses, I need to get used to manually setting Plain-text mode
>> every time I send a message).
>>
>> For the mixed read, we wouldn't be looking for another caller of
>> pread() (since it doesn't care what the file pointer is), but instead
>> a caller of read() or lseek() (since those do depend on the current
>> file pointer).  In index-pack.c, I see two possible culprits:
>>
>> 1) A call to xread() from inside fill()
>> 2) A call to lseek in parse_pack_objects()
>>
>> Do you think these could be related?  If so, maybe that opens up some
>> other solutions?
>
> For index-pack alone, what's wrong with open one file handle per thread?

Nothing wrong with that, except that it would mean either using
thread-local storage (which the code doesn't currently use); or
plumbing pack_fd through the call stack, which doesn't sound very fun.

Stefan

> --
> Duy
