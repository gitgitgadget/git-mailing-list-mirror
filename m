Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1865C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E216113B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 11:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhKDLTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:19:12 -0400
Received: from mail-eopbgr1410133.outbound.protection.outlook.com ([40.107.141.133]:25824
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229809AbhKDLTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 07:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqRXN8HRhHwwTuU0+xGF2KJKi27cX1nnutR03fLCB/Q+nhgDmAmQO8edp5KB8wT+0dBbnWT4Rwsh9bB7+pG3b+lZGVMwN04Nm7Zvdze04jUesMKvdbmN/lY0KZS6Oj55rtDHW2PjYxCcLXIyZUjfPQRyVO0097tDjQacqVJmXMlUWOuWk9VSJ0bTOqp0pVr0usOoIkDuWQBBH++uKovVYiuN1pl95xKEoYKfI9jh3a8KBYL5V7xnnRP/Fddp5knswXjN8DIgmsyWKcDu25imtDhW/SehL1tgyZeeffZK4oTJheQHmAhuKVWAK5ixGReM7qsT2ihbKxrotncXV/beHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAwof+IIi1IXLHlT1iIXR3IlUl50dHZAmZtFOR7YJhs=;
 b=nENlLHazhkD8HlOs0ztDDQgAiFOyHugxd8Xt7PON/eKyIizwpmzHWVBzud3xeYoOM9rehYyj7gT0KQSHNiQ2qmVYnwti/JYoAmuWxXExbu4G7dE2fCRLfYJybSarQg9J4HeuMYboPUAU5xfrhFRWqEw1QGzdHwqtI4OhV5vm3YYUzlixuAG4U8JgsIs+1YItA7m4uoShH7FyXutf80MfVAMHKDLUorTmkPHpQO0h06DLBAcaX8yiE/gyjLfCmaD8fGGsyFpEF9qAFXTeqpq88aaLEy/XW5t6jmyamOlUYNrA2McwWrhTdEFikLrvyAwN0GKZs9I8hkWYElyWhSCt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAwof+IIi1IXLHlT1iIXR3IlUl50dHZAmZtFOR7YJhs=;
 b=d0gYvG2GUhipWUOcisCwfElCiaVdT4KcW1YO2hf4FMl5UqHFLvkKD0wPquj+Z4p3Fn8fkF6ksIFKsQe63jG6M5QOWzGryNyozyA9qKqY/o1S3tU1jc43260mTzpc0UWOfFVCM833y5YQ3WQdRiFrUXGrhgn7XyEL7sG/wf5SU5Q=
Authentication-Results: skydio.com; dkim=none (message not signed)
 header.d=none;skydio.com; dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYBP286MB0126.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:802d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 11:16:25 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b4b2:45a5:5cf4:d52a]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b4b2:45a5:5cf4:d52a%3]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 11:16:25 +0000
Date:   Thu, 4 Nov 2021 19:16:06 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] apply: fix delete-then-new patch fail with 3way
Message-ID: <YYPA9tKnsfTBOWDM@Sun>
References: <YVmTKWlOFr+IwzzI@Sun>
 <YWsbcbASLG3QNPyZ@Sun>
 <xmqqv91wyyij.fsf@gitster.g>
 <CAMKO5Csj_ck+1+0JsvmF7eSkr514GBUtznKqPvkfEwHGJ34cwQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMKO5Csj_ck+1+0JsvmF7eSkr514GBUtznKqPvkfEwHGJ34cwQ@mail.gmail.com>
