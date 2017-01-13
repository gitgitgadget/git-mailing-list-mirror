Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1891520756
	for <e@80x24.org>; Fri, 13 Jan 2017 21:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdAMVHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 16:07:35 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33881 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdAMVHb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 16:07:31 -0500
Received: by mail-ua0-f170.google.com with SMTP id 35so45571612uak.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cycEaci8ppLSO8JxKFwTGIq17Eg/QBldOndUcY37Kug=;
        b=IrJd+YXARWtLhxtq1DUTjzN2YJtKQIwNEoR4f6z0ihcmVmndE4iOLNdXTydfIX4LVs
         mqyDQP9Ad/a6zZMKzR1wRqj2AJUNaG6AB2RQL4vT+BuKFiqnxFQyEqycY2CORutzSxQx
         bDPdlYctoPN0Z9v0eiNHlRIs6GDMzkV6y9FpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cycEaci8ppLSO8JxKFwTGIq17Eg/QBldOndUcY37Kug=;
        b=nLMGpcu4QKIzwOSlYt3wMyCDQHwhOnc+lPe06aY0CgmDVo4FWVQXt3lmy59C16CmXE
         Yh6As9CGxneadeF2Hw1JkhXSYUQTU2e463C3B9CpbMO3Qq1nIoaZ+V6ompkOc3xtmrKv
         ePluGlEQgMPnMgNO39zIckcNsYafTdOUck6jOqeLQnUf39DR6YhsCo5tjxVRRjyDvDZk
         F2xPNdR4O75M2ejujFJ7n22q+b6WeHIAwKwGtIb8mU9d5mxn0fp724ovOuyhZqjHFHE6
         PUaIjdrrYthMEnxVLZXYdy6qO0WiE9ep57K7Lho4g+cd34xKFQvH717cgZn1fFThhIL/
         ERoA==
X-Gm-Message-State: AIkVDXLVsFcbZD1aPLNZUXpLtQ4pSmRO2kKiFS8hplnzlE2wIa4m2lRvZAHICM+GKaVD2fcyxyHKfmTPyC4yhQ==
X-Received: by 10.176.69.140 with SMTP id u12mr8161025uau.127.1484341649820;
 Fri, 13 Jan 2017 13:07:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.145.76 with HTTP; Fri, 13 Jan 2017 13:07:09 -0800 (PST)
In-Reply-To: <20170113155253.1644-1-benpeart@microsoft.com>
References: <20170113155253.1644-1-benpeart@microsoft.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 13 Jan 2017 13:07:09 -0800
Message-ID: <CAJo=hJumYXTRN_B3iZdmcpomp7wJ+UPcikxGb6rn9W=uJeYmfw@mail.gmail.com>
Subject: Re: [RFC] Add support for downloading blobs on demand
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, benpeart@microsoft.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 7:52 AM, Ben Peart <peartben@gmail.com> wrote:
>
> Goal
> ~~~~
>
> To be able to better handle repos with many files that any individual
> developer doesn=E2=80=99t need it would be nice if clone/fetch only broug=
ht down
> those files that were actually needed.
>
> To enable that, we are proposing adding a flag to clone/fetch that will
> instruct the server to limit the objects it sends to commits and trees
> and to not send any blobs.
>
> When git performs an operation that requires a blob that isn=E2=80=99t cu=
rrently
> available locally, it will download the missing blob and add it to the
> local object store.

Interesting. This is also an area I want to work on with my team at
$DAY_JOB. Repositories are growing along multiple dimensions, and
developers or editors don't always need all blobs for all time
available locally to successfully perform their work.

> Design
> ~~~~~~
>
> Clone and fetch will pass a =E2=80=9C--lazy-clone=E2=80=9D flag (open to =
a better name
> here) similar to =E2=80=9C--depth=E2=80=9D that instructs the server to o=
nly return
> commits and trees and to ignore blobs.

My group at $DAY_JOB hasn't talked about it yet, but I want to add a
protocol capability that lets clone/fetch ask only for blobs smaller
than a specified byte count. This could be set to a reasonable text
file size (e.g. <=3D 5 MiB) to predominately download only source files
and text documentation, omitting larger binaries.

If the limit was set to 0, its the same as your idea to ignore all blobs.

> Later during git operations like checkout, when a blob cannot be found
> after checking all the regular places (loose, pack, alternates, etc),
> git will download the missing object and place it into the local object
> store (currently as a loose object) then resume the operation.

Right. I'd like to have this object retrieval be inside the native Git
wire protocol, reusing the remote configuration and authentication
setup. That requires expanding the server side of the protocol
implementation slightly allowing any reachable object to be retrieved
by SHA-1 alone. Bitmap indexes can significantly reduce the
computational complexity for the server.

> To prevent git from accidentally downloading all missing blobs, some git
> operations are updated to be aware of the potential for missing blobs.
> The most obvious being check_connected which will return success as if
> everything in the requested commits is available locally.

