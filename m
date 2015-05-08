From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] tree-walk: learn get_tree_enty_follow_symlinks
Date: Fri, 8 May 2015 15:43:11 -0400
Message-ID: <CAPig+cQTN5OCxfH_OLjaqza4Os8=kton8baiQMgiNZjR10C=ag@mail.gmail.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:43:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoB3-00068K-4h
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbbEHTnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 15:43:12 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34136 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbbEHTnM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:43:12 -0400
Received: by iget9 with SMTP id t9so37107980ige.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2oDB/uqtwXaY54wJVgdbLnSOQuX+jm0qJY8mV7ECT8s=;
        b=Xsc1KSjSymLtbUogFzyvJWdovdSI/+JyTbQk42mCKrD/8bFPO5RspJxB8CRC+yIgkB
         +zCrOPgfszvKha68r8jqSe9AOswukwSc4F6fFMvwiauo+Cj/VlqNU+KFvFZQTP/c7zJ+
         if60SlUTQI/aTCXOPeEh4cWzoN6ZeCKcH7K3Wn6Jbewn9cw0qF7i6EFHYgCRD3RbL3Ci
         lbsWNgyQrdlc9HWaqRkEt0rC/Df7O6ZkzV7tm0ku652Uy3dQK3tr+NWOxoPSGHSfA3Io
         EQT8q3Jx+kqredRxOxHcxCmYWlUfkACvzUDYWoappFjXaDNVrWuYLdapQ8XgPMwlaQiz
         k5wA==
X-Received: by 10.50.43.169 with SMTP id x9mr636053igl.7.1431114191761; Fri,
 08 May 2015 12:43:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 12:43:11 -0700 (PDT)
In-Reply-To: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: 6JFaB7UL4cZ5UgSYQm4LBLohaVE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268651>

On Fri, May 8, 2015 at 2:13 PM,  <dturner@twopensource.com> wrote:
> tree-walk: learn get_tree_enty_follow_symlinks

s/enty/entry/ here and in several places in the patch itself.

> Add a new function, get_tree_entry_follow_symlinks, to tree-walk.[ch].
> The function is not yet used.  It will be used to implement git
> cat-file --batch --follow-symlinks.
>
> The function locates an object by path, following symlinks in the
> repository.  If the symlinks lead outside the repository, the function
> reports this to the caller.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
> diff --git a/tree-walk.c b/tree-walk.c
> index 5dd9a71..6fb4b7d 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -415,6 +415,228 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
>  {
> diff --git a/tree-walk.h b/tree-walk.h
> index ae7fb3a..002e5a9 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -40,6 +40,8 @@ struct traverse_info;
>  typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
>  int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
>
> +int get_tree_enty_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, unsigned char *result_path, unsigned *mode);
