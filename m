Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88A33D4F8
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994233; cv=none; b=Rr2POVe8cBKPLKi6d4cOFlhxgwOEq/+wqvGS0qEtX1B0iQtlUpT27rVn9XlMKSGPxGgvZr5qdbIL+QnroS+b7yp2OxNtYE8M60gh1AE5gQtf5jqhKv0VfuNwMgvZ1c7tV40QlTZwHF2UY3n6DDxnUXdSTA66XAaTSlu+8HmdAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994233; c=relaxed/simple;
	bh=arRldcb42rYCE7MmDr55PHrC+oWJ3ktJ0apNOlC2QvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGpny33E2Fjkfs+tszZVTRFrOt7buaFE6FclPEBP6W5yLv/bmVptLQ9zt1UtBcepJCp99Ps93P1tXkWxpwXTqIKZkM2p6XTNKIf4nF9YnCyfZpZ9fJ99J538duGvHDWvR6tOTOQWdqUvzog0X6vuTjHuEGwBt+KeDGDihM5/uuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rS7StHIe; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rS7StHIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994222; x=1768599022; i=l.s.r@web.de;
	bh=seXevUanVNMwxcHcKCfMPf3gY0pGW+DN18+hMmbK974=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rS7StHIe4XuaYY49k+/bjo9Re6P4nSnxZCykweFE0yq0Lq9/vxUgFow3wwbb2uLW
	 yYCHPsmjTaAufZO9aaO4/se32LtrU8KB+KVAJgjZeV7u7R+FKI/7wr2A003/5ry8W
	 dnAsBgvNTa21FkJMg3iIMK/VrA1+9PLcvObmmzzjt+M4H6b1Y9Gr8K+7qYl1gLNqF
	 XHdPEor62FbmvcYAlF1VV+NHxpmTQ18QLba0MiF82ugpp0VMMV7EOBXCt8X9+451z
	 FXDhQL1+YwZRYVEyGBuVFmptoI2x9O44uN/Itf9zOW4Aq/zrOjXBFOUa9LOAbJ0Tt
	 S8MgG9EoGx2lmHT+8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1McZjb-1wGh991F1R-00l909 for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 02/10] tree: add repo_parse_tree*()
