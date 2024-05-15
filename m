Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86713EFE5
	for <git@vger.kernel.org>; Wed, 15 May 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790473; cv=fail; b=sf001KruBledKmyoBO2V02YBaRnoujATJuU6TDFuk3b0sh/AL1jjmb6c9TI+Y4XKXBOrS/IzstaJDH12k1jmzm2G6uHny3JYDluT50CRUzmsOJhIcrDRWxIRiROysD/icwD0S8YtE/quZdCLKeF/iAPzgP4KBskgEYQm42jw+UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790473; c=relaxed/simple;
	bh=1zUfvoxGGX8bXSgxi76UuYE45HJtn7tM3y5Ed1pLfJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTphWCQckvOeLBCdBlt+Knd51iDqgAqB7mkqfiw4dQ4sR4bv5giefuyKfgCmnhK7OYfVKBDXcUZYiL9ue8fnQIkiv4H6Tre/NcQ1ST4qvllSP/RP2MeA4Ipcs+OrfiyuvMbVLjeq3OdYRNp3Dx33pZp5vYViDkELZSZ+RJoNUaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=qT7BsNmy; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=CqM4GJ7a; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="qT7BsNmy";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="CqM4GJ7a"
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F8xZBf004545;
	Wed, 15 May 2024 09:27:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=qFEsS54EgrnSLzUgliNnPvUUPPqiIIdUYwL18nre7Bo=;
 b=qT7BsNmyyvhm5bfInRi9ys2Qt0kb/0ycroWGjc9ehrQJ813qwpdI7tuFDjtg2/B+PKnh
 0f7H3yhUFtEo17wQW+2VEMXEocOBNX/P2fwq5CyjAsWvQZno4hshT/yTEca2X2aubg5Y
 zEVavO8WqxY8b7fNeVsdMnI6kmEVFJ1rSb0dlvmOBR3P4j0m/MK5LvhgCiuKDiFqpk17
 g9CJ5gAUfyZt/NhO2CpQKB6s7W8wG0iLlWN7vhNfLtA+n+eisjmWkuegoppKzdZHKDc+
 5oNsfg4j61lN1xe9f9hLGfjuOFCQ2kbiIFFE1bj3FiGt/kCVjAv5g26sxUxqtr/cundk vg== 
Received: from gcc02-dm3-obe.outbound.protection.outlook.com (mail-dm3gcc02lp2101.outbound.protection.outlook.com [104.47.65.101])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 3y4qgasryb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 09:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ9D8ErxjocWiXAnyPNP2pe/aQqDGYycMyXPDi1O+EUp0Zgayfr7VKXiLZQLQ8LTULsyF8ioEVOKtPv1G3j8juJQm6Q0MPKdkSDDUan91z6ogYi4LUDc0d2B6eRHzKSNq3R4UBGfgnB7oa2R4EGXjz29KskpJ00WxaMHj/8FmDmq3/JxszH534+souJq/oxpl6i3ebofx2IHffzQfNOBzhi5RyfrzSr3LSc9p4NoWvR+fmYXzVG4MuzF1+bV+OGaAZrXFYR9byTZ6aoA8qND7Er5CHU1LYTQbep+8VZ4jk4/l5qZuTCivaNcD04jFiU5w1LyYGqASO6HAWHy/HLiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFEsS54EgrnSLzUgliNnPvUUPPqiIIdUYwL18nre7Bo=;
 b=f20R4LHwp26tuMv2rFhORBc1FnK1nVNrxMZrEhgQjUwZrG7BtfxNglL5CrxOEXltJ36mAsiaSnDBa+mYunNQSQlQBZRWBXlivzmzVOrSFzUpusF/sw4QYnod3NzisFsHoPe1eVq1L2YlHoXRKlWMVeQ+7XVokgfrItBOIYdHSl2NgAsTm3s1UUQXh8kLXhV+8AEODuaxW5llVFmknUaumo+YE5lqKLhg3we6gYYd4Ew/nC3q0vBS+A28B1pWq0N9eCbk1aeIh5TFlIcpkt8rrdM/V6VlHCSVxMGqFBXraix4ou0RP7QShuMf19fZjBa/fWYvoPWaUNha4oT1KsRJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFEsS54EgrnSLzUgliNnPvUUPPqiIIdUYwL18nre7Bo=;
 b=CqM4GJ7aeZlMjz2odBGw75fZK9x5+fWIPYerLU4/8f1beuStGxyhvlZGioTCjxd+9UUzL8sWx/5x+exq1yATTWn0By8GFo4jpr7tVmUt65FkjMIreD4xQnXpBED6p41hg0e+/84Yzt8AIUin+4SgID0Mye06jjTpRmNullJqCYg=
