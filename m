Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85575C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjDXLlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDXLlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 07:41:51 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2093.outbound.protection.outlook.com [40.92.50.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985DF3A8C
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 04:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dchBoCg/h4Xmzlmgo05Qc7c43ZdpeWzLOSzyrYzLEMyx80plwDB8euzE+YY/USpCL5HppP6Xyjow5G3fckMkNwaVwN9PB86pQETt6jG7BSeYO6gz51P4568WDJ584mtdykdHGt6e+r6EyfCb2tBIbgAuyEa8GiS+bbMVorhrLX4NR9GEaqLEhLPl898cx82aLbm7lnw+brO09vdft0P4NdIFgIslgzj2ZdIUX+nsTGxumZXRS4lCCRi5OhZ7RbRUJmBk1Kk2Czms78vf9KbiNq2+j2W/Djl4gqEaejbd98oEJka70griFJUkJ0lTT4xUnIo7cXs9K4xowcu/cKUXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p5f2Iky1e3Fan43yPAxrAEJYnxsWxt5H2Ko8HwV1qs=;
 b=l8ZRM36t/f0SXMss/1p1yCO9IeLh4Ul/WdX757NiBglYFfabQc7SEs0aAC7r3NnAO14dBcZ1Mg6PCu7LGh543PZBDeP4dEfTGYslZGGNxaAjYVbOQbF06etPjHS7t7Xa6lN79DacKftaIBNks/kVg4fJ+99dMtfBNWuazOXC24UzcNv/f4lgL/iccPwvD4FXZuCjsrouSKXUHOorhadHNinHIebwR6ScmF0tgvtrEUxN6CiO+dKKMvkSyIKRn7t/ige67ZYL9VT4wrMfL6PkN9aYPsB8DBJn/VhJ/zhIx7PgMDVpz3wdOKUt1MrZPhdOP29lE4X81Q34Qv8OefSFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p5f2Iky1e3Fan43yPAxrAEJYnxsWxt5H2Ko8HwV1qs=;
 b=IT0JAqTJVLz/XqZe2eyBNkkdrUSz8DuZGi3+TG9cS6vgiBJwzqLqT/sjqHwvjsK9ymyvuw6Gmb2XnNvykOYjQ5MLKpEeXKiyO6IUFeSn67NwJRWRr12b5lr43UUWkxyxsk+ftgAf5B7P8Ez5WF18+VnmtVfnM7UcTIBpIe9JLhvPiC/U16Ndmqcdx0dKhO62Zp2oaMB4GB2cuaPQNRSPbPqTgeA5m3WJvXTEACneouGt6T1pjzbAmEWLa6xeUL+4cgdAXC4ZxJAnZ5igXHankW2Ex7ji6cxTdwXITsEyhNsp8u6j5LzJI28F2HLr3QDmyDkiWN/cK8NxUhx/x7dUzg==
Received: from PA4PR09MB6516.eurprd09.prod.outlook.com (2603:10a6:102:26e::7)
 by DB8PR09MB4422.eurprd09.prod.outlook.com (2603:10a6:10:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 11:41:47 +0000
Received: from PA4PR09MB6516.eurprd09.prod.outlook.com
 ([fe80::8239:6b07:29d9:4ffe]) by PA4PR09MB6516.eurprd09.prod.outlook.com
 ([fe80::8239:6b07:29d9:4ffe%5]) with mapi id 15.20.6319.022; Mon, 24 Apr 2023
 11:41:47 +0000
From:   i o <lvsil4@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Proposal: adding --soft and --mixed options to git checkout
Thread-Topic: Proposal: adding --soft and --mixed options to git checkout
Thread-Index: AQHZdqGqIJFOd4OKQ0OsGknYTVP2yw==
Date:   Mon, 24 Apr 2023 11:41:47 +0000
Message-ID: <PA4PR09MB65161C38AEFBC07B3D7A1C62B0679@PA4PR09MB6516.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [nUoRh6jPNRdzflD1UuKmYsiYKfnjMwtY]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB6516:EE_|DB8PR09MB4422:EE_
x-ms-office365-filtering-correlation-id: 66e52148-99c8-478c-cb1f-08db44b8e301
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mOV0Ekx6nYZL152Btlgoai+u983ts/XQWO1m+J3t4rsf6Phs3uGQhdTpOLwpXRi+lJNSB3uXIUaiSokfQPmwGgXBkqaRaRZFE+dnKTs1bd0hbiG332VVyBVCAr5/vkooHCmZP+NEVvC9ieIC0HCDxhjQd1BSmQt3g763n9rPCvxGVF8Rlg4DejXXt9xJt8CGFwBhGKA8x0fVw5NYMBrbobv4/aTAxwaSJ1eIsOwdixokE+kNQiitfV/nm/Qm4hw1CxgZ/OXcO74Wb3af5egU/AzEbVCdBXwzvKrtwgCiaxwtkcA2D6ZXiG0+xvsD91D9ejQYN3ve2KZo1PXBZQgnzX878hQ0RBkgoFwbS5q5g6exoWn+eSOKEzYLYusfQgf9T/+OhUCA5tcS4Jb5BRmYe6HDT/i598cBEH5BZOoIxfAyHKMAXnyYOyMV2W6cVpM7EhnobD6vJcnJT9N6fQp6dkQdW4SRK3HglA1uawwSQ9PP6k/6r+pK84lVezEFGRSNBSkUErm0J5GOI+ab2BVc4l5H9u9+3QjNcVYXfPsFj10FLXKfo7QdwW5KZHh07XR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FPz3A+j+n0E/Z/6Gq8dGipNDBPh4eGoGZEqT60LEJaR8BxXCJMBhKYMHon?=
 =?iso-8859-1?Q?juVxE+bmginFfQVhAVm5gG67ZKBEZnyDIOJLOR5rBTZncYBMwxVbQE33T7?=
 =?iso-8859-1?Q?qiKFWllZYgLDA/Jhztzd1ZWB0c5lcne8ffi3UcEJeG8mOX/cujnk1Cz4dQ?=
 =?iso-8859-1?Q?LoDMMYHavMXVqrORFAdo6ZksGNSOxWfYF33Xo0MUKDTHsMFUG2edT0AYv4?=
 =?iso-8859-1?Q?toPRvRxUIdkpjmm8MGMzr1lgMG7mdEne3N3vGqUlex7XQ4y7HcQcFX1SWk?=
 =?iso-8859-1?Q?JF8RIqN+coECY6ohhr2kh+ahKy9195fgZ64s2HRVDlJ1q1JruuLsV4YdEy?=
 =?iso-8859-1?Q?MdOkqMlSxjNayLasH1qQ/ITOT/Cm5nNOqmjbZXkLghNxovWtT4VLyyJ5NZ?=
 =?iso-8859-1?Q?9cPGUa4S+L/dL6VGuXHc8WwPY+KZpmVEpvAi+saL4CDSEkHq5ZOXhzhoRx?=
 =?iso-8859-1?Q?T2NPSLM/EOlGuGiR0SazMdfu7f2/C0as3Jeg9kt5E6swEj+mtl11ZpGWY7?=
 =?iso-8859-1?Q?eTGIohGiG3fyhHtuk6RUS7WuJOJoiovAnKbR5DF8VVMtm3dhVtC9JyeouW?=
 =?iso-8859-1?Q?8Z9sOXxO1jeYRq5MwWwTlyqXZsiaB3z96ND8VKOmHyyNga9M77B8j6a8Xn?=
 =?iso-8859-1?Q?o12Fq7t0TPzHgFshA82zTkl3Ma4x5/Ghe0J8lZxF9fep8FIkExmOkW5/DA?=
 =?iso-8859-1?Q?iba3PFz3yPm0WipPuAz79XDDMoa/RbheLCY4Q1/oBZlcWJBim2g7hs73/V?=
 =?iso-8859-1?Q?+699utwX39rHZg4VSq1sQvy2ez3yIrs3Vd1bz9Ie+II4FF/j5HKJIAxUF2?=
 =?iso-8859-1?Q?a+mtnCTXFP/1v8meqSSRxWERpeKbIDA/eEY1pc4WkNAVjgt3whWItt87vn?=
 =?iso-8859-1?Q?SOgXk5Xj88bN6KK6Wjs1sBKk8MhEZAP++ws/rSLMdDCucy2Y/XP5/7kh6h?=
 =?iso-8859-1?Q?+4ThmVxMswIy8GLskQj9rFMZlRUJqryBUaQLWzSK2ztWtqMeUvvHBhYx3V?=
 =?iso-8859-1?Q?9WRYKVTQugI4LnOIdqX3cQPYC628RyNrUd+KQbbi7ntTEK03wTRb+saN0A?=
 =?iso-8859-1?Q?EGPFxE3LAof56N8Qh13Uu4rtEG7kqJ78iHpVk3Y6xQVHxNzKuObLjgELux?=
 =?iso-8859-1?Q?SBftd7bQcPbIY5RavUOmTbfJ9dwGn9KurqLDVMGUpCtJJprEbVIAdpN6wg?=
 =?iso-8859-1?Q?EdfpzOIdR2LIHbF7cfdPN3odGesf8f3NhTmRCp3cwNu1iquq8tssmJxb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB6516.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e52148-99c8-478c-cb1f-08db44b8e301
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 11:41:47.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4422
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suggest adding `--soft` and `--mixed` options to `git checkout`, that act=
 similarly to the corresponding options of `git reset`, i.e. `git checkout =
--soft <tree-ish>` should move the HEAD to <tree-ish> without affecting the=
 working tree or index, and `git checkout --mixed <tree-ish>` should move t=
he HEAD to <tree-ish> and update the index to match it without changing the=
 working tree.=0A=
=0A=
The difference between this and `git reset` of course would be that, unlike=
 the latter, this doesn't 'drag' the current branch along with HEAD; instea=
d the usual behaviour would apply depending on what exactly <tree-ish> is, =
i.e. `git checkout [--soft|--mixed] <commit>` would detach HEAD and point i=
t to <commit>, whereas `git checkout [--soft|--mixed] <branch>` would move =
HEAD and switch from the current branch to <branch>.=0A=
=0A=
I'm aware work arounds exist for these, something like:=0A=
=0A=
    ```=0A=
    git checkout --detach=0A=
    git reset [--soft|--mixed] [<branch>|<commit>]=0A=
    git checkout [<branch>|<commit>]=0A=
    ```=0A=
=0A=
so the aim here is really one of convenience by having this feature contain=
ed in a native option.=0A=
=0A=
Another option that might be worth adding to `git checkout` is `--keep-inde=
x` (like the option in `git stash`), to move the HEAD to <tree-ish> and upd=
ate the working tree to match it without changing the index.=
