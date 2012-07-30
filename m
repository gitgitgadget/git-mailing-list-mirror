From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Mon, 30 Jul 2012 06:34:43 +0530
Message-ID: <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
	<CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
	<7vvch6uw89.fsf@alter.siamese.dyndns.org>
	<7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:04:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvePk-00071a-17
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab2G3BEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:04:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36123 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab2G3BEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 21:04:45 -0400
Received: by lbbgm6 with SMTP id gm6so3218585lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 18:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pOUy5nPMhtpKx+jbay/dvNCLL5Ze5BXIK0L365AtJrk=;
        b=O1mu/NJrT6czl+IYOwzTs/P4wzsCGRtBuZ607o8KitgDXl4gdRGeuTeG8krduSMqiF
         wy59eQCPUZm6XXPvwv7KuTO1FiyaZ9JZSYgya+dfns2aSFUJek6/X6J/1IjUxuM945MS
         uQ5A47E8km02BLBW2IZH18tTj/cN9aDWx3/Fc9IYHVOG7RtcWtXzX9+1O52midh2/WHX
         mAMN7q+/DZ1tWorg8n0YED5n+TVBITrcf/hqbVfVCNQhXXABFmgoWs/QLDx5QnzPq/SL
         92CcGYdZoZc1d3t4FaRw/bQ4JVnpznC9cG7dWBNvGZHAVkmXU82/GKJUf117DhUjWShf
         kr9A==
Received: by 10.112.103.135 with SMTP id fw7mr4531244lbb.25.1343610283513;
 Sun, 29 Jul 2012 18:04:43 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 18:04:43 -0700 (PDT)
In-Reply-To: <7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202513>

On Mon, Jul 30, 2012 at 3:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>
>>> Uggh, no.  Client-git should only talk to server-git.  It shouldn't be
>>> talking first to some *other* program (in this case gitolite), and
>>> then to to server-git.  That doesn't sound sane to me.
>>>
>>> You should wrap this whole thing around something else that does it in
>>> 3 steps.  Check, create if needed, then the actual git command you
>>> intend to run.  All this should be local to your environment, not
>>> rolled into git; it's far too specific to be rolled into git itself,
>>> if you ask me.
>>
>> Thanks for saving me from having to state an obvious sanity ;-)
>
> Having said all that, I am not fundamentally opposed to new features
> added to the git protocol.  The responses so far from me in this
> thread were primarily me reacting to (1) auto creation by gitolite
> is a bad example and (2) the proposal sounded, at least to me, that
> it wants to add random and uncontrolled interactions between the
> sides outside the defined protocol exchange (e.g. "pusher connects,
> pushee says what it has and what capabilities it supports, pusher
> says what it wants to update how and chooses what capabilities it
> wants to use in the exchange, sends the pack data, ..."), which is
> an unworkable idea.
>
> For people who do not understand how the git protocol works (the
> proposal that started this thread included), a bit of clarification
> on (2) may help.
>
> Long time ago, we did not have "report-status" capability (think of
> a "capability" as a "protocol extension").  The "git push" protocol
> exchange ended with the pusher sending the pack data and that was
> the end of conversation.
>
> But we realized that it would be beneficial for the pushee to be
> able to tell the pusher that the push failed at the protocol level,
> so that the "git push" program can exit with an error code.  The
> version of the "git push" program that was current at the time
> exited with success unconditionally, as long as all protocol
> exchange went well and all the pack data was sent successfully.  The
> program's flow was not expecting any response once the pack data
> started flowing from it to the pushee, so that is the only
> reasonable behaviour.
>
> So what did we do?  We added "report-status" capability to the
> capability suite, and made new versions of "receive-pack" program
> advertise it.  Existing versions of "git push" did not know about
> this capability, so they did not ask for it and pusher and pushee
> worked exactly as before.
>
> But that way, the new versions of "git push" can learn to ask for
> "report-status" capability to updated "receive-pack", and the new
> versions of "receive-pack", after receiving and processing the pack
> data stream, can send new messages the original protocol did not
> allow it to send to "git push".
>
> An important point to understand is that there is one more thing
> that is needed.  The updated "git push" that asks for "report-status"
> needed to learn how to interpret the new message and act on it.
>
> Another example in the same protocol was the addition of "sideband"
> capability.  Before that happened, there was no way to send the
> error stream from the pushee to the pusher.  Unlike "report-status"
> that happens at the very end, this actually changes the way how the
> remainder of the protocol exchange proceeds once it is activated.
>
> You could add a new capability that says "when in effect, both ends
> can write to and read from new sidebands 4 and 5 to communicate out
> of line", but that is not all that useful.  You need to make the
> updated programs to agree on what should happen to the main
> interaction when a new kind of communication is made out of band.
> For example, you may ask "do you really mean it [Y/n]?" to the
> client, pause the entire transaction until you hear Yes or No from
> the client, and you may even choose to do something different from
> the usual when the client says No, but you also need to update the
> client to behave differently after that, perhaps by defining a new
> conversation path in the protocol.  At that point, you would need to
> handle real and concrete definition of the extended protocol and the
> code on the both sides to support it _anyway_.
>
> For example, imagine that you want to let a new user interaction to
> verify the repository it is pushing to.  How would we do that with
> your "adding random interaction between the server and client"?
>
> The server end notices that the user is trying to push into one
> repository.  throws "Do you really mean to push into repository
> foo?"  Updated client that understands your "random interaction"
> extention is capable of show this message, pauses until the user
> says "Yes" or "No", and sends it back to the server end.  If the
> answer is "No", the client may want to say "No, the repository I
> really wanted to push into was not foo, but bar".
>
> How did the client _know_ the "Do you really mean" message from the
> server requires a Yes or No response in the above scenario?
>
> How did the client know, when saying "No", to ask the real URL of
> the repository to the end user, disconnect the current session with
> the server, and restart itself using the real URL of the repository?
>
> All of that need clearly defined new protocol exchange steps, state
> transitions, and new conditional and new codepaths to implement
> them.  It cannot be just "let's allow the server and the client to
> randomly exchange packets out of band".
>
> In short, I am not fundamentally opposed to protocol extension, as I
> said in my very first response.
>
> I however do not think allowing the server 'to communicate directly
> to the git user' (which was the phrase used in the original message
> that expressed the idea) is a good idea, at least for two reasons:
>
>  - because we already have a proven-to-work-well way to extend the
>    protocol via "capability"; and
>
>  - because doing so is not useful for the purpose of extending the
>    feature of the protocol,
>

As I may have said earlier, this interaction is far too site-specific
to be rolled into git itself.

How about a new hook instead?  A pre-pack-protocol hook that acts as
if it was called by the remote user as a command, and if it exit's
with 0, then the real pack protocol starts else it gets aborted.  Let
him do whatever he wants in there.  Arguments to the hook will be repo
name and command (git-upload-pack mainly).

>From the ssh stream point of view, he'd have full STDIN/OUT/ERR
available in this hook, but when the hook exits, the normal protocol
takes over (or the whole thing aborts).

Of course this will only work with ssh.  None of what Fredrik has so
far suggested would possibly work on smart http without even more
hacks, I think.

And even then, all we are doing is rolling into git something that he
can very easily do outside right now on his own environment if he
wishes to, using a shell script on each side.  (And therein lies a
more general rant for the future, but not now...!)

-- 
Sitaram