This ... sounds risky for the developer, as the repository may be
corrupt due to a missing object, and the user cannot determine it.

Would it be reasonable for the server to return a list of SHA-1s it
knows should exist, but has omitted due to the blob threshold (above),
and the local repository store this in a binary searchable file?
During connectivity checking its assumed OK if an object is not
present in the object store, but is listed in this omitted objects
file.

> To minimize the impact on the server, the existing dumb HTTP protocol
> endpoint =E2=80=9Cobjects/<sha>=E2=80=9D can be used to retrieve the indi=
vidual missing
> blobs when needed.

I'd prefer this to be in the native wire protocol, where the objects
are in pack format (which unfortunately differs from loose format). I
assume servers would combine many objects into pack files, potentially
isolating large uncompressable binaries into their own packs, stored
separately from commits/trees/small-text-blobs.

I get the value of this being in HTTP, where HTTP caching inside
proxies can be leveraged to reduce master server load. I wonder if the
native wire protocol could be taught to use a variation of an HTTP GET
that includes the object SHA-1 in the URL line, to retrieve a
one-object pack file.

> Performance considerations
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> We found that downloading commits and trees on demand had a significant
> negative performance impact.  In addition, many git commands assume all
> commits and trees are available locally so they quickly got pulled down
> anyway.  Even in very large repos the commits and trees are relatively
> small so bringing them down with the initial commit and subsequent fetch
> commands was reasonable.
>
> After cloning, the developer can use sparse-checkout to limit the set of
> files to the subset they need (typically only 1-10% in these large
> repos).  This allows the initial checkout to only download the set of
> files actually needed to complete their task.  At any point, the
> sparse-checkout file can be updated to include additional files which
> will be fetched transparently on demand.
>
> Typical source files are relatively small so the overhead of connecting
> and authenticating to the server for a single file at a time is
> substantial.  As a result, having a long running process that is started
> with the first request and can cache connection information between
> requests is a significant performance win.

Junio and I talked years ago (offline, sorry no mailing list archive)
about "narrow checkout", which is the idea of the client being able to
ask for a pack file from the server that only includes objects along
specific path names. This would allow a client to amortize the setup
costs, and even delta compress source files against each other (e.g.
boilerplate across Makefiles or license headers).

If the paths of interest can be determined as a batch before starting
the connection, this may be easier than maintaining a cross platform
connection cache in a separate process.

> Now some numbers
> ~~~~~~~~~~~~~~~~
>
> One repo has 3+ million files at tip across 500K folders with 5-6K
> active developers.  They have done a lot of work to remove large files
> from the repo so it is down to < 100GB.
>
> Before changes: clone took hours to transfer the 87GB .pack + 119MB .idx
>
> After changes: clone took 4 minutes to transfer 305MB .pack + 37MB .idx
>
> After hydrating 35K files (the typical number any individual developer
> needs to do their work), there was an additional 460 MB of loose files
> downloaded.
>
> Total savings: 86.24 GB * 6000 developers =3D 517 Terabytes saved!
>
> We have another repo (3.1 M files, 618 GB at tip with no history with
> 3K+ active developers) where the savings are even greater.

This is quite impressive, and shows this strategy has a lot of promise.


> Future Work
> ~~~~~~~~~~~
>
> The current prototype calls a new hook proc in sha1_object_info_extended
> and read_object, to download each missing blob.  A better solution would
> be to implement this via a long running process that is spawned on the
> first download and listens for requests to download additional objects
> until it terminates when the parent git operation exits (similar to the
> recent long running smudge and clean filter work).

Or batching these up in advance. checkout should be able to determine
which path entries from the index it wants to write to the working
tree. Once it has that set of paths it wants to write, it should be
fast to construct a subset of paths for which the blobs are not
present locally, and then pass the entire group off for download.

> Need to do more investigation into possible code paths that can trigger
> unnecessary blobs to be downloaded.  For example, we have determined
> that the rename detection logic in status can also trigger unnecessary
> blobs to be downloaded making status slow.

There isn't much of a workaround here. Only options I can see are
disabling rename detection when objects are above a certain size, or
removing entries from the rename table when the blob isn't already
local, which may yield different results than if the blob(s) were
local.

Another is to try to have actual source files always be local, and
thus we only punt on rename detection for bigger files that are more
likely to be binary, and thus less likely to match for rename[1]
unless it was SHA-1 identity match, which can be done without the
blob(s) present.


[1] I assume most really big files are some sort of media asset (e.g.
JPEG), where a change inside the source data may result in large
difference in bytes due to the compression applied by the media file
format.

> Need to investigate an alternate batching scheme where we can make a
> single request for a set of "related" blobs and receive single a
> packfile (especially during checkout).

Heh, what I just said above. Glad to see you already thought of it.

> Need to investigate adding a new endpoint in the smart protocol that can
> download both individual blobs as well as a batch of blobs.

Agreed, I said as much above. Again, glad to see you have similar ideas. :)
