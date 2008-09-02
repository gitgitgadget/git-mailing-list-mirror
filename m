From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Git-aware HTTP transport
Date: Tue, 2 Sep 2008 11:20:31 -0700
Message-ID: <905315640809021120j13ee5f5t21e1d2618b63568c@mail.gmail.com>
References: <20080826172648.GK26523@spearce.org>
	 <20080828035018.GA10010@spearce.org>
	 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
	 <20080828145706.GB21072@spearce.org>
	 <7vwsi0a2op.fsf@gitster.siamese.dyndns.org>
	 <48B784FD.3080005@zytor.com>
	 <7vej488gcu.fsf@gitster.siamese.dyndns.org>
	 <20080829173954.GG7403@spearce.org>
	 <905315640809010905w20f4ceeo43e7b0a14abd48a3@mail.gmail.com>
	 <20080902060608.GG13248@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaafF-0005X8-ET
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 20:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYIBSae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYIBSae
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 14:30:34 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:8745 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbYIBSad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 14:30:33 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1126446ika.5
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=kby0I7CQI8IdW9EucVmduIt8d8cCUvYN7FALKOmgItI=;
        b=iUIGpLstx7ktGZDWqfZlft+gVeg5kJcd5lwvY7y913xLo0vBJK5aCocc39x7szOLf7
         EjtiyrLGWLtw+dnHU3xl0POub1BnHGtViWZyVK8nMek/ITnjOOW+qTtYMHgc3Jt5F19i
         jEI8wJFPDRqpwozVK1H2H0IiYoJJdHEmaLWOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Nl1n09RjiAu3vRJfFGmxwrhH4qqhbWqCzqZb8NclIWRQmKJaI0VWbYocrWWUAGabF+
         YU32CMN7OTJqbAu3Yt3CIms+68xiMDJOe7DpG0eNddL39l7iQQIhGSj783hr5birugTJ
         dGUaH8X6cHux2qNrxgYpj0JBfN5jiMnYOHd90=
Received: by 10.210.27.20 with SMTP id a20mr8655371eba.119.1220379631267;
        Tue, 02 Sep 2008 11:20:31 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Tue, 2 Sep 2008 11:20:31 -0700 (PDT)
In-Reply-To: <20080902060608.GG13248@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 95a2140f8f40ac6a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94689>

On Mon, Sep 1, 2008 at 11:06 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> What does the server do after a 000cgive-up ?  Does the server send
>> back a complete pack (like a new clone) or if not, how does clone work
>> over smart http?
>
> When the server receives a "give-up" it needs to create a pack
> based on "git rev-list --objects-boundary $WANT --not $COMMON".
> If the set $COMMON is non-empty then its a partial pack; if $COMMON
> is empty then its a full clone.  This is what the native protocol
> does when the client gives up.

OK, that makes sense now.

>> Does that mean that if I fall more than 256 commits
>> behind, I have to redownload the whole repo?
>
> You are thinking the wrong way.  If you have more than 256 commits
> that the other side doesn't have you may give up too early.
> For that to be true you need to create 256 commits locally that
> aren't on the remote peer and whose timestamps are all ahead of
> the commits you last fetched from the remote peer.
>
> Yes, it can happen.  But its less likely than you think because
> we're talking about you doing 256 commits worth of development and
> not picking up any new commits from remote peers in the middle of
> that time period.  Get just one and it resets the counter back to
> 0 and allows it to try another 256 commits before giving up.
>
> I should amend this section to talk about what giving up here
> really means.  If we have nothing sent in common yet or maybe
> very little sent in common we may have existing remote refs tied
> to this URL in .git/config that can send, and we may have one or
> more annotated tags that we know for a fact are in common as both
> peers have the same tag name pointing to the same tag object.
>
> A smart(er) client might try to toss some recently dated annotated
> tags at the server before throwing a give-up if it would otherwise
> throw a give-up.  Its likely to narrow the result set, and doesn't
> hurt if it doesn't.

Yes, throwing in tags and remotes as a last resort sounds like a good idea.

>> So again, if the client falls more than 1000 commits behind (not hard
>> to do for example during the linux merge window), and then the client
>> WANTs HEAD^1001, what happens?  Does the get nothing from the server,
>> or does the client essentially reclone, or I am missing something?
>
> Oh, this is a live-lock condition.  If the client grabs the list of
> refs from the server, then has to wait 100 ms to get back to the
> server and start upload-pack (due to latency) and in that 100ms
> window Linus shoves a 1001 commit merge into his tree then yes,
> the server may abort and tell the client "error invalid want".

Ahh, now I get it.  Somehow I forgot that the WANTs were only boundary
commits and not a list of all the commits that the client wants.

On Mon, Sep 1, 2008 at 11:13 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>> Shawn O. Pearce wrote:
>>>
>>> Correct.  Today _none_ of the transport protocols allow the server
>>> to force the client to use some sort of reference repository for an
>>> initial clone.  There are likely two reasons for this:
>>>
>>>  *) Its a lot simpler to program to just get everything from
>>>     one location.
>>>
>>>  *) If you really are forking an open source project then in
>>>     some cases you may need to distribute the full source,
>>>      not your delta.  You may just as well distribute the full
>>>      source and call it a day.
>>>
>>
>> 3) it encourages single points of failure.
>
> Or bad network usage, as I pointed out later about an India user
> unknowingly being forced into a US based mirror when another was
> closer to them.
>
> I didn't make it clear in my response but I'm really against our
> protocol having this sort of explicit redirect.  I'd rather put a
> requirement in that says "Unless you have X,Y,Z in common with me
> (directly or indirectly) I'm just not going to give you a pack".

OK, this all makes sense. http:// and git:// are probably the wrong
protocols to reduce bandwidth for the server for new clones.  Long
term, maybe gittorrent will be the right solution...

Thanks,
Tarmigan
