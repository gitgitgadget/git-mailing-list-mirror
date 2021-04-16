Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D5DC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 14:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8A56113D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhDPOeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:34:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhDPOeN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 10:34:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GEOcDH146744;
        Fri, 16 Apr 2021 14:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=E4IQD0NIuIThHG2y86BDqLKoivA4Qnt0Ne/8+yLscuQ=;
 b=pdAo8AuGSQtcew8K1/W8qKXU+7uVQOKVc3uoik4qLtIoR6z6Os0D/2GPUpIMmjSUGtGe
 KW6eZXDfLqJ6ZxV+UNG1tqXdIsz4mUwdUzB7CbdH5HUaidhSwDQkM/s+lSVVKf+XnjBx
 4eao/p1rBdgEc3WvhClL6JjatCvo/hTZaS86epEZ/OcwuQlNrWigEjyjxsgGF68eIeO7
 4ga5KEijC4myxlOEJDvsaMZ5zDbSc95DxPu6UIZrsvcBZ5MAerItRdrtINvXZoybszuS
 juh2Xlvk41gQNPysxdhTRzP+CkxmXWIpi08HsSq+mxCEytdwAco01EDoDxr5iIjly9Fu Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37u3ymsb1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 14:33:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GETqcj037771;
        Fri, 16 Apr 2021 14:33:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 37unx4k6qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 14:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf2AWc2kFrtLGVOyh8U1myRSSFARh1Z0uuxsX/z/4fFHOxzxAvQZcx4t0EhxgF4fJL7sLg7wAPp7fIgPwc0K7jkSQCm0mSvq/5DCNwoJzIQJLjmnUYJFUPEosbhv/P+k4csDx9IuOEDtk86Q5ewI1fefT/+f3AUXa8ZOFFDiR+kE38ReQiUeA7vMG0yxm6GBW2MzTAK/+wkyV0XmQVtRdsxU3JlrOkuMKrrQVIfClWd8jvTmM9pFMo3LpzcJxKGjOHx1TSPJtolAKtNbdHdIkrYGZoC8ydgWMwawtHq0KLMslyBg9OW9Hlq4CkpZdAH1ZWJtnModwGtuRtCjB3qS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzz1sDuEG/e9LKFr6Pi+bjoQ2bu+cPXOYELYr8GN+Dg=;
 b=heBLrf4mgV/3XYAI8p8TKNyUhU4zzDIx7XnTF/zPrQzewAQH8dYlMeeUAOd3IKcRjye2tMEpb10HaZolVCYTJsHkduqLbOD2hdJq45LyIckSPls2UlRb6AfPNaiD3ZOLciYo7G0PaFJDdTk5O978tQ/3CNcoOAupzn+10K+j9oiXyweAumkEmvV+k8TXcXcyyPsCwtd8T6eM/Ebh+lF4u/DB+jGBYcZcb7OGplGBLE/cg3lLbYipCGfQ7crxO23eNkR7KGVOl5UtD/Jb2IasT5VNNBBwXn+Tn7diAhy9DgQnTdtC8C1WX7Dg3kWOJgaTX6B0oYJ2i3bo5Ye7JI9xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzz1sDuEG/e9LKFr6Pi+bjoQ2bu+cPXOYELYr8GN+Dg=;
 b=ctJOuZkCVpb4D+6NaHKF5mgW7G5PDtrJjqHGV1rkzqs1JVZp1X1o0vgnfuHv1LCtYcCkjtJP/LbUjnBw6iLRyx93g6E/eFT3tRiJ+0BgxO3NEDpjjj3e2IUazU6o3clZu8megNeXof46kNgnIzUqg3nLPH7RNuic2S+f6VzWkcQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4002.namprd10.prod.outlook.com (2603:10b6:a03:1b0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:33:24 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 14:33:24 +0000
Date:   Fri, 16 Apr 2021 09:33:17 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/4] maintenance: respect remote.*.skipFetchAll
Message-ID: <20210416143317.hoswhvk7ivdg6z7v@dhcp-10-154-163-120.vpn.oracle.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
 <92652fd9e6e17654abdb30625c85937b6b56c38e.1618577399.git.gitgitgadget@gmail.com>
 <87zgxytjwa.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgxytjwa.fsf@evledraar.gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SN7PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:806:121::27) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-163-120.vpn.oracle.com (70.114.130.219) by SN7PR04CA0082.namprd04.prod.outlook.com (2603:10b6:806:121::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:33:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfecd0ec-d2c0-4345-ff21-08d900e4976c
X-MS-TrafficTypeDiagnostic: BY5PR10MB4002:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4002048E37B9A5DDF3862E6AFC4C9@BY5PR10MB4002.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pv3mN1rCgC4vwFkavi/ktesmwDRa9d+foie0xmIoWf81Bmwybx/yFC1/RBX3gRbQS6ayskOPlOyOywAf9MEpxOm60/ITnTUBrtde4Jvquvza8B6MGR0vXFJeYcX14AkkYMAe+RzcFeb9xbyKdfiO7N1vOriztlDRI3Eofk2/WLDCXATCpMW0YyjySwf1jUpZFOkm/TiWYYp2hcwsEu4VA0USUwwTH+z1S6wUwLaYmLYCsChZloRGtNrTgWF7B5f/opE21mQ57QAfP9OWPAAmvGJmrkImj3SayNrBAvc0nZVyNkLauEJRfL/5xWP75VxQ8hsItiKFhbmRt7HOk96WNImuBuQBVhpEvh9vqWa3ngCLEYPQTmIvxqpiAe6OCXxsKlSo1jP80po/t54562STB3Cj8D6L6OAOFqjKz12znaPf8cl1y4PG88sJZJMQPM46cvmGm9I99He5rSaUq0a4fN7B2LRrfxLlaimvnfG9Jf+sga18blAjyUaL0aJirJYYAU/Pa4ziGdJL8ChYQFAfY/TCg9+1YMeq6lJ0DFd3Xq0b6mT5/30tiBLtpcJWKnHQr7XwjY1qTjKpeHrCZYH15zj6d6+uESyw7qK4uFmRL/Bc91V80TN+HObcHlxsKOmTZbrmI2hK69GMExo476dFitu7HF1E8XCVyvMPYGZgrVRG55tZYT2I3MGvEAaavm46g0PlF0FCSUcuco8kx5iLKh9hTPl7T9eM29gZFKPMLJZu5B1NfEs41RkhqrvP5TvQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(186003)(16526019)(4326008)(66946007)(55016002)(83380400001)(956004)(66556008)(508600001)(19627235002)(7696005)(316002)(86362001)(2906002)(26005)(66574015)(52116002)(5660300002)(8676002)(45080400002)(38350700002)(6666004)(966005)(8936002)(1076003)(54906003)(7416002)(44832011)(38100700002)(6916009)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?hQuYV1lyE2DDHkLJqs3JKdugr2kbHR0uTNY5asnTF1af9PvHavyuluClkn?=
 =?iso-8859-1?Q?vZlvdf/hxiBC5GcF5xaV5l11TXXHamuj4zvX6sWAm5o3GP/Pf/Z+Sv+1h9?=
 =?iso-8859-1?Q?P0HNtWkrnosglHJw+I321r5f3x0humPcc0FtkT4cRH9v7xRN4XNPpOHJ/N?=
 =?iso-8859-1?Q?GFEgSsugAXFbPRyAcwonp8EX/y/h4k0i12bU9jt8YsIj+s3tnKies7Pah5?=
 =?iso-8859-1?Q?9ilov3UUzOAMQ1AjySBIcmFLeil5cqkg3Hszk4UtB/v6T+GRFxhcmkbKsf?=
 =?iso-8859-1?Q?uNmfiZX83fCdfEtpCwoNmOev1lxo0qvKxRpDrXlfMfz2iRL+mbed/zSXfU?=
 =?iso-8859-1?Q?54vo1B3vcra6b9j2cBGOFtFNLrWj7r2I47YzaZoGajceRdADBA0Wi+PzpD?=
 =?iso-8859-1?Q?bX3t/y6pTVpgeejwdTKuIRIG9RcUs57WBPRO4EJuNLNSsOjd8XFwa2tX9J?=
 =?iso-8859-1?Q?noOCWW0NWv8W0Td53rBDerEV1sPLxeCL9gYgw1ttgAjpAdEoTNiGn9+aCi?=
 =?iso-8859-1?Q?VeYElPMx8dOYEln6L/2tuY4DDDwWD4ZdgpL7R8FAAZH24MOFzl3E10XU4I?=
 =?iso-8859-1?Q?lm9A8stzib5nrL+D8lREmHdOUb9CKEf2hciFIDK4dk/1Tkh34c8ebMjPDp?=
 =?iso-8859-1?Q?L/ru8JM+NQkf/i48a3FyWW4z2LdBiMoLHn4rgAtzPNxsko3RYV3E54uttw?=
 =?iso-8859-1?Q?mcEieQ2hj96UXIuB2Ia7wUGG7XHIO2QJgnclVrSyLnn1pdRWJ7WCTNYgeu?=
 =?iso-8859-1?Q?tEY/AvurjMIgyvehgpSESsScY4ZG+NmUKp5ph8vYQ927r/6utS2MwuUYP6?=
 =?iso-8859-1?Q?AH4bFYDfTG8sHVOuKTO9NiFF0dSk/LV8N7VWS4+3xKbVLprpuqWnAp14Jj?=
 =?iso-8859-1?Q?tDbJieqDPGfVyPIGqANDMFLR0OFdiG0xbgU1QKUq74ORsUASIUBIGTRfTe?=
 =?iso-8859-1?Q?bfk8RyF0QhQU7wr5mKi510h3f0J4KDZnKH5xv9ywU3HDP1LFBWNOSNSosi?=
 =?iso-8859-1?Q?ltSW/OcNxpWtZStC4/KfknLQUHWfUKNN/Gd9ZtQSFJNG2Dp+UYDaqkq+rU?=
 =?iso-8859-1?Q?9/5FxhTU16Ag4P0hWHYWZDZ1d7AWINd7W82tEd4xCEGrCivPysTKUg/4/8?=
 =?iso-8859-1?Q?Pjfkro/qwHFLj0fAk+8xB+Xtm5bBMsHTwzr1gqN68cRaoyBsdqeSLjhydv?=
 =?iso-8859-1?Q?UH4tTpnpfOEHnOqKYblgQCjkov9DTRzBQTudLUoNbjTe7M/KiAtsqIB54/?=
 =?iso-8859-1?Q?j2XF6YQ6xgF1O1fCoar19ndwnvAf4PfwRQy0eDBMl61r1z16e1Wzd4O7GX?=
 =?iso-8859-1?Q?bzP2HjM6Dtie7+CljC87r0LxupuyIYzI2tTkYJj8v2GnVLO9T7OtW/RE2K?=
 =?iso-8859-1?Q?jMG60Pce05?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfecd0ec-d2c0-4345-ff21-08d900e4976c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:33:24.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kw34okuEijx82JuY0TjrUTkFhje80ySEOXfvaeH+TLTuzXBNk/ZZpFg8zH07wTIljdywSg6NqgwPO5GKFerxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160110
X-Proofpoint-GUID: vC4KqyJv2fleOz6ELXNbt636SW25PL5c
X-Proofpoint-ORIG-GUID: vC4KqyJv2fleOz6ELXNbt636SW25PL5c
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160109
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 03:54:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Apr 16 2021, Derrick Stolee via GitGitGadget wrote:
> 
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > If a remote has the skipFetchAll setting enabled, then that remote is
> > not intended for frequent fetching. It makes sense to not fetch that
> > data during the 'prefetch' maintenance task. Skip that remote in the
> > iteration without error. The skip_default_update member is initialized
> > in remote.c:handle_config() as part of initializing the 'struct remote'.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  builtin/gc.c           | 3 +++
> >  t/t7900-maintenance.sh | 8 +++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 9d35f7da50d8..98a803196b88 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -878,6 +878,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
> >  	struct maintenance_run_opts *opts = cbdata;
> >  	struct child_process child = CHILD_PROCESS_INIT;
> >  
> > +	if (remote->skip_default_update)
> > +		return 0;
> > +
> >  	child.git_cmd = 1;
> >  	strvec_pushl(&child.args, "fetch", remote->name,
> >  		     "--prefetch", "--prune", "--no-tags",
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index eadb800c08cc..b93ae014ee58 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -153,7 +153,13 @@ test_expect_success 'prefetch multiple remotes' '
> >  
> >  	test_cmp_config refs/prefetch/ log.excludedecoration &&
> >  	git log --oneline --decorate --all >log &&
> > -	! grep "prefetch" log
> > +	! grep "prefetch" log &&
> > +
> > +	test_when_finished git config --unset remote.remote1.skipFetchAll &&
> > +	git config remote.remote1.skipFetchAll true &&
> > +	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
> > +	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
> > +	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
> >  '
> >  
> >  test_expect_success 'prefetch and existing log.excludeDecoration values' '
> 
> Without having read the code I'd have very much expected a
> "remote.*.skipFetchAll" to impact:
> 
>     git fetch --all

'skipFetchAll' indeed impacts 'git fetch --all'

But this patch doesn't add "skipFetchAll", instead it just honors that
config if set during 'git maintenance --task=prefetch'

See v3 discussion: https://lore.kernel.org/git/2f4fa2b5-0d8b-b368-ab4d-411740595a4f@gmail.com/

> 
> Or:
> 
>     git remote update --all # --all does not exist yet
> 
> As e.g. remote.<name>.skipDefaultUpdate would do (i.e. impact "git
> remote update" ...).
> 
> I suspect naming it like this started as a hack around the lack of
> 4-level .ini config keys, i.e. so we could do:
> 
>     maintenance.remote.<name>.skipFetchAll = true
> 
> But I wonder if we couldn't give this a less confusing name still, even
> the pseudo-command form of:
> 
>     maintenanceRemote.<name>.skipFetchAll = true
> 
> Or something...
> 

Whether or not additional maintenance specific configs are desired, that might be
something to consider.  I've thought about this for a few of my repos
which have remotes which require a VPN connection.  Perhaps
I want to skip those during 'prefetch'?  Or maybe instead define a
'remotes.prefetch' group and only prefetch remotes listed?

That all said - I wouldn't hold-up this patch series for it.

--Tom
