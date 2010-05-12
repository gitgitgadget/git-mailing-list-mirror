From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Re: git log -M -- filename is not working?
Date: Thu, 13 May 2010 00:07:24 +0800
Message-ID: <AANLkTilje2dBHjd2aykMnAjWdf8k1vayJ_ez4IfMrl7_@mail.gmail.com>
References: <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	 <20100508044434.GC14998@coredump.intra.peff.net>
	 <19428.62170.654092.308682@winooski.ccs.neu.edu>
	 <20100508053025.GG14998@coredump.intra.peff.net>
	 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	 <19429.3589.823244.270582@winooski.ccs.neu.edu>
	 <20100512113855.GB23847@coredump.intra.peff.net>
	 <19434.39095.448649.313537@winooski.ccs.neu.edu>
	 <20100512124948.GA11761@coredump.intra.peff.net>
	 <19434.48308.815673.263230@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 12 18:07:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCETG-0000RT-BD
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 18:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab0ELQH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 12:07:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:32867 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab0ELQHZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 12:07:25 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so209868vws.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7fEguXatlQe3qFIiJpcy82WnJTCmUcbsx4bxQBmY/nM=;
        b=T6JJp6BEvcKONN2Kz/raFEWme6THy+xdrzfevMliLFEBCIB36dIvx+kz6WkuhZUWMJ
         BZHArVouWeao77ryhVaVrLaxmcMsFOAMRQvXvdD0H5QWs4qpfBVWtLvWQAucvEqdgqjN
         WBsAbLJOnrvDwscQA8AqF3obq0zv2rPMSYOYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JliLLS6oZ5b1863IgRDJ87Wx0Ky0oY/BI2hOXaw8EFs6e1xxazz3qVPvl2xsPjc/bb
         jco5P68wteWgziyJIJVem2XMA55bbRnVMFPHyjQiauwKGN6S/Vuj3Zi3TppdMUdNqyzY
         r/svW0AoAL0UH3kQrxzLFT+nCXZnZegdOWTns=
Received: by 10.224.35.216 with SMTP id q24mr5238846qad.79.1273680444376; Wed, 
	12 May 2010 09:07:24 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Wed, 12 May 2010 09:07:24 -0700 (PDT)
In-Reply-To: <19434.48308.815673.263230@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146954>

Hi,

