From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] entry.c: convert write_entry to use strbuf
Date: Wed, 23 Oct 2013 10:52:42 -0700
Message-ID: <xmqqeh7bri1h.fsf@gitster.dls.corp.google.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
	<1382532907-30561-1-git-send-email-pclouds@gmail.com>
	<1382532907-30561-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org,  Erik Faye-Lund <kusmabite@gmail.com>,  Johannes
 Sixt <j6t@kdbg.org>,  Antoine Pelisse <apelisse@gmail.com>,  Torsten
 =?utf-8?Q?B=C3=83=C2=B6gershausen?= <tboegi@web.de>,  Wataru Noguchi
 <wnoguchi.0727@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?B?UmVuw4PCqQ==?= Scharfe
 <l.s.r@web.de>,  msysGit <msysgit@googlegroups.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB3UZUCJQKGQEHWA5O2A@googlegroups.com Wed Oct 23 19:52:48 2013
Return-path: <msysgit+bncBCG77UMM3EJRB3UZUCJQKGQEHWA5O2A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f189.google.com ([209.85.128.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB3UZUCJQKGQEHWA5O2A@googlegroups.com>)
	id 1VZ2bv-0006oI-Nq
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 19:52:47 +0200
Received: by mail-ve0-f189.google.com with SMTP id jz11sf224616veb.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=f2fc5dQG5srtun8CSgqpFW60SqiCU9jDsNnaV1AotB0=;
        b=cZKLT+pgpA5GX1xAERe/4+rebOZweoF7MIzS6oGsc/XO9A+Cb9vQQdG5YWDj8qJfpN
         IchAyb78WdI4eQiy3tUDuHlxPFk8Xgm7vFDG+31AoW8xMQRNM/0SpKSkI8/nxzNHUvxj
         ++XWp7gs++QYhjcLvwr+xcOmT/zr7PPI0g0TwijjriVw65zPsrsCvkgtqm0S26Ll4fnO
         g4oIZSqIlCWAcJxaKVTbBHJHGjLQmxhJnQ4CTt5vEtkDUS3LS+3zCT9U5NzNI/1na8R8
         a633FzC9Iye5f7EkuQ+SHvmdVXfllfxRzmBi6/IQ7yfBkTWFox2S5733RsHdOYHYWYK8
         q2dw==
X-Received: by 10.50.109.170 with SMTP id ht10mr111343igb.14.1382550766865;
        Wed, 23 Oct 2013 10:52:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.164.137 with SMTP id yq9ls3086327igb.43.canary; Wed, 23 Oct
 2013 10:52:46 -0700 (PDT)
X-Received: by 10.66.146.136 with SMTP id tc8mr1768644pab.43.1382550766341;
        Wed, 23 Oct 2013 10:52:46 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id r18si2578015vds.2.2013.10.23.10.52.46
        for <msysgit@googlegroups.com>;
        Wed, 23 Oct 2013 10:52:46 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FDC74D2B4;
	Wed, 23 Oct 2013 17:52:46 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB534D2B3;
	Wed, 23 Oct 2013 17:52:45 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 298F24D2AD;
	Wed, 23 Oct 2013 17:52:45 +0000 (UTC)
In-Reply-To: <1382532907-30561-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23
 Oct 2013 19:55:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBF9F764-3C0B-11E3-B961-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236540>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The strcpy call in open_output_fd() implies that the output buffer
> must be at least 25 chars long.

Hmph, where does that 25 come from?

> And it's true. The only caller that
> can trigger that code is checkout-index, which has the buffer of
> PATH_MAX chars (and any systems that have PATH_MAX shorter than 25
> chars are just insane).
>
> But in order to say that, one has to walk through a dozen of
> functions. Just convert it to strbuf to avoid the constraint and
> confusion.

Wouldn't it be far clearer to document what is going on especially
around the topath parameter to checkout_entry(), than to introduce
unnecessary strbuf overhead?

At first glance, it might appear that the caller of checkout_entry()
can specify to which path the contents are written out, but in
reality topath[] is to point at the buffer to store the temporary
path generated by the lower guts of write_entry().  It is unclear in
the original code and that is worth an in-code comment.

And when describing that API requirement, we would need to say how
big a buffer the caller must allocate for topath[] in the comment.
That size does not have to be platform-dependent PATH_MAX.

Something like this?

 builtin/checkout-index.c | 2 +-
 cache.h                  | 1 +
 entry.c                  | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index b1feda7..4ed6b23 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -14,7 +14,7 @@
 static int line_termination =3D '\n';
 static int checkout_stage; /* default to checkout stage0 */
 static int to_tempfile;
-static char topath[4][PATH_MAX + 1];
+static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
=20
 static struct checkout state;
=20
diff --git a/cache.h b/cache.h
index 85b544f..3118b7f 100644
--- a/cache.h
+++ b/cache.h
@@ -975,6 +975,7 @@ struct checkout {
 		 refresh_cache:1;
 };
=20
+#define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *s=
tate, char *topath);
=20
 struct cache_def {
diff --git a/entry.c b/entry.c
index d955af5..2df4ee1 100644
--- a/entry.c
+++ b/entry.c
@@ -234,6 +234,14 @@ static int check_path(const char *path, int len, struc=
t stat *st, int skiplen)
 	return lstat(path, st);
 }
=20
+/*
+ * Write the contents from ce out to the working tree.
+ *
+ * When topath[] is not NULL, instead of writing to the working tree
+ * file named by ce, a temporary file is created by this function and
+ * its name is returned in topath[], which must be able to hold at
+ * least TEMPORARY_FILENAME_LENGTH bytes long.
+ */
 int checkout_entry(struct cache_entry *ce,
 		   const struct checkout *state, char *topath)
 {

--=20
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

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
