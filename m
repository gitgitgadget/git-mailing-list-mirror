From: Stefan Beller <sbeller@google.com>
Subject: [WIP PATCH 00/14] Protocol v2 patches
Date: Fri, 29 Apr 2016 16:34:33 -0700
Message-ID: <1461972887-22100-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHw4-0000kw-T1
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbcD2Xe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 19:34:56 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35489 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcD2Xez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:34:55 -0400
Received: by mail-pf0-f181.google.com with SMTP id 77so21503868pfv.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TML5tFB2MbK24S0w3QXd3ZKbfPCUQQM6pJA3M7IxcEs=;
        b=BgQYGF31jYN5weMpZysc2jxKCLmBDI/9PdbocWtCSkWzxJ5oLHqnZgINp5XnSyDWnN
         1ajO8I036S1hFvFnF+V288HsDOyxDbOkye/+/dIDtY3Yz+mR9gfR5Yho78MGmK0UvjbD
         ny9A7viXjSx4HwhxyNB33nRV4FAM0VxCKUWX+KhQoKIut3ghcuet+36xKpFbwRpcastn
         6MjMl+ol88k0Wpl3TNUhgZnG2MMEPe29zod27+ZPtiogW1X7sV4CH8eAZPR68WA8kGZM
         f57eny6/p61ZYuUZu4yAdO6HubOVD1zHCuKfwjO3Apk0lWFJ9A8GJDNZzbQbY+qV5j5z
         Dcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TML5tFB2MbK24S0w3QXd3ZKbfPCUQQM6pJA3M7IxcEs=;
        b=RXES2GNNTpx06NgOWaZxhUOu2CTP9ewcz1nk9hyL7qeAP0ZEkt9ndcEyjYhwFXEq1h
         pKrmKdqXjGD6bVUOdmFdxCByI+BceP+pShi+q1oJu2HQKPF+sPYcqlI+sQfZXs1xnuyM
         vOa6aHG4bBgO4EgtnmW8DBVDtS0OFLXUByQyapJwXbp0aHaYvjD2x6CDCIPTa/axO5VA
         PQimsxL8XJrbRehdj0e3Xgq+HQakOgxcqKL9z+OvhBBZo+Vl/t9sR3h7m9a5nm2xKekF
         Pvt0DuZVYZkeaE/jJiXDA1lk/iEsA9GTHwJVRrMr9F5DeF4EfS2VJZiZir/Vm21cZcY4
         dWQA==
X-Gm-Message-State: AOPr4FVCkdAsdfflFEMk+DhR9iJIgqqC7R4MpWkraLdlqpkpUhKNaNFrKfkCuxCkZ4B6nEOY
X-Received: by 10.98.18.80 with SMTP id a77mr32691054pfj.27.1461972894634;
        Fri, 29 Apr 2016 16:34:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id 127sm26208901pfe.72.2016.04.29.16.34.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:34:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293070>

Hi David,

here are my patches for a protocol v2.

("Negotiate capabilities before doing anything else", or as code:

        static void upload_pack_version_2(void)
        {
                send_capabilities_version_2();
                receive_capabilities_version_2();

                /* The rest of the protocol stays the same, capabilitie=
s advertising
                   is disabled though. */
                advertise_capabilities =3D 0;
                upload_pack();
        }
)

They are rough and unfinished as you can see by the tailing WIPs.
However the plumbing (upload-pack and fetch-pack) works and we'd need t=
o
integrate that into user porcelains, i.e. fetch, clone, push.

Also we need to add tests for all the options again, so we'd need to be=
 smart
about testing that.

I am not sure if it makes sense to integrate that with the http series,=
 though.

Thanks,
Stefan

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  upload-pack: make client capability parsing code a separate function

Stefan Beller (13):
  upload-pack.c: Refactor capability advertising
  upload-pack-2: Implement the version 2 of upload-pack
  connect: rewrite feature parsing to work on string_list
  transport: add infrastructure to support a protocol version number
  remote.h: add get_remote_capabilities, request_capabilities
  fetch-pack: move capability selection out of do_fetch_pack
  fetch-pack: factor out get_selected_capabilities_list
  fetch-pack: Add negotiate_capabilities
  do_fetch_pack: select capabilities for transport version 1 only
  builtin/fetch-pack: add argument for transport version
  Add test for fetch-pack
  WIP add test for git pull
  WIP test git fetch

 .gitignore             |   1 +
 Makefile               |   4 ++
 builtin/fetch-pack.c   |  20 ++++++-
 builtin/receive-pack.c |  15 +++--
 connect.c              | 141 +++++++++++++++++++++++++++++------------=
--
 connect.h              |   2 +-
 fetch-pack.c           | 102 ++++++++++++++++++++++++-------
 fetch-pack.h           |   7 +++
 remote.c               |   2 +
 remote.h               |   5 ++
 t/t5500-fetch-pack.sh  |  21 +++++++
 t/t5510-fetch.sh       |   5 ++
 t/t5520-pull.sh        |   6 ++
 transport-helper.c     |   1 +
 transport.c            |  20 ++++++-
 transport.h            |   8 +++
 upload-pack-2.c        |   1 +
 upload-pack.c          | 159 ++++++++++++++++++++++++++++++++++++-----=
--------
 18 files changed, 403 insertions(+), 117 deletions(-)
 create mode 120000 upload-pack-2.c

--=20
2.8.0.32.g71f8beb.dirty
