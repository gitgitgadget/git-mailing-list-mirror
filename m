Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A5B20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcFVTCA (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:02:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34593 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcFVTB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:01:59 -0400
Received: by mail-lf0-f68.google.com with SMTP id l184so15198278lfl.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:01:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5Xz1qZPD1M9HgMI/Ccj1VxITzMqcTsnCzOD8vMbd0LA=;
        b=IrrPdes1/xmdSQg9qPAcwTZt06WLqUfGJRc6pT6VneVw6wkNsV8tMJcJLIHzI2Y68g
         +QwEDM1eHJyK5Ei2Wigz4suFlnKHIiV7toNl51mhtopfBKqUSC6yGt1CUNNEmh6mYClN
         nqMtQ66ujrmt0kRmfhgF+CNRTLGLmZv3XAdVO5UCpfH2fz2GDG/w8lVXRk8ES76j1b2R
         5k8TDJ5eauRTQ1vB4+VJtriQmQd3m749w4Li3A0NQ+d8r2uX1uH5kPowkPXrPjUdh8pK
         gF9rTYG6/k+g8BfP0G0brI8wzluVcgTAhmjD60soQytDXQiVkQeL7PjUvtczupqnd0ct
         ufAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5Xz1qZPD1M9HgMI/Ccj1VxITzMqcTsnCzOD8vMbd0LA=;
        b=MGB6QPsr5BLoDmxrr8IiZA9dGC1GaFDTSW3vxOM+zdZkBvOFaQPeCQ2zRDele9WgbV
         vVlfJhAYx4VVVSkUSlND8TEHOs5BLt9gEDNaAyOlq7FelnPz1gz3pTvZkyJ+98kwsU+X
         1mmpfLvUHNtaF8Fyg/QhVgH+BTOH5bzjF7jTu6rH0i07oXjEzd6kp0oA7YWPC/IRYV39
         wWHpctWloogvx+uXF0nAWIflCZ+uFAO73ClmIZx8XLUCALeBVQuAgQvXDhU1rkT7jBH9
         0GHrauUI2+S8ERVR0VZrj1ptNtklgIbR5cMf/BFYoPxMoMNnbV0j7FHPMWYOjxUiAPgC
         yOJg==
X-Gm-Message-State: ALyK8tL4kmc/Tlmvu05qR3drszXd4R6sCUKF05wgMNFei3XCQ5ujUsFpVqQTGH1UzP5MVw==
X-Received: by 10.25.22.84 with SMTP id m81mr10299468lfi.180.1466622117711;
        Wed, 22 Jun 2016 12:01:57 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id h191sm169599lfh.0.2016.06.22.12.01.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2016 12:01:56 -0700 (PDT)
Date:	Wed, 22 Jun 2016 21:01:55 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	git@vger.kernel.org
Subject: Use docker for _some_ testing?
Message-ID: <20160622190154.GA17442@duynguyen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The story started with my problem on Debian, which I didn't have and
didn't want to install a Debian VM just for that problem. So I made a
docker image with the following script.

Which makes me think, could we use something like this to make sure
people (on Linux) can test more obscure cases? Sometimes there are
featues that require some dependencies that are not always present on
the developer's machine (http server is a big one, locales come close
second, then there will be lmdb and watchman in future...). With this,
said developer can do a final test run in docker covering as much as
possible.

Of course it can't cover everything. Different compiler versions are
out. OS-specific changes are out (but wine would be still good to test
some aspect of Windows port, or at least make sure it builds)

Comments?

-- 8< --
diff --git a/contrib/docker/locale.gen b/contrib/docker/locale.gen
new file mode 100644
index 0000000..ef08e00
--- /dev/null
+++ b/contrib/docker/locale.gen
@@ -0,0 +1,2 @@
+is_IS.UTF-8 UTF-8
+is_IS ISO-8859-1
\ No newline at end of file
diff --git a/contrib/docker/run.sh b/contrib/docker/run.sh
new file mode 100755
index 0000000..83e5679
--- /dev/null
+++ b/contrib/docker/run.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+die() {
+	echo "$@" >&2
+	exit 1
+}
+
+build_debian() {
+	cat >Dockerfile <<-EOF
+	FROM debian:latest
+	RUN apt-get update && \
+		apt-get install -y libcurl4-gnutls-dev libexpat1-dev \
+		gettext libz-dev libssl-dev build-essential
+	RUN apt-get install -y locales
+	COPY locale.gen /etc/locale.gen
+	RUN locale-gen
+	RUN groupadd -r $(id -gn) -g $(id -g) && \
+		useradd -u $(id -u) -r -d "$HOME" -g $(id -g) -s /sbin/nologin $(id -un)
+	USER $(id -un)
+	EOF
+	docker build -t $IMAGE .  || die "failed to build docker image"
+}
+
+DISTRO=debian
+IMAGE=git-$DISTRO-$(id -un)
+ROOT="$(realpath $(git rev-parse --show-cdup))"
+
+test "$(docker images --format='{{.Repository}}' $IMAGE)" = $IMAGE || \
+	build_$DISTRO
+docker run -it --rm -v "$ROOT":"$ROOT" -w "$(pwd)" $IMAGE bash
-- 8< --
--
Duy
