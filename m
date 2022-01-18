Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A5C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiARMqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:46:24 -0500
Received: from mout.web.de ([212.227.15.14]:44547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236231AbiARMqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642509977;
        bh=s59ou5DXM40SC0/QIIAqfUk/4DCmrktlcIyrCWbGtqQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LFv+ljG0wLoeCiHYZ/zcVKMhSVuK1e4ZE5fickdT3LUNtJD7e9oa1S34B472Gxr+x
         DdFFV0Otf9A4EBiBpsfO7TLQMfTjtz8zDYX3CjGwMJH4TTJQpr6Kd/+nsubtneJboY
         xX1QlPIhZMsEvjY9SzbSovoi1YXFtdoMNHDtXBpU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1maBwZ3K9T-00Zro0; Tue, 18
 Jan 2022 13:46:16 +0100
Message-ID: <bdcd0e26-3ce9-d646-70e1-61ff7a4b6dbb@web.de>
Date:   Tue, 18 Jan 2022 13:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: [PATCH v2 2/4] bisect--helper: release strbuf and strvec on run error
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/HsZTt0OtXuRptMjGsE8CRVTbssKhSS9zja+gWPYstKNK6esheQ
 qWQo6sh4f7UOUU3LruyuacMeXMDxbFQmVfPz6ge7nTOBvYDS2Zv0vytPfBBResrncuQPeWx
 2ft1XVXzr62yrNDMQs8/v2S8IO8L/R6+OLjki/O2lSENuQ1Lo3FFO/Yu3vH04cztPT8aQX6
 P1KIkqPFVICyj/lKGVagw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wt0dxjiMel0=:+REseKHTzGY15f63C4Qhv/
 XrUVcYGmgQYYApLM7vCnC2H8ALSsCDZQUDGRhMVQIKCC4L4rS7R8Gm88jo0VTrL61bAPcLfQe
 TJvFq506yutWTDFVnN0G2UnTLGs5dQ6vdzJxfr1EAdlNhM+ma/oydTeMtKerD19QeMvWmmi7X
 l4EmrUJvo42EdN5D8xMpuAOVIQRLGQT6xeTQSjel1oNiG2IKdxgq6okCbAUsK5V6GBxZWc1oU
 qKOabPjeo0ZBZHbM1FDAao2X3IPfveEUDD9KTL/RLMnmcbDQ/YVQSk5+2AJ69+uaElN9WLbc4
 pzmcmeYKY2qcOB7+vS7b2nlRtILVeI1Tx0az46207359e9+xB8QGepdVYpFlct8mbfba1hRe9
 M3Xi8lTa907TyW/inwkixP0XLdn7djImpmV7DuCd07e7QnwMy8QxEikBMzZlVWFjnEKNFbBxR
 BjBPxndjw+Myb/Ohd1gvFinoBzK4oZCo+AwV5ntFo+C7ju9yff2Z7XNPnPsdRsYL6z6aN8ThR
 Yfz4DCuaZcoKOtvKQLYqe7C5q8fdt6VHTaRbWTHVqRT45kyus9dXsZA93TBmcb+SjvGNPcSoy
 M8fXZR3tnttLKF7J8cYo3F2NkGavfcSTRFmFRjwVqKjbZXsX5BGgujXge2Yz9GTyxnpkIh849
 GjqZERmB707PdK5fiIrnzQgvjndtHrmaArpyVDObVISJpla05k1hRFbD+M0vnj6JPQTlGcPwn
 XzSX2jSp42WaNByV4Fk5NsRPGKNSaxzWRow6b7JmRrofYmm3YwMKp3yh5/m0AeMjE9ZBy+zPT
 fG+VVYFR1bYpOzapjmhHM1BlARW3eMLJ4ABpU7nZhpWc0hqGCzxEpGyGj2yfE7PmlqDzXsg08
 5u/CPuRfWAIcFWclYk/5n5sQr4J3/Fh4PM6IaphWmJb6xbciNxrqFUkQkdfnan9V8KNSL1TEW
 FqgqyTVWZN/aXtfXPfJr7Jv+tbitWLK0dDGpDfQtf2WQe598nRwvu5B50MfQ2pR5o53BmpKgt
 n+hKR9JAcvEbQVgsoD9auIoLAos2z+JpgzJAyqVBdnFZ7xUcGlfvOwo/xlH1sVtnwXmNsxA8p
 1/wBd2qMq4XB4w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the cleanup code out of the loop and make sure all execution paths
pass through it to avoid leaking memory.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/bisect--helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1dbc6294ef..e529665d9f 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1116,8 +1116,7 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 		if (res < 0 || 128 <=3D res) {
 			error(_("bisect run failed: exit code %d from"
 				" '%s' is < 0 or >=3D 128"), res, command.buf);
-			strbuf_release(&command);
-			return res;
+			break;
 		}

 		if (res =3D=3D 125)
@@ -1129,8 +1128,10 @@ static int bisect_run(struct bisect_terms *terms, c=
onst char **argv, int argc)

 		temporary_stdout_fd =3D open(git_path_bisect_run(), O_CREAT | O_WRONLY =
| O_TRUNC, 0666);

-		if (temporary_stdout_fd < 0)
-			return error_errno(_("cannot open file '%s' for writing"), git_path_bi=
sect_run());
+		if (temporary_stdout_fd < 0) {
+			res =3D error_errno(_("cannot open file '%s' for writing"), git_path_b=
isect_run());
+			break;
+		}

 		fflush(stdout);
 		saved_stdout =3D dup(1);
@@ -1159,11 +1160,12 @@ static int bisect_run(struct bisect_terms *terms, =
const char **argv, int argc)
 		} else {
 			continue;
 		}
-
-		strbuf_release(&command);
-		strvec_clear(&run_args);
-		return res;
+		break;
 	}
+
+	strbuf_release(&command);
+	strvec_clear(&run_args);
+	return res;
 }

 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
=2D-
2.34.1
