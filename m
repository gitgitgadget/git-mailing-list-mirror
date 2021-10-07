Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E3C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3562B60F22
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbhJGUeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:34:04 -0400
Received: from mout.web.de ([212.227.15.14]:40353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242624AbhJGUd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633638719;
        bh=m6DIhPWVz1Bux0/ieEVCmXk1q0HC/M4bL+orY0KktCw=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=U40znknlYW9OvnVWTVxIvXwhH2bJQR9psnOTPwuWJrjjwpZVRlVnM7EIMcA/+UE5v
         66ZNeQiqcQRqpJX1f0f2nSA2txIUvI8lLr0KlkFQSakUE73jGvrMkGZCvU6p6m2LCs
         Jm73xoipwr2d2FP9UQ8YK52oX/KIZR8gK1e7vMpQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M6UiB-1mindk1Ltz-00yT4d; Thu, 07 Oct 2021 22:31:59 +0200
Subject: [PATCH 3/3] read-cache: let verify_path() reject trailing dir
 separators again
To:     git@vger.kernel.org
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Robert Leftwich <robert@gitpod.io>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5e6fafa9-f155-61af-6906-05fec27808e6@web.de>
Date:   Thu, 7 Oct 2021 22:31:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VV8hB4BVMMROHL7K0ISls4UPsD9AzMMJux1ul7Q7qKAas9QSndn
 fo0I5FeHOPq8H49h5FAsH8irsmtG4Lgh9rNSdXxlJd+3yLV2v5zTlquifZwJWmm5hoCaA30
 TWLmerPOu6e82rwh83cne1s73ipPaiXE+MGZk5oBIDOAH+hEkPMkOJZcQHAs/Vt+CYjD9sO
 84Xye6HsCEyc9HsOrpB6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UB44buz+v+Y=:bfEVECwbbCd9z86n/U1oRg
 rmM5T73MNLraMtneyEVdffhIG3cB+gGvDE1zF3jcpHsZSWUvekXw9XUmtvQuyLepeKMxlU8Ge
 PdNMVDVqdlRN2hcn/MMndR0mibH2tHbLzVgDDbwZjmhZzLhc5AOL8Z9CKthAgo981scuP//Oj
 X43U4DvTbeb3KEq7ZQm1ZBaYh8D+ZNfw6eavc71LhFD7B6yr8e1V+BEy91BnCRBwdQrf1aqPg
 mquqoGHAHndfBwCM9jcsf/l0byfxFf6o6lcVTwMXP6bMWC3FW4DuotBJvD3F2XvPbWQLyaUbB
 rSqT5KOCjz1GKZQlTFKIZB2ZpNXM5uPjNQ/Td9ohbxYkd+BbziOBUF+03JmMizxJrYAMM16QR
 gjHXLyZ2NOvOurpEHb9f7DJJ3ZyIWsLLGrKLWa6e3OTYmKYw2knpr3R/Yksj5R7AZSW8MpP3N
 Kcti799Z9zPGDzyy7lx7/6UNZoGPZpqljTCJuWob8Caav25d52EpQF+ho1p2VGcrtmyg+AE6t
 AlUktUYy2/GxYxeYlkZgrcsc3jNrIgN20raFQa3+exFCdr1p0uX5SiObTwJsuggTmEMJi/JAf
 0Ovh4Z1cj2CAJEmV+nGciaPR3HeO10A2RsavupkzypLWh+Da17TtCBLVpqNTFlxVIoOwzOhbI
 PImHa/zvXUHmiz3sHgUN1xzP5E5GfYI97hXZvyliH/Ea/FT6qtE/i/ElY+z3uvsDfVL9XIpd4
 UpYfGs08xOd5Po8hbciVQxhdq8ewiD+qIxVv7izl9ZSWH8JpV5Q/bt4sxprgaEjTkVvir0LdZ
 MA1XmEc9t6Ha1MiqzMxgYhw9TG5bEKXu8WWczO5RW+gh+wypD+d/g4QMNt+VjIndyFOTKPC1G
 f6Dw4Oi4EaNDeqPSoTyMhP5NhlW1y+VvE3DzmeKhDB8IZPhtTBvvcj907FcecPv1VaEc2wDUm
 dlJzQA20dsIKGIb18UJ5uFs7sUKff4T1qPVgm6Niad+5XAjupYun4VUPtFiFpRzKA52bsS1pR
 P/UJy/ApAhzXRHXzyCoMJ5kHAmmAdA/6ab9fMVhv1HWj6xiliDdAwC/Zv3xzkvCT3dAIx7WPj
 P9DplRimmvKF6w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6e773527b6 (sparse-index: convert from full to sparse, 2021-03-30) made
verify_path() accept trailing directory separators for directories,
which is necessary for sparse directory entries.  This clemency causes
"git stash" to stumble over sub-repositories, though, and there may be
more unintended side-effects.

Avoid them by restoring the old verify_path() behavior and accepting
trailing directory separators only in places that are supposed to handle
sparse directory entries.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 read-cache.c                       | 6 +++---
 t/t3905-stash-include-untracked.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5b6fc08e46..f1aabc47b6 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -859,7 +859,7 @@ static enum verify_path_result verify_path_internal(co=
nst char *, unsigned);

 int verify_path(const char *path, unsigned mode)
 {
-	return verify_path_internal(path, mode) !=3D PATH_INVALID;
+	return verify_path_internal(path, mode) =3D=3D PATH_OK;
 }

 struct cache_entry *make_cache_entry(struct index_state *istate,
@@ -872,7 +872,7 @@ struct cache_entry *make_cache_entry(struct index_stat=
e *istate,
 	struct cache_entry *ce, *ret;
 	int len;

-	if (!verify_path(path, mode)) {
+	if (verify_path_internal(path, mode) =3D=3D PATH_INVALID) {
 		error(_("invalid path '%s'"), path);
 		return NULL;
 	}
@@ -1364,7 +1364,7 @@ static int add_index_entry_with_check(struct index_s=
tate *istate, struct cache_e

 	if (!ok_to_add)
 		return -1;
-	if (!verify_path(ce->name, ce->ce_mode))
+	if (verify_path_internal(ce->name, ce->ce_mode) =3D=3D PATH_INVALID)
 		return error(_("invalid path '%s'"), ce->name);

 	if (!skip_df_check &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-un=
tracked.sh
index 19da46b7fb..5390eec4e3 100755
=2D-- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -422,7 +422,7 @@ test_expect_success 'stash show --{include,only}-untra=
cked on stashes without un
 	test_must_be_empty actual
 '

-test_expect_failure 'stash -u ignores sub-repository' '
+test_expect_success 'stash -u ignores sub-repository' '
 	test_when_finished "rm -rf sub-repo" &&
 	git init sub-repo &&
 	git stash -u
=2D-
2.33.0
