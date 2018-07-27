Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790171F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbeG0XLB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:11:01 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38536 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389728AbeG0XLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:11:00 -0400
Received: by mail-yw0-f193.google.com with SMTP id r3-v6so2396528ywc.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SV0fV3aNOQe9m6CQzYly2K0qKDLlf0fsNWELJJPe6rc=;
        b=v5/ZmTe+gxF563MWbXKH7TZ+jySYBQbGTJ62wmS9CaLgZRKbadwk+r/ausvuKFYAv+
         4A5VYgHNsYU00zqDF/KI54APNKG48+4NFyjS6U4BLPd1pN/5c/TMk9PL/uxJDGkXmwnO
         QdFt9zVrSQjmKky3BuwRihiWlz/uBivBWVgLuh51I6jvPbJ0ycwuN9ORZF7Ke3ICYdLZ
         Z3/S4yWLG86Ow5R4f0r4HzfyxT5UzTEvfQQKKErBkrnWNrJ1dNRjf6nhZzq9E7kK9oD3
         4//Jxfvo9E0PIESeQjdN+rCD76IE+dYkIGhZS2Nf2g/RhkGB3y1i3N7/r2ky4dDmsd18
         xE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SV0fV3aNOQe9m6CQzYly2K0qKDLlf0fsNWELJJPe6rc=;
        b=mcRnCOmz9WIRq8QN0griI71YDxZ6eL0YlH/b/pPCEcpmuUyURmaL6qBKEB1wRzggcb
         MDaUig0wYtKeShzyZhVw7NQ0KTbRokPngq8W+WeK4Xd0wsja9H3KU4brG6OyB9pMsmF3
         Iv0iDocpTPsAVZXHDLG+nrw7VgxTAP9WWo/NdT93FtTg4+k03wZj3y82cR+OKHWwuaXy
         0wWp3YB/KVAKiPwgluysjrxkOZ2vHZIIYd445T5nKQBk4n66mdH+dr4tM19RRmNu63Ud
         Q2syxi2hAc6Ec+i7NgxEis7w22VNK6RWL1efDyrJ1zHNhhh87VpsJ3TF6caitQy7VsTz
         dJDg==
X-Gm-Message-State: AOUpUlHO6FfoRz/uNd7XFi/N+kBHE0WHAXKyT63UQLd6t/ho5sZdlcpJ
        NV1Mpt6pNPKhEyJ29XpM+TRy4ZaggybNbovGSEgkYDP9q3A=
X-Google-Smtp-Source: AAOMgpf7bY8bPnKe08OemLw5mHSQU2PX6P6KLYBBqYt7r1MJRTM9q2rlitSTyOFJBxfDHUHJKZD4Wha9t+WBz8fHv+s=
X-Received: by 2002:a81:c848:: with SMTP id k8-v6mr4248952ywl.89.1532728031314;
 Fri, 27 Jul 2018 14:47:11 -0700 (PDT)
MIME-Version: 1.0
From:   Josh Steadmon <steadmon@google.com>
Date:   Fri, 27 Jul 2018 14:47:00 -0700
Message-ID: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
Subject: Proposed approaches to supporting HTTP remotes in "git archive"
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000d8d5120572020dd2"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000d8d5120572020dd2
Content-Type: text/plain; charset="UTF-8"

# Supporting HTTP remotes in "git archive"

We would like to allow remote archiving from HTTP servers. There are a
few possible implementations to be discussed:

## Shallow clone to temporary repo

This approach builds on existing endpoints. Clients will connect to the
remote server's git-upload-pack service and fetch a shallow clone of the
requested commit into a temporary local repo. The write_archive()
function is then called on the local clone to write out the requested
archive.

### Benefits

* This can be implemented entirely in builtin/archive.c. No new service
  endpoints or server code are required.

* The archive is generated and compressed on the client side. This
  reduces CPU load on the server (for compressed archives) which would
   otherwise be a potential DoS vector.

* This provides a git-native way to archive any HTTP servers that
  support the git-upload-pack service; some providers (including GitHub)
  do not currently allow the git-upload-archive service.

### Drawbacks

* Archives generated remotely may not be bit-for-bit identical compared
  to those generated locally, if the versions of git used on the client
  and on the server differ.

* This requires higher bandwidth compared to transferring a compressed
  archive generated on the server.


## Use git-upload-archive

This approach requires adding support for the git-upload-archive
endpoint to the HTTP backend. Clients will connect to the remote
server's git-upload-archive service and the server will generate the
archive which is then delivered to the client.

### Benefits

* Matches existing "git archive" behavior for other remotes.

* Requires less bandwidth to send a compressed archive than a shallow
  clone.

* Resulting archive does not depend in any way on the client
  implementation.

### Drawbacks

* Implementation is more complicated; it will require changes to (at
  least) builtin/archive.c, http-backend.c, and
  builtin/upload-archive.c.

* Generates more CPU load on the server when compressing archives. This
  is potentially a DoS vector.

* Does not allow archiving from servers that don't support the
  git-upload-archive service.


## Add a new protocol v2 "archive" command

I am still a bit hazy on the exact details of this approach, please
forgive any inaccuracies (I'm a new contributor and haven't examined
custom v2 commands in much detail yet).

This approach builds off the existing v2 upload-pack endpoint. The
client will issue an archive command (with options to select particular
paths or a tree-ish). The server will generate the archive and deliver
it to the client.