Date: Fri,  9 Jan 2026 22:30:13 +0100
Message-ID: <20260109213021.2546-3-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/RCVbxvb8/0/BUlb60Ff8jPmDEzawNSYh09Kf3yvpSU/lawnFzX
 +8wwCrn6bwDzvQoYpVlqcRcx853qBPbzQdPy99e1CKFdpzegOFU7s2XlEFImef+vVMDMFSL
 IEzvYky5jMAwIQgU22BDb4mC0JWh7sUCnWjo7NEQXeSmOtxt/wbax9YJ5QmCb90KOZgoqvw
 DgrkmyDvV+Qqckk/IIF7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uZP0dIqBWOI=;HY2UmQpqP4fV4GOlrVFt82IbVem
 +iHMoyvCZFfF65zCiMDLO2THeDc4KI7DtgVlMQJJQManxjc4jGhys23/xRDEawnI787N76NGD
 wYn/2hglgLZG0zJQLh3BBY46M0dqMTg6gALnujuvQpd5SfiWUFVBlT+MGwe16G75ytKdIs2+M
 ZAnR+rNn5XqDVMNLWPKGwG97s6l9ey8S3kUYwyLPkK4qH+EGsKxo1w+m1xnws4wRPOwFtO/z0
 POgsjB2EAKbwaviZG2qDTA3vGfOfcL5Ek1IZ3dkxJqsjRPD1sSkK+66K7vkb6HKKOFsMPaPZD
 ifoAsOD/hJzI7cq+H4BXzsnU3Tz1bftiHFnswEzEOigYn3J2LnLPmN89e99s/SmAMAsRNE0hV
 CIaCD7TVkjvRyUIpx2+C+CeolnLyhE7cWVM+Lsn3vFbIxOeI/8BcmFif3EUykaaAQBypDBaGc
 LTOBifGummVf6BQEVt91NOxivjsH/ZizuG35eUH0pmsjKJ4sxY2/kVrshSia2QPAal813YHFk
 KiaOBJI/VFgMjlyvFrprt46H+BcFASK9U8Tecc7nCxaLcxpXNafHZ74tkgvJoi+8Bqd946SsY
 UeLhqJr/74ETjVrDz4PBP6m0sx2hKpN6Ht9aVReoy2J7qSzYGMemnS7AbZ65kE0u8EgdK5Dg2
 y8W4OjM9V2LAtKMSO3N9PC1EvYWK8Vd1IKnUQJoffcLMDE3/rCh0KPLE/ZztWjnXFY3g3lmVP
 Qu9mohdzCH9pivtO2T+K9RGTNHNeBc+8xRcfp09kj6prsCJdaYGUvbsPGMgxoDtkFRHKVzUt2
 nKcUinmkX2H81ax2C07i2FFUiJoMwcmWo32ZTgD4utO7x9ctdOvLIvHX1k+H/h466lHz2lnuO
 JNZNrMFzIl/CCuC6ARQvnl6gvoO4DtiAv7D+3GujAPyUUF2SaKWu7sEAR4HJSgnEhvD04s2PT
 ODWMHj3NOzbdpYz/R+KzGPV61DVfpdBekxNc06oh509JxPDbVOQxWYvI9CV8f4D7N5nZYIJja
 MQiQn5yXV56L76AFCLsPxYKM5mPttSMOd59QPkEUSV/J368OwdbKgNjRw+K20U4rVh+5CkB5u
 WgGNhwuTkyZLSwX/VY7zT/yLEH7yiylK2I0jCFzRf0tH6V4NX8HbsRnlJ1Z650gw6wwDe/Lqi
 k9U8tCMARXf8eOHTTGm/Ky31aU1Q0HR2kvB0wiu4cU96ARPYk88UTqiDsZ0jBINDqHh//J0KD
 qQKbJ4rK1J1n/Y9/qDzt7kgy5CBnPquO9JQESxTcGvgqsnvXfK3fm2Pt4v/HHNqXIdabmT8ZG
 Stq/5XjkBHUP2P4v37P6iTOMkSP4DzNvzVzItmyY+8JmrMGEalbJhxxOJKy0CLFeAwxCef1Ds
 OidMIdXU9+bHcGtxF1/qkhfHzlACPIIM89UgreQ6QBFhlaRyb2srt9epRiIoKcGC7XoQ9W50D
 T++1ikQc7RqOZOVNzL5kbDJRnvCgZxIVLgLB++wRLiwTHiw9I9fd5xScSbm70Q4WXYZmvhQdJ
 /e2St/xUygyjpHwqjZDDha0sKTU1Zr2vjoljwKploxR3MVW6DGzyO/fKkvytTld6+FqdN5VMz
 Cw05ov9EgtXjPtry93Pour2BBVJdz9mH1ahL3FjKTaFJ8T5l4pg6AboALZbeAG8h2o95yDKhf
 N4k4GNxDrKUHDm8UEybCgdP5Wc2wS51Fa6su7paEN9IQfO0DeUaFvmyKuugWS6FLUa6RnKKQm
 5GucX7/YOCSAXRr+vOw8ee21dKh5UtcWfbU6nYvw4e765V4KTjnc4I/Q5PGnVxJrKzflFFrsF
 huhD08hfUq6BnUC7f/5TmjY8Jw64BkmqK6e2d09iChBGRKXNSRWifmS3Gl9n6POoQGNiRcmXu
 SFjbZJcQQTx3023yG1JY75YJ2m4f2OT59Miog95NiIxCFIquiH+gDjVvRdOCIuIGxvimpQ5Xe
 OIH5MgS4bZAEaG5spqeQLzcNqJ2MP8IBl5PLNh8W6nhFQrQQaR/lp4ocF+fOu0/MLufBPV9TA
 0lQWTL0aOcfC8wtFhB6yzx/F3wAIMogHFBE6n/0odmuPVpsxBnVc0U3dkhoTR2OYTzbs0lOR8
 E8wpd+r05SuDelLbVQQHSmJSt9vXyLWFjIHbvOBZz0YK3pHg6JSaUV0xXZxjVuBkB/R/ahPnG
 2beiGzZYs9m4CUwdfbL4Y6zl+jgzByjZ96O48a5KxMrLNmlW1ZMbLKdeeiqJ6D8I1km245jkX
 AkznShooR0fWlTm2AjVJd1/01X1jEpMw3Fty6GR+itRg7y5S5j42A4OWSvrkibU8zm/J8To2f
 6bhZsMAsn3UNwqmtcSOIA2S0cvkRhs3SfYfE5M1fL171CwshhGuzjZxn3OxzzyQlX9rRbvY9d
 hFH23vYza4g57kq/gmaVrl9RMjGrqbSKFGzjG9IHxMzUhbtR4em19GSCJ7Jkruiisvj2M9TDQ
 JoSe7oSxhgJW0OkwzZEe5WlQ8csE/91X7BOx33x4Xwtot+Ag6c/p2HqItzkhyom4vQxn+ueHo
 sLQB0ADMTZ3LLL+obnN07AU/Qykk8zZBlGcqoQnUdAfGHaxzmmAYR91QfnZS/fvgydjH7J1Ng
 XMACfbRw5WH1FwclvPWqtCA4hgobz82+JBbyPQPHKXU2VCl2j4KKbT0CxYe0QAKhF5h3tXgvH
 3oMF0kgudBM/MsMOh+L+VmxiVREXqKIQb+anSZ3GInIX26wYkbUJAZwm+ZLd+TVwYJZFW1IhH
 nR5VoU3yklN366gQIDH9EAgNCAEMdt1+/HLZyNB7hV4CguDO4YrSirF+UL1zqx8F/s1ZCBXfz
 f2LlBgbIBndYnmgh1OTH1I2aaTLO0BtcMbwIFrNLqugLovOzNaYmsq9+pX+F6aOZMziQge24T
 Q8Cy2VVLYR7ocJLLZM4gj9iwCV02FhZV3brH/MYDsgHfgN+25TrMdIeTtFEmr1wglIiJS3S5W
 QjW7xtZjUDd0E4w9QcLER12edj9l32IjeyD8QQffPLPIJZJskuoHt13cu2e4Ntw4fiuCbzkVX
 SLUkOH/LeI0N1muyFuJQ0iEl8yvPn1FMGggILgl18vnmpXBee0lw6jVhdGfkCLiv6e9JawL7f
 Ixv0yDWxdkwmsUidYQ90s53cn0fIdYrGjpeqv2wozDF1RBbnwIgY38g3zxEmTUSCSpYUYXU/l
 i3W7GnLQA29nw/uP/Cc0t9nEymHjrk2TVZ/C5IOsy//SMM+rTlFA+3Yv0lGyr356x8iEsWnlJ
 +rnsqsQ00m2FcFx4ZieUDqAsJeF1nUtRydbRzKalRyqPFiFLY9s8IPggcHzjD5IUMKC8T/3NZ
 CAqkDWKtup9Fmt4kONat4JRFBHRptxcvAeDTSWEjCMDR70qGSAhUn1+lryGgNrxUseIdy91Hv
 4ucjzKOj5ICK/d++Z+h8YPLUifdhh3E9SWc+7zOq5grLuXvlX0J+eFokI+ZZkq/EZclN5Frad
 qHIVDqYkh/Pogc7aXv3symS/DkmtjfozXluQiFu41cgqmMgSV4gBGWAEm6GZ+fHqZWTjK7I/w
 YWKcD32HDJM0xEWT81x4C11LtT4+0O4CSo5hOxUleCXyVokILCxoi81ssyMEYDt7dnvIbCXrj
 nR+JUgPWLpUmTChubWYcs5WhzBtKnEvLLvaFe5cZnS4G4VKZghQpyiNe9L8zxDB8v3UwgpIQ4
 SPlPlB1XzcGU0ALciA7QPRax6PDyssvLfsOKuPNCpjGyn24QNjpYBHKRuDiyV2VMumpD0sSzE
 /COmbyhUXTK6rft4KAklng6GTDzPUMRIY/Q61i9X496lemn3CFU4IovQCxAw4ZksBsrPDeg4s
 42VkqZlh6tbZMOnZzG4d8os/YjWK1HVq4EwERyD6OyklAJEF0gt2iTuf9+x18Uk6QmaEvmGkT
 B+FZExPUjzYWov9hb/sgo2y7e3UcvEtAMl9zztNpGxgIQ1uR4IRR/LEnLZ0U8nxWkshjsvfzg
 I2GNXa/S8r+TTy+yMaThlGIkjZd0eoZCvV+QRWGtfKzf3LkojErlI9Js1+OZrhf6aQ9HJrvgh
 tosf5eQAjVliXH865TGBtS5ASwJM2+a2rWsZD/JpxCCMLxYGh8AS5yng5qlw/hcWss0whemWA
 yEw0skAwm0zXBEVnaagn8izBIcFVzBOk9uDLfaoCWHfEOVDFWAmb2gQq13NZ+vbLEGRsmUGM0
 YUkSkUN/8vfAT0NlERtZeI6K8htPpmT0cULp4dAq/a1E5znk+bfjeFfTr0RPjRlrLpWWV5u4R
 MjuiwNCjeiLpqXKzc4Nu4e5ER2NZy9WW8PWE0Ln93FJFur5G15eVe4HBTZRN3s/SBgVEoCpt2
 x+UV9Y+O16Af0JyOY1hngBZODRLgzUfXPgB10WjbxCQAXWLeJd/UxstNlr8twFSJ/6AG06AnO
 vjORXch+bWrvwbuzioauiSS1UhrxKRRhAzhDzKZQVr6h/AmYcoHW5M17RZzYH8ZNgJDX077bI
 f1YG4WBrXJ/RXWAdwI747z8HU+02YsXgQVaaBgsspoGnKFjjFdIM2WInoSF91EeuSBBQPkI2R
 pAMHNKXzBAd64mj6fgKf/0EYEX7r+tIk0ZPFw8FZQ0Ro++1FMWjvjmKihbQhBwj5jDrbFSmBQ
 KTmJFKdb3nk9CHQpk2fBdCdWfHZk+7CxmE5QniJ3P7rd10wnoZswEUVYUL765/FmK5QMHwXn7
 TZiz7yVXKyms7BBGmA8+hBWy7RHoH1LWdXYxlJgJlGbP9gqVY5/EGoX6bfcBazoF2du9wXz0U
 pWTC2jgo6S70QT9k8+5r5XP0YfNHVuLoOsFJNENzgVDGICNs1PTdLNEsOK2g9SWSx9/At0c0b
 eoa/Qdn8p8QhOnHBvEhJKYfY2Q+7ylAUD0Xw183n0z5jeiyJT3edX3m7mpJgc/2f3hjxVGFhQ
 JLckp941drDkF95lpa2IRwT434nxhbqGWpyLE23OJeoGzFNepjSHeIMyEJB/pLGAe3Y473f/l
 3P0x1TimeHZ70V+e+xTVMYcqT2MO2gg7PqHHOCct266lHEjraEJcIo1NrdTwWz2jK/+DNiiaS
 ynnE4lcP7gLxoThP2aI4IGvodgCtm7YQEbqgOjWLpCjfNa/4l+b4sZLQ6n78FXA7LwhZA==

