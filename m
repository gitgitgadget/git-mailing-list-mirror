Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E096FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhLIUO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:26 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:62241
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhLIUOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBIYuC+jtNZkOtdk4ZLRvbLkjOI4SoNz1Of5FkjG8knodbH7nwxFR+R9FP//dCjQeWf0zs/aquifmYted6RbbgUZEaP6gEps+vBN/1NBs17rdZMezdhWwSg4//hKut/cEJbiKV3SIxtABCDteFutWgCj+E7lysst4YrYMuxuWncbuU9OHH+OpXDNtH2qOV8fyotxuXvnpTEdLtYIUtAC77D3Y+rak/9J6MPvCsP3peHd/Ot33E45vGENaM19EClyk1u9hX0VxOE4dD+qD+v/h3U/hk7Nw0/Szm/6/DnOliLJCBivJ8aOGVr4wZziWJihiXwi5R5PBLcpOfW4BPhmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D5tNN2dQoNcsSjZxJU0ZKwbIERRysqpnZMmazpw3jk=;
 b=PNTV+vLEpi8YBh7nywaSF5dJvuJS8JF0E2bd0MELLlbsHdZf7NXbou7q60jxM1Dy+sxdevi1AIN7lqa/tWMep0a4frqGcwebBGc0ttx0GyDHxBBJibD4ehtSBAl9zckZ4CJMe5i9EUlyc47esZOs/DP0wC/PXW0yDCFHuetzxzTnH806Invw3FQeqTCQwj1D462t+51Rb00wHjh41N5IZTKBHbDqtgo+vn2r+vOCC4X21eASe9JaT429bV+rG34A68eofVkX633rAmh/gYgmBrh/C9VGVzsREQXxdjifGs2czye0K8V99I34vk2MjBrk9urkIpmz6ummBdcwjfDw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D5tNN2dQoNcsSjZxJU0ZKwbIERRysqpnZMmazpw3jk=;
 b=RGmdW79rCalaCof4rbObLiIF4OQ3KBh68J3oIqp1rzg0edMsTk20k5GjAM1XnY5kmAYz2zUQkk+MTRDWp08OlPEAYGcwpxcIepgm1Tp7cklOXch0eef9exe78HaMkT8U6YTPG8hXPmMZoE6PTvYaBiKClKQL0IsB21L3Zd85DoYNLwEyyF6nS3lMW6ZupnXrWhAVe+XyYxH9SNGKRYSwWTuBP8HUWuXez4FSPIsuQdOYqMOeOlO97TxU62Gpf5KxOsOxzGtSSZB6JuoKAjvlD3myb7iqnkUwpxPsDP7QflnPKtrAGSZLcLPHBCciSDqL3xRMZ/Kjus9O16HmHkaTjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:50 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:50 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Date:   Thu,  9 Dec 2021 20:10:23 +0000
