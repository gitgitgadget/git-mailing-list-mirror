Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9690E1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbcH0StL (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:49:11 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35190 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbcH0StL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:49:11 -0400
Received: by mail-yw0-f193.google.com with SMTP id r9so4793711ywg.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=SIRLgVpJRmejH2YKu+3HA1GSeBzLrAlObCwuaMV3aGI=;
        b=Km/y3s2hcj/sqn2RPFY7eEZIJ0P6TiXyehopje2joWNGcnu+gcD3q9CX4CTmYLMeWj
         x1JrOiSVCp3o6TAlLq5teMH6ULOfv4GgzkU0dYxKo7nbz3DX7YB8TFi7fKEHeUMPmTTW
         1qP0qm5OKXi8PAuvWEuRi9QAgCMl3s/3zOscQ3gh72UcBTNG2wI8pVkMZFVuBC93UDJ2
         gbz43W0OD6cvMVhRZqdNt9x4xXPTYH7X6Q++oCOSycXO7lPvHhtP0mhgYaFHv24Vpxoa
         1Pu0Hg1oPkW2NCOGsftLR3JRNPZMw+wFP1x2UriZhyN3CecZW9lrJLZdZaLBP8Peh5qn
         992w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=SIRLgVpJRmejH2YKu+3HA1GSeBzLrAlObCwuaMV3aGI=;
        b=f8pPl17Xonc/gnUZgX0snayMC7h9QHlFEcDiG/ye4Uvsh06E/XP6cbLPfYEJRoha/G
         iWAMswy6wiC8vZUAVEig5LBhFKIyxNU6axbbrYJXCy+VWn1KZz3FKde/T5e/5iUrJeR/
         uH6if7i8pDdOvk+JJQ4btvbTy/VlpcL7LyCJ8gi+pvPWI1LhR4H1VpY7NseidVzGqh+d
         X0+BdheqwB3lCT561YnnVPOkmANgbtZNqs2GdyMWiywZWjC0HqjY+Bk6FNhlpRM8rzXJ
         0I+JBSOK2IlDQU+11B7xVKS6EwiLsNAJzJAtpLAuQOfU/FFEabGLwhsSozKGYaPSSqFX
         fFRg==
X-Gm-Message-State: AE9vXwOoCWDzJwrIaBqd4ASKuu2nBN01IbppGsOcoa5tX/fV0liyBlPppj7jGnIAOwEdN78nftuIZVajmlNSeA==
X-Received: by 10.129.125.135 with SMTP id y129mr8783544ywc.107.1472323749963;
 Sat, 27 Aug 2016 11:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.42.12 with HTTP; Sat, 27 Aug 2016 11:49:09 -0700 (PDT)
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Aug 2016 20:49:09 +0200
Message-ID: <CAP8UFD31xnKKigVHFhHT=TKHtDV2bSgVG61aiMnhu3X5HxJvwg@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2016 at 8:45 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I will send a diff between this version and v12 as a reply to this
> email.

Here is the diff:

diff --git a/apply.c b/apply.c
index 7e561a4..5cd037d 100644
--- a/apply.c
+++ b/apply.c
@@ -3993,12 +3993,21 @@ static int check_patch_list(struct apply_state
*state, struct patch *patch)
     return err;
 }

+static int read_apply_cache(struct apply_state *state)
+{
+    if (state->index_file)
+        return read_cache_from(state->index_file);
+    else
+        return read_cache();
+}
+
 /* This function tries to read the sha1 from the current index */
-static int get_current_sha1(const char *path, unsigned char *sha1)
+static int get_current_sha1(struct apply_state *state, const char *path,
+                unsigned char *sha1)
 {
     int pos;

-    if (read_cache() < 0)
+    if (read_apply_cache(state) < 0)
         return -1;
     pos = cache_name_pos(path, strlen(path));
     if (pos < 0)
@@ -4042,7 +4051,7 @@ static int preimage_sha1_in_gitlink_patch(struct
patch *p, unsigned char sha1[20
 }

 /* Build an index that contains the just the files needed for a 3way merge */
-static int build_fake_ancestor(struct patch *list, const char *filename)
+static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
     struct patch *patch;
     struct index_state result = { NULL };
@@ -4071,7 +4080,7 @@ static int build_fake_ancestor(struct patch
*list, const char *filename)
             ; /* ok */
         } else if (!patch->lines_added && !patch->lines_deleted) {
             /* mode-only change: update the current */
-            if (get_current_sha1(patch->old_name, sha1))
+            if (get_current_sha1(state, patch->old_name, sha1))
                 return error("mode change for %s, which is not "
                          "in current HEAD", name);
         } else
@@ -4089,12 +4098,13 @@ static int build_fake_ancestor(struct patch
*list, const char *filename)
         }
     }

-    hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+    hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR);
     res = write_locked_index(&result, &lock, COMMIT_LOCK);
     discard_index(&result);

     if (res)
-        return error("Could not write temporary index to %s", filename);
+        return error("Could not write temporary index to %s",
+                 state->fake_ancestor);

     return 0;
 }
@@ -4683,7 +4693,7 @@ static int apply_patch(struct apply_state *state,
             state->newfd = hold_locked_index(state->lock_file, 1);
     }

-    if (state->check_index && read_cache() < 0) {
+    if (state->check_index && read_apply_cache(state) < 0) {
         error(_("unable to read index file"));
         res = -128;
         goto end;
@@ -4715,7 +4725,7 @@ static int apply_patch(struct apply_state *state,
     }

     if (state->fake_ancestor &&
-        build_fake_ancestor(list, state->fake_ancestor)) {
+        build_fake_ancestor(state, list)) {
         res = -128;
         goto end;
     }
