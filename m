Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B631F403
	for <e@80x24.org>; Mon,  4 Jun 2018 12:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeFDM07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 08:26:59 -0400
Received: from mail-cys01nam02on0108.outbound.protection.outlook.com ([104.47.37.108]:39296
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752559AbeFDM05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 08:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YidADK4upSA1XS3mdaApZtSaqnDgNcCFwPb8+ZpeGy4=;
 b=IPuFGgorM5tfSqNKZRV64j8++Ou79LWVf+G9H40Qw5LEY/KDbtVyWTLxCXkOnXVoy1wUQKuMfE4jz8mct7wpaMa2gYqtDhmWiUEQPOGegzRDhvRwymy0CHofiPZC/udpuSSTgCw1wB7n7QC6AnBaVHMnIohz3dbIF4/seY+/+vw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from ban8fdmsf2.ads.autodesk.com (132.188.72.184) by
 MWHP136MB0013.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.820.15; Mon, 4
 Jun 2018 12:26:53 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de, pstodulk@redhat.com,
        nickh@reactrix.com, jeremy.wyman@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC PATCH v1] http: add http.keepRejectedCredentials config
Date:   Mon,  4 Jun 2018 05:26:35 -0700
Message-Id: <20180604122635.95342-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.72.184]
X-ClientProxiedBy: BL0PR0102CA0032.prod.exchangelabs.com
 (2603:10b6:207:18::45) To MWHP136MB0013.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0013;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0013;3:nTQhEV3OG3K1u9mWI+gF6XHX6Z0bRmN/UDsMOuDt9rFSvUA9jD/SZD2XFa69/yLXzdBnGrGTJE9fdazDnusel8VED0f+Kcn2rfG2Mw+K3SOdVytvjzkEQJE8viTKMVp4sAElu+BpUGXHM+4kb3iLmrBJyI5LSmzlZcK+te3hcaKjB0hzCA9TLpQ6LSyshYeBAdArGodPOi8cQm84xxOKMTpPBbdIrDZR+yb93Z6hWM+IZAvF+k/F5JffmT59SBfF;25:UxihNbJZzOJO2qFUxEOaeZp2D6Ug7KHYjZlxomeNOCqrcMx9f0OWSUFvwuFcI7SgGmFVijxFdVIktutFQv2nRtH7m6y4tLgU37z8ZSIemSQ2hDL9SaMC/G0lljnJ4ZY2UCKY1S13YyjdBPNkIaqpKiOQrQWdkqUzJ/5kusVmA8k8kkM7lXhmIKclrSnQjOJ9OeVlm1iB5Dix+n2wvpf1kh7MrsWIkcE+y/LZEkpM39BpSbKMwnEyC9X2UoO6NTG1RY2UPAYqg8kI3tSyQt9PQ802n7KMmFB3dcoeyrOUEmwvv8k+sxWmOkeoeA5aq/h91daG5M+kcSQBG55qjgGMNg==;31:9B6sSItlSYV6GcY4zGSpMzapUIjaDAAwKK7Tgp0ulFtE3d0smLjUF1g1JokRYZKS6SscBTCv5xV0MZF2Cv5fsZ1eJOzZ6sD+zBJRtK15ExJDWp5Hr/WRMLQI8Kf3wiZbJ/12ntJTL9Ou41qE23ANwPqfjqI5iHG2h8RHdfOSwMteHVK3TdJkyVzeaELtaGKmKdozOewGG3vPRRvwUb6cvkB3GwZecoM3Q4iW0vsZL+c=