> But with `-p' it was doing something confusing: I used two files that
> were recently renamed, and the result was the correct log history, bu=
t
> the first patch that was shown (the rename) showed the two files as
> added. =A0(That's even when I added `-C' and `-M'.) =A0This happens e=
ven
> with a single path. =A0OTOH, using `--follow' with `-p' and a single
> path without your patch produces the expected result where the first
> patch is a rename (even without `-C'/`-M').

Try this one, it only change a little on Jeff's patch, my simple tests
show it works. Apply it on 'next' branch.

diff --git a/builtin/log.c b/builtin/log.c
index 6208703..0142036 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -70,9 +70,10 @@ static void cmd_log_init(int argc, const char
**argv, const char *prefix,
        if (rev->diffopt.pickaxe || rev->diffopt.filter)
                rev->always_show_header =3D 0;
        if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
-               rev->always_show_header =3D 0;
-               if (rev->diffopt.nr_paths !=3D 1)
-                       usage("git logs can only follow renames on one
pathname at a time");
+               if (!rev->diffopt.nr_paths)
+                       DIFF_OPT_CLR(&rev->diffopt, FOLLOW_RENAMES);
+               else
+                       rev->always_show_header =3D 0;
        }
        for (i =3D 1; i < argc; i++) {
                const char *arg =3D argv[i];
diff --git a/diffcore.h b/diffcore.h
index 491bea0..9039a06 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -99,6 +99,10 @@ struct diff_queue_struct {
                (q)->nr =3D (q)->alloc =3D 0; \
                (q)->run =3D 0; \
        } while(0);
+#define DIFF_QUEUE_MARK_RUN(q, r) \
+       do { \
+               (q)->run =3D (r); \
+       } while(0);

 extern struct diff_queue_struct diff_queued_diff;
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
diff --git a/tree-diff.c b/tree-diff.c
index 1fb3e94..dd95f74 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"

 static char *malloc_base(const char *base, int baselen, const char
*path, int pathlen)
 {
@@ -322,78 +323,74 @@ int diff_tree(struct tree_desc *t1, struct
tree_desc *t2, const char *base, stru
 }

 /*
- * Does it look like the resulting diff might be due to a rename?
- *  - single entry
- *  - not a valid previous file
+ * Does it look like the resulting diff might be due to a rename? If w=
e have
+ * any files that appeared, then maybe.
  */
 static inline int diff_might_be_rename(void)
 {
-       return diff_queued_diff.nr =3D=3D 1 &&
-               !DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
+       int i;
+       for (i =3D 0; i < diff_queued_diff.nr; i++)
+               if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one))
+                       return 1;
+       return 0;
 }

 static void try_to_follow_renames(struct tree_desc *t1, struct
tree_desc *t2, const char *base, struct diff_options *opt)
 {
        struct diff_options diff_opts;
+       struct diff_queue_struct outq;
        struct diff_queue_struct *q =3D &diff_queued_diff;
-       struct diff_filepair *choice;
-       const char *paths[1];
+       const char **new_paths;
+       int new_paths_num, new_paths_alloc;
        int i;

-       /* Remove the file creation entry from the diff queue, and
remember it */
-       choice =3D q->queue[0];
+       DIFF_QUEUE_CLEAR(&outq);
        q->nr =3D 0;

        diff_setup(&diff_opts);
        DIFF_OPT_SET(&diff_opts, RECURSIVE);
        DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
        diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-       diff_opts.single_follow =3D opt->paths[0];
        diff_opts.break_opt =3D opt->break_opt;
-       paths[0] =3D NULL;
-       diff_tree_setup_paths(paths, &diff_opts);
        if (diff_setup_done(&diff_opts) < 0)
                die("unable to set up diff options to follow renames");
        diff_tree(t1, t2, base, &diff_opts);
        diffcore_std(&diff_opts);
-       diff_tree_release_paths(&diff_opts);

-       /* Go through the new set of filepairing, and see if we find a
more interesting one */
+       new_paths_num =3D new_paths_alloc =3D opt->nr_paths;
+       new_paths =3D xmalloc(opt->nr_paths * sizeof(*new_paths));
+       for (i =3D 0; i < opt->nr_paths; i++)
+               new_paths[i] =3D opt->paths[i];
+
+       /* Go through the new set of filepairs, looking for renames. */
        for (i =3D 0; i < q->nr; i++) {
                struct diff_filepair *p =3D q->queue[i];

-               /*
-                * Found a source? Not only do we use that for the new
-                * diff_queued_diff, we will also use that as the path =
in
-                * the future!
-                */
-               if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') &&
!strcmp(p->two->path, opt->paths[0])) {
-                       /* Switch the file-pairs around */
-                       q->queue[i] =3D choice;
-                       choice =3D p;
-
-                       /* Update the path we use from now on.. */
-                       diff_tree_release_paths(opt);
-                       opt->paths[0] =3D xstrdup(p->one->path);
-                       diff_tree_setup_paths(opt->paths, opt);
-                       break;
-               }
-       }
+               /* XXX actually this is the slightly different wildcard=
ing
+                * pathspec. We really want to check just prefixes. But
+                * I wonder if we can convince the diff machinery to ju=
st
+                * be interested in these paths as destinations, but us=
e
+                * the whole tree as sources */
+               if (!match_pathspec(opt->paths, p->two->path,
+                                  strlen(p->two->path), 0, NULL))
+                       continue;

-       /*
-        * Then, discard all the non-relevant file pairs...
-        */
-       for (i =3D 0; i < q->nr; i++) {
-               struct diff_filepair *p =3D q->queue[i];
-               diff_free_filepair(p);
+               diff_q(&outq, p);
+
+               ALLOC_GROW(new_paths, new_paths_num + 1, new_paths_allo=
c);
+               new_paths[new_paths_num++] =3D xstrdup(p->one->path);
        }

-       /*
-        * .. and re-instate the one we want (which might be either the
-        * original one, or the rename/copy we found)
-        */
-       q->queue[0] =3D choice;
-       q->nr =3D 1;
+       /* now finalize the new paths */
+       ALLOC_GROW(new_paths, new_paths_num + 1, new_paths_alloc);
+       new_paths[new_paths_num] =3D NULL;
+       diff_tree_release_paths(opt);
+       diff_tree_setup_paths(new_paths, opt);
+
+       /* and restore our old queue */
+       free(q->queue);
+       *q =3D outq;
+       DIFF_QUEUE_MARK_RUN(q, 1);
 }

 int diff_tree_sha1(const unsigned char *old, const unsigned char
*new, const char *base, struct diff_options *opt)


Regards!
Bo