Add variants of parse_tree(), parse_tree_gently() and
parse_tree_indirect() that allow using an arbitrary repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tree.c | 16 +++++++++++++---
 tree.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 2a677234d60..036f56ca29b 100644
=2D-- a/tree.c
+++ b/tree.c
@@ -186,6 +186,12 @@ int parse_tree_buffer(struct tree *item, void *buffer=
, unsigned long size)
 }
=20
 int parse_tree_gently(struct tree *item, int quiet_on_missing)
+{
+	return repo_parse_tree_gently(the_repository, item, quiet_on_missing);
+}
+
+int repo_parse_tree_gently(struct repository *r, struct tree *item,
+			   int quiet_on_missing)
 {
 	 enum object_type type;
 	 void *buffer;
@@ -193,8 +199,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_=
missing)
=20
 	if (item->object.parsed)
 		return 0;
-	buffer =3D odb_read_object(the_repository->objects, &item->object.oid,
-				 &type, &size);
+	buffer =3D odb_read_object(r->objects, &item->object.oid, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
@@ -216,7 +221,12 @@ void free_tree_buffer(struct tree *tree)
=20
 struct tree *parse_tree_indirect(const struct object_id *oid)
 {
-	struct repository *r =3D the_repository;
+	return repo_parse_tree_indirect(the_repository, oid);
+}
+
+struct tree *repo_parse_tree_indirect(struct repository *r,
+				      const struct object_id *oid)
+{
 	struct object *obj =3D parse_object(r, oid);
 	return (struct tree *)repo_peel_to_type(r, NULL, 0, obj, OBJ_TREE);
 }
diff --git a/tree.h b/tree.h
index cc6ddf51b32..9037891d30f 100644
=2D-- a/tree.h
+++ b/tree.h
@@ -20,14 +20,22 @@ struct tree *lookup_tree(struct repository *r, const s=
truct object_id *oid);
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size=
);
=20
 int parse_tree_gently(struct tree *tree, int quiet_on_missing);
+int repo_parse_tree_gently(struct repository *r, struct tree *item,
+			   int quiet_on_missing);
 static inline int parse_tree(struct tree *tree)
 {
 	return parse_tree_gently(tree, 0);
 }
+static inline int repo_parse_tree(struct repository *r, struct tree *item=
)
+{
+	return repo_parse_tree_gently(r, item, 0);
+}
 void free_tree_buffer(struct tree *tree);
=20
 /* Parses and returns the tree in the given ent, chasing tags and commits=
. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
+struct tree *repo_parse_tree_indirect(struct repository *r,
+				      const struct object_id *oid);
=20
 /*
  * Functions for comparing pathnames
=2D-=20
2.52.0

