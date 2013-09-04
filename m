From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] add--interactive: fix external command invocation
 on Windows
Date: Wed, 04 Sep 2013 09:24:47 +0200
Message-ID: <5226E03F.208@viscovery.net>
References: <521EF02A.2020300@viscovery.net> <1378001284-18426-1-git-send-email-pclouds@gmail.com> <5224334A.2090300@viscovery.net> <20130902092959.GA17306@lanh> <52246B70.3080200@viscovery.net> <CACsJy8BxGVyVsOV=XyWRqSnNjna0LQOAk6rgJ_jRkVox1jUSxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, 
 Alex Riesen <raa.lkml@gmail.com>,
 msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIMDQE3SECRUBE457IK6@googlegroups.com Wed Sep 04 09:24:50 2013
Return-path: <msysgit+bncBCJYV6HBKQIMDQE3SECRUBE457IK6@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f56.google.com ([209.85.161.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIMDQE3SECRUBE457IK6@googlegroups.com>)
	id 1VH7SM-0001vy-Fd
	for gcvm-msysgit@m.gmane.org; Wed, 04 Sep 2013 09:24:50 +0200
Received: by mail-fa0-f56.google.com with SMTP id x1sf141668fax.11
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Sep 2013 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Kp3gSrLqt5xUE95Ez89ABabd0YZyX2X36tMz25dyDsk=;
        b=hkRv32KdBjmWbaVGsitM4MRZHBqEqpnQXoeyA/OiAAYEbA1CtotXghoNcKbFLgUPzv
         1Jd/MysEFzGahk8bw1ZEIyolo3UuahvoLagAWAXH/Q3sbXfi98mPMmwLIxLJqvHSIyHr
         VV5z9RG9EI8D0pBn82eXwKIS3wcFfAD++Zo+e5f4F/KDBXb3y2Ij178/V7UxWgnltYuj
         UEHmicVGlQEm5dTy5ezG97pcBCSibsmwnAXLcocACKWWYWiELDl6GX6Zn+De4pMWY4ce
         liC4j+Bo9aH/SZ+cTxO9uZJzeR1iQELprToybQ168ZRa6xRdqi3uczY1o2fGB0LZfLDE
         W7WA==
X-Received: by 10.180.74.231 with SMTP id x7mr20704wiv.21.1378279490194;
        Wed, 04 Sep 2013 00:24:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.84.71 with SMTP id w7ls9360wiy.31.gmail; Wed, 04 Sep 2013
 00:24:49 -0700 (PDT)
X-Received: by 10.14.251.134 with SMTP id b6mr1265720ees.2.1378279489546;
        Wed, 04 Sep 2013 00:24:49 -0700 (PDT)
Received: from so.liwest.at (so.liwest.at. [212.33.55.13])
        by gmr-mx.google.com with ESMTPS id a1si3419372ees.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 00:24:49 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.13;
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VH7SJ-0000tI-Qh; Wed, 04 Sep 2013 09:24:48 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 863AC16613;
	Wed,  4 Sep 2013 09:24:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CACsJy8BxGVyVsOV=XyWRqSnNjna0LQOAk6rgJ_jRkVox1jUSxQ@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 212.33.55.13 is neither permitted nor denied by best guess
 record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233812>

From: Johannes Sixt <j6t@kdbg.org>

Back in 21e9757e (Hack git-add--interactive to make it work with
ActiveState Perl, 2007-08-01), the invocation of external commands was
changed to use qx{} on Windows. The rationale was that the command
interpreter on Windows is not a POSIX shell, but rather Windows's CMD.
That patch was wrong to include 'msys' in the check whether to use qx{}
or not: 'msys' identifies MSYS perl as shipped with Git for Windows,
which does not need the special treatment; qx{} should be used only with
ActiveState perl, which is identified by 'MSWin32'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 9/2/2013 13:56, schrieb Duy Nguyen:
> On Mon, Sep 2, 2013 at 5:41 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Which features do we lose on Windows with the previous patch and this fixup?
> 
> New pathspec magic :(glob), :(literal) and :(icase). You can still use
> them via --*-pathspecs or equivalent env variables. You just can't
> enable them per individual pathspec.

I think this here is the correct "solution" rather than the special cases
for Windows that you proposed. ActiveState perl users would still suffer,
but that is a problem of the run_cmd_pipe implementation, which would
need a smarter method to quote the arguments before it feeds them to qx{}.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 75a991f..5156384 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -169,7 +169,7 @@ my %patch_modes = (
 my %patch_mode_flavour = %{$patch_modes{stage}};
 
 sub run_cmd_pipe {
-	if ($^O eq 'MSWin32' || $^O eq 'msys') {
+	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
 		die "$^O does not support: @invalid\n" if @invalid;
 		my @args = map { m/ /o ? "\"$_\"": $_ } @_;
-- 
1.8.4.1549.gc059550.dirty

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
