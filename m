Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24331FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbdJHSuB (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:50:01 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:22725
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753298AbdJHSuA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7J+JqVvpYd4Qf4/GWT2zDJU2jteNTF82yfQTXkfIU8c=;
 b=EN7IfL4M6y9hcvqbx5cbOPxoqkB62eWqqOD3sFqHoQaaaYD21mLbBHmf7mjl6ck91BsHctN8zi7EGQQpl4NtCYeLHrq3WfkZiSZfcaOdFZY0Bcy6c63MMNRBE0y7WoU2rUpD5RlCFTF54i8XmjjqMtFVJQaTENsIecICl7lo6Bs=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (2603:10b6:803:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Sun, 8 Oct
 2017 18:49:57 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 0/4] Improve abbreviation disambiguation
Date:   Sun,  8 Oct 2017 14:49:38 -0400
Message-Id: <20171008184942.69444-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:404:10a::20) To SN4PR2101MB0734.namprd21.prod.outlook.com
 (2603:10b6:803:51::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15312713-85d9-4752-e92f-08d50e7d5f84
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:kbt98FC/leaObsvEGKenjpQ2FARjxNGABBOoEsqke9M/FuhtN0U6DMdL+aCTSsThS2gvWo9i0KmHF19+RTdV9NN9EHHtPbJRDfvCcBWKOJ17eq5XKdCPoViSeDM7Djt3vGFwWUjby6BJbYAl1dN4qqZ14bGl5GlDMNhPnTaoTNhxJDS01hXyDIr8pm9F5pGHCv/QL5NB46rfr7FbZONEnCWvchBy4mm+WXGlmDKS3o7oTSwYT3lu15mSvO4zL31T;25:2bagMEDCFf2UheD4f3kDA7f7EmDKtUqqL8lYcvbuifRpAuqtpWZRGmp80KodaNbhwVcMp1pZU9J2QuEdnOLuITVUFIXky2yOBhadDwCzpOszQnrnus0B/B0aoLbwDDK1CgMPm2mSIDrbr7zUxDkcrgQkNgrTpY/PBRFJkJwkayAWbr/HBfPeOy9MjPB3rHNkuPXHEN2whf2anWrm1nfrpfqpZTYONd3S0EuG+IGmPtwu5zn5qj/rvdeZF9kE4RmLucspJBEsZlHA0DyY2XYxQMi2IOvY7SWxJsJ1wYR/hLfDRk88Ge4+N19FCc5IcJIuOh4FJqEJik4FmxHjxRkNQQ==;31:FY/J7mz8y8Vdgwbwmf9TaWxG3hO75hILkDsz+vYokTCt60u9fSWGGJY0xvIjt9l7IzCzejm9pZ9EKBfjPP3PPgD1poOnaobekQLyVDt/eOmBOfopnWCSYASufOVjYAKxOLkwCdCtYJjBryrcJUT6LdLeewQ6+qEejPoYXM+cFGNAQ/cC7EJSLEV5188l/Gko8nFUiWCA7zZ3GoLP3uqnHNwS6P7vgE5c1FQkGrc2hJs=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:RlrMJp7zaZov7yn4O+XbRj6kgdXqSw4+ctug9TpstuYV3UQHnMV7tLjy+PovalHvDNErgRMX8jiKWMnkRMCqExzMOaR4qun3DmyvuhAZgtklMAck6h9FyHT2IdrUZ1Ug9KRpmOD8iwvsy3TklLK7X0j/BXgPfTgyqgdukOkP8eYgswclCR4k6w3ruw9ex+UBFXbuHHLjCXS9IbMqGxqihVaBrl6fSphO2Z4ol6Ail2klnNweNfPGhyaPjp/IxuehYZVhdfhTJze3ljTDdSgJ6UwBnfD6w8bRmpl5pVTPbJ7vy3HMSlteOcQjeiwDiMI/yv5OS25e79IxFRwyD5JfbDm5y5GAXEK8mRJ2+H8EmKBwOr0jOVokjIPuoF5bOoI3xypWdUJbQCQlXirFMdGn5yK9S9qn1iL62zzLgjjanSvGo7bch+DN00PQ1l6Q1zAnaZrAv70jgYVoeksjnemUH3ZCuXyJ5n2bP2zwBT6dFtheFLJZ7XPP2/L9uEaNqmx2;4:OMiwRR/6CEqpJtZ7tf3SWY0F8wnf554EAoCZCip4D5k0TS+xjJaT2w1Zwm7zkS1eAMhd7IcALsS/fEUawLsq2AY5SAPwNzAzkVvPTTSHBG9/oC1UYmroUqbWx0SUDt+SDFy+gvqxKeCRT9HQ2m/PG5UqaFNDcNVWnJlV0E5ijFFrcBIwZd8tvltLc1QNl9gbuo6DsMXiiixI+ac6YeYwH0b2UwwcZs48oAL086w86pVdMW/xag+zSmfDS1zeGn65bLJdnRu/U8sayxI3PTPAlE9tezlE6ERgaXZSlbGbRAs=
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB07342488E4CB177F71F4880BA1770@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(47760400005)(69224002)(199003)(189002)(6116002)(6666003)(33646002)(2361001)(81166006)(81156014)(47776003)(6916009)(8936002)(50226002)(8676002)(97736004)(48376002)(50466002)(2351001)(1076002)(22452003)(10090500001)(189998001)(25786009)(16586007)(86612001)(53936002)(316002)(4326008)(5003940100001)(36756003)(39060400002)(107886003)(68736007)(6486002)(106356001)(10290500003)(5660300001)(2906002)(8656003)(105586002)(86362001)(50986999)(478600001)(101416001)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:RXyoxEtaQr/L6VTO5DclkKulQy6JglgyMb/zHdL?=
 =?us-ascii?Q?3xoG2OoCQWAKJOVD1zKLO3UMYz4/OPMpL5IKcviKvG3H1cxV1MxrCnkwNWrM?=
 =?us-ascii?Q?EQna3otq6w8tNsrbBiE/OvA4rpaugIGym4NFda3Ik5OpI8rA3U6XYfbHVRr4?=
 =?us-ascii?Q?CkzBtBdaGIbQMgVX4ulB1YZsQH+eecasgK595nx6VjztthNACvYkjIguJLyC?=
 =?us-ascii?Q?HcZnJmyLkb7MfrT146HtFgusGfkJR/fTVs+SsHWu11iDhS1NwagpmMi7EQgh?=
 =?us-ascii?Q?a6r6qh9o1Bt8gjIrg8zgpDRJAgzQ/0pqCNzYfvfKrZNLyAJoqQPhhc0+vtkn?=
 =?us-ascii?Q?2mrXkhQwnT459RmrHZ6k2cDKe0wa4XDqD957R7WoFt09avNZPAHENsoCVYZ8?=
 =?us-ascii?Q?EJDFOJTHrI7VJFeWF2fAnevSuXPk6nPWz3xO3mVVEdQaYaug4EE5hpvAiVP9?=
 =?us-ascii?Q?MAmUOS3liSwkAHRhK1Xm8kImhnkzB6MxyOSZ6zciB3SMJAkrY332stD6vv22?=
 =?us-ascii?Q?jixEBIZWhmyr0gHGI6lUBulPtLTleQl1l7QH1hLlBcj9/6RoNpRNpsm5N7ml?=
 =?us-ascii?Q?XEBxgtopN0lDfa59kmMRBubsrNajTw5IOYeF2X7R5/MyEh5pFOjEa+h9f399?=
 =?us-ascii?Q?2yxZmpDNiBzVaqsWCALn52RRlbh4FUsnUSVM4p6Z6CUKQD3stVb9m9dNSRj0?=
 =?us-ascii?Q?162pZzi81mTUPlsrt9LjNW9k9n3HXrpKkJKSwOOgbXiwMFnB3Nb1swM4mF7t?=
 =?us-ascii?Q?QrTZNqugjMU84dRcf2XfKp74K3+/dKAT6I1vX0Y0MURkw2B/kMpoNNDP8pOh?=
 =?us-ascii?Q?V8tjkXaEEAJkHxOOcd3TEtkd0i6abBYn6gRHkUBcs8kj6FvlDaDgp0e/xfEB?=
 =?us-ascii?Q?Q32lVr4738HyG/lxaCBOTbJVjqBMClgQ8V+xlhD2X9iduZAIJBTbHF2Za2ub?=
 =?us-ascii?Q?7tHH+ZW/DzLV51Bat+e8R7CgU4kWNEEF1NpAnK2H5g0o/bXwVrMfrnUbaBu2?=
 =?us-ascii?Q?dkj8V+pKGfsqBo18KlQ0NbI5PJRDmCmTaU8pxVJiotMciHkCT9P2T0uyZ23U?=
 =?us-ascii?Q?iObKJCfGyp6dkB0Wa9GDAJIYFf/Kby9j0lnSdrlk1eOCLxfJqFhW7hSZD9Uv?=
 =?us-ascii?Q?Gm6Hpp7VEpKE53MsbjxRUjbtCKKorwePDzy6K37z8JHL2qEtqDW/v0uJ+uIW?=
 =?us-ascii?Q?Baecx+frtqa1KdXUoq9hj/U2NeKyn+TMhmsUVIKttERpCJio2CfUp27aaSA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:2ZsP8IhSf/gGhaGRmfUfeJ2NdMdKzxm4HbsUAqY30zakktfGzXB6igbQ2ojaJzS3TpWejt5PEvoMs9aaSK/z+V0G6ZXapSd/uPFq0ZcGirEhzY50LBH72cE/eEvtgVgpX0Ot+6BO83QQYevWpU/95JS/8n7N0ApXCjoCO/33QrzLSI/nNYS+pOSJ8Bic2QudoaDHzBcvCUQtMPTK1WsRUt9PLIO8Fz8As5gHMfX23NiJB30h6oJw0R1Uj22ULxuKDBIqCoQa9fi6Ydy7VMo5q8uBhvkZI9aptPR+l0Tu7IvnXRimUue1U/kqmJgSfj52rPOWrJoAYHISan4RaTfDYw==;5:lQpYCPBndGZlNwO8cXN05qrzVkuMOPCq8KmExnhg0Lx9fn1XdKyQfNieiYyZSTbwKZhLWCs0K7fxEvmvgqrOliOgAF3V0ySyR22Xlwg6VHwV4UCRL/nze/JrLugin7Q7MynFl9piPtIbtigLZxKpqg==;24:Tyk9VHGjUwZxjrPvlodBEhN3lUI6s0Rt2r6IMBHbl/cteujfSo1TECoF9ULbABW6wm5+whj2KuGMNf9tNx0G1MImVVBiRIeEV2t0iYa90MM=;7:ut8IdSpmfzw/j1NKkLlpoeL/ABLT+cN57EORd/ksLNTV8rTGybGlTiNgbGAutxlGif5V3cop3nhmQEhtP2/9HOR1h8JGI6eBJcSmOz/H9wf1k6MJ5EOWp4W6KBM/7NsoT5p3SgNuEErb1AE2wTyGfFPLcgNoRTlHTHcjXCWNauotCtq+DSXUH0T5YL9/SNMUzkZWQmQ+6Hgfx1fhKSEev7JvURLbZn6KQJmG+sV8UoA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2017 18:49:57.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15312713-85d9-4752-e92f-08d50e7d5f84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since previous version:

* Fixed an overflow error in the binary search. I sent a separate patch
  to fix this error in existing searches; that patch should be applied
  before this one.

* Removed test-list-objects and test-abbrev in favor of a new git log
  test in p4211-line-log.sh. Limited perf numbers for Linux repo are
  given in cover letter and commit 4/4.

* Silently skip packfiles that fail to open with open_pack_index()

Thanks for all the comments from Jeff, Junio, Ramsey, and Stefan!

Thanks,
 Stolee

---

When displaying object ids, we frequently want to see an abbreviation
for easier typing. That abbreviation must be unambiguous among all
object ids.

The current implementation of find_unique_abbrev() performs a loop
checking if each abbreviation length is unambiguous until finding one
that works. This causes multiple round-trips to the disk when starting
with the default abbreviation length (usually 7) but needing up to 12
characters for an unambiguous short-sha. For very large repos, this
effect is pronounced and causes issues with several commands, from
obvious consumers `status` and `log` to less obvious commands such as
`fetch` and `push`.

This patch improves performance by iterating over objects matching the
short abbreviation only once, inspecting each object id, and reporting
the minimum length of an unambiguous abbreviation.

Add a new perf test for testing the performance of log while computing
OID abbreviations. Using --oneline --raw and --parents options maximizes
the number of OIDs to abbreviate while still spending some time
computing diffs. Below we report performance statistics for perf test
4211.6 from p4211-line-log.sh using three copies of the Linux repo:

| Packs | Loose  | Base Time | New Time | Rel%  |
|-------|--------|-----------|----------|-------|
|  1    |      0 |   41.27 s |  38.93 s | -4.8% |
| 24    |      0 |   98.04 s |  91.35 s | -5.7% |
| 23    | 323952 |  117.78 s | 112.18 s | -4.8% |

Derrick Stolee (4):
  p4211-line-log.sh: add log --online --raw --parents perf test
  sha1_name: Unroll len loop in find_unique_abbrev_r
  sha1_name: Parse less while finding common prefix
  sha1_name: Minimize OID comparisons during disambiguation

 sha1_name.c              | 129 +++++++++++++++++++++++++++++++++++++++++------
 t/perf/p4211-line-log.sh |   4 ++
 2 files changed, 118 insertions(+), 15 deletions(-)

-- 
2.14.1.538.g56ec8fc98.dirty