X-MS-TrafficTypeDiagnostic: MWHP136MB0013:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0013;20:dxXsflSdm7tSWAjJOqt4gvZ6xrz19n9jn1f0RQ1rgo7IKUOzqzKQVcv8NkZuMrR2rmvhpc06ZqiKY+PGTa8PQEyPdsWSWkqQY94rS5qGpDAWsBv8ysrjKAYJKagCIJMGhP3+bdpyOmnV9r+7GLg1Dj0GNk3smIkSlYSkixzyJdl8ozhSqyihy3OwqM2SeoDWKIgQx09Yol9YoX/mqd3H5GSIwdgzWpNkkPs1WDDMiON6+ubgwwE1Dp+DH9EIe5DVH6lu+sXXMc4aCWvp6MCrfKsyCuQKaPhbwb2LeQYI9Slj1/d5FqoUAJ2ftygrDn459ECB3xzWNjj5kgTh5gKaxhZsQtUYffwGMGSB1aB1Q3iDeinbu/D9lqkFgVNcnn1DTQlpKLXX8aKySJgaKxgxhS18/naaAS0WBUqAo4PbmSdLz7d9lWm0woNJteYh4A7u6DnucqvsckCb3yS38gugNqtrA1k5I/1PYIyZ8un5kkgwCcYD7P4rxjqC9CMzvzPDR7aIfX6eeJ/nvUdgXwAkDk5sIzZCmgQd2NUpq0VkLODuTBIxlfXYaClusnUPCgrSzFyj+hisf6DSxyd56/6pmirRLpYrS5VTZOzOLITNVtk=
X-Microsoft-Antispam-PRVS: <MWHP136MB00132DA07ED0182EEA1084B5E8670@MWHP136MB0013.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(166708455590820)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHP136MB0013;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0013;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0013;4:GSEodkk5IvA/o9vKh2MveLxw5vEbHWQaC4B/RCO9SP344GbaSd413p50xt5jWPbnEIErv90RTEH1qDpU7F9AMUHtzkNeXt5gVIfPL12DwWBOosxu/6qEMfhh7cROrUYoVaB/Fok1Y7smC4L26Ixc+05zZOIvtl/j+Ifn6g6femtWvi7iVW5vBBWFY6TYvUE8iWEz8xd7uPDhR2jPvC6QVtA9pMssIAIX3sgldjwiy12Z3ipDrRG9e43gMOcRAx6NZqjcewKjES6fryspbTWIaZwvEMkZ7okoJurKJ7F6uEER+eZJNzYKx1trHtimHHuiSQH/a1fxrroI/eGuW5VS0aayoybtatSva1P9JPj74/0WFfXgAxxdVzjIXjd5rFHB
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(199004)(189003)(5660300001)(3846002)(6916009)(105586002)(106356001)(50466002)(6666003)(85782001)(68736007)(7696005)(316002)(575784001)(86362001)(2361001)(51416003)(8666007)(66066001)(52116002)(16586007)(2351001)(551544002)(48376002)(2906002)(47776003)(36756003)(97736004)(81166006)(81156014)(8676002)(50226002)(39060400002)(386003)(26005)(7736002)(305945005)(6486002)(4326008)(59450400001)(8936002)(1076002)(9686003)(6306002)(486006)(186003)(16526019)(25786009)(53936002)(966005)(6116002)(45080400002)(476003)(2616005)(956004)(478600001)(85772001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0013;H:ban8fdmsf2.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0013;23:jL3f4SPPxNkIqzljD/ICZ3zZmi+r9TC6kHZBMuk0Q?=
 =?us-ascii?Q?/9q9yxC0C9VS1wreGXmsnRr2XCobOfYsyhzkoBhiQwvmjVLH2ULPMH7muR7u?=
 =?us-ascii?Q?tqyusxssuaSnOoGM/IGLOYqTehW1Xqj7cQ16QKdC8odw5MoQEQXUgRxmgSrR?=
 =?us-ascii?Q?H7CWkb4QzQ+xo2sodx6j+VoKrBzDclY/ZyiU/x1QD38i1JbSyl9Jn5aLb7l3?=
 =?us-ascii?Q?2U7pTJRfsqA2fQ+rgXdNx/wxW+7w/Mj3/FRJvufXTxEBNuSWy2GWOMB56TR3?=
 =?us-ascii?Q?cC2bZDDPnvG9xePPBMgmLtEJiUFD0sddgjMwv95QkCdCc+lNk35KF8HpsULF?=
 =?us-ascii?Q?+UErCy8INDDNk9NCSzWKAwcig14SJjq8/H/Lm7TSAfmKpOvb+RSVw5pi8+Lh?=
 =?us-ascii?Q?voqag+JwRj8cPbGyHUgC/SsNaeiL+Dum7QYsePjf7rZABezsNh7Q1xFTtJ92?=
 =?us-ascii?Q?noIkQjoIh7JFrofpPqUOQQfoW9QdSAyLjLaW8y37N/39B2m1QszA0xEOqdyH?=
 =?us-ascii?Q?r4E9GeIr0w2DieE+iAucDFo1cLusvXXKGksJYZtkWMpx5TU4eD4unV+RHVSu?=
 =?us-ascii?Q?QJ9hU/KBB3qKGCW8bs4QklboHASi5xvqy69uLuzEYay8WbwGVZxKznxjB2gm?=
 =?us-ascii?Q?WGNvMryq6+EAUCt+OjXzfypu4ZtF96KEg6Wge5WH1IQQny8EjhdoPcyv2nGw?=
 =?us-ascii?Q?2xia3uraE4zRWzfQFREUaOfiIK/3YSx1b/0KVq3ME+uhJsWRpR0jNKMjiiHW?=
 =?us-ascii?Q?GK6QMMjj4lrHHc8cJGDHrO/4B2dB470ziJXK8P+Dc4Z4/jr42N5JmIU2yEl9?=
 =?us-ascii?Q?nhgQXJ1lVyGokaT/Xsq6dl+kZAEU3+Ic8QCCEZhOmiv+sofBLXzXkV8K8XA8?=
 =?us-ascii?Q?uWxVfJ7JWmZZoNRldYi4zziNVHwYtWzf/qQo891qQRrFtDonr4j6GnTCf4xr?=
 =?us-ascii?Q?QJ4oVJLF16IUQTjlYnr9g28CVr/5nRhJajfwOYPX/zL8qR+myFoLHnVwpBXH?=
 =?us-ascii?Q?sK88tEiYpXY1vDXKBtp6aOMI6JrTLxWvR9HZGWz5Va4S2/afw+VCD/eJcbcd?=
 =?us-ascii?Q?aJXRdT18xflDW21P5mqOm2XzOSZRzqto4JrEeiqopB3LXvobm6pQ+D5kizTF?=
 =?us-ascii?Q?PCR0JkuR3j94iygcO2k5kqXKZi2h7jJvvbLnpAXbTfVcvawcGUnef/Z7/j9w?=
 =?us-ascii?Q?+HPeZuJ9aDU00h21yyV3EOE0ZBzVc9QOKW0OFJvmIyUpoz4nvGU3M43eUJiI?=
 =?us-ascii?Q?ppCN8RA7zcu98E1xoY+HQe4S9GFdE9tFdoPd0Aj6lTg3ZrIeekM21p9AWoYH?=
 =?us-ascii?Q?En93GcfbPsTx8W3rUDcnYqKug/yp+kn5NPZvGuS7Ts7QTGJnGKXDIx/WICMk?=
 =?us-ascii?Q?HxUwVcrE703VYsA8GrPzywQ0TSp7erBA340OEZdNTEcmWdY9gxyWZya+AZJl?=
 =?us-ascii?Q?g5xq4ckbg=3D=3D?=
X-Microsoft-Antispam-Message-Info: VwxVHfp99nMO4kYrLefY+NhoUWWghDIZcE5bxgiBVavCu29QcpFF4X9k+YaARM9OO+sJ+s0aBXFU3ldBgoAUxXATzjeHCqZVq1zOy/8o/DjmuV6d1vKlCKg7xbeWNn/oDdnFrsoDPIsJS/I4cQniJGckZ526Q2FTprCKmvEAzxa3/adv+bEEjwl+VhTO8TSA
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0013;6:3D7XIWq5JYpohXAJjfmrwqLGdCFFpp/uWZdcfWccJseVQbYM7H59DSzZhBkovjx+0p9O0Uu6718LVhjxyfCI1sekagFfMYx+9qCM7aclJACFkg7kmWNPdBkXP278o9Xm3K2KAe0WM4Ps+slL3AK4dZ3R3/B9W9G6O4tm8bZCPDoWyD02N9bJ9J9XBTUCnkscyLDABOLH3WIF9ZDH4cl5V37Be5ULdtWUVKcMdSD1KtQ3pfx8EpXc7IIVhqXYDw2UPRRiDMtDmSOwIaAafBR5PZE/+SnehrJZ70zZ1psSpsGpz6XGq55xGfuVQ2+E4sHHDtg8uYzmq8Z9eKn1+C5SfqbLHcslGtfat2Wge2er48tX3uSsue/sEmbPC+gDispwQtRVnCqVXaT4whp0M8IaxY1KofOvzJFVTloeDm4QVe5hxp9nYhPp4FwQaUU+mRFG626/+Cc3b9MI/n8w1aidAA==;5:WwyER8ukhI7zc4RhqkYph0hD8lTdoEPXaFqQzd6gMitqez3xz0ZwRwcbnTsBpg9AlUftfD2fzQYHoM5PvbKnXtsDWN3cF1e9Y0pKGNHMQpQkz+7r4itKBrVBK3rWu5AO1lK/TiVxwc1TuZ+9WLzMT0ZAXNQ6RV/tNm7GE8mKRy4=;24:1Sn28Ol7A0zXEBXf7NmK+lkpC3nEj30xhvbUGrv67KhXz1U9kcLNRBXRpV+FTmaIexxzr+meJUlaMtZgyjl1UzHkFWTF1OHoth19yj1PrT4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0013;7:KhgLfibRx6sX4wKmpLRoEoEduFwNx9/ps2DS0XyeWsfCPe3K8gFCqLh1z3ljnc/RssTyITkYpZy7V1dci0FpydfNjq83WOdStlnOJ9qXS9JP4qIJWmJs6WJn0P0tvLH1DmY3HEOQj+jt7nhfjMoTx7x55JtN6qcghaMBPdjBOuTb9Y28bWcJBbJwNTyE7/yd25LxHsUSciXjIZtc9rm+B35VgemzEAb9El7i1bWkoCZhXj6pmfKAovE2sLiSu888
X-MS-Office365-Filtering-Correlation-Id: 73c39a81-4c2c-448e-886b-08d5ca16753e
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 12:26:53.1822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c39a81-4c2c-448e-886b-08d5ca16753e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0013
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If a Git HTTP server responds with 401 or 407, then Git tells the
credential helper to reject and delete the credentials. In general
this is good.

However, in certain automation environments it is not desired to remove
credentials automatically. This is in particular the case if credentials
are only invalid temporarily (e.g. because of problems in the server's
authentication backend).

Therefore, add the config "http.keepRejectedCredentials" which tells
Git to keep invalid credentials if set to "true".

It was considered to disable the credential deletion in credential.c
directly. This approach was not chosen as it could be confusing to
other callers of credential_reject() if the function does not do what
its name says (e.g. in imap-send.c).

The Git-Credential-Manager-for-Windows already implements a similar
mechanism [1]. This solution aims to enable that feature for all
credential helper implementations.

[1] https://github.com/Microsoft/Git-Credential-Manager-for-Windows/blob/0c1af463b33b0a0142f36f99c49ca8f83e86ee43/Shared/Cli/Functions/Common.cs#L484-L504

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/51993c2ff9
    Checkout: git fetch https://github.com/larsxschneider/git keepcreds-v1 && git checkout 51993c2ff9

 Documentation/config.txt |  6 ++++++
 http.c                   | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..184aee8dbc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1997,6 +1997,12 @@ http.emptyAuth::
 	a username in the URL, as libcurl normally requires a username for
 	authentication.

+http.keepRejectedCredentials::
+	Keep credentials in the credential helper that a Git server responded
+	to with 401 (unauthorized) or 407 (proxy authentication required).
+	This can be useful in automation environments where credentials might
+	become temporarily invalid. The default is `false`.
+
 http.delegation::
 	Control GSSAPI credential delegation. The delegation is disabled
 	by default in libcurl since version 7.21.7. Set parameter to tell
diff --git a/http.c b/http.c
index b4bfbceaeb..ff6932813f 100644
--- a/http.c
+++ b/http.c
@@ -138,6 +138,7 @@ static int ssl_cert_password_required;
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 static unsigned long http_auth_methods = CURLAUTH_ANY;
 static int http_auth_methods_restricted;
+static int keep_rejected_credentials = 0;
 /* Modes for which empty_auth cannot actually help us. */
 static unsigned long empty_auth_useless =
 	CURLAUTH_BASIC
@@ -403,6 +404,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}

+	if (!strcmp("http.keeprejectedcredentials", var)) {
+		keep_rejected_credentials = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -1471,7 +1477,8 @@ static int handle_curl_result(struct slot_results *results)
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
 		if (http_auth.username && http_auth.password) {
-			credential_reject(&http_auth);
+			if (!keep_rejected_credentials)
+				credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
@@ -1485,7 +1492,8 @@ static int handle_curl_result(struct slot_results *results)
 		}
 	} else {
 		if (results->http_connectcode == 407)
-			credential_reject(&proxy_auth);
+			if (!keep_rejected_credentials)
+				credential_reject(&proxy_auth);
 #if LIBCURL_VERSION_NUM >= 0x070c00
 		if (!curl_errorstr[0])
 			strlcpy(curl_errorstr,

base-commit: c2c7d17b030646b40e6764ba34a5ebf66aee77af
--
2.17.1