### Benefits

* Requires less bandwidth to send a compressed archive than a shallow
  clone.

* Resulting archive does not depend in any way on the client
  implementation.

### Drawbacks

* Generates more CPU load on the server when compressing archives. This
  is potentially a DoS vector.

* Servers must support the v2 protocol (although the client could
  potentially fallback to some other supported remote archive
   functionality).

### Unknowns

* I am not clear on the relative complexity of this approach compared to
  the others, and would appreciate any guidance offered.


## Summary

Personally, I lean towards the first approach. It could give us an
opportunity to remove server-side complexity; there is no reason that
the shallow-clone approach must be restricted to the HTTP transport, and
we could re-implement other transports using this method.  Additionally,
it would allow clients to pull archives from remotes that would not
otherwise support it.

That said, I am happy to work on whichever approach the community deems
most worthwhile.

--000000000000d8d5120572020dd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"># Supporting HTTP remotes in &quot;git archive&quot;<br><b=
r>We would like to allow remote archiving from HTTP servers. There are a<br=
>few possible implementations to be discussed:<br><br>## Shallow clone to t=
emporary repo<br><br>This approach builds on existing endpoints. Clients wi=
ll connect to the<br>remote server&#39;s git-upload-pack service and fetch =
a shallow clone of the<br>requested commit into a temporary local repo. The=
 write_archive()<br>function is then called on the local clone to write out=
 the requested<br>archive.<br><br>### Benefits<br><br>* This can be impleme=
nted entirely in builtin/archive.c. No new service<br>=C2=A0 endpoints or s=
erver code are required.<br><br>* The archive is generated and compressed o=
n the client side. This<br>=C2=A0 reduces CPU load on the server (for compr=
essed archives) which would<br>=C2=A0 =C2=A0otherwise be a potential DoS ve=
ctor.<br><br>* This provides a git-native way to archive any HTTP servers t=
hat<br>=C2=A0 support the git-upload-pack service; some providers (includin=
g GitHub)<br>=C2=A0 do not currently allow the git-upload-archive service.<=
br><br>### Drawbacks<br><br>* Archives generated remotely may not be bit-fo=
r-bit identical compared<br>=C2=A0 to those generated locally, if the versi=
ons of git used on the client<br>=C2=A0 and on the server differ.<br><br>* =
This requires higher bandwidth compared to transferring a compressed<br>=C2=
=A0 archive generated on the server.<br><br><br>## Use git-upload-archive<b=
r><br>This approach requires adding support for the git-upload-archive<br>e=
ndpoint to the HTTP backend. Clients will connect to the remote<br>server&#=
39;s git-upload-archive service and the server will generate the<br>archive=
 which is then delivered to the client.<br><br>### Benefits<br><br>* Matche=
s existing &quot;git archive&quot; behavior for other remotes.<br><br>* Req=
uires less bandwidth to send a compressed archive than a shallow<br>=C2=A0 =
clone.<br><br>* Resulting archive does not depend in any way on the client<=
br>=C2=A0 implementation.<br><br>### Drawbacks<br><br>* Implementation is m=
ore complicated; it will require changes to (at<br>=C2=A0 least) builtin/ar=
chive.c, http-backend.c, and<br>=C2=A0 builtin/upload-archive.c.<br><br>* G=
enerates more CPU load on the server when compressing archives. This<br>=C2=
=A0 is potentially a DoS vector.<br><br>* Does not allow archiving from ser=
vers that don&#39;t support the<br>=C2=A0 git-upload-archive service.<br><b=
r><br>## Add a new protocol v2 &quot;archive&quot; command<br><br>I am stil=
l a bit hazy on the exact details of this approach, please<br>forgive any i=
naccuracies (I&#39;m a new contributor and haven&#39;t examined<br>custom v=
2 commands in much detail yet).<br><br>This approach builds off the existin=
g v2 upload-pack endpoint. The<br>client will issue an archive command (wit=
h options to select particular<br>paths or a tree-ish). The server will gen=
erate the archive and deliver<br>it to the client.<br><br>### Benefits<br><=
br>* Requires less bandwidth to send a compressed archive than a shallow<br=
>=C2=A0 clone.<br><br>* Resulting archive does not depend in any way on the=
 client<br>=C2=A0 implementation.<br><br>### Drawbacks<br><br>* Generates m=
ore CPU load on the server when compressing archives. This<br>=C2=A0 is pot=
entially a DoS vector.<br><br>* Servers must support the v2 protocol (altho=
ugh the client could<br>=C2=A0 potentially fallback to some other supported=
 remote archive<br>=C2=A0 =C2=A0functionality).<br><br>### Unknowns<br><br>=
* I am not clear on the relative complexity of this approach compared to<br=
>=C2=A0 the others, and would appreciate any guidance offered.<br><br><br>#=
# Summary<br><br>Personally, I lean towards the first approach. It could gi=
ve us an<br>opportunity to remove server-side complexity; there is no reaso=
n that<br>the shallow-clone approach must be restricted to the HTTP transpo=
rt, and<br>we could re-implement other transports using this method.=C2=A0 =
Additionally,<br>it would allow clients to pull archives from remotes that =
would not<br>otherwise support it.<br><br>That said, I am happy to work on =
whichever approach the community deems<br>most worthwhile.</div>

--000000000000d8d5120572020dd2--
