From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex
 to improve performance
Date: Tue, 13 Nov 2012 22:51:46 +0100
Message-ID: <50A2C0F2.20606@gmail.com>
References: <20121102153800.GE11170@sigill.intra.peff.net> <OF27D0F811.18A373FB-ONC1257AB5.0055809D-C1257AB5.0055B47D@dcon.de> <7v4nktfo35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: karsten.blees@dcon.de, Jeff King <peff@peff.net>, 
 git@vger.kernel.org, msysgit@googlegroups.com, 
 pro-logic@optusnet.com.au
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBB4MBROCQKGQENU22KPQ@googlegroups.com Tue Nov 13 22:52:00 2012
Return-path: <msysgit+bncBCH3XYXLXQDBB4MBROCQKGQENU22KPQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB4MBROCQKGQENU22KPQ@googlegroups.com>)
	id 1TYOOi-0000Iv-92
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 22:51:56 +0100
Received: by mail-lb0-f186.google.com with SMTP id y2sf1157546lbk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 13:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=2wNvS0wWtMHRwnfMcyU/2lAY3W2DrfzHD/t+OBe+/4E=;
        b=jCkyMVAnLIKy91oqx2FzgzwUdxO0uW/oN1I6Vq2hT9hh+A/DdYmIf0o3tmANuM3uyE
         Ft82NCGZQm8JA3H5/ZaoN/6u6ODH2+vOrntwgU8KIWMzURvqXFW2fJx9AvoSsS8ErTV+
         9eocG8GljGke+Ifnt25B5UFeawg3fTkGWiJ/PB7EyujMpL28afu9hptYPxCgmYCd7IzV
         SkAsw7KlyXPelmXGbwoyTmhuCL0odoIMJGCfMjva300Gtsp2C684milEKpVFr6d5mbti
         /N7cLlUTHSH3+0gizhZphj6mRqmAnnwm2Bs+6kpyl1fhsOqW 
Received: by 10.180.97.194 with SMTP id ec2mr2233416wib.0.1352843506625;
        Tue, 13 Nov 2012 13:51:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.198.201 with SMTP id v49ls5297949een.0.gmail; Tue, 13 Nov
 2012 13:51:44 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr24632281eep.3.1352843504934;
        Tue, 13 Nov 2012 13:51:44 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr24632279eep.3.1352843504920;
        Tue, 13 Nov 2012 13:51:44 -0800 (PST)
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
        by gmr-mx.google.com with ESMTPS id z47si2688391eel.0.2012.11.13.13.51.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 13:51:44 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 74.125.83.50 as permitted sender) client-ip=74.125.83.50;
Received: by mail-ee0-f50.google.com with SMTP id c41so5360572eek.37
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 13:51:44 -0800 (PST)
Received: by 10.14.203.132 with SMTP id f4mr79615787eeo.11.1352843504789;
        Tue, 13 Nov 2012 13:51:44 -0800 (PST)
Received: from [10.1.101.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id s1sm25253633eem.9.2012.11.13.13.51.43
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 13:51:44 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7v4nktfo35.fsf@alter.siamese.dyndns.org>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@gmail.com designates 74.125.83.50 as permitted
 sender) smtp.mail=karsten.blees@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209676>

Am 13.11.2012 17:46, schrieb Junio C Hamano:
> karsten.blees@dcon.de writes:
>=20
> If anything, "fix your mailer" probably is the policy you are
> looking for, I think.

Well then...I've cloned myself @gmail, I hope this is better.

Just some provoking thoughts...(if I may):

RFC-5322 recommends wrapping lines at 78, and mail relays and gateways are =
allowed to change message content according to the capabilities of the rece=
iver (RFC-5598). In essence, plaintext mail is completely unsuitable for pr=
eformatted text such as source code.

On the other hand, git tries to solve the very problem of distributed sourc=
e code management, and consistency by strong sha-1 checksums is on the top =
of the feature list.

It is somehow hard to believe that contributing to git itself should only b=
e possible using the most unreliable of protocols. Don't you trust your own=
 software?


-- >8 --
Subject: [PATCH] update-index/diff-index: use core.preloadindex to improve =
performance

'update-index --refresh' and 'diff-index' (without --cached) don't honor
the core.preloadindex setting yet. Porcelain commands using these (such as
git [svn] rebase) suffer from this, especially on Windows.

Use read_cache_preload to improve performance.

Additionally, in builtin/diff.c, don't preload index status if we don't
access the working copy (--cached).

Results with msysgit on WebKit repo (2GB in 200k files):

                | update-index | diff-index | rebase
----------------+--------------+------------+---------
msysgit-v1.8.0  |       9.157s |    10.536s | 42.791s
+ preloadindex  |       9.157s |    10.536s | 28.725s
+ this patch    |       2.329s |     2.752s | 15.152s
+ fscache [1]   |       0.731s |     1.171s |  8.877s

[1] https://github.com/kblees/git/tree/kb/fscache-v3

Thanks-to: Albert Krawczyk <pro-logic@optusnet.com.au>
Signed-off-by: Karsten Blees <blees@dcon.de>
---

Can also be pulled from: https://github.com/kblees/git/tree/kb/update-diff-=
index-preload-upstream

More performance figures (for msysgit) can be found in this discussion: htt=
ps://github.com/pro-logic/git/commit/32c03dd8


 builtin/diff-index.c   |  8 ++++++--
 builtin/diff.c         | 12 ++++++++----
 builtin/update-index.c |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 2eb32bd..1c737f7 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -41,9 +41,13 @@ int cmd_diff_index(int argc, const char **argv, const ch=
ar *prefix)
 	if (rev.pending.nr !=3D 1 ||
 	    rev.max_count !=3D -1 || rev.min_age !=3D -1 || rev.max_age !=3D -1)
 		usage(diff_cache_usage);
-	if (!cached)
+	if (!cached) {
 		setup_work_tree();
-	if (read_cache() < 0) {
+		if (read_cache_preload(rev.diffopt.pathspec.raw) < 0) {
+			perror("read_cache_preload");
+			return -1;
+		}
+	} else if (read_cache() < 0) {
 		perror("read_cache");
 		return -1;
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index 9650be2..198b921 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -130,8 +130,6 @@ static int builtin_diff_index(struct rev_info *revs,
 			usage(builtin_diff_usage);
 		argv++; argc--;
 	}
-	if (!cached)
-		setup_work_tree();
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
@@ -140,8 +138,14 @@ static int builtin_diff_index(struct rev_info *revs,
 	    revs->max_count !=3D -1 || revs->min_age !=3D -1 ||
 	    revs->max_age !=3D -1)
 		usage(builtin_diff_usage);
-	if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
-		perror("read_cache_preload");
+	if (!cached) {
+		setup_work_tree();
+		if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
+			perror("read_cache_preload");
+			return -1;
+		}
+	} else if (read_cache() < 0) {
+		perror("read_cache");
 		return -1;
 	}
 	return run_diff_index(revs, cached);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74986bf..ada1dff 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -593,6 +593,7 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
+	read_cache_preload(NULL);
 	*o->has_errors |=3D refresh_cache(o->flags | flag);
 	return 0;
 }
--=20
1.8.0.msysgit.0.3.g7d9d98c

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
