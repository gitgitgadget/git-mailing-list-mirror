From: Michael Heemskerk <mheemskerk@atlassian.com>
Subject: Fwd: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Sun, 21 Apr 2013 11:08:27 +1000
Message-ID: <CAJDSCnN_Va7r2BMLYSbsSzoUNs6YfYfihatb-u4jJw25w8qvZg@mail.gmail.com>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
	<CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
	<7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
	<CACsJy8CT8r7ebE_q5ET+oicTY0NM4LAt1B61xwqfL8tLKc-4OA@mail.gmail.com>
	<CAJDSCnPt=wgT0UQirahvTyen9w_v4XTn0ABHJVCLeKLmC8BsHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 03:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTilo-0004Zz-Uj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 03:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab3DUBI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 21:08:29 -0400
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:53999 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750829Ab3DUBI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 21:08:28 -0400
Received: from mail-ye0-f197.google.com ([209.85.213.197]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUXM8DGHh+c63mK5KRkQVK6SW8pFDK9Q6@postini.com; Sat, 20 Apr 2013 18:08:28 PDT
Received: by mail-ye0-f197.google.com with SMTP id q9so840007yen.4
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 18:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-received:in-reply-to:references:date
         :message-id:subject:from:to:content-type:x-gm-message-state;
        bh=+dM/MKke77u+THpfIQJsGupOzCWLVzKo9kpr/CJbglU=;
        b=NMd8jE3NZQjj27NlrNjzvOREf85XOBxoEJbzi9/zqZ71fCmT2lir4CnGJMODUBFfoi
         FhTs0bq6Osakwr4rGCaVGiiHrrZazmbakGirmZ9IfCOffjyCxV8TDrv6K0vQf21KMOwY
         IWVJDgvFZoSY36wnbpfOO10FpYPz45LT3xL2Kl3LuFRHbzpf/k8VZCy5eGe9iDe91QUI
         tL9X3s5VuRaZ2Z48z/ZXk2ZYzWeIEouEHlh8/k0De4/Z3zfIPPnP++XjyCpDMd9qMS0F
         rK5pzr6dADzAnG8OcdnUmldQlIxpBrqkqbpBpziVyHntPiKY9AmfVumhpZnyW8kHXTmU
         pVgA==
X-Received: by 10.220.147.12 with SMTP id j12mr15547962vcv.59.1366506507625;
        Sat, 20 Apr 2013 18:08:27 -0700 (PDT)
X-Received: by 10.220.147.12 with SMTP id j12mr15547958vcv.59.1366506507528;
 Sat, 20 Apr 2013 18:08:27 -0700 (PDT)
Received: by 10.58.8.76 with HTTP; Sat, 20 Apr 2013 18:08:27 -0700 (PDT)
In-Reply-To: <CAJDSCnPt=wgT0UQirahvTyen9w_v4XTn0ABHJVCLeKLmC8BsHQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQldcomUA7arxMGI1ICz6/xGs2svsvmibwtLkd1lScRcVBmOno05rVgamTnrTcjVppYoiOQgRLjVkk4BKZ98z8bukKZSf5jh2jHwTYjZVLJ8LhI1YJG4jdp0C87Ue9nJhIYy+rSxhXGYIGwciAq+v8JCRutWyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221885>

Re-sent to the mailing list because the original was bounced (HTML subpart):

On 21 April 2013 09:56, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sun, Apr 21, 2013 at 6:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Duy Nguyen <pclouds@gmail.com> writes:
> > But the shallow list is also used to compute the updated boundary
> > (i.e. "this client does not have a valid history behind these
> > commits")?  When we know their current shallow boundary, after
> > sending history that crosses that boundary, we can tell them "before
> > this fetch, you did not have any history behind this commit, but we
> > know that you now have a bit more. Update your record with these new
> > boundaries. You still do not have any history behind these commits."
> > That is how deepening works.
> >
> > When you receive a shallow boundary unknown to you, it might not
> > hurt if you keep it and parrot it at the end, so that the fetcher
> > will still remember that it does not have any history behind the
> > commit.  There may be reasons why doing so is not sufficient and we
> > have to reject clients whose history is truncated at a place unknown
> > to us.
> >
> > You would declare "now you have everything behind that unknown
> > shallow boundary", if you ignore an unknown shallow boundary and do
> > not send it back.
> >
> > That sounds ourright wrong to me. You simply do not know enough to
> > make such a declaration.
>
> It's a good point. But I think the receiver does not rely solely on
> "shallow " lines from the sender to create new shallow file. If it
> receives "shallow " line, it registers the received sha-1 as a cut
> point. If it receives "unshallow " line, it unregisters. If it
> receives neither, the current registered cutpoints in memory are
> simply written back to disk. So not sending it back should not be a
> big problem (at least for C Git).


With the patch applied, the server ignores the shallow line mentioned by
the server and will not send a "shallow" or "unshallow" line for it back to
the client. This scenario is not explicitly described in pack-protocol.txt
but I'd be happy to add it to. I'll also update the comment to cover this
aspect.

As Duy pointed out, it doesn't cause problems in the current C Git
implementation: the client adds a new entry to the shallow file for each
"shallow" line it receives from the server and removes an entry for each
"unshallow" line it receives. Any current shallow object that is not
mentioned by the server is still marked as shallow after the fetch.

I think that's how it should be: it should be the client's
responsibility to track
the list of objects it only has in shallow form. It should not rely on
the server
to tell it what that list is. Again, an extra line or two in pack-protocol.txt
would help to clear this up.

In testing this patch, I also discovered that the shallow file is not updated
as part of a prune operation. Arguably, any pruned commits should also
be removed from the shallow file. I haven't included a fix for this in my
patch because it's an existing issue that is best fixed in a separate patch
(in progress).

>
> > I do not seem to find the patch you are responding to, so I do not
> > know how the patch handled the unshallowing part, but the impression
> > I got from reading the log message quoted is that the patch was not
> > even aware of the issue.
>
> I can't find it on gmane.org either. Patch quoted below.
>
> On Sat, Apr 20, 2013 at 8:05 PM, Michael Heemskerk
> <mheemskerk@atlassian.com> wrote:
> > diff --git a/Documentation/technical/pack-protocol.txt
> > b/Documentation/technical/pack-protocol.txt
> > index f1a51ed..b898e97 100644
> > --- a/Documentation/technical/pack-protocol.txt
> > +++ b/Documentation/technical/pack-protocol.txt
> > @@ -228,8 +228,7 @@ obtained through ref discovery.
> >  The client MUST write all obj-ids which it only has shallow copies
> >  of (meaning that it does not have the parents of a commit) as
> >  'shallow' lines so that the server is aware of the limitations of
> > -the client's history. Clients MUST NOT mention an obj-id which
> > -it does not know exists on the server.
> > +the client's history.
> >
> >  The client now sends the maximum commit history depth it wants for
> >  this transaction, which is the number of commits it wants from the
> > diff --git a/upload-pack.c b/upload-pack.c
> > index bfa6279..127e59a 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -592,7 +592,7 @@ static void receive_needs(void)
> >                                 die("invalid shallow line: %s", line);
> >                         object = parse_object(sha1);
> >                         if (!object)
> > -                               die("did not find object for %s", line);
> > +                               continue;
> >                         if (object->type != OBJ_COMMIT)
> >                                 die("invalid shallow object %s",
> > sha1_to_hex(sha1));
> >                         if (!(object->flags & CLIENT_SHALLOW)) {
> > --
> > 1.8.0.2
> >
> --
> Duy