Message-Id: <20211209201029.136886-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07851670-03cc-45f2-0b1d-08d9bb4ffe9f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32824BB226EFC65773D60FE8C8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXXK4qBA44v32xJz2X1S61XWC9ehIocf/eRY58Uegp6PhZXkHw1JMh6T6iw3/RJtqVRz8NvVfNVKq16+SCK+iESM19mhMPtSnxqQyvmVdr0MyH+D3TB40e6cy4lUNJonvbKL2ArUzVLDaYXJwIg+WgGhkEAAXGZ6CPCimz8x/H1ZbDxAr3akK8kM2a7idgrCj1Bzj9gSDT5VXCZjwgrVY2KQ0l2p23qPI22N6/7ao669gPlc00o9Ptm/We2GQYFJrMw4pKp5BXUVHdHRiJaUTF/enaAnVsh4zgJMzZnPK7SAmd1S5nHDTMILOqX/NgbRVBPIK7N1pZ8aHOmUNju3FnoNQt881ODswBAu8OFKV/YRadfBQMu8N/iRPPNRGzc21ntm3Izb9KVBulFgyUmUDsorcJeN5gdz/uIw1EiDYx2m/gBXzB77+JnZPZ9yFsEZGnWA7jmEGsnXpnZgd30l7i1Y+JZFd6QrC+ya+qs1QSs5sd3OqTOuuKDnYeaqfI2wRicGlZy0MXiCtaIdbkfnZDu0qbfD65V24/jBueut1sv/geEoeglqAuHQU2eASaaCavjjT3ut+NtMG71b4EHwPldM7g3gEvvb2Cak9Rhh9g0ml7ZHN1Ks+YKT/vIbZZCb4jzpR0PdlKpUVU6o7KMrUJXPReGx3vS9wx5yAK3v8bK2FXS/2aE+L/s3wEjhAe/DtyKP1hYswxIzBzetl1f4WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ntx0r0q5FkUcLl8W9jhlvWuYvrtJ33NVuWYsFKI7xz/K2n7FXonTRDzk2l5Z?=
 =?us-ascii?Q?3f55deKUCFMIZcaKQI3mWGzqRvXegLXY+l7ubycCC1HKhffZn3Opg6DrEdWk?=
 =?us-ascii?Q?m4OuNSca24YGDS+JpXGx3wzl5XsGueem48JwG0TGw9igsuFRZC82+yobbiFD?=
 =?us-ascii?Q?ebpzWcCJc+KBd/isRIvHBZgV2849ojIOBBekpocFMZGnP2+uB5IiJDGbhfOX?=
 =?us-ascii?Q?7nE42MeZiz7S2yjUizrPfoTI3C9qteOy2MMeYSTgPPOVBF/IiTMs72KGhT5Q?=
 =?us-ascii?Q?4CF+KHVFbZB3/HbIFxsZYFfHX9+ZxUZEWoiRi4NKDz3JuUhcdNHiF4+Hmnr4?=
 =?us-ascii?Q?FvVS0GY6apUJGUHJcVdoo4QMal0Nvr6UKwmL9pv17RiLmQIRU25hVfOU+a8A?=
 =?us-ascii?Q?ZOsPI+ys2H8LD+YCse0Jy0UW2CHRVJuc7+guqFKUQJw5FNigmfayhnTKJaJj?=
 =?us-ascii?Q?KPDLfEy1dXrScxWLelyhG8UN/tbZiwYFJ27r/QVDZ3/p5KMNGIpZf7Nd3yHD?=
 =?us-ascii?Q?aBd+s147SWp2JhbG+9DG8jegkDwvlt2/D2hTWe3CG+EfSljpCeKIdLBN9WtV?=
 =?us-ascii?Q?LSSNpLPwj6UmL+RcanRniXef4X6qIGasdtzksZrlbuEDF6pGX3thUzlNKdvH?=
 =?us-ascii?Q?MQJInSNyu/KbVzjd9Va2JNJnikGm7BfyYh/I7i4I4hO+erQWCm8d8iO5ILOs?=
 =?us-ascii?Q?oLbPd46vFNhWjyAFSP5hfhj749m65FVVMpHn1gOrZEz2Fo28cMDAxfmtogyQ?=
 =?us-ascii?Q?ZI+cOljZvNGppcvTHn8wl70HlGWU3R+y/Mv8IdQQBtkWCaGimY4QLNvDqNSy?=
 =?us-ascii?Q?PXCc+lcMquq+PzrXrum0sNcw5HlGpDmS9H9Y6AuYPAPhbIjVY/U76jzngEG2?=
 =?us-ascii?Q?wjiEO7R/YLpgMBcx3+ILafUTUQhL0Ze3SFPmpdzvfw+rtFLPuVuiThPrHDtY?=
 =?us-ascii?Q?AzCzVx1lPKetgwVD4mbsVK7Mdw/Gw8iWTs3LHP5Icx6IEL5tgRnn0IJPBXSC?=
 =?us-ascii?Q?SkpoZ6tgVfUKkMujgFbVRYuRacLZBrvbLuC7zOWJ5dYf31EdjHuP3CbSgPP6?=
 =?us-ascii?Q?/YJFk4VlsSN0yNogVA2QGkuyJpkP8IH2+b5DFDMkJANa+f7VY2DoFTOuX3H8?=
 =?us-ascii?Q?MNqK4BXlaEKwDvui2nbuXFE6oU7O/yGyqZFyXDvdicAxTHW7OUmmdrgG1K9s?=
 =?us-ascii?Q?yjLM5PtNo5UJ9g+8bbexlPQdk2Wt6sMKbaGOoHljY4ipq4Ij84weyaAEM5Vi?=
 =?us-ascii?Q?pG8I+z7dkG+nW3hnLGOnYO5FJpAzwgtntSoqC+gwmiacTOh/8dhsAOZGVAu3?=
 =?us-ascii?Q?4j7GoRgZxAcW2guVPHfmHCWpyIgHh+Ss0eWyHOowWCJD6dZnNYKKyN05Rt7d?=
 =?us-ascii?Q?z/ZOIaZvRO4dLELGgil9CkqY1Kz2JHgOlrdXMU70SoeJEWNBivTwb0zBAfv0?=
 =?us-ascii?Q?0a8zhQf33rA4jfsqH7h6tyCmcAtTZmpYo5TUeTnwI2QbOgI7FImMy0Ftpi5p?=
 =?us-ascii?Q?9DH7t+TAmIHmEgezqRBSW6ttoP27VW8KEGOmMBhU6dAK9OCgmGAqHSz1iy5f?=
 =?us-ascii?Q?u3cXJrcVZ3ShaE7SoMj218Lp33WAy387j7onLWVDJkNbOvyN+qwX3eQYtXoP?=
 =?us-ascii?Q?uY/5yIHD8zC3UJi+5a3QECQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07851670-03cc-45f2-0b1d-08d9bb4ffe9f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:50.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9e7e+DnRuJo8cu/dhAb6r0Uikucb5KRMd/pjgQfrYZE6CYWnkzrWncJ03vAiZRouHFKTpmDmbYb5PBH4iVOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4.py script currently implements code-paths for both Python 2 and
3.

Python 2 was discontinued in 2020, and there is no longer any officially
supported interpreter. Further development of git-p4.py will require
would-be developers to test their changes with all supported dialects of
the language. However, if there is no longer any supported runtime
environment available, this places an unreasonable burden on the Git
project to maintain support for an obselete dialect of the language.

This patch-set removes all Python 2-specific code-paths, and then
applies some simplifications to the code which are available given
Python 3's improve delineation between bytes and strings.

Joel Holdsworth (6):
  git-p4: Always pass cmd arguments to subprocess as a python lists
  git-p4: Don't print shell commands as python lists
  git-p4: Removed support for Python 2
  git-p4: Decode byte strings before printing
  git-p4: Eliminate decode_stream and encode_stream
  git-p4: Resolve RCS keywords in binary

 git-p4.py | 319 +++++++++++++++++++++---------------------------------
 1 file changed, 123 insertions(+), 196 deletions(-)

-- 
2.33.0

