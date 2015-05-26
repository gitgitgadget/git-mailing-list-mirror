From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 00/11] Protocol version 2, again!
Date: Tue, 26 May 2015 15:01:04 -0700
Message-ID: <1432677675-5118-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMug-0001sA-Ml
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbEZWB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 18:01:26 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35871 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbEZWBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:25 -0400
Received: by iepj10 with SMTP id j10so102964905iep.3
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yZ8UBCIaR3Hd1GSXnoOoPJTNN7jI+OWyQI3MOS/ElIo=;
        b=VCQcisV5HAIbfgPPc+1hg4l7S7ZToRFGSvo/nt6t12fqLZ+dY8YtIXetMJXe/tEenZ
         Gf40oGqg1IaxJIjEkgNUe6NR/9otjjJs33po2Lz+Me/ZgWk/gXPBKPxr+2s6BV3RML46
         xTieFUGeYRU01mZAhvb/XKQuxl+NB9gwEt4LdAt/3q/PYgDo4rnrB3IjVRc5BMtdT9An
         qL7/fronX9R1XTIb2oZ12ZZuW9eCm9+wnfAiehxM9Au0mr32DLMRlZzdTTB/Xz4GQTAU
         ESJBtgT3PotOSf1w956U8pQU/fw0XDwsGKjbyeOofqVE+magt2teKDuZuTR9/ebs2XIn
         qi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=yZ8UBCIaR3Hd1GSXnoOoPJTNN7jI+OWyQI3MOS/ElIo=;
        b=cHjiBNmsR23vPHZnzqh32DrTbnl50U4+AzZ7D3HPjPMf028Q8RX6faY6jib2zlJ+6f
         +p/l8JtM3SC0bnBma1tiGNiv1/ISILRCNuT/ZksCD19Ljf8IE7nxoAUg1AsGj3lgG1Aa
         tOAZ45VfdIhGtw2cs0Cu+wughLx5NVdc3En5YM8JsrjDVQAxHprnhXl/rRFpYEQmNnIA
         GdiIPvKyRaszat+pyJ4l8MmkUu1bnvJk2KT9UleEqNJkCPERA0MmABRKCk9cUO5TQZNX
         BlnTedt/2B7i1Fk3a6fCpe91eu2DIQSFYN9EOFPVxVD8FVraD9FBvufAWS/7B2rcU/vh
         +Hcg==
X-Gm-Message-State: ALoCoQkddJO9exFVZr1xAIqhr4bjpgoU2iFfiTR6550JjW6RQJ4xlBBgym2TQm4BRTzBAR7x4H9p
X-Received: by 10.50.93.69 with SMTP id cs5mr33178660igb.4.1432677684621;
        Tue, 26 May 2015 15:01:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id qh9sm301488igb.20.2015.05.26.15.01.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269988>

    "Just give us something to play around with" - Peff at GitMerge 201=
5

This is another approach for updating the pack protocol of Git.
While in the previous attempts I tried to come up with the perfect
specification of the new protocol I realized that such an approach
doesn't lead anywhere. So this time actual working code is included!

The included code is not complete, but a minimal example of

    git config remote.origin.transportversion 2
    git fetch origin master # uses the new protocol!

works.

In a previous discussion[1] towards version 2 of the pack protocol I wa=
nted
to come up with a protocol which even includes negotiating what is done
in the protocol exchange, such as having a command "push, fetch, ls-rem=
ote"
being part of the protocol. This is not a very good approach as it's to=
o much
work to be done at the same time.

This patch series focusses on just the fetching side, so the first four=
 patches
are teaching git-upload-pack about the new pack protocol. The next five=
 patches
will teach git fetch and fetch-pack how to use the version 2 protocol. =
Then there
will be a small test and a documentation update.

The new protocol works just like the old protocol, except for
the capabilities negotiation being before any exchange of real data.

This solves the problem of having a first huge chunk of data (the refs
advertisement) sent over the wire and just realizing in between that we
don't need these data for that operation and no way to cancel.

By having a capabilites negotiation first the new protocol may be even
more future-proof than the current one, as the capabilites will hopeful=
ly
be kept small and all larger data transfers will get their own later st=
age
in the protocol.

To determine the protocol version we check the ending of the
invoked program for an appended version number to see which protocol
version we're using in an exchange. At first I thought we should append
a unique suffix instead of a version number to make a distinction easie=
r
for the kind of protocol we want to talk (There may be the traditional
protocol with no suffix, or the "upload-pack-capabilities-first" protoc=
ol
which will transmit the capabilities first).

My preference for a string suffix instead of a sequential number is
motiviated by the discussion of sha1 vs sequential numbers to describe
a state of a repository. The main difference here is however how often
we expect changes. Version 1 of the protocol is current for 10 years by
now, so I do not changes to the protocol number often, which makes it
suitable for just having a counter appended to the binary.

The advantage of just a counting number is its small size,
and I think this advantage outweights the disadvantage
of having named protocol versions.

This series doesn't include an automatic upgrade of the protocol versio=
n
for later changes if the server supports it, so for now the use of the =
new
protocol needs to be activated manually via setting remote.origin.trans=
portversion.

Any comments welcome!

Thanks,
Stefan

[1] http://permalink.gmane.org/gmane.comp.version-control.git/267572

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  upload-pack: make client capability parsing code a separate function
  upload-pack: only accept capabilities on the first "want" line

Stefan Beller (9):
  upload-pack: move capabilities out of send_ref
  upload-pack-2: Implement the version 2 of upload-pack
  transport: add infrastructure to support a protocol version number
  remote.h: add get_remote_capabilities, request_capabilities
  fetch-pack: use the configured transport protocol
  transport: connect_setup appends protocol version number
  transport: get_refs_via_connect exchanges capabilities before refs.
  t5544: add a test case for the new protocol
  Document protocol version 2

 .gitignore                                        |   1 +
 Documentation/technical/pack-protocol.txt         |  86 ++++++++++++--
 Documentation/technical/protocol-capabilities.txt |  15 ---
 Makefile                                          |   2 +
 builtin/fetch-pack.c                              |  17 ++-
 builtin/fetch.c                                   |   6 +
 connect.c                                         |  48 +++++++-
 fetch-pack.h                                      |   1 +
 remote.c                                          |   2 +
 remote.h                                          |   5 +
 t/t5544-fetch-2.sh                                |  40 +++++++
 transport-helper.c                                |   1 +
 transport.c                                       |  60 +++++++++-
 transport.h                                       |   4 +
 upload-pack-2.c                                   |   1 +
 upload-pack.c                                     | 138 ++++++++++++++=
+++-----
 16 files changed, 366 insertions(+), 61 deletions(-)
 create mode 100755 t/t5544-fetch-2.sh
 create mode 120000 upload-pack-2.c

--=20
2.4.1.345.gab207b6.dirty
