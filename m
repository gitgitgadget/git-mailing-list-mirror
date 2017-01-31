Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D359C1F6DC
	for <e@80x24.org>; Tue, 31 Jan 2017 07:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbdAaHBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 02:01:24 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:34571 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdAaHBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 02:01:21 -0500
Received: by mail-ot0-f176.google.com with SMTP id f9so259623721otd.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 23:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8wPjNn28YBrEJOcHSSDZrsEMQJI0oCI4Yz+YY24eDts=;
        b=lE7l8bnZe8kacYrnk7XvBIwCtsZA6Wa506K/eUGCKZtMGvNFNlO+WkMBtEkyd7+oI/
         cJLAECS0cxkqM9xwm6Qn1perb7AUI4YKTV82MUPRArCcc8ZitpqBCSTfIoK6MBF+1HKx
         EKXHqad9ZU3L/hW/fmpo6ZnrY8hder8WyMTE/FUjlCVdHg7WY+7h07l2jtvSjO3/w8gv
         W3K7+C234CQKnukANZrQaWrCH8UPdEIKw7p9Tptd/4t+zekBSU/d7m3THpH3dZeBWwsk
         YJk4Q074b6Py5Wsl7gqqUvn9kPnBf6YiOTQ8bzzVEdkfYVxBVoAscAGYEssc8CCpE7j5
         DAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8wPjNn28YBrEJOcHSSDZrsEMQJI0oCI4Yz+YY24eDts=;
        b=QIsNjOtyiR8FtPEdXtGilxog+yPBL4WlzJJLuMxD0LYBAzLVfUiSiSQU2xCWCfqac9
         EYOtNEklEoeeraymv/RsC91/PY3ymw79L7quBPYTdVDUvtdczgGel4zcx1TUgoA1VmGP
         SoBnODsd1P9vp//LobxozGGDKa0849kbk7SnU9PiNplC7RBcuIk8X1fjMKevhVmXSIrG
         afOQvQnnPf76u/IcseAndTZH5l/q1Z+5QukO/xh0jHueZFYBoeH5dNhkbGtro953IGmW
         cn9xLLjFml2kqTPWExxB3Rtgr2mTjqWMVqh3rwTkQCjWRqg2u3BExgigyIOo6/Y75ocP
         Sy5A==
X-Gm-Message-State: AIkVDXJOH6ZK00L2fcS1k8rfcN9TpHXzYp+1xHjYr79yZkwwnMvHUdIP0xqsxzGJ8wKbXo9dZyHGs7ngFVVgudvx
X-Received: by 10.157.63.188 with SMTP id r57mr11366344otc.78.1485846074852;
 Mon, 30 Jan 2017 23:01:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.69.69 with HTTP; Mon, 30 Jan 2017 23:00:34 -0800 (PST)
From:   Stefan Saasen <ssaasen@atlassian.com>
Date:   Tue, 31 Jan 2017 18:00:34 +1100
Message-ID: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
Subject: Git clonebundles
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Bitbucket recently added support for Mercurial=E2=80=99s clonebundle extens=
ion
(http://gregoryszorc.com/blog/2015/10/22/cloning-improvements-in-mercurial-=
3.6/).
Mercurial=E2=80=99s clone bundles allow the Mercurial client to seed a repo=
sitory using
a bundle file instead of dynamically generating a bundle for the client.


Mercurial clonebundles?
~~~~~~~~~~~~~~~~~~~~~~~

With Mercurial clonebundles the high level clone sequence looks like this:

1. The command "hg clone URL"  attempts to clone the repository at URL.
2. If a bundle file exists for the repository, the existence of the file
`clonebundles.manifest` causes the server to advertise the `clonebundle`
capability (capabilities lookup is the first command the client issues).
3. In the above case the client then executes the command "clonebundles".
4. The manifest file will be returned.
5. The client then selects a bundle file to download from the list of URLs
advertised in the manifests file, to seed the repository.
6. To update the repository the last step involves fetching the latest chan=
ges.


Why is this useful?
~~~~~~~~~~~~~~~~~~~

The fact that clone bundles can be distributed as static files enables us t=
o
use static file servers for bundle distribution. Users have also reported
latency improvements for clone operations of popular Mercurial repositories=
.
Additionally this significantly reduces the resource usage of clone operati=
ons,
as clone operations are reduced to simpler fetches to resolve the delta bet=
ween
the current repository and the downloaded bundle state.


clonebundles for git?
~~~~~~~~~~~~~~~~~~~~~

