From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 5/6] transport-helper.c::push_refs(): ignore
 helper-reported status if ref is not to be pushed
Date: Thu, 7 Jan 2010 05:41:20 +0800
Message-ID: <20100107054120.84972788.rctay89@gmail.com>
References: <20091224154352.ecefd242.rctay89@gmail.com>
	<20091224154258.08b4fe44.rctay89@gmail.com>
	<20091224154158.15ba580f.rctay89@gmail.com>
	<20091224154057.33611ae7.rctay89@gmail.com>
	<20091224154005.a642c8ec.rctay89@gmail.com>
	<20091224154445.ad4b7a01.rctay89@gmail.com>
	<20100105063253.GA19368@coredump.intra.peff.net>
	<20100105180113.6e0572dc.rctay89@gmail.com>
	<20100106120456.GA7221@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 22:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSddR-0004m7-8i
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 22:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732Ab0AFVlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296Ab0AFVlk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 16:41:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48130 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab0AFVlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 16:41:39 -0500
Received: by bwz27 with SMTP id 27so11032630bwz.21
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Tc6FwwkAK3lxthwzO2XEHRENmgQHEikz7lZZHSOv920=;
        b=AfHdqhagLyPe/IyX+m58YmU5UVZfStrrYXduI4EuVxBYcaWnCk0qbRRPbkGlP03X3L
         I0b2aZTds1MzR9yFbHO/YttvNKJaIP8924CXeNFOdbbtt+YfvreSfEEWnOOmmqizh1Sl
         yxyyz/jOLLAaPKIricT1N/HHEmmzJOweaG2V8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=K1qZTRN3AL6MbOoMMbuds3jdxF669iYOnLHb4J+e/8lNqbQnNwoBvc79UXVmnBjrdz
         C6J0QvtYviClllgEgPfiQNqLIKokLQlvmZ9izAIHL+cTKWBX86TF3589FgBxHQ+bAKex
         l1QTmEsc+HL6ODiVhGC/XuXTPZ53hxVrDAGQU=
Received: by 10.204.5.66 with SMTP id 2mr4800202bku.198.1262814097042;
        Wed, 06 Jan 2010 13:41:37 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 15sm6810591bwz.0.2010.01.06.13.41.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 13:41:36 -0800 (PST)
In-Reply-To: <20100106120456.GA7221@coredump.intra.peff.net>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136300>

Hi,

On Wed, Jan 6, 2010 at 8:04 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 05, 2010 at 06:01:13PM +0800, Tay Ray Chuan wrote:
> 
> > > It seems like this should be checking for REF_STATUS_NONE explicitly
> > > instead of trying to enumerate the reasons we might not have tried to
> > > push. Shouldn't helpers _only_ be pushing REF_STATUS_NONE refs?
> > >
> > > I think right now the two cases are equivalent, since non-ff and
> > > uptodate are the only two states set before the helper is invoked. But
> > > we have discussed in the past (and I still have a patch floating around
> > > for) a REF_STATUS_REWIND which would treat strict rewinds differently
> > > (silently ignoring them instead of making an error). Explicitly checking
> > > REF_STATUS_NONE future-proofs against new states being added.
> > 
> > I'm not really sure if this is true (ie. that if status is not non-ff
> > or uptodate, then it is REF_STATUS_NONE), but we could step around this
> 
> Well, consider it this way. If it's _not_ REF_STATUS_NONE, then what is
> it, and what does it mean to be overwriting it?

Ok, I'll take your suggestion from your previous email and do this:

@@ -429,8 +429,16 @@ static int push_refs(struct transport *transport,
 			continue;
 		}

-		ref->status = status;
-		ref->remote_status = msg;
+		if (ref->status == REF_STATUS_NONE) {
+			ref->status = status;
+			ref->remote_status = msg;
+		} else {
+			/*
+			 * Earlier, the ref was marked not to be pushed, so ignore what
+			 * the remote helper said about the ref.
+			 */
+			continue;
+		}
 	}
 	strbuf_release(&buf);
 	return 0;

Going by this principle (only refs with status of none will be pushed),
I think I should also squash the below into patch 3 (refactor ref status
logic for pushing):

@@ -336,11 +336,10 @@ static int push_refs(struct transport *transport,
 			continue;
 
 		switch (ref->status) {
-		case REF_STATUS_REJECT_NONFASTFORWARD:
-		case REF_STATUS_UPTODATE:
-			continue;
+		case REF_STATUS_NONE:
+			; /* carry on with pushing */
 		default:
-			; /* do nothing */
+			continue;
 		}
 
 		if (force_all)

> Maybe I am misunderstanding the problem the patch is addressing, but the
> point of these REF_STATUS feels was to act as a small state machine.
> Everything starts as NONE, and then:
> 
>   - we compare locally against remote refs. We may transition:
>       NONE -> UPTODATE
>       NONE -> REJECT_NONFASTFORWARD
>       NONE -> REJECT_NODELETE
> 
>   - we send the push list
>       NONE -> EXPECTING_REPORT (if the remote supports individual status)
>       NONE -> OK (otherwise)
>
>   - we get back status responses
>       EXPECTING_REPORT -> OK
>       EXPECTING_REPORT -> REMOTE_REJECT
> 
> I haven't looked closely at the new transport helper code, but I would
> think it should stick more or less to those transitions. The exception
> would be that some transports don't necessarily handle EXPECTING_REPORT
> in the same way, and may transition directly from NONE to
> OK/REMOTE_REJECT.

minor nit: yes, this may differ from transport-to-transport, but
EXPECTING_REPORT is not used at all in the top-level transport (the
level above the helper).

There's also something I'd like to point out for accuracy: it's that
this sequence of transitions occur at two levels, separately: one at
the top-level transport/transport-helper, and another at the helper.

So, for certain non-ff refs (the type this patch series is looking at),
the sequence of state transitions stops and doesn't continue to step 2
in the top-level transport (sending the push list); but separately, in
the helper, the ref goes through another sequence of state transitions.

What this patch touches is the part in the top-level transport that
syncs the ref status between the helper and the top-level transport: do
we take and present to the user what the helper has done, or not?

Regarding this point, I now think that we should ignore the
helper-reported status only if that status is none, and continue
updating the ref status in the top-level transport if the helper did
push successfully/failed, even if we didn't tell it to push:

@@ -429,7 +429,7 @@ static int push_refs(struct transport *transport,

		ref->status = status;
		ref->remote_status = msg;
-		if (ref->status == REF_STATUS_NONE) {
+		if (ref->status == REF_STATUS_NONE && status == REF_STATUS_NONE) {
			ref->status = status;
			ref->remote_status = msg;
		} else {

> So offhand, I would say that your list should also probably include
> REJECT_NODELETE. However, I think that status is just for old servers
> which didn't support the delete-refs protocol extension. So presumably
> that is none of the new helpers, as they all post-date the addition of
> that feature by quite a few years.

You're right, AFAIK, for the smart http protocol; I don't think it
supports NODELETE.

> > by introducing a property, say, ref->should_push, that is set to 1,
> > after all the vetting has been carried out and just before we talk to
> > the server.
> 
> I'd rather not introduce new state. The point of the status flag was to
> encapsulate all of that information, and a new state variable just seems
> like introducing extra complexity. If we are not in the NONE state, I
> don't see why we would tell the helper about a ref at all.

Noted.

-- 
Cheers,
Ray Chuan
