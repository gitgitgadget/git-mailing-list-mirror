From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] Supporting non-blob notes
Date: Mon, 24 Feb 2014 14:08:06 +0100
Message-ID: <CALKQrgfqYxsCPvksDee=C2z9F7M5WKra4BX19Se-1gVF5TFCAg@mail.gmail.com>
References: <OF15344132.B289BF94-ONC1257C89.003921CB-C1257C89.003E8AF2@local>
	<897120266.591794599.1393237656293.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Yann Dirson <dirson@debian.org>
To: ydirson@free.fr
X-From: git-owner@vger.kernel.org Mon Feb 24 14:08:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHvGr-0001v7-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 14:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaBXNIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 08:08:20 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:33830 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbaBXNIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 08:08:14 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WHvGV-0005c5-Iu
	for git@vger.kernel.org; Mon, 24 Feb 2014 14:08:11 +0100
Received: from mail-pd0-f179.google.com ([209.85.192.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WHvGU-000EBN-Py
	for git@vger.kernel.org; Mon, 24 Feb 2014 14:08:11 +0100
Received: by mail-pd0-f179.google.com with SMTP id fp1so6319211pdb.10
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 05:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N9NiJ3az64lfS2+7FN4PGgbRQfTFJ0e5yqCX2Pco9h4=;
        b=Br0hOhOd6I4tIaTTYtU9MB8oa6w1IyvA5cc12vovVTL9SDKMGL3IZAScy4/6URncMo
         ies1r8/QhTZpZttb9eaKgqMin/6XjQe4vQpZ3p8jJI+udefCisHlJz3FUZZyhjq36WHx
         uAC2b/kudDownwAPjcShrqMWDgXmip70/vGCZZddJ6WDmhS12FS61rLMrVWSNiAXho8B
         EXoykU04mlDTfAG3buH1uGehnVtq1U181P9T8AGBzbQ+b1+bTzRM3w6S/pFTyki/9ZAM
         UG0CT7J3K5PwX7DbuD4m6AwUqJHSBHqm5opPVNwOcd85qdH4IsPL3mdQCfe02DrUKka5
         ddfg==
X-Received: by 10.68.159.228 with SMTP id xf4mr25165741pbb.74.1393247286853;
 Mon, 24 Feb 2014 05:08:06 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Mon, 24 Feb 2014 05:08:06 -0800 (PST)
In-Reply-To: <897120266.591794599.1393237656293.JavaMail.root@zimbra39-e7.priv.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242587>

On Mon, Feb 24, 2014 at 11:27 AM,  <ydirson@free.fr> wrote:
> Johan Herland <johan@herland.net> wrote on 02/24/2014 02:29:10:
>> I've been thinking about this for a while now, and I find myself
>> agreeing more and more with Junio's argument in the linked thread.
>>
>> I think notes are fundamentally - like file contents from Git's POV -
>> an unstructured stream of bytes. Any real structure in a git note is
>> imposed by the surrounding application/context, and having Git impose
>> its own object model onto the contents of notes would likely be an
>> unnecessary distraction.
>
> OTOH, it looks like a good idea to allow the surrounding application/context
> to benefit from existing infrastructure. I identified so far:
>
> (i) diffing/grepping trees
> (ii) efficiency of indexing through notes fanout

All of my proposed alternatives store some sort of reference to the
"real" data in a notes object; even when using a tree object directly
as a note, the notes tree itself only stores a SHA1 reference to the
tree object. As such, all alternatives (a) through (e) (even including
your RFC) benefit from indexing through the notes fanout, and I'm not
sure what is gained by attaching the "real" data more directly to the
notes. In all of (a) through (e), the lookup of a specific commit's
testrun logs always start with doing a lookup of the notes associated
with a given commit. Once that is done, the remainder of the work is
about resolving that reference and retrieving the associated resource,
Whether the consists of loading an HTTP URL, fetching a remote Git
repo, or looking up a local tree object is ultimately an
implementation detail, and does not affect the indexing itself.

> (iii) reachability
> (iv) content packing

These four criteria/requirements apply to your specific use case, but
they do not necessarily apply to _all_ use cases. I can easily imagine
a slightly different scenario: For example, a company setting with
highly-available internal servers, and where testrun logs are
primarily interesting to a small subset of users (e.g. most developers
only look at them very occasionally). Now assume there is already a
(third-party) system in place for archiving and indexing the testrun
logs (i.e. providing (i), (ii) and (iv)), and direct reachability
(iii) is not desired as including the testrun logs in the repo would
add nothing but bloat for most users. In this scenario, simply adding
a note with the appropriate URL to the third-party service would be a
sufficient and preferable solution.

>> In Yann's example, the testrun logs are probably best structured as a
>> hierarchy of files, but that does not necessarily mean that they MUST
>> be stored as a Git tree object (with accompanying sub-trees and
>> blobs). For example, one could imagine many different solutions for
>> storing the testrun logs:
>>
>> (a) Storing the logs statically on some server, and putting the
>> corresponding URL in a notes blob. Reachability is manual/on-demand
>> (be retrieving the URL).
>
> Would require to redo (ii) and (iv) in a way that does not impait (i)
>
>> (b) Storing the logs in a .tar.gz archive, and adding that archive as
>> a blob note. Reachability is implicit/automatic (by unpacking the
>> archive).
>
> Interferes with (i) and (iv), ie. does not allow to benefit from similarity
> between the contents of (unpacked) notes.
>
>> (c) Storing the logs on some ref in an external repo, and putting the
>> repo URL + ref in a notes blob. Reachability is manual/on-demand (by
>> cloning/fetching the repo).
>> (d) Storing the logs on some ref/commit in the same repo, and putting
>> the ref/commit name in a notes blob. Reachability depends on the
>> application/user to sync the ref/commit along with the notes.
>
> Better than (a), but still does not address (ii).
> And indeed, my intent was to let the notes live in a separate "fork" repo,
> so ordinary users need not fetch the testrun contents systematically with the
> code.

Just to clarify, my alternatives (except for (e) below) were not
intended to satisfy the exact criteria for your use case, but only to
demonstrate that there exist a variety of solutions for a variety of
slightly different problems. When we consider adding significant
complexity to the notes code, we must justify that with real and
tangible benefits, not only for your exact use case, but preferably
also for a larger group of related use cases. So far I don't see how
allowing the direct use of tree objects as notes benefit more than
your specific use case...

>> (e) Storing the logs in a commit, putting the commit name in a blob
>> note, and then creating/rewriting the notes history to include the
>> commit in its ancestry. Reachability is automatic (i.e.follows the
>> notes), but the application must control/manipulate the notes history.
>
> And finally, that one does address all points in my case.
>
>> Whichever of these (or other) solutions is most appropriate depends on
>> the particular application/context, and (from Git's perspective), none
>> of them are inherently superior to any of the other. Even the question
>> of whether testrun logs should or should not be reachable by default,
>> depends on the surrounding application/context.
>
> Wouldn't it make sense to mention these possibilities in the git-notes
> manpage, to help people use the mechanism as intended ?

I don't disagree, although I think it's hard to provide generic
suggestions that will be very useful for all kinds of surrounding
applications/contexts.

>> Now, the intention of Yann's RFC is to store the testrun logs directly
>> in a notes _tree_. This is not too different from alternative (e)
>> above, in that reachability is automatic. However, instead of having
>> the surrounding application manipulate the notes history to ensure
>> reachability, the RFC would rather teach Git's notes code to
>> accomodate the (likely rather special) case of having a note that is
>> BOTH structured like (or at least easily mapped to) a Git tree object,
>> AND that should be automatically reachable.
>
> Incidently, proposal (e) would allow the use of commits, although
> doing so would probably cause problems, not all of the children of the
> commit used as annotation having the same relationship to their parent.
>
> Are you suggesting using a slightly different mechanism than
> the "parent" relationship ?

Not really, I'm suggesting that we (ab)use the parent relationship to
achieve reachability. Sure, this "pollutes" the notes history with
"pointless" merges of a totally arbitrary/unrelated history, but the
notes history is typically not interesting/important in any case. The
notes code itself is only interested in the notes _tree_, and does not
care about the history at all. At some point in the past, I believe we
even considered having the notes ref point to a tree object directly,
and simply avoid making commit objects for notes altogether.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
