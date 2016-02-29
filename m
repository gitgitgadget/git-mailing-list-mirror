From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/7] notes copy --stdin: read lines with strbuf_getline()
Date: Mon, 29 Feb 2016 14:48:18 -0500
Message-ID: <CAPig+cQwhPvpGmiOa-KJzeDsEJZVp9KJMd2Oj_RjDTq6aEtWXA@mail.gmail.com>
References: <56D401C2.8020100@moritzneeb.de>
	<56D40314.7040608@moritzneeb.de>
	<CAPig+cSptQr21QMOJmxT4RPVR3r3zkEQ2TkTU8RoaJfo7=KChw@mail.gmail.com>
	<56D49B7A.2060601@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:48:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTnv-0007l0-TK
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbcB2TsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:48:23 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36188 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbcB2TsV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:48:21 -0500
Received: by mail-vk0-f67.google.com with SMTP id k196so10119784vka.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=8eoF6QDIm4sI34IFgmiRzT/+TPeQYTYW3z3sLYNQCJ0=;
        b=fygVEFhMpJYYzfitFVFpjRg4B+72BRnFr3QZYIP+0TeTGXvOuxvI3ibiu48vZNuPeW
         E/zGeajVHUT6uKrfaMQ6e+otrcl3o2x1H1gRzH6Rgjn0vs8kypNWih74dRfztfINBNDb
         pPzcBPCh6HTwCVFy8mc7dMVvZQ+92FGxha9l/ig4bG8je+TOcEICqehw6H36JJ0wj3Lr
         i9LMR0SiwngHgdoXFhm/Ic5rVWu8vbKRaT4DlMIZqUQpzaEa6YgBbwEHinxeBg2hHrSr
         y9ZebF//JYiYFFDz4uHBLmWS4pcf6YLvG1PBSpdQo/2ZwUVBsfj9Re9CuRy59qg19IrB
         XjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8eoF6QDIm4sI34IFgmiRzT/+TPeQYTYW3z3sLYNQCJ0=;
        b=iYT5564vGEJuiuCRt7vbHbEfkAoobYRrQVqyOvMcaUwNUw6VMhZRNgfn2y6Z4z+xix
         HbcahygDwqdATQU5hEOtA9r34wE+zJqVJ7V4DrP2w/PbKcxR6QG0hsrUyX3EYhQsHIWO
         HVQmxFsbIuGNiclDlQZsvUFFS7JXn/anJ0dNNv0HbEFje0f+lYEPoHDU15VOd2ZCo+b6
         RGcmqPv8oY4l9YTNaCu8xKNPrhYWr4CZ459CnSa5arg8uQm3jSTVwjkWyT280eTZj09Q
         WlsMmOzCNPT3+ggXY09a0MUxi4AZyF/dG9zlKsip+Q82CGZ5x6FTM08gHkQz8V+fl3jI
         oJFg==
X-Gm-Message-State: AD7BkJK/oIK6PtvocgOIDvQJiLy0OYR+18jFt4Gl8zmvH/s4H3EQRrC6hr1Tt+bazPC2kSunqzEZLBUn3aCrXg==
X-Received: by 10.31.182.143 with SMTP id g137mr12516779vkf.45.1456775298923;
 Mon, 29 Feb 2016 11:48:18 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 29 Feb 2016 11:48:18 -0800 (PST)
In-Reply-To: <56D49B7A.2060601@moritzneeb.de>
X-Google-Sender-Auth: P8i0ACh6cSaNtFtop-Qzx9daZY0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287894>

On Mon, Feb 29, 2016 at 2:26 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
> On 02/29/2016 07:19 PM, Eric Sunshine wrote:
>> If you do elect to keep things the way they are, then (as mentioned in
>> my v2 review) it would be helpful for the above paragraph to explain
>> that strbuf_split() leave the "terminator" on the split elements, thus
>> clarifying why the rtrim() of split[0] is still needed.
>
> Yes I would rather leave it like it is. I have the feeling it is
> unmotivated to remove the rtrim of split[1] in the patch 5/7, because it
> is directly related to the strbuf_getline_lf() replacement. Thats's what
> I was trying to explain in the 2nd paragraph of the commit message.
>
> First I was following your review, but then I had to add a paragraph in
> patch 5/7 that says something like "because the effect of the previous
> patch is that there is not a CR anymore, we can now safely remove
> rtrim() split[1]."
>
> You're right, maybe I should add a comment about why I left rtrim() of
> split[0] to make it more obvious. I thought that would get clear by
> looking at the context, i.e. patch 5/7, where it is explained (by you,
> thanks for that), that strbuf_split leave this space. Is the assumption,
> that those two patches are most times viewed in context wrong?

I was more concerned about someone reading patch 4/7 in isolation and
not consulting 5/7 (which might happen during a "blame" session, but
it's a very minor point, not worth a re-roll if you and Junio are
happy with the series as is.
