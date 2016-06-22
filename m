Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2A51FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 11:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbcFVLBw (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 07:01:52 -0400
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:2784
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751495AbcFVLBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 07:01:49 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.onmicrosoft.com;
 s=selector1-roku-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Txa1P81dFU2/PtfHfDeqzcHwERsQITzTOSu5VbPDhQc=;
 b=AkH9Zcjm/LP+V+hHAaJJnRfT8EjwSXRS9jLJ6p8h+/hyM0VQmFZvA7fUgIGsT8dYMl7W+41HIRjLd5PWGeCW5lVaxhNvxN5BfhYgcsZBXnQr72cCJqTTVNYXwEo3eDiVMigjJQ3vS/gwPWyjgvZyMrcVu68/R0uXfBx2/OiGzG0=
Authentication-Results:	spf=none (sender IP is )
 smtp.mailfrom=aoakley@roku.com; 
Received: from aoakley-t5810.corp.roku (81.145.207.254) by
 CY1PR01MB2073.prod.exchangelabs.com (10.166.205.13) with Microsoft SMTP
 Server (TLS) id 15.1.523.12; Wed, 22 Jun 2016 09:28:07 +0000
From:	Andrew Oakley <aoakley@roku.com>
To:	<git@vger.kernel.org>
CC:	<gitster@pobox.com>, <larsxschneider@gmail.com>,
	<luke@diamand.org>, Andrew Oakley <aoakley@roku.com>
Subject: [PATCH 1/1] git-p4: correct hasBranchPrefix verbose output
Date:	Wed, 22 Jun 2016 10:26:11 +0100
Message-ID: <1466587571-18532-1-git-send-email-aoakley@roku.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <xmqqbn2uqufj.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn2uqufj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.145.207.254]
X-ClientProxiedBy: AM4PR03CA0035.eurprd03.prod.outlook.com (10.165.240.45) To
 CY1PR01MB2073.prod.exchangelabs.com (10.166.205.13)
