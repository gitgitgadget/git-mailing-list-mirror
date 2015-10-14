From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/10] ref-filter: add support for %(upstream:track,nobracket)
Date: Wed, 14 Oct 2015 11:42:55 +0530
Message-ID: <CAOLa=ZRuTLfRbc3hQ_3AKGD-Vj6v2VcXXVThG+oXptDkYCHo_w@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-9-git-send-email-Karthik.188@gmail.com> <CAOLa=ZRZszOqHqJfOHhFqa-XDZbrcPCuSdvM_zMEYHURv8kW_A@mail.gmail.com>
 <vpqeggy61ma.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:14:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmFK6-0000SH-HV
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 08:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbbJNGN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 02:13:28 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35407 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbJNGN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 02:13:27 -0400
Received: by vkha6 with SMTP id a6so23936523vkh.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q7QbjGCdIVykabfsEGAslBQTtERNI7GjSk2dH6sVu9A=;
        b=jJxFLf4gqhL/jawxetuf07Cr9t7w5Q0ZrdaB4DSH4jBuvoKdhyvV04hSkhUH5FbaR9
         lszzegPg8XhF1nyF0WsnbHZbtkGHpQgWg8P06HpB0qLuYC+XaGpKPC8SyPfsLl3TxSqF
         3J5TmFmwr+Udoeyo+14elIFsPw8HAPrENi5EBnPxAnu/YPramQ3icqXiKKxjHk8GyrbG
         1175ZspvdGksW4TXeg3LNJ3LgdJNnWU960OvokppkX8bqDW7DLd3+kEorKYAKssxZ4Cj
         KHwpc235lAwwEKvJfgcO4HKKYNksvX0AR8TBh9yYbY1wO+oMD5+ucaJqfeozg9Hi9gmo
         2iUQ==
X-Received: by 10.31.10.6 with SMTP id 6mr807482vkk.17.1444803204443; Tue, 13
 Oct 2015 23:13:24 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 13 Oct 2015 23:12:55 -0700 (PDT)
In-Reply-To: <vpqeggy61ma.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279562>

 Wed, Oct 14, 2015 at 12:24 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Yes, but I still think that this was a bad idea. If you want nobracket
> to apply to "track", then the syntax should be
> %(upstream:track=nobracket). I think the "nobracket" should apply to
> "upstream" (i.e. be global to the atom), hence
> %(upstream:nobracket,track) and %(upstream:track,nobracket) should both
> be accepted. Possibly %(upstream:<not track>,nobracket) could complain,
> but just ignoring "nobracket" in this case would make sense to me.
>

Oh okay, was thinking only WRT the "track" option.

> Special-casing the implementation of "nobracket" also means you're
> special-casing its user-visible behavior. And as a user, I hate it when
> the behavior is subtely different for things that look like each other
> (in this case, %(align:...) and %(upstream:...) ).
>

Makes sense, was just looking for opinions.

>> %(upstream:nobracket,track) to be supported then, I think we'll have
>> to change this whole layout and have the detection done up where we
>> locat "upstream" / "push", what would be a nice way to go around this?
>
> You mean, below
>
>                 else if (starts_with(name, "upstream")) {
>
> within populate_value()?
>
> I think it would, yes.
>

Yes, that's what I meant.

>> What I could think of:
>> 1. Do the cleanup that Junio and Matthieu suggested, where we
>> basically parse the
>> atoms and store them into a used_atom struct. I could either work on
>> those patches
>> before this and then rebase this on top.
>> 2. Let this be and come back on it when implementing the above series.
>> After reading Matthieu's and Junio's discussion, I lean towards the latter.
>
> Leaving it as-is does not fit in my arguments to do the refactoring
> later. It's not introducing "another instance of an existing pattern",
> but actually a new pattern.
>

I meant after changing whatever we discussed above.

-- 
Regards,
Karthik Nayak
