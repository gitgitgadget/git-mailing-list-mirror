Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6FCC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 20:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D52E206EC
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 20:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj4IWLFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLCUNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:13:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCUNe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 15:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575404013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AT20r92uKZ+BeI4X1nrR7C+op+QUA1D45zR7stSNfz0=;
        b=Fj4IWLFBvAo84c2a5Egi1tvU162GftVEmV06v9SqKk0RrtWvaaXbp0rz4bPTUem2cM8iIf
        knTgIG2yQ1I2A7eCxVdbLlkb+k/+8M9NpzS3ZLrWrYMFjXmV3G89JVJ7HpJiy7gJZmFSt1
        jPlAMhNQeauqtmxKPuPYXsJcPSuclUI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-lRaDwHGAOOqOz2BmAlJXLw-1; Tue, 03 Dec 2019 15:13:32 -0500
Received: by mail-qv1-f71.google.com with SMTP id g9so2971093qvx.12
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 12:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=PVz79hFBXYsENsptij4wxaWvvTxZpGE0CY5ny0yPW3E=;
        b=JksOXM/P+lTFiJ+I5ss+uvwVu/eOmbgmKDvBO63CkS7u6taW1jD4ksugYDL/YS0m4y
         lStALXeuDMS+mKLv72/ymWq8W7USsXZxGnn01vhmo+bQP4pArO7Z7gc5gRgDqhUnYSka
         hIf30SYKJhtI1PhZ2p7QDFKGKpayVXLIb9qoCb15P9+vufJyW7YxrFfS2ohJD+7yvopi
         v9oVIFUX8S2m1VNGMgPnTLvSnfyuHV53JotO6DieBPLQxK4r1pp8/tImRf/b28kCZAob
         91hTu25YUFRGFkYuAxV3025CktMg8uF7sizK4Igz5i3VpSABm07zNhV3W94x40JGcaDf
         HGGA==
X-Gm-Message-State: APjAAAWrHsUFQFtYC5bwVKEUoLaQH5xcuxjV07XrxPnn4jwicoxHu3qe
        n4+D3YLs03rDMnWHZeQczEEOW29F7ofCb9tXmoqzAstApxe7njC3rdPOhwTwrsqEpf3oSt4twou
        hqFPVGhrdVyW2
X-Received: by 2002:ac8:fb0:: with SMTP id b45mr6803523qtk.1.1575404011667;
        Tue, 03 Dec 2019 12:13:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqywOl8gV2K5Mkkwf7UZ0nmUv/mTqgTpyeUgDosftx9WHcAtV4Nu+3D9CsURyvLG2yOmlONncQ==
X-Received: by 2002:ac8:fb0:: with SMTP id b45mr6803502qtk.1.1575404011444;
        Tue, 03 Dec 2019 12:13:31 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id x6sm2340857qkh.20.2019.12.03.12.13.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:13:30 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:13:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] contrib: git-cpcover: copy cover letter
Message-ID: <20191203201233.661696-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: lRaDwHGAOOqOz2BmAlJXLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My flow looks like this:
1. git format-patch -v<n> --cover-letter <params> -o <dir>
2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter.pat=
ch

copy subject and blurb, avoiding patchset stats

3. add changelog update blurb as appropriate

4. git send-email <dir>/v<n>-*

The following perl script automates step 2 above.  Hacked together
rather quickly, so I'm only proposing it for contrib for now.  If others
see the need, we can add docs, tests and move it to git proper.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Fixes from v1: support multi-line To/Cc headers.

Any feedback on this? Interest in taking this into contrib/ for now?

 contrib/git-cpcover | 84 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 contrib/git-cpcover

diff --git a/contrib/git-cpcover b/contrib/git-cpcover
new file mode 100755
index 0000000000..fe7006a56d
--- /dev/null
+++ b/contrib/git-cpcover
@@ -0,0 +1,84 @@
+#!/usr/bin/perl -i
+
+use strict;
+
+die "Usage: ${0} <from> [<to>]" unless $#ARGV =3D=3D 0 or $#ARGV =3D=3D 1;
+
+my $ffrom =3D shift @ARGV;
+my @extraheaders =3D ();
+
+open(FROM, "<", $ffrom) || die "Can not open $ffrom";
+
+my @from =3D ();
+while (<FROM>) {
+=09push @from, $_;
+}
+
+close(FROM) || die "error closing $ffrom";
+
+#get subject
+my $subj;
+my $bodyi;
+my $lastheader=3D"";
+for (my $i =3D 0; $i <=3D $#from; $i++) {
+=09$_ =3D $from[$i];
+=09#print STDERR "<$line>\n";
+=09if (not defined ($subj) and s/^Subject: \[[^]]+\] //) {
+=09=09$subj =3D $_;
+=09=09chomp $subj;
+=09}
+=09if (m/^([A-Za-z0-9-_]*:)/) {
+=09=09$lastheader =3D $1;
+=09}
+=09if (m/^(To|Cc):/ or (m/^\s/ and $lastheader =3D~ m/^(To|Cc):/)) {
+=09=09push @extraheaders, $from[$i];
+=09}
+=09if (defined ($subj) and m/^$/) {
+=09=09$bodyi =3D $i + 1;
+=09=09last;
+=09}
+}
+
+die "No subject found in $ffrom" unless defined($subj);
+
+die "No body found in $ffrom" unless defined($bodyi);
+
+my $bodyl;
+my $statb;
+my $state;
+for (my $i =3D $#from; $i >=3D $bodyi; $i--) {
+=09$_ =3D $from[$i];
+=09$statb =3D $i if m/ [0-9]+ files changed, [0-9]+ insertions\(\+\), [0-9=
]+ deletions\(-\)/;
+=09next unless defined($statb);
+=09$state =3D $i if m/^$/;
+=09next unless defined($state);
+=09next if m/^$/;
+=09next if m/^  [^ ]/;
+=09next if m/\([0-9]+\):$/;
+=09$bodyl =3D $i;
+=09last;
+}
+
+die "No body found in $ffrom" unless defined($bodyl);
+
+#print STDERR $bodyi, "-", $bodyl, "\n";
+my $blurb =3D join("", @from[$bodyi..$bodyl]);
+
+my $gotsubj =3D 0;
+my $gotblurb =3D 0;
+my $gotendofheaders =3D 0;
+while (<>) {
+=09if (not $gotsubj and
+=09    s/\*\*\* SUBJECT HERE \*\*\*/$subj/) {
+=09=09$gotsubj =3D 1;
+=09}
+=09if (not $gotblurb and
+=09    s/\*\*\* BLURB HERE \*\*\*/$blurb/) {
+=09=09$gotblurb =3D 1;
+=09}
+=09if (not $gotendofheaders and m/^$/) {
+=09=09print join("", @extraheaders);
+=09=09$gotendofheaders =3D 1;
+=09}
+=09print $_;
+}
--=20
MST

