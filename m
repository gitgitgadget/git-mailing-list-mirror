From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: [PATCH] Use the alternates of the source repository for dissociating
 clone
Date: Thu, 15 Oct 2015 13:28:41 +0200
Message-ID: <561F8DE9.4040703@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 13:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmgiR-0002lO-8I
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 13:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbJOL2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 07:28:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:65082 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbJOL2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 07:28:52 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue004) with ESMTPSA (Nemesis) id
 0MDl62-1ZnHKj3fiA-00HAdp; Thu, 15 Oct 2015 13:28:47 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 8A3EEB016CD;
	Thu, 15 Oct 2015 13:28:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4Eg3o11oH+L; Thu, 15 Oct 2015 13:28:41 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id 397CAB00E1C;
	Thu, 15 Oct 2015 13:28:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
X-Provags-ID: V03:K0:hzHArJ5ixbiLkjrWtVeOb7BE1VYr03DimiWnp2pHEVVtjr4wAo6
 mFyfIWW2zs5tuQ9CYE9lscS4A0qNgiHeT4/2ykzeNH4bFgYjhqIcFzUXHceAdNwC+PvPK2H
 1W7HlxwIph3dBXuQM2GbV7x5icckQTEBC0k0eiGFaB8Ht1bpQAcyPwMJA/cyvLJbwcXXIrJ
 L2WlJGyB2IBokxvhv6IXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:71sj2pziiM0=:jBsDWClU4TsE4zPOSzVKQb
 Jml+7DQJBN5lcCtBvO2fUiBGwsazXBHitRQmWu3wTVm+1mejF2bUqph4Iya9Y/aJSnKiTzCsT
 kxLZ6JP39XCLoC9HUqi9tkk1+AyrFbGTCedau+BdqsCMmmpldPqATtja4bUcmgLdSDWIZh/TO
 zA8eCHWRvX0VUXip2wz5Wnu7g7W5rES3jWhA7/A9ceLEVg3G9QcCEflx7Tc02aqKMagFFAUBY
 8umT/Ka63uSLb31PsxDa7RswfcLmpi+LY2jcALn80ySKRtTHpVWEX1vtLU20qKV92rnMQiiMY
 8Dd451RxL3z/ORLRLE8QPfFhw9m+y5ZBVu/SRkc+TNS/zU886uLgJM5q1qhe61i3oRrlFgAN6
 mLdt9KzbomD2qX404VllktCBnwWBulC30PYLhfU2B7AFPd0I68Y10qAcBLmcZP2D4KL/6bqvV
 oM5/HnAyKk4PRC9axYR37aFyfRf6sljfnQaP1CclAKSg3rRQ0Bm9eMNr8QoEyOm9wCWlRebAw
 Y/WcoovNt5zLueg8rIo9DZq73Fv+QL6WAXMXd5b9lrWocKAJbbhKu4kzdGAWlw44ROK7rMltH
 RF1K8gCCJc4Vb9ZYs2MuWJ8v+1Pg4onkEPw8iAh2ZEe/TK9mkuC7xRSTMu3A1k5BB+lB+Zn4q
 5y+nuF4vJ3dB+SpOBJ01KvZgMn8ZdZY4Wdf8x7HcjcLGpKOxN2qOShYxb6r3X9LRabmjoTAsd
 wEgF61ZMoob26X6L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279661>

The "--dissociate" option required reference repositories, which sometimes
demanded a look into the objects/info/alternates by the user. As this
is something which can be figured out automatically, do it in the
clone unless there is no other reference repositories.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I often (enough) did something like this (preparing for manual backup):

     # Run mc (the Midnight Commander, it is a console (ncurses) file manager with
     # two panels).
     # Select a repository.
     $ git clone --mirror --dissociate \
       $(sed -e 's|\(.*\)/objects|--reference \1| -- 
%f/.git/objects/info/alternates' 2>/dev/null) \
       %f %D/%f
     # (except that this is one long line in mc)

The '%f' expands to a selected directory on the current panel, %D - to the
current directory on the other panel. But as I see, the combination of the
options "--dissociate" and no given references is not used for anything but
giving the warning yet. So maybe it can be used as a shortcut for the above?

  builtin/clone.c | 42 ++++++++++++++++++++++++++++++++++++++----
  1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 578da85..344bf21 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -791,6 +791,38 @@ static void write_refspec_config(const char *src_ref_prefix,
      strbuf_release(&value);
  }

+static int copy_alternates_to_references(const char *src_repo)
+{
+    int refcnt = -1;
+    char *src_alternates = mkpathdup("%s/objects/info/alternates", src_repo);
+    FILE *in = fopen(src_alternates, "r");
+    if (in) {
+        struct strbuf line = STRBUF_INIT;
+        refcnt = 0;
+        while (strbuf_getline(&line, in, '\n') != EOF) {
+            struct string_list_item item;
+            if (line.len < 8 || line.buf[0] == '#')
+                continue;
+            ++refcnt;
+            if (!strcmp(line.buf + line.len - 8, "/objects"))
+                line.buf[line.len - 8] = '\0';
+            if (is_absolute_path(line.buf)) {
+                item.string = line.buf;
+                add_one_reference(&item, NULL);
+                continue;
+            }
+            item.string = mkpathdup("%s/objects/%s", src_repo, line.buf);
+            normalize_path_copy(item.string, item.string);
+            add_one_reference(&item, NULL);
+            free(item.string);
+        }
+        strbuf_release(&line);
+        fclose(in);
+    }
+    free(src_alternates);
+    return refcnt;
+}
+
  static void dissociate_from_references(void)
  {
      static const char* argv[] = { "repack", "-a", "-d", NULL };
@@ -947,10 +979,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)

      if (option_reference.nr)
          setup_reference();
-    else if (option_dissociate) {
-        warning(_("--dissociate given, but there is no --reference"));
-        option_dissociate = 0;
-    }

      fetch_pattern = value.buf;
      refspec = parse_fetch_refspec(1, &fetch_pattern);
@@ -976,6 +1004,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
          warning(_("--local is ignored"));
      transport->cloning = 1;

+    if (!option_reference.nr && option_dissociate &&
+        copy_alternates_to_references(path) <= 0) {
+        warning(_("--dissociate given, but there is no --reference"));
+        option_dissociate = 0;
+    }
+
      if (!transport->get_refs_list || (!is_local && !transport->fetch))
          die(_("Don't know how to clone %s"), transport->url);

-- 
2.6.1.150.gb633014
