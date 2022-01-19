Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DCBC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356539AbiASRtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:49:43 -0500
Received: from mout.web.de ([212.227.15.3]:60767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350491AbiASRtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642614554;
        bh=Isy/2FzHcmVbMA397MKPwiThdV1TWZJmuPM4Jqzx1+A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bObxds7BQrddbu+7t36qTAHPSZ6tMrx5VLz2ezkkgGWloCtC3OtXzEumcWaeNmTVO
         CKss34x6eqswelZPMXtH+rAO/8us1IYKtgbt0SxmIrdPYHcdAA9EqyCwVk8W7Nch6Q
         0o2gkkmRvJx8XgjR6aExqK7wjRBfTp5HDg/3Qkf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mty5w-1mIP0X43ae-00uVYT; Wed, 19
 Jan 2022 18:49:14 +0100
Message-ID: <53416697-2047-67c1-145b-895f147c91da@web.de>
Date:   Wed, 19 Jan 2022 18:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file
 names
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
 <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
 <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de> <xmqq7daxt0pk.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7daxt0pk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Enqpy3Ye3YicAuynzLgUa2IdVzlO5jT+usjyagmSxfQ2JtH0cKc
 Cxw9fdNagGYc+Q4B+g6cem2cSLYdcCx8KME07LFOUNESW8qdGqcAPu3jFFXnSjopH5w+5E1
 8Y3aTGH0nBbZjS6HSKBS6yLcjutiBt89//kv0wZmeZfkwur0CLjNAmaq/4ushIWHHXDHmtp
 M1xTwOE5L8MSelA3iMEvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ch4bUq6Iq/Q=:XHDxlIp+D05nTCJeLooc1b
 AoTBytivAg5SbIo6GUyhqAjn6jlxCrb8CtB/4JKXsWMQPTAXgnOVEL4DLYu9x9JCZ4Xklq6xW
 qJpVRFJjdfZGP3xW6bn0TJSDwrH7zYBSilfQV0qxomzqK6weZxAzX6vO/ejGM4N+QuvQYv//U
 lDtKly7NknKrGGRfVGCXp3nEUpC6QC8UunkFUs78tOAOq3EngdSik7v6+sNDqWkh+BNi8smsP
 HU6equGeA4bLuJXokX1OkEw7mLihK9YnsR9TsxW03RZe50i3BBo8K2MOw/BlmbuonGWBM7OJs
 Z96D9csyE4eAkAC0uExOmcY568rompbScrZ59je0KgyVR7RSnuNMf+oSQjD52CLJRXmZFMTc6
 FJRov5Jr9Q5OJMAfN8clQSZNb/F545hjULNH188QMxrUfndFE0meKFrfuMoElM/DjlaRBi4ja
 ciypFV3sR4dyMF+ZTLR4Xg7TF6nIkscMNe1eEkYE3QVt6Z7N04vPMjyYFvayw0q5XdyDhTzzt
 Puj2JnX9CnAJjDUglc5u++trLcDNQ2j1mob5WrcWXcubkGfDEWDb16g8pF67jU4eg/XVAln1q
 ALhnnUAR/SNy4v6FmijzMSXE9CUjaHZHi1Rm0GJL9rXLThvJ1t0xBD/GNt+bYwQQii8HJl+uw
 /cX0EfAwXb1OkMgAIKHbqCIb2xDyzF/EGKxd/MGHe8JVEY4se100SmXiTNsZGxzdAaAt0cA+8
 XsXd964yFoVxn+Dt0myID8xanlgDIXrEiBkzlGf5IbPo8qhIFVD+eespEqdMEHPXgQs0LKH66
 QFx2XYJ1yv9dLAUMs56p2wKFUY+Ph2O1K/0OzDnS02zUsbZP5RCvulL7S3W8Rzf1VCckWSkvq
 lnclK+iH3rxTWaWOB5cn7lqYU/RuAHLngnJFqG6zyrU766Gao8FK4qj75NiqAPK0yU1ub/cGQ
 3o8qQ8jq3GCPUuTrGH/lW7Ieh99G06fVHZNErAAyBJ282sOT/YTAaMHQrRu8HoiMIBagTEmll
 yneSDdfLGZyQerhe+b+iFn938X/9+y9fr1n47s2Ph9GrZX8wCEsyCPLgG9XrRV24683ZEEk5E
 +p/HvtUVDvRHwQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.22 um 18:25 schrieb Junio C Hamano:
> I agree with your analysis that the "diff" tempfiles do need suffix,
> we SHOULD create them in $TMPDIR (not in the working tree or
> $GIT_DIR) to support operation in a read-only repository, but we can
> create a unique temporary directory and place a file (even under its
> original name) in it as a workaround.

Here's a proof-of-concept patch for handling just that diff use-case
using mkdtemp.  Indeed it's nice to see the actual filename with
difftool.


 diff.c                   |  4 ++--
 t/t4020-diff-external.sh |  2 +-
 tempfile.c               | 20 ++++++++++++++++++++
 tempfile.h               |  1 +
 wrapper.c                | 12 ++++++++++++
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index c862771a58..37db4743b0 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4098,8 +4098,8 @@ static void prep_temp_blob(struct index_state *istat=
e,

 	init_checkout_metadata(&meta, NULL, NULL, oid);

-	/* Generate "XXXXXX_basename.ext" */
-	strbuf_addstr(&tempfile, "XXXXXX_");
+	/* Generate "git-blob-XXXXXX/basename.ext" */
+	strbuf_addstr(&tempfile, "git-blob-XXXXXX/");
 	strbuf_addstr(&tempfile, base);

 	temp->tempfile =3D mks_tempfile_ts(tempfile.buf, strlen(base) + 1);
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 54bb8ef27e..e7f93f36f5 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -217,7 +217,7 @@ test_expect_success 'GIT_EXTERNAL_DIFF generates prett=
y paths' '
 	touch file.ext &&
 	git add file.ext &&
 	echo with extension > file.ext &&
-	GIT_EXTERNAL_DIFF=3Decho git diff file.ext | grep ......_file\.ext &&
+	GIT_EXTERNAL_DIFF=3Decho git diff file.ext | grep git-blob-....../file\.=
ext &&
 	git update-index --force-remove file.ext &&
 	rm file.ext
 '
diff --git a/tempfile.c b/tempfile.c
index 94aa18f3f7..80cc9fb512 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -56,6 +56,21 @@

 static VOLATILE_LIST_HEAD(tempfile_list);

+static void remove_template_directory(struct tempfile *tempfile,
+				      int in_signal_handler)
+{
+	char *end =3D tempfile->filename.buf + tempfile->filename.len;
+	char *suffix =3D end - tempfile->suffixlen;
+	if (*suffix !=3D '/')
+		return;
+	*suffix =3D '\0';
+	if (in_signal_handler)
+		rmdir(tempfile->filename.buf);
+	else
+		rmdir_or_warn(tempfile->filename.buf);
+	*suffix =3D '/';
+}
+
 static void remove_tempfiles(int in_signal_handler)
 {
 	pid_t me =3D getpid();
@@ -74,6 +89,7 @@ static void remove_tempfiles(int in_signal_handler)
 			unlink(p->filename.buf);
 		else
 			unlink_or_warn(p->filename.buf);
+		remove_template_directory(p, in_signal_handler);

 		p->active =3D 0;
 	}
@@ -100,6 +116,7 @@ static struct tempfile *new_tempfile(void)
 	tempfile->owner =3D 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
+	tempfile->suffixlen =3D 0;
 	return tempfile;
 }

@@ -170,6 +187,7 @@ struct tempfile *mks_tempfile_sm(const char *filename_=
template, int suffixlen, i
 	struct tempfile *tempfile =3D new_tempfile();

 	strbuf_add_absolute_path(&tempfile->filename, filename_template);
+	tempfile->suffixlen =3D suffixlen;
 	tempfile->fd =3D git_mkstemps_mode(tempfile->filename.buf, suffixlen, mo=
de);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
@@ -189,6 +207,7 @@ struct tempfile *mks_tempfile_tsm(const char *filename=
_template, int suffixlen,
 		tmpdir =3D "/tmp";

 	strbuf_addf(&tempfile->filename, "%s/%s", tmpdir, filename_template);
+	tempfile->suffixlen =3D suffixlen;
 	tempfile->fd =3D git_mkstemps_mode(tempfile->filename.buf, suffixlen, mo=
de);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
@@ -316,6 +335,7 @@ void delete_tempfile(struct tempfile **tempfile_p)

 	close_tempfile_gently(tempfile);
 	unlink_or_warn(tempfile->filename.buf);
+	remove_template_directory(tempfile, 0);
 	deactivate_tempfile(tempfile);
 	*tempfile_p =3D NULL;
 }
diff --git a/tempfile.h b/tempfile.h
index 4de3bc77d2..b9a60f2431 100644
=2D-- a/tempfile.h
+++ b/tempfile.h
@@ -82,6 +82,7 @@ struct tempfile {
 	FILE *volatile fp;
 	volatile pid_t owner;
 	struct strbuf filename;
+	size_t suffixlen;
 };

 /*
diff --git a/wrapper.c b/wrapper.c
index 36e12119d7..358db282f9 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -481,6 +481,18 @@ int git_mkstemps_mode(char *pattern, int suffix_len, =
int mode)
 		return -1;
 	}

+	if (pattern[len - suffix_len] =3D=3D '/') {
+		if (mode !=3D 0600) {
+			errno =3D EINVAL;
+			return -1;
+		}
+		pattern[len - suffix_len] =3D '\0';
+		if (!mkdtemp(pattern))
+			return -1;
+		pattern[len - suffix_len] =3D '/';
+		return open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
+	}
+
 	/*
 	 * Replace pattern's XXXXXX characters with randomness.
 	 * Try TMP_MAX different filenames.
