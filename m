From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/blame: destroy initialized commit_info only
Date: Mon, 9 Feb 2015 16:33:17 -0500
Message-ID: <CAPig+cQAmYzzVF5+0j6AgcpEsi6SOVkXyqw4uOMCUjExPSLz_w@mail.gmail.com>
References: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Dilyan Palauzov <dilyan.palauzov@aegee.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:33:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvxK-0002hY-PH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761357AbbBIVdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:33:19 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:52798 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761294AbbBIVdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:33:18 -0500
Received: by mail-yk0-f178.google.com with SMTP id q200so12588785ykb.9
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Jzt2PjuSy0aA8KDgdRr81zVBtcqRy3zXPPj7vc0xvT0=;
        b=Iwv2eBSk+NW6K5MMOF0bb3eZo1peyT7eSbJ6EEyPR5ajeI3z777MCfK/5xWmIsj4ai
         dTBv4RfH1fX0eTmREr/44b1Zy84GrqybEzOb+wnASGNdt5XbA+ohLJO1XTAu5vfGXl8Z
         Sth88Kb1xL/W//CP3GhkZ2VLlQ23AYUV3UKDkHramKnCJORiLz80+ckKKm46cTGVW/8y
         g85xR4i3156aed8SDy8pZXJ8N1g4rpWeT5/VEuwZh+vCfgbj/B8akxRi7ci6/2bbBydL
         9wWmLvMYgigB9CVi4sQfZa1ShPbyarPZZY4jO4K7UpheXa4lddiHBuDcaKzv/Fy8tCt5
         DIRQ==
X-Received: by 10.170.136.83 with SMTP id d80mr6315185ykc.2.1423517597652;
 Mon, 09 Feb 2015 13:33:17 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 9 Feb 2015 13:33:17 -0800 (PST)
In-Reply-To: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: 9LOUUFfok2woI4-Vy7E9TmYCmRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263604>

On Mon, Feb 9, 2015 at 4:28 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Since ea02ffa3 (mailmap: simplify map_user() interface, 2013-01-05),
> find_alignment() has been invoking commit_info_destroy() on an
> uninitialized auto 'struct commit_info' (when METAINFO_SHOWN is not
> set). commit_info_destroy() calls strbuf_release() for each of

s/each of/each/

...despite several proof-reads (sigh).

> 'commit_info' strbuf member, which randomly invokes free() on whatever
> random stack value happens to be reside in strbuf.buf, thus leading to
> periodic crashes.
>
> Reported-by: Dilyan Palauzov <dilyan.palauzov@aegee.org>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
