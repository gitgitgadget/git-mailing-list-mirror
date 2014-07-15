From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 15 Jul 2014 17:23:14 +0700
Message-ID: <20140715102314.GA8273@lanh>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
 <1405140276-32162-4-git-send-email-dturner@twitter.com>
 <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
 <xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
 <53C41456.2000006@ramsay1.demon.co.uk>
 <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
 <53C42453.1090109@ramsay1.demon.co.uk>
 <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
 <CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
 <CAPc5daVH=i72Y4dA8TefPLfFB79Cvw7STPnQf_f10cBeYbg2ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 12:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ztG-0006Iy-8U
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 12:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbaGOKXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 06:23:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:40756 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbaGOKXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 06:23:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so3155722pab.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pfXYXakQBISGhgqtuJlOCfJbs/8qKmFRtGTuPm80J90=;
        b=OBipF1KrlanTAcYIIxuEwEnSwfjkj+18juNllg5DTpLl17k3TxeM5NNSuD4fZCi/Fb
         2vLFapFB4jqZG1l33wcvt+pYW/Ra9hPNijI859zIwF/kQA/EVJAg0wyVR2xt1nnOjLBN
         FGDzpX1FEuuvLDnxuPw6y53wii8BSTy/a/lmvGQ0N7qiIOKR73Gc2iwBYkwDSYx7mMaQ
         yK6DOxYw44c2TyPGuDDJLTQTLeJnRq5dQMfc/+WguowpJMTQ+10Yt2+aUc+0pTWRcGkj
         0zm1ZnRXd8jsc8AApq9Cp2ZKRV6q06BCy0FkndSD0zH8Sj6xM5CSVpFfiHkYjU8oY1Sp
         Br6w==
X-Received: by 10.66.139.164 with SMTP id qz4mr83537pab.151.1405419792795;
        Tue, 15 Jul 2014 03:23:12 -0700 (PDT)
Received: from lanh ([115.73.228.10])
        by mx.google.com with ESMTPSA id y2sm18037177pdl.38.2014.07.15.03.23.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2014 03:23:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 15 Jul 2014 17:23:14 +0700
Content-Disposition: inline
In-Reply-To: <CAPc5daVH=i72Y4dA8TefPLfFB79Cvw7STPnQf_f10cBeYbg2ug@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253551>

On Mon, Jul 14, 2014 at 11:38:06PM -0700, Junio C Hamano wrote:
> On Mon, Jul 14, 2014 at 7:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > It makes me wonder if a cleaner way of rebuilding cache-treei in this
> > case is from git-add--interactive.perl, or by simply spawn "git
> > update-index --rebuild-cache-tree" after running
> > git-add--interactive.perl.
> 
> We could check if the cache-tree has fully been populated by
> "add -i" and limit the rebuilding by "git commit -p" main process,
> but if "add -i" did not do so, there is no reason why "git commit -p"
> should not do so, without relying on the implementation of "add -i"
> to do so.
> 
> At least to me, what you suggested sounds nothing more than
> a cop-out; instead of lifting the limitation of the API by enhancing
> it with reopen-lock-file, punting to shift the burden elsewhere. I
> am not quite sure why that is cleaner, but perhaps I am missing
> something.

Reopen-lock-file to me does not sound like an enhancement, at least in
the index update context. We have always updated the index by writing
to a new file, then rename. Now if the new write_locked_index() blows
up after reopen_lock_file(), we have no way but die() because
index_lock.filename can no longer be trusted.

Doing it in a separate process keeps the tradition. And if the second
write fails, we still have good index_lock.filename. We could also do
the same here with something like this without new process (lightly
tested):

-- 8< --
diff --git a/builtin/commit.c b/builtin/commit.c
index 606c890..c2b4875 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -340,6 +340,18 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 
 		discard_cache();
 		read_cache_from(index_lock.filename);
+		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
+			static struct lock_file second_index_lock;
+			hold_lock_file_for_update(&second_index_lock,
+						  index_lock.filename,
+						  LOCK_DIE_ON_ERROR);
+			if (write_locked_index(&the_index, &second_index_lock,
+					       COMMIT_LOCK)) {
+				warning(_("Failed to update main cache tree"));
+				rollback_lock_file(&second_index_lock);
+			}
+		} else
+			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
-- 8< --

I was worried about the dependency between second_index_lock and
index_lock, but at cleanup, all we do is rollback, which is safe
regardless of dependencies. Just need to make sure we commit
second_index_lock before index_lock.

> In the longer run, it would be plausible that somebody would want
> to rewrite "git-add -i" and will make it just a C API call away without
> having to spawn a separate process. You cannot punt by saying
> "make 'add -i' responsible for it" at that point; you will be doing
> what 'add -i' would be doing yourself, no?

Yes, but at current rewrite rate I'd bet it won't happen in the next
two years at least.
--
Duy