X-Operating-System: Linux Sun 5.10.63 
X-Mailer: Mutt 2.1.2 (2021-08-24)
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
Received: from localhost (2402:f000:6:600b::11) by HKAPR04CA0017.apcprd04.prod.outlook.com (2603:1096:203:d0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 11:16:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0f047f7-79c0-4636-655c-08d99f8489bb
X-MS-TrafficTypeDiagnostic: TYBP286MB0126:
X-Microsoft-Antispam-PRVS: <TYBP286MB0126D94893FCC378DD6063A1BC8D9@TYBP286MB0126.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE5PDrx8q6fYRGkOuc0PaojJhb3Sz3oNxTWe7fA0jZPgmGTbLrVcMlFxnHYIei57G1t3Bg+LviSjrJ+yraMgX5CEgTF+eOHNynzpbjLupFPa4EhDAdygiiWI99loJStr6lNYr1C1APkPmDg/6Fjcs5wTp73b4YxFplp6C8Yi5tO15h/2I7iTE0GeSQtB8783kBiPOXXsFyjLnDg3y1bt9/pMLugPk5WY1HWwWVc0/l45cR/9FXBiG7vxoOWglvRtBbBz8nXcs8RHKXD3ZbFtbNjAg44Z4W1IUrCT2JDSRzutb8LtVj2wT2VZiahqKRV/Y4DvWf3YwnOR+CWDjo4HHGKe7Ro3xHKnSGdDSbRJZLRf1T1sQeM2WGbSO9dwJpg8QcjbpnbAftOKqJtMC73MFXeJZUDQcu9bkV22RqdNsqvrbsypJf3m/50JJFnUFhiLWAnnBs9lZrIX5R5DdPuiWSZTdUnN18z9x9VcuDUtjGi8hBNlmaBSHfb+c5Pvnq4KopSl6w1IKF8WVph+IbdURejme8yJdnRLBLAgtx/X1yeXWkwcCw519K9gWMzVzuRByL948mhil5XKef18PpWzF8by+uPpP25biaOPTvvX6rr9Y/+7SigPkKOU1QMN3a0/iwRmNgzN/uDjlVxo/EIcy/p9uutnTg703jRHBl1tkaipBYJ8yhB2fJ/NWsAF19WXJ+LiZX0UfVYYvfiBQk4eTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(396003)(39830400003)(346002)(376002)(366004)(136003)(316002)(786003)(5660300002)(38100700002)(2906002)(53546011)(54906003)(4326008)(6496006)(52116002)(33716001)(186003)(66476007)(83380400001)(9686003)(86362001)(8936002)(508600001)(8676002)(6486002)(6916009)(66556008)(66946007)(6666004)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNX87EBaF2tc1QrXOYKhUfMXhXTRZdeMr/ADQsZAMnZNA9FiPtmy0LROnYha?=
 =?us-ascii?Q?Sf7wyw1z/SjmAiSU0fWyL3d0HPGGmmenIyjWg5BjGKRxXkWuFmabl9cxAGwX?=
 =?us-ascii?Q?1pEjKsFQke5tb95qcCoX1ioTsqzjXUW5ebY6wq0SIejnbZKTan7OWnsGlxEg?=
 =?us-ascii?Q?RrrrKhAjxl8yLKF7w1t2dv+3YTemCOJnrWUPqK29/6tP4EDTxXd4tBfuaU05?=
 =?us-ascii?Q?KUNHZ8qC3ojvDnmwI4YLFdThhd7XPIrno0jRUGX4sDQutRwUMdIsoAkDzEy9?=
 =?us-ascii?Q?q9rchsxG/nAVs5nOY5v+1/LFVmZxP/SCQFHbGQu1xfkWCTr6sAoNi7eX+K/M?=
 =?us-ascii?Q?CnlLrXK1VatoNqo57I51JV6QtYzudPRYORGdSfn3pNzP59br0DmUKVQZNtW3?=
 =?us-ascii?Q?MYOxxTyrvBHSCmdFyKiod0WYTUyPGFidDVpRbnZlI0mG0K7Fg5mwXBzcUy/u?=
 =?us-ascii?Q?UfRI/sp05prVZnxkq+kVOIclX6hCE/yJWsAQvyQajt3H2BIRnaA2Jz7tTjeN?=
 =?us-ascii?Q?3PhKde/LrDY9670/k359c6eFnHxoZ+S1kiG8LyAozvkIZMMohqDR/pSKwy8S?=
 =?us-ascii?Q?a1oRpoK2C4cB1604q7t4kWSEOkLbeyiXFwztoireL3w35Ng2uBle0hMXez50?=
 =?us-ascii?Q?fvvW8UJqTVwwDaAghMIpqdwFyMQP8WFsdoK2Kdd4QIzNMHsb7mFFDOUb7c8J?=
 =?us-ascii?Q?5+FGlX3abGgZAv9vXrkvb91Sh8crBTwTZjxWAVVdml+UtCot+YV3KzHbQix6?=
 =?us-ascii?Q?OBXbum4Lt6RhJxtiIrjG6FPDxnz4amA8LS2k6NZTdvjmSOX3XoA0fFRJZ/CA?=
 =?us-ascii?Q?dMvVkZ297JmL4X73BfMMPe/ds6Xh1wBI3fbPzBcnxw6hTm5kTSzXT/ZgU5Nv?=
 =?us-ascii?Q?qXawzaRMJIS1yIs/B0/qFh1oZPe6v/1gUaLFIqIJ409fwSHNbXIU0hJLgdCv?=
 =?us-ascii?Q?SJgLNc8DZkYZhgEoHN82s/lzN2J0ocARcOsMHNt9PSio6tuWThbGx2BrJLPu?=
 =?us-ascii?Q?vMux/GsztnCUwcunrlV80aZwu2qC9Q1a+N1To1rbw4PhGYrwR4g9WOk2QnuY?=
 =?us-ascii?Q?hwoDU6QtdYUZI0a7OUqMvSNym8jETfO5PGFIZHdemMdkGVhj/hnYP51J+zXS?=
 =?us-ascii?Q?L/xYSq1sAu/aPd6E5ZZkdxbTYRzlWHJ3SkRqfpCEtgA3AKK6PpgiBLLQOMIx?=
 =?us-ascii?Q?koC77mR9u2+cKse0Tm2xcKTJfo9gg+BVsuFUBIHnCuB72kkeZSIe26JyVd3y?=
 =?us-ascii?Q?2TawF0Wz6ixpfNxubUFRMKQs4wCpvr6YGj4rM9DDK+kX+xJ2b5mN9TUBXwOD?=
 =?us-ascii?Q?2ycyl/mSuQDB1IzHhVdqz4ksFaoD1vQwjTzs7JFZdgUrhmBXelqe5IGm0E9y?=
 =?us-ascii?Q?MJubcqgE2Kh1x8g3ZjyP5/jouSFqXdMvxdSPR1jvzv2DePHpBPVRAuqCVYtg?=
 =?us-ascii?Q?O828G5bbBopcX7USKdAg2F/xxswTKf6m5mAW+cOW/HP26Jc6F8nYj/D8jtiZ?=
 =?us-ascii?Q?DlTMkLGcSI1MICcG5/Gnhe6fh79kZqAPMlKcQBNhFGRLZDBNKh2iooeLc6aX?=
 =?us-ascii?Q?BYntdgoa3IelAW/g753l4sYgALtVyMjbfO7G4K/e?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f047f7-79c0-4636-655c-08d99f8489bb
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 11:16:24.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39TkPJjPg9K0T5JnNYAoiMh6THxiYyNDm6WSGVkhqGCJjObJ9jsFFTCU8YgNeDrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0126
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 11:56:11AM -0700, Jerry Zhang wrote:
> On Sat, Oct 16, 2021 at 11:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Hongren (Zenithal) Zheng" <i@zenithal.me> writes:
> >
> > > On Sun, Oct 03, 2021 at 07:25:29PM +0800, Hongren (Zenithal) Zheng wrote:
> > >> For one single patch FILE containing both deletion and creation
> > >> of the same file, applying with three way would fail, which should not.
> > >>  ...
> >
> > Sigh.
> >
> > Jerry, it seems that the earlier "let's be more aggressive to use
> > --3way, instead of using it as a fallback" is turning out to be more
> > and more trouble than we hoped.
> >
> > One thing to notice about the patch used for this test is that ...
> >
> > >> +test_expect_success 'apply delete then new patch with 3way' '
> > >> +    git reset --hard main &&
> > >> +    test_write_lines 1 > delnew &&
> > >> +    git add delnew &&
> > >> +    git commit -m "delnew" &&
> > >> +    cat >delete-then-new.patch <<-\EOF &&
> > >> +    --- a/delnew
> > >> +    +++ /dev/null
> > >> +    @@ -1 +0,0 @@
> > >> +    -1
> > >> +    --- /dev/null
> > >> +    +++ b/delnew
> > >> +    @@ -0,0 +1 @@
> > >> +    +2
> > >> +    EOF
> >
> > ... this is clearly not a patch that was generated by Git.  We do
> > not show two separate patches, to delete and then to create, the
> > same path to express a file modification, and that is true even when
> > we are showing a total-rewrite patch.

I'm aware of such process. This patch is generated by manually concatenating
two patches together.

Why should I concat patches, you may ask. Well, there are cases where
I have to distribute a patch series containing dozens of patches (like
packaging for a Linux distribution), instead of multiple files, one
file would be convenient. Also, since the patch series may be out-of-date as
the upstream repo progresses, git apply -3 would be better.

Despite the above example. Placing patches inside one file or not should
not affect the result of git apply -3

Refer to the man page of patch

From my first post:
> > >> The man page of `patch` says: If the patch file contains more than
> > >> one patch, patch tries to apply each of them as if they came
> > >> from separate patch files. So I think this way is more standardized.

> > In addition, the above set of two patches lack the "index" header
> > that records the old and new blob object name, because it is not a
> > patch generated by Git.  Whether 3-way is attempted before or after
> > the normal application, because the object names there are a crucial
> > ingredient for the 3-way merge logic, there is no way for it to work
> > at all.

It is my fault that for simplicity, I did not use a way to generate
patches with an "index" header in it. Below is the procedure to
reproduce this "bug" (I still call it "bug") even with index in it.

mkdir delete-then-new
pushd delete-then-new
git init
echo 1 > a
git add a
git commit -m "init"
git rm a
git commit -m "delete"
echo 2 > a
git add a
git commit -m "new"
git format-patch --full-index -o ../ HEAD~2
git checkout HEAD~2
cat ../0001-delete.patch ../0002-new.patch > ../delete-then-new.patch
git apply -3 ../delete-then-new.patch # it would fail

> >
> >
> > >> +    # Apply must succeed.
> > >> +    git apply --3way delete-then-new.patch
> >
> > So, one simple and safe answer would be "Don't do it, --3way is only
> > about Git patches."  IOW, the command is failing as designed.
> Yeah I do wonder why one would specify "--3way" when the behavior that
> they want is actually "direct application". Maybe the OP can elaborate on their
> use case?

I have mentioned the specific 3way usage in the above case.

> Part of my original assumption was that "--3way" users actually *want* 3way,
> and thus the behavior change wouldn't be too controversial. Of course since
> git has so many users, it shouldn't be that surprising that there are many use
> patterns out there.

I do want 3way, but there are cases where 3way would not work,
like when 3way patches and direct patches (e.g. delete/new, mode change)
are mixed together in one patch file.

I think we should enumerate all cases where threeway should be avoided
and we should fallback to directly applying. From my inspection of the
code, it seems that it is not sufficient now.

> One possible fix-all solution would just be to back out the original change and
> move the behavior into a new flag "--actually-3way" (name tbd) that will apply
> this behavior and "--3way" would keep the old behavior. The downside here
> would be proliferating more flags that would complicate the api and require
> maintenance. And of course if users depended on the *new* behavior in the
> meantime, then we'd be stuck.
> 
> Back to the patch at hand, it does seem like it would work, however I
> notice that
> if a modification patch were added to the end of the file such that it were
> deleted -> add -> modify, that modify wouldn't benefit from actually
> doing a 3way
> since the file would not be in the index due to this short-cut. The
> more general approach
> of refactoring to write out results after each patch instead of at the
> end *would* fix
> both things. I guess this goes back to the larger issue of the
> threeway implementation
> not being well suited to non-git patches.

Yes, the problem comes from the short-cut, and I have mentioned that
we should write out results immediately instead of at the end.

From my first post:
> > >> Another way, which I do not adopt because it requires major refactor
> > >> but it is more clean and understandable, is to change the way
> > >> write_out_resultes() is called, namely instead of calling it
> > >> after all patches being applied in one patch FILE, after each patch
> > >> being applied, we write_out_result immediately thus deleting one file
> > >> would immediately delete the file from the index.

> >
> > To extend and automate the solution would be to see, just before
> > attempting to do the 3-way, if the incoming patch is a Git generated
> > one, and do not even bother using the 3-way logic if it is not.
> >

Concating two git-generated patches together would fool this mechanism, I
suppose. So the above "bug" still exists.
