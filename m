From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Fri, 11 Mar 2016 07:47:34 +0700
Message-ID: <CACsJy8BRhuSOs96fonjBJ0ok6JZJ3CwLkDPCP_9QQdROZUVh8w@mail.gmail.com>
References: <20160307221539.GA24034@sigill.intra.peff.net> <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net> <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net> <20160310122020.GA24007@lanh>
 <20160310211052.GC30595@sigill.intra.peff.net> <xmqqbn6mdnyn.fsf@gitster.mtv.corp.google.com>
 <20160310214042.GB32608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 01:48:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeBFV-00069G-Up
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 01:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176AbcCKAsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 19:48:10 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34065 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933243AbcCKAsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 19:48:06 -0500
Received: by mail-lb0-f174.google.com with SMTP id xr8so130545178lbb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=orJcnbnJS2hLesRq04J9xpAPX8qBDLtNvjTdlJJBItU=;
        b=QxnK/jb8R2wompAvVgS4kIj/hLgq9SG0jlcC08TnPRdwcyIl14ZejZ6qitxJwIy7uc
         w6HC3QRgqWh6JTbfA5SOeTPUz/9GeGV4h3vJUxtn2tdHWZQp+CTB1FNeYsbKqBeIIMTR
         IIq+jToY26xI/9IsKtBA8Z3F9/D5eQcQrUxXc7inOg9XVGWsYfwKuyUa7QRisvraKCLZ
         uiW5LauhceWXCwmkt0R/T7c9qOQ3DiBlWHiuFeRcZ6QIjRiGenT+6sesuD8ahQX1sYcN
         jzkxQgUeKvaoIejXWPB9Sofwjyl49HlOQwcCC0u2M4B6TgefulwM2/QnGNsPhy/AYEtp
         eyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=orJcnbnJS2hLesRq04J9xpAPX8qBDLtNvjTdlJJBItU=;
        b=l1i+9C6b+5NA9eJ1rR+kVtIdBZmBDcBywDJ5J8+G8riPhzRbldRn6IC2OHKG5WIQpE
         AS3EB4/QbeBp4nLEhucNCrHhktlUbS+jeuOMHrf916SidLRa9MT5hF2p1xH2OjRV89AP
         aSoUB1eDNHaCTelEj7ZSgby9t+bm5g75O6ui1nghhGDaXEiYRFM3daFTpaWhIwIPvjCn
         Bl/vUocZExAiKkvemFKJDLvDG2VaV5KDTT/YKbDR8W7cvyTK+Y8GIvkIw4Z2Y2TV5qnZ
         pGdLwSUjPiQCesTr7kylN75Fa4YfxXU6t04cdBzma9b1EO3dPbNYiYfM0lfiFbeJdUOu
         gUkA==
X-Gm-Message-State: AD7BkJJAVkWo3VGtamAmVu3F0YfE9k7LiIk+llUvH/+yVTGhS8rWgeOCfvbCFrkYBbRl1jtjJpWxha67Zoxssg==
X-Received: by 10.112.171.163 with SMTP id av3mr2210310lbc.145.1457657284269;
 Thu, 10 Mar 2016 16:48:04 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 16:47:34 -0800 (PST)
In-Reply-To: <20160310214042.GB32608@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288666>

On Fri, Mar 11, 2016 at 4:40 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 10, 2016 at 01:26:08PM -0800, Junio C Hamano wrote:
>
>> > IMHO, that is the right thing. They asked for "C" as a shallow cut-off
>> > point, so anything that is a parent of "C" should be omitted as shallow,
>> > too. It has nothing to do with the numeric depth, which was just the
>> > starting point for generating the shallow cutoffs.
>>
>> I think that is the right mental model.  The statement that "C and D
>> are current cut points" does not make much sense.  As you cannot
>> rewrite parents of commits after the fact, you cannot construct a
>> case like "when the shallow clone originally was made, two histories
>> were forked long time before B and D, and the cloner ended up with C
>> and D as the cutoff point, but now that we have the ancestry linkage
>> between B and D (and C and E), we need to make E a new cutoff".  The
>> original "shallow" implementation does not store "starting point +
>> number of depth" and instead translates that to the cut-off point
>> for this exact reason.

Well, assume again that F and G are ref heads, and their respective
distance to C and D are the same (like the below graph), then "fetch
--deptch=<distance>" can mark C and D as shallow cut points because
--depth traverses from refs until the distance is met, it does not do
total exclusion ^C like rev-list.

       --- B ---- C ---- H ---- F
          /      /
     --- D ---- E ---- G


> OK, good. Now there are at least two of us who view it that way. :)

But going that direction just gives me more headache. If you two are
ok with this and nobody else complains, I'm ok too :-D I guess it's a
corner case anyway that's probably hard to occur in practice.

>> > So what next? I think there's some protocol work here, and I think the
>> > overall design of that needs to be considered alongside the other
>> > "deepen" options your topic in pu adds (and of which I'm largely
>> > ignorant). Does this sufficiently interest you to pick up and roll into
>> > your other shallow work?
>>
>> I can pick it up if you are busy with other stuff. But I'm also having
>> a couple other topics at the moment, so it may not progress very fast.
>
> Thanks. I don't think it is too urgent; it has been that way for a
> while. I certainly have plenty of other things to work on, but mostly I
> just feel a bit out of my depth on the shallow stuff. I haven't given it
> any real thought, and you obviously have.

More people understanding this code is always better though. But don't
worry I'll take care of this.

>> > Yeah, we definitely need an extension. I'm not sure if the extension
>> > should be "I know about spontaneous shallow/deepen responses; it's OK to
>> > send them to me" or "I want you to include the shallow points I send as
>> > boundary cutoffs for further shallow-ing of newly fetched history".
>> >
>> > They amount to the same thing when implementing _this_ feature, but the
>> > latter leaves us room in the future for a client to say "sure, I
>> > understand your spontaneous responses, but I explicitly _don't_ want you
>> > to do the boundary computation". I don't know if that is useful or not,
>> > but it might not hurt to have later on (and by adding it now, it "just
>> > works" later on with older servers/clients).
>>
>> I am not sure what distinction you are worried about.  An updated
>> client that is capable of saying "you may give shallow/deepen
>> responses to me" can optionally be told not to say it to the server,
>> and that is equivalent to saying "I don't want you to send them", no?
>
> Mostly, I wondered if we would need to send spontaneous shallow lines
> for any other cases, and the client would not be able to say "I
> understand them and want them in case A, but not in case B".
>
> I do not have any case A in mind; it was just a general sense of "let's
> make feature flags as specific as possible to avoid painting ourselves
> into a corner". I'm OK with implementing it either way.

Another note to myself is, we do not want these spontaneous cutoff
requests to cut client's history even shorter (possibly by accident
because of buggy servers). As long as they are about sealing commits
that lead to non-existing objects, i think it's ok to make it a
general feature.
-- 
Duy