We recently looked into how this concept could be translated to git. This i=
s
not a new idea and has been discussed before (more on that later) but our
success with the Mercurial clonebundle rollout prompted us to revisit this
topic.

We believe that bringing a similar concept to git could have the following
benefits:

* Improved clone times for users that clone large git repositories, especia=
lly
  if bundle file distribution leverages global CDNs.
* Improved scalability of git for managing large popular repositories.
  Offloading a significant portion of the clone resource usage to CDNs or s=
tatic
  file hosts.


Our current proof-of-concept to explore this space, closely follows
the approach from Mercurial outlined above.

* An `/info/bundle` path returns a bundle manifest (over HTTP)
* The bundle manifest contains a simple list of URLs with some additional m=
eta
  data that allows the client to select a suitable bundle download URL
* The bundle download URL points to a bundle file generated using `git bund=
le
  create` including all the relevant refs as a self contained repository se=
ed.
* The client probes the target URL with a `GET` request to $URL/info/bundle=
 and
  downloads the bundle file if present.
* The repository will be created based on the downloaded bundle (downloadin=
g a
  static file allows resumable downloads or parallel downloads of chunks if=
 the
  file/web server supports range requests).
* A `git fetch` and the appropriate checkout then updates the "cloned"
  repository to match the latest upstream state.

The proof-of-concept was built as an external binary `git-clone2` that
mimics the behaviour of the `git clone` command, so unfortunately I
can't provide any patches to git to demonstrate the behaviour.


Ultimately our proof-of-concept is built around a few core ideas:

* Re-use the existing bundle format as a single-file, self-contained
repository representation.
* Introduce a bundle manifest (accessible at `$URL/info/bundle`) that allow=
s
  the client to resolve a suitable bundle download URL.
* Teach the `git clone` command to accept and prefer seeding a repository u=
sing
  a static bundle file that is advertised in a bundle manifest.
* Re-use as much as possible of the existing commands and in particular the
  `git bundle` machinery to seed the repository and to create the static bu=
ndle
  file.
* We accept additional storage requirements for the bundle files in additio=
n to
  the actual repository content in pack-files or loose objects.
Hosting providers
  or system administrators are free to decide how many bundles to advertise=
 and
  how frequently the bundles are updated.
* It targets the "seed from a bundle file" use case, with resumable clones =
just
  being a potential side-effect.


Some of the problems that need to be solved with an approach like this are:

* Bundle advertisement/bundle negotiation: We considered advertising a
  new capability "clonebundle" as part of the rev advertisement
capabilities list.
  This would allow clients that support clonebundles to abort the clone att=
empt
  and resolve a suitable bundle URL from a bundle manifest at `$URL/info/bu=
ndle`
  instead. For HTTP this would amount to an early termination when
retrieving the
  ref-advertisement.
  Note: We didn't pursue this for our proof-of-concept so we didn't
explore whether
  this is feasible.
* Uniform approach for the supported transports: Our proof-of-concept
only supports HTTP as
  a transport. Ideally the clonebundle capability could be supported by all
  available transports (of which at least ssh would be highly desirable).
* Bundle manifest and bundle download: It is unclear whose responsibility i=
t is
  to generate the bundle manifest with the bundle download URLs. Most likel=
y the
  bundle files will be served using a webserver or CDN, so download
URL generation
  should not be a core git responsibility. For hosting purpose we envision =
that
  the bundle manifest might contain dynamic download URLs with personalised
  access tokens with expiry.
* Bundle generation: Similar to the above it is unclear how bundle
generation is handled.
  For hosting purposes, the operator would likely want to influence
when and how bundles are generated.



Prior art
~~~~~~~~~

Our proof-of-concept is built on top of ideas that have been
circulating for a while. We are aware of a number of proposed changes
in this space:


* Jeff King's work on network bundles:
https://github.com/peff/git/commit/17e2409df37edd0c49ef7d35f47a7695f9608900
* Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy's work on "[PATCH 0/8] Resumabl=
e clone
revisited, proof of concept":
https://www.spinics.net/lists/git/msg267260.html
* Resumable clone work by Kevin Wern:
https://public-inbox.org/git/1473984742-12516-1-git-send-email-kevin.m.wern=
@gmail.com/


Whilst the above mentioned proposals/proposed changes are in a similar
space, I would be interest to understand whether there is any
consensus on the general idea of supporting static bundle files as a
mechanism to seed a repository?
I would also appreciate any pointers to other discussions in this area.


Best regards,
Stefan Saasen & Erik van Zijst; Atlassian Bitbucket
