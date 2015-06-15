From: Brian Vandenberg <phantall@gmail.com>
Subject: Re: [PATCH] [RFC] Make git-update-ref invoke the update and
 post-update hooks
Date: Mon, 15 Jun 2015 14:58:35 -0600
Message-ID: <CAEJ-0i8mfabWoLivX_ZJHRJBYFftoENWmHw5__CGphK54oOpug@mail.gmail.com>
References: <CAEJ-0i-BB=5W-Ah3nkeLFCe5-4XW4CvYaDgdqv1mMp4UGF81qw@mail.gmail.com>
	<xmqqpp4w7mco.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:58:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bSs-0004IM-1G
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbFOU6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 16:58:38 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36648 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbFOU6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:58:36 -0400
Received: by ykaz81 with SMTP id z81so67035343yka.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KpJ+7mNbE+khfqNkkFK2yexWytkMW3RTYI8JbHfrhBU=;
        b=H1pzaKe/dc1pZJaKJ8EH1CL9ZogbHjU59kS0My74nMZeX0t2BuYcfLLzhVANReJ+SG
         efT5Nel8NVNU0UP8Y3mgXEu48udewmHL4Ge3ZOLxTo2t67ZtBvWOqrFRQJ7Tz3wwKM7C
         m9dnkaGR76clBPz14Ng8lnIzH5GeQMUlGzye5mU2e2vp5QQVZ7OTrGr/yjsTd/m3QQTL
         kKAl+slPTZGpEzf6a8iTvo0ykojzYCi0QT8oboA0VBWUPZTiqPBntblyQsvgIZmBPPkf
         8TUYMg/UigQ77S6PhqXnii3zAqSe43xrp8KG5sK7F1+QdcMLsoCXKIC5Mi1GxZZTkAwK
         t5/g==
X-Received: by 10.170.131.201 with SMTP id x192mr36279459ykb.118.1434401916052;
 Mon, 15 Jun 2015 13:58:36 -0700 (PDT)
Received: by 10.37.24.67 with HTTP; Mon, 15 Jun 2015 13:58:35 -0700 (PDT)
In-Reply-To: <xmqqpp4w7mco.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271728>

On Mon, Jun 15, 2015 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am ultra-doubtful at this point ;-)
>
> For one thing, update-ref is not a tool that is exclusive to
> receiving object transfer aka receive-pack, so it makes no sense for
> it to pay attention to post-update.

I was a little dubious about that as well, though I like the idea of
update-ref having a hook.

> Also it is a low-level plumbing; the policy issues should come at a
> level higher than that.  I.e. Porcelain scripts implemented using
> them as building blocks should be the ones that you do your policy,
> e.g.
>
>         if whatever logic you want to use in your policy says OK
>         then
>                 git update-ref ...args...
>         else
>                 echo >&2 "My policy does not like your arguments"
>                 exit 1
>         fi
>

In principle I agree, though telling people "you should use xyz
script" is one thing; in practice they're more likely to google "git
alter history" and eventually find an explanation for using
update-ref, completely bypassing any policy/protocol we put in place
for altering history on the master repo.

Would you be less doubtful about adding a lower-level hook for
update-ref?  Or in lieu of that, a config option that can affect the
behavior of its "-m" and "-d" options?

-Brian