X-MS-Office365-Filtering-Correlation-Id: 2561dbff-72cd-4228-a0d8-08d39a7f8606
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2073;2:YbJm8gh7gNhjGRYrb4Sr1+aFlNJ8NgULzh1vcQEREvnAE0X1P1ELB4GSkclagDnASFF1FXEVwA87RXfJ8R+891kGqWVrGKmVrPWcsmdNvoQ/gs3eks/sWuOMRg3hZXNtKELkyEJdKK7o9TrIUgzjA93gOf9mg5S1AQfttBsl+3OslkKJRYRDWoanHfj8FHa7;3:uF5by+gISnqaveoqUrBDN13EMNv7QFj27x1rldhChREuJmCes33dIpCPdamiobVhx8nbdC9U1aB2j4+YP1HrGLbsdvXkP+1SiQx94UyOPOpYfiyKm1eOc43+CcdFBqY0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR01MB2073;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2073;25:dvYO1j1QqDMuNLErnAriBbNDoy0lxdV6y1QZrm6k5mzHJtezdMdzaM9lhuIO1SBZe8HmoR9qJxljB3ApZuhl/zMw92zDMBFsV+6MsVNg26a6U/4KMA34jOUCphmWey7ClMOhna8qJISP/+vMZGIUJI624N78DQFY4npkjEPO9e0dVRPIdl9ra30n90kAKoTATp0bcoVHafu5cNjTqJgOXWNyPdpWw8xJmhRmWgOUnjf8UfWVVPmLy0RfYbzDN7p6gNwxJtkmbUH+ZZ+DcX8mQF1l4RHMP7h+iJBZabo/myOScTjEiok81gANZeZ23hNGTDRII+rIrUADoe/hipayKltfsN6ncDLLkJ/QdeJpxD9tnTKTuh5EFvGGJVvPuvcDSa/2AOTyQSYFRHXEI0aJDOP9uxHSCZGjgfGEqqQ2Pc50z4qGWjlw+NxmPCuoLf9jP0UonKh81tJo04zrAz6OaLkbK0gBDwxvmsiTg0/pCiUyAPYOBh8AeG7RjTU0QUbC6n5lWtMnrGwJHWqvYdpBWy9foSTKw6y0IdOmGD4GNH1vIOMa5BDkVbc4BYsy2GZvl6GyfY4LRDds8V0UsH6eWscnJ9s1EoerqYdExim4gvuMPYgzrCeLOmx/9kruTh6CxYjHUYaYusgENTs3OVUMX9qar+ntSYpLj91a1dieeOFtC9bfMcN20Bg59lSulzidmIn6ol1iQQCl0lsEf09olJ3AQE8N8juevEefDHKBxj4=
X-Microsoft-Antispam-PRVS: <CY1PR01MB207353FB5C3D0C164DCECEDEC22C0@CY1PR01MB2073.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(169088704739312);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CY1PR01MB2073;BCL:0;PCL:0;RULEID:;SRVR:CY1PR01MB2073;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2073;4:tf8de2iHdkUpme1e856Io5pIaICVipjI6Az1p6QWxHPyTjv5QF46862xfZ8nC/SuOUYACsPO49mxy9E+LCat8RQRwhgWvOijSxQ/HRnlelu74T7LvtU5j3LTNkWXRT3I+HrOXBlhzUTfU5B6YdlWkVNP4faJKt5GmI3vfTwGqojt80mraha/VjUw4ig7UuZNBshbWboi0w9gAqhxGXtYp/uLRM/fI1ampTeYFmzrxok4ZhGLjKMCgjaIkEe0gYAfabcoD1Nnf9ybwQReyKZaU0MSxoD84OJa9PbzHrvhVdfugwO5sWuEm6fmoZdSz5YjvMURrY/18ZVszkf6wZUEfMnSctE/ywuHleNGUT7UwCwKSoP3EEacSNGhNeOl28C88h6gN5PAu+Cq468+VU9QyA==
X-Forefront-PRVS: 0981815F2F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(7846002)(586003)(48376002)(77096005)(92566002)(6116002)(76176999)(69596002)(50226002)(3846002)(8666005)(2950100001)(68736007)(36756003)(50986999)(97736004)(229853001)(5003940100001)(8676002)(106356001)(105586002)(47776003)(66066001)(4326007)(2351001)(101416001)(19580405001)(81156014)(19580395003)(50466002)(189998001)(2906002)(42186005)(107886002)(86362001)(81166006)(4001430100002)(33646002)(7736002)(53416004)(110136002)(7059030);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR01MB2073;H:aoakley-t5810.corp.roku;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: roku.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR01MB2073;23:n1u8nb5FyQmiBdWf2iEgjkV05wkZccLECd+O4IJwe?=
 =?us-ascii?Q?C5y1GGDM4wGb6Bq1JrX7+N0/L0LXfVA657yFUzn8wsvA2WzFFLeNUEy4uLg+?=
 =?us-ascii?Q?ep3fVD31iL83ePtKs1vjhf/kK0EuW6nA7UldQARoWYXATls7xAg3MFWeXoG2?=
 =?us-ascii?Q?TTYK6rJ3LZ/cs+dicFvAd4dhlTCg51KmQ2Qwco3EQjhTKEAInYUyuGsejLZP?=
 =?us-ascii?Q?yMUa4ZjGhfOdk4Um++rBkxeYTlw7EWBWTSVv/TyWYlyd6HYKhcW9f3exwZ2j?=
 =?us-ascii?Q?1Q+fNayfNtBLVR57fXNk784Ec8QK2DJJgsF05S9zmQA+3La4uX7s0Y/fteg2?=
 =?us-ascii?Q?lzB8ACAJmgM5Efa1B6jQSkZfqUXU6PMA8oDRnxbW7OIfB8CVeleYe9tWCtsA?=
 =?us-ascii?Q?QIEP7EHXaR+U74lmv85NXoOZIjJdtnlWzk0B165VY+8fjPPkJQgFwLlihonH?=
 =?us-ascii?Q?nepRtxom4jIoyFrEJlmgFFaW3cUr/uw1WdPFJ+Nr7mSD5KEeduElx7nHfwCK?=
 =?us-ascii?Q?w580jamX3P83aDIRfJCbduUBXlfXTG2W0/5nel93uK09men8/PmNe8NIWnW4?=
 =?us-ascii?Q?ktsjq6klqS4tsjKIBF6LNm6jFZyiX1yxlWRruH7UAC/JZqIU+eTX4O4v2ZXN?=
 =?us-ascii?Q?D3+p/HbWthLyoIRC04rxD5s01QwHoe7hgUnPlHx2UqhaWSWvvkGzUd+/duDr?=
 =?us-ascii?Q?AXP2tUWipJDpt0E4LxldD7SYe8uHO5tvwiKq3oUKzd1h30fyrvYj/qELtHlF?=
 =?us-ascii?Q?WK2iFgpFy6XfjwF4WBNg+NVcad/svG93In0qT+3GZZwkR6RPdWnRDJACiq/M?=
 =?us-ascii?Q?ZgNtWrv89pjq+561YsYkr+TQORV8W8IIG88B/SGeTwoibMcYZbKNQTXLRcrq?=
 =?us-ascii?Q?RdY5gURBfTHCgDTiqdCuOaizgaxwlSDI4ty8buNMQuO8omIm7Anw5I0kpwNX?=
 =?us-ascii?Q?3lmQIFPsVOYHJ+AeJZKk1LjklZGcRhRmLRdvaghixX59OzFN+LZbzDSk1w+W?=
 =?us-ascii?Q?rNvDJGabVgXVkxLU4ZXXD4L34lnQLsblfjFpdi1BtUZ4mKDk9zIMyKoeeu1I?=
 =?us-ascii?Q?MXyLiCDhV0a6YdL7on+MvW6y1asEwzvgQWE32GtQ/hBJlTlLYJ873IeUUD5Y?=
 =?us-ascii?Q?eOFzoo534YRNlyZt4RfsyfvUAa1zfeh4isGQ2t638uK1VjbaY46WRyp4wpmp?=
 =?us-ascii?Q?DhAzna5UeRVYKM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR01MB2073;6:1PcOM8eVooaIDXR0/gSl5L9mapVSsIeW2J85CPMn2U01H3lqxs3LTWrktrikC9rAxbjOBkDZcDsHTYsCd9KQrpZd9LLPtH2HGPMMupraNMdPSWa9wjl4n/yzjEqRQod9spAgOaTZyqrGx1mfiQJsCXLY2BPz4rXOqKLEHbpKF3uv+GORWNoMeaT4P3OGlIjjlVuV/Hs2F/bkE+U4xqC/H0uGPiV5lco/yVwPYRH2HEx1wb/px4UKJUrpPH1cPF97RlFUR4NQURrzZ23wGp87+ex36HlaGN53B8RPJUDSPD5HNzJoSbYqptg/VB/+LVaK;5:BUM6MRVuBA7uryOUpLrO9angUnY7h0IfcPyNdtWwU7PnP6Kxs31oI+rT9DQc9+rZB0r82anRl/sgEgWXtVM1gwwhkpFExXoctOBMcj7tNFrkn85108U54hwU0TKI+/geZUL4rgGVYIqxvAgjCi0zoA==;24:IKjZCqghcAdLdSWb8edTr8vkrXS2r217i76qdbzNPJ5B5wWQJqe3eUpj+ztyVr9ss8z+WoxMf3GpX0JYnx490HBLioSnWkFGsoYL6OARg/U=;7:i8xuDIuYqmKqw9wByKFYx5OYXFn9Aw552Hb3GCSddc5TY+BjXUkcD1d4NkINRFo9lTqiWWDM0WdOSHEzDQlBDCGlDt7rHkPVdjEsA5fCiyUn3+C5Cf14qlxfe89m61U3hIRAZNiJO8h5WOw2lI7mWxFXqIgE3Cc6xnZhGzWCot5LTs3nexzAoEhwK7G6AM6BemNQPgMyWjn+TsKJdWM5fg3FB9XP5N8AmOSl94rxi4C1gOxdE1Fg9UNxE7xclTAG4EzIfYFz5Lr3NBulCrKlgg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata:	NSPM
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2016 09:28:07.9448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB2073
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The logic here was inverted, you got a message saying the file is
ignored for each file that is not ignored.

Signed-off-by: Andrew Oakley <aoakley@roku.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index b6593cf..b123aa2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2674,7 +2674,7 @@ class P4Sync(Command, P4UserMap):
             return True
         hasPrefix = [p for p in self.branchPrefixes
                         if p4PathStartsWith(path, p)]
-        if hasPrefix and self.verbose:
+        if not hasPrefix and self.verbose:
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
 
-- 
2.7.3

