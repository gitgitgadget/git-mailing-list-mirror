From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 23:09:49 +0700
Message-ID: <CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com> <1369321970-7759-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfuZV-0000jd-18
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab3EXQKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:10:20 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:55645 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab3EXQKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:10:19 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so6251716oag.39
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=isjf0djqKLoXfshcJ+kg9SMUR3BjRH/2Sw0C0gPdS5w=;
        b=iE8d4GgbPB3vZkttlMg7gIfCu5kjQiW4u5LH7B1xD1nI9icY/yqc0L1PQIFweFqUdy
         6fj3jvOZkzvZAa+PgaBHcBS0SH4iHoBqetD8P0fHHOYTAMHyOSw0eTmFvzXU63jPznL3
         iw76gNhJEuAQDi8bh+CI57Vs6X75cSkERfIpXDcAF/KDST4UfoOJ1v9ghnYfnpYKJZXo
         84R1sWS4PSAzOSl62PU256nrxaTEHqtG7nHR3KRzwDW78h+x4QKzxgqlE2SJDM8gkefx
         ObhyMIEa7nuomyH4R+Z4XJZvupaQvAN0mMvCs3xwYR7zc1llNFiuNvk7z0fjnYa9B7Ic
         CfOQ==
X-Received: by 10.182.134.231 with SMTP id pn7mr12066101obb.11.1369411819485;
 Fri, 24 May 2013 09:10:19 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Fri, 24 May 2013 09:09:49 -0700 (PDT)
In-Reply-To: <1369321970-7759-8-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225370>

(I haven't caught up with git mails lately, but the @{special}
refactoring caught my eyes..)

On Thu, May 23, 2013 at 10:12 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Try this now: configure your current branch's pushremote to push to
> "refs/heads/*:refs/heads/rr/*".  Now, type 'git show @{p}'.  Voila!

Voila what? Why not avoid guessing game and describe what the patch is for?

> +static void find_push_ref(struct branch *branch) {
> +       struct remote *remote = pushremote_get(NULL);
> +       const struct refspec *pat = NULL;
> +       char raw_ref[PATH_MAX];
> +       struct ref *this_ref;
> +       char *dst_name;
> +       int len;
> +
> +       sprintf(raw_ref, "refs/heads/%s", branch->name);
> +       len = strlen(raw_ref) + 1;
> +       this_ref = xcalloc(1, sizeof(*this_ref) + len);
> +       memcpy(this_ref->name, raw_ref, len);
> +
> +       dst_name = get_ref_match(remote->push, remote->push_refspec_nr,
> +                               this_ref, MATCH_REFS_ALL, 0, &pat);
> +       printf("dst_name = %s\n", dst_name);
> +}
> +

Isn't this an abuse of extended sha-1 syntax? How can I combine this
with other @{}, ^, ~...?
--
Duy