Received: from SJ0PR09MB7071.namprd09.prod.outlook.com (2603:10b6:a03:259::8)
 by CO6PR09MB8743.namprd09.prod.outlook.com (2603:10b6:303:cf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 16:27:37 +0000
Received: from SJ0PR09MB7071.namprd09.prod.outlook.com
 ([fe80::5bfd:20fa:e427:31f0]) by SJ0PR09MB7071.namprd09.prod.outlook.com
 ([fe80::5bfd:20fa:e427:31f0%4]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 16:27:36 +0000
From: Tom Scogland <scogland1@llnl.gov>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tom Scogland via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] archive: make --add-virtual-file honor --prefix
Date: Wed, 15 May 2024 09:27:35 -0700
X-Mailer: MailMate (1.14r5937)
Message-ID: <12AA20BD-B226-43EA-A92A-BBC74FAE2840@llnl.gov>
In-Reply-To: <xmqqcypn14ld.fsf@gitster.g>
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
 <xmqqcypn14ld.fsf@gitster.g>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To SJ0PR09MB7071.namprd09.prod.outlook.com
 (2603:10b6:a03:259::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB7071:EE_|CO6PR09MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cf125e-b0b3-4914-7a79-08dc74fbee4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UQ4l7l4xt64gx6Cyl/nhbkSeZavqnEvUCbgV9OqCHv2CZlu1UBWbT2iLzVm6?=
 =?us-ascii?Q?EL2NDJf/xsMq8dBpI/4mW4B9IR71RQRHjogGg8aAaKMy8ODKKY+q+zyoq6pL?=
 =?us-ascii?Q?MjH8L/02L22iKBwfvfRmcldgX8jL7w/023fWmKgqClJzmeW05ikmL0Y6qpGZ?=
 =?us-ascii?Q?9b1J4aOVx3u5Xs3p3qrt7WpsskCA5D0JQeiTaCQdP0iXD4Px3U4mjTGsILkU?=
 =?us-ascii?Q?HUO5WZBs73koNTFmyao50Dk4b14RW+o12n5XD/WFJJkxSx+XfXjJ8UXC2qtR?=
 =?us-ascii?Q?e2v+QbrWE9rGk4XGYXa+jIwfDGswCstriNjt0Q+Jwrp1rZDdNxDcJ11+Jehi?=
 =?us-ascii?Q?8XrvB6uN5ClhIQdPgYlHPcBTRGbkfpzGwSp3LZ13nqqS/UjZOGoG8zWUKMM2?=
 =?us-ascii?Q?cVqfuk1eeNtf4mZuQGGMTXEwl/N/YcRGStS5QUwAZMxWPavJgi+8jy6vlMq8?=
 =?us-ascii?Q?0eELLKqpsqMp2O5GbApshWZ3h4GNkfSv1FlNqIuUy1arzbvby45Ukz8SWpfE?=
 =?us-ascii?Q?+yHWcxo0MmoNn6ps2idgLQVon7a2CkHrKOwH95riMO6iOHOJT/rW/+lJEhko?=
 =?us-ascii?Q?w8w3MvLh5z8tLcPvo96GLtXSCp046QV9v4WKNz19AV1RCPeiN1VflcVJ7Stz?=
 =?us-ascii?Q?2i3yTOtQdjSMUbKebmx+sx+jG6ToqixwfAsNGCTnjKs/3AIRJGAdmTWDtl4i?=
 =?us-ascii?Q?jzdaN0huey5FTm08LpBPkBsRb/aFOUSUFOoJOGPxFYu1wAz64Cl77I4lWYpv?=
 =?us-ascii?Q?3jZqGBCghI8eiyIZCA6jxlw5oqXvqGVYlGU8+kv0EuT3BpLiUsvRZMwGKCZa?=
 =?us-ascii?Q?iiZUaV9NglHs/espQMOQodJ//5rkRa+YmukzcGDqUE3fNSpRn04Y8iLLzIl4?=
 =?us-ascii?Q?D2tfTufOAi3+d8veTUAbcBu0GPbnxpe7rC6VLmgCzRweAto+8QLqu9w05hdK?=
 =?us-ascii?Q?tulcvRG6Sd12jN8EAhKe2m1lyjFdx91eoapahQm+eoVWMXLsRf0/Txx1VTgf?=
 =?us-ascii?Q?HJwJ2V8qI/sQjqLuQQDaXekE0qR/U8elHA0uC+SsHi0POGCGSuvyAc5htMyY?=
 =?us-ascii?Q?E8QdVGLE8p3LO8jYkpB5rTG0wmQ3CaqKthooAQaI/iFtE/fNGGeC8BJrBg6m?=
 =?us-ascii?Q?ZOF3LaReMzEAYK6becfCyWN+k7YN3Yf1zPh+jpaL0AsYXqj8mJhncdzdcr43?=
 =?us-ascii?Q?/7AFxHx8zdLWjWAakLaO1R0+UZW0zNKbwGhzqO46v/jToBkOfEfMbZIDGcyA?=
 =?us-ascii?Q?K0nq607jT8fYwre8jLfet564U3rh6ibg90cy28ZfRA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB7071.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a7wheKJXyPIchXeFDqveD/CYr2TCdnT4Zs0nWjM7WWrC45M7TdntfXl+AkVA?=
 =?us-ascii?Q?T4X2IA7QFL4AYlt9yhe/JBfQlvDyELUF6jHqZai9CnO5hErM/amnGRCQ+skU?=
 =?us-ascii?Q?e44tk6a9nlfZlreEnjctnD9UzL6JDldIKKzQXlhcDlIq+kXBwB/mXQz6wjIX?=
 =?us-ascii?Q?3QrAfaXiHGaGFQdqTgBUF1F25mLkjmnwFmMYUx4qmcV3pFHhE3UAc+9CCpC1?=
 =?us-ascii?Q?UQKFNlaIPwpRZwsefbvM5KeIB74Yz5n9mzgkH5XE+Z6trow2DjUbdNZCS4A1?=
 =?us-ascii?Q?rtv0Qt7ddJUijGcwbupnsolrZIbtkNEV0TaLImdvwChR/kCKCyYmRu9rojEy?=
 =?us-ascii?Q?lXft1PYqOZJfd/20Lhocmw0rkmJ7Dwph2hoKzH/o+MrueA8yqr3E8suzt+Tv?=
 =?us-ascii?Q?HYQoIzFUAWPGU3BVYIkJBLMASaUMh0tUg63Am2twADIndiN5GTnAWgtaZU41?=
 =?us-ascii?Q?iZt8/w4zATmKbbx8ljvEdaoCd/Kv55wBcr6m5m7QHy59NYDX1tAFY3ujSRIL?=
 =?us-ascii?Q?RRS45WlRmClODqyBbW+nFvn8BjyoUQVtudwWu6P4CZhD4Mif08NbkRh0mGY6?=
 =?us-ascii?Q?Cs0BxLgMZQxQTPR/RC+R3KGqIWx6cXeSBBi92unYteT0spEy2Elcx9cNX7ZQ?=
 =?us-ascii?Q?GZMjZ5REzkQtwqbIeauOCE39X64LEiv2Gb3EsaT28NQJMkNC7NIxS1/hWixp?=
 =?us-ascii?Q?MSb0KnlQwLYpT7ZJqFWMK2/dLM2W1p8mnq2bYAhVy1VX5QVoA2lMgGCPAFuM?=
 =?us-ascii?Q?lekyudXfNpLqUlAqpz+mwH0K0jJrrDKNgyrRdiN1xWsR2d/yg91SCeFRX7Er?=
 =?us-ascii?Q?Mx20itn4bWjcmHRUTsdv7Q3ksVYEr1a9G3BNXzrybKKdqr+xLcCDiAouIEN/?=
 =?us-ascii?Q?Z74LOGgnSpWhFniiY5zhNEVwo/FzRpIbN/dheRpCyCt9d+KDt4uqt3qE/mtP?=
 =?us-ascii?Q?Y2I5KmP5hE204hQJq31OtXPlnLr0xxHEkUrg10Lwk/CoIXfcMHDWxtU7Y4au?=
 =?us-ascii?Q?naU2UDedL+xQ5qE3aA5e2K49yLM2Lk3TadfnWjbV6XCocCQSLWTA8GW4ajBy?=
 =?us-ascii?Q?dNcUlt2VDNyK+rer3qfF0vbJkoOQChG6+u7ucvMZwxt13YP9BMmI98pK9w+u?=
 =?us-ascii?Q?oBMb6PuTuBXMCfUsa1oz6w4PrmGvniJI4Stlsxs7xjzrvprpVYMDZDonZCkh?=
 =?us-ascii?Q?aDURtyqxReEfyx79AORAd/XH+IQYnYhDFWlL8sKS33G45n8rmXME4vW8KDFu?=
 =?us-ascii?Q?gQqA7sbfcZhYy6Y8zg0NrJNTVGwRAGjCvS1xWBvIc3mxS52xsMC93g4cG70i?=
 =?us-ascii?Q?0VewD1yuDbVjxSvQr0XlrmoultujNPYNlj9gPCBF8eghNMYCJzHhUI7vqYpk?=
 =?us-ascii?Q?AfADSKVvds99ajJldUWDxnQh9ThuZVEUb7nSo5jtk2CcO9SwUb+jN4x6jCiz?=
 =?us-ascii?Q?pQ0TNHayovpXTpaKH3TViA9FebWchRhc78Tq8U+vw803FqWKa43pf6OrvKDV?=
 =?us-ascii?Q?PzQzIICkBuWaMNS4Ae0WllFc8wGWORC60mRSDD0QAl3fNI9hRGAkeIshy1Tt?=
 =?us-ascii?Q?HvBRqcSgtcBi55IgTMyMskPyx1Qb4/aYS0mYndib?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bawxjdAcptYTnKXIhE1Gp+aLtlqeOhozCsHMNq1azLq1cWPc4gfYgOztXLyp9DcGXW1wk3n5oe5Rh1Z35sQWaZa443U1i3zcBcKuorCn4/64fX/6SwMa8SBzi833SOb2DNR7We3lvmXyD2j2Ja8Py1GmGUFYsjxs6XbCJwBb9h7+h7KZ5y584KMUPXyPkN6q8bGnfAAmI10SKueE1vSXfiP0wx9XbnFWw/BI6K8/IwXhtRZ9LciGgwusZc6a9/CHL4nYxrKp38xbdKVJKp6cefhy7e6KYE6q0aRby7ghFtwiB1+XV18oZUIWaR7SHaFl6ugEjdN9zM3Ex5J6nkk+nLOTTuv+aLN/GsfsASCIg5uagvgFWt4fFcfk7SApi8RpulLShep+huP/4NLKBPjFB10hm6BZ1byfhN4lvBAm7Il5jvWMl3fr4eV7dIMlrdSU1K5Bc6D5EPZiiWO/uwd+CoE5bLGsexNk4tOXlsBs0ImEEehNscqEtF2DZ/klTl0Sks/6qXMBCDpIlg35WxAeqyKr3QXDf/cFkT1HtliKxLRpgW/0rl59MWRrb7EyfjOO2AUVdDr6mUMt175kvk6gPitZZgBMvQ5OKLvxScj5XoyInceyrMCzFg0kjW0L0WBScYL0XkbZf1tEcg1+JsBWYg==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cf125e-b0b3-4914-7a79-08dc74fbee4f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB7071.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 16:27:36.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR09MB8743
X-Proofpoint-ORIG-GUID: r1Y_w9d8fcBsWcwDe_th9i2sUuAsOJC5
X-Proofpoint-GUID: r1Y_w9d8fcBsWcwDe_th9i2sUuAsOJC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150116



On 15 May 2024, at 8:23, Junio C Hamano wrote:

> "Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Tom Scogland <scogland1@llnl.gov>
>>
>> The documentation for archive states:
>>
>>   The path of the file in the archive is built by concatenating the
>>   value of the last `--prefix` moption (if any) before this
>>   `--add-virtual-file` and <path>.
>>
>> This matches the documentation for --add-file and the behavior works f=
or
>> that option, but --prefix is ignored for --add-virtual-file.
>
> This first paragraph was a bit hard to parse for me.
>
> You will contrast the quoted paragraph with another one you did not
> quote later in this paragraph, so it is more helpful to readers if
> you instead said:
>
>     The documentatation for archive describes its
>     "--add-virtual-file" option like so:
>
>         ... excerpt from --add-virtual-file description ...
>
>     This description is the same as "--add-file", and "--add-file"
>     does behave the way as described.  "--add-virtual-file" however
>     ignores "--prefix".

Ok, I'll update the message with this and the below style.

>> This commit modifies archive.c to include the prefix in the path and
>> adds a check into the existing add-virtual-file test to ensure that it=

>> honors both the most recent prefix before the flag.
>
> Style: "This comit modifies" -> "Modify".
>
> An obvious alternative fix is to update the documentation, which
> would be a much safer thing to do, given that there may be existing
> scripts written during the two years since --add-virtual-file option
> was introduced and has been behaving exactly this way.  They will
> all be broken big time once the command starts honoring the
> "--prefix" option.

I wouldn't mind doing this necessarily, but would want an option that fol=
lows the documentation in addition.  The current implementation is harder=
 to use consistently with `--add-file` and with `--prefix`, though it's p=
ossible to manually prefix each virtual file it's surprising that it prod=
uces (as far as I have found) the only files in the archive that don't fa=
ll under the prefix.

>> In looking for others with this issue, I found message
>> a143e25a70b44b82b4ee6fa3bb2bcda4@atlas-elektronik.com on the mailing
>> list, where Stefan proposed a basically identical patch to archive.c
>> back in February, so the main addition here is the test along with tha=
t
>> patch.
>
> This pargraph should come _after_ the three-dash lines below.

Certainly.

>> Signed-off-by: Tom Scogland <scogland1@llnl.gov>
>> ---
>>     archive: make --add-virtual-file honor --prefix
>
> The implementation looked obvious, assuming that it is a good idea
> to change it (I've already talked about a safer alternative fix).
>
>> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
>> index 961c6aac256..acc8bc4fcd6 100755
>> --- a/t/t5003-archive-zip.sh
>> +++ b/t/t5003-archive-zip.sh
>> @@ -218,14 +218,18 @@ test_expect_success UNZIP 'git archive --format=3D=
zip --add-virtual-file' '
>>  	fi &&
>>  	git archive --format=3Dzip >with_file_with_content.zip \
>>  		--add-virtual-file=3D\""$PATHNAME"\": \
>> -		--add-virtual-file=3Dhello:world $EMPTY_TREE &&
>> +		--add-virtual-file=3Dhello:world \
>> +		--prefix=3Dsubdir/ --add-virtual-file=3Dhello:world \
>> +		--prefix=3D $EMPTY_TREE &&
>
> Instead of reusing the exactly the same name and contents, use
> something different so that it is clear to the later test which of
> the two "--add-virtual-file" options created these two paths in the
> unpacked directories.  I.e., create something like
>
>     --prefix=3Dsubdir/ --add-virtual-file=3Dgood:night
>
> here and update the test below to match.
>
>>  	test_when_finished "rm -rf tmp-unpack" &&
>>  	mkdir tmp-unpack && (
>>  		cd tmp-unpack &&
>>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>>  		test_path_is_file hello &&
>>  		test_path_is_file "$PATHNAME" &&
>> -		test world =3D $(cat hello)
>> +		test world =3D $(cat hello) &&
>> +		test_path_is_file subdir/hello &&
>> +		test world =3D $(cat subdir/hello)
>>  	)
>>  '
>
> Other than that, looks good to me.  Thanks.

Thanks for the feedback, I'll get an updated patch posted later today.
