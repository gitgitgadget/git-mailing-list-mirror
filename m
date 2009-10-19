From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH v3 10/17] Move WebDAV HTTP push under remote-curl
Date: Mon, 19 Oct 2009 10:59:21 +0800
Message-ID: <20091019105921.d58c2728.rctay89@gmail.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
	<1255577814-14745-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 04:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MziTH-00056z-5u
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 04:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbZJSC7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 22:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755746AbZJSC7d
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 22:59:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:61109 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZJSC7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 22:59:32 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1257506fga.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 19:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=kY4RE+LdyEsoMetF2qBY6Czb/2xXPrisVFZxergQSyU=;
        b=K33tOYHkYMCBnWffwbHqUqWhnfnUFEVDYlADNirSHyHYXBPYKR6/lDwaWYruhrxIFB
         qIbslS9LaCo+ER1Izi1g4hZ6eNWdwAUgL0sr+AK05x06CZb+nAWXYC7oqrFWHq+7/xi+
         etS1xRFRjGSWI7Qa/lU/bE+bQU3D46pw0TQis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=JlJL8eTrHgEDyT7Hm9Z+O5LYhaUeFY2kWpY4yY6SKxIDxRWBwi5PzhuD/6lM344TQR
         dXodc186I4d32J4pEvGCghahsL02UrHc1uBM0pwa85aIo6trtEIzIIGr+GWow8zm7yfB
         leYsPufGjmCPb0qHyT1pNyGIqsqDC+TaYQw70=
Received: by 10.86.214.34 with SMTP id m34mr2804457fgg.6.1255921175874;
        Sun, 18 Oct 2009 19:59:35 -0700 (PDT)
Received: from your-cukc5e3z5n (cm134.zeta152.maxonline.com.sg [116.87.152.134])
        by mx.google.com with ESMTPS id e20sm4338392fga.25.2009.10.18.19.59.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Oct 2009 19:59:34 -0700 (PDT)
In-Reply-To: <1255577814-14745-11-git-send-email-spearce@spearce.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130640>

Hi,

On Thu, Oct 15, 2009 at 11:36 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> @@ -34,6 +34,10 @@ Commands are given by the caller on the helper's standard input, one per line.
>        value of the ref. A space-separated list of attributes follows
>        the name; unrecognized attributes are ignored. After the
>        complete list, outputs a blank line.
> ++
> +If 'push' is supported this may be called as 'list for-push'
> +to obtain the current refs prior to sending one or more 'push'
> +commands to the helper.

The new paragraph should have the same indentation as 'list'.

It would have been great if you implemented this as a filter, such that
'list <attr>' lists the refs with the specified attribute <attr>,
rather than hardcoding it.

> @@ -59,6 +63,22 @@ suitably updated.
> +When the push is complete, outputs one or more 'ok <dst>' or
> +'error <dst> <why>?' lines to indicate success or failure of
> +each pushed ref.  The status report output is terminated by
> +a blank line.  The option field <why> may be quoted in a C
> +style string if it contains an LF.

You should mention that this behaviour only occurs when the
--helper-status option is used.

> @@ -106,6 +132,11 @@ OPTIONS
> +'option dry-run' \{'true'|'false'\}:
> +       If true, pretend like the operation completed successfully,
> +       but don't actually change any repository data.  For most
> +       helpers this only applies to the 'push', if supported.
> +

The 'like' after 'pretend' can be, like, removed. :)

> diff --git a/http-push.c b/http-push.c
> @@ -1941,9 +1946,14 @@ int main(int argc, char **argv)
>
>                if (is_null_sha1(ref->peer_ref->new_sha1)) {
>                        if (delete_remote_branch(ref->name, 1) == -1) {
> -                               error("Could not remove %s", ref->name);
> +                               if (helper_status)
> +                                       printf("error %s cannot remove\n", ref->name);
> +                               else
> +                                       error("Could not remove %s", ref->name);
>                                rc = -4;
>                        }

I think error() calls should be left intact (as indicators to the
user), even when --helper-status is specified. It wouldn't affect
transport-helper.c's parsing of '(ok|error) <ref>' lines, since it
reads stdout only.

In other words, the above would read:

>                                error("Could not remove %s", ref->name);
> +                               if (helper_status)
> +                                       printf("error %s cannot remove\n", ref->name);
>                                rc = -4;
>                        }

> @@ -1968,12 +1980,15 @@ int main(int argc, char **argv)
>                                 * commits at the remote end and likely
>                                 * we were not up to date to begin with.
>                                 */
> -                               error("remote '%s' is not an ancestor of\n"
> -                                     "local '%s'.\n"
> -                                     "Maybe you are not up-to-date and "
> -                                     "need to pull first?",
> -                                     ref->name,
> -                                     ref->peer_ref->name);
> +                               if (helper_status)
> +                                       printf("error %s non-fast forward\n", ref->name);
> +                               else
> +                                       error("remote '%s' is not an ancestor of\n"
> +                                                 "local '%s'.\n"
> +                                                 "Maybe you are not up-to-date and "
> +                                                 "need to pull first?",
> +                                                 ref->name,
> +                                                 ref->peer_ref->name);
>                                rc = -2;
>                                continue;
>                        }

Same here.

> @@ -1987,14 +2002,20 @@ int main(int argc, char **argv)
>                /* Lock remote branch ref */
>                ref_lock = lock_remote(ref->name, LOCK_TIME);
>                if (ref_lock == NULL) {
> -                       fprintf(stderr, "Unable to lock remote branch %s\n",
> -                               ref->name);
> +                       if (helper_status)
> +                               printf("error %s lock error\n", ref->name);
> +                       else
> +                               fprintf(stderr, "Unable to lock remote branch %s\n",
> +                                       ref->name);
>                        rc = 1;
>                        continue;
>                }

Same here.

Two more areas in http-push.c that should have status messages
(generated on top of pu):

(I'm not sure what ref should read when there's no match, but
transport-helper.c should have no problems parsing it with 'null'.)

-->8--

diff --git a/http-push.c b/http-push.c
index 9010ccc..e979feb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1916,9 +1916,12 @@ int main(int argc, char **argv)

 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
-		if (delete_remote_branch(refspec[0], force_delete) == -1)
+		if (delete_remote_branch(refspec[0], force_delete) == -1) {
 			fprintf(stderr, "Unable to delete remote branch %s\n",
 				refspec[0]);
+			if (helper_status)
+				printf("error %s cannot remove\n", refspec[0]);
+		}
 		goto cleanup;
 	}

@@ -1930,6 +1933,8 @@ int main(int argc, char **argv)
 	}
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
+		if (helper_status)
+			printf("error null no match\n");
 		rc = 0;
 		goto cleanup;
 	}

--
Cheers,
Ray Chuan
